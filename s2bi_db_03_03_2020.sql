--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2020-04-03 15:29:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 70258)
-- Name: bailleurfond; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bailleurfond (
    idbailleurfond integer NOT NULL,
    idsourcefinancement integer,
    nom character varying(254),
    code character varying(254)
);


--
-- TOC entry 182 (class 1259 OID 70264)
-- Name: bonusqualite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bonusqualite (
    idbonusqualite integer NOT NULL,
    idtypeuniteorganisation integer,
    idperiode integer,
    taux bigint
);


--
-- TOC entry 183 (class 1259 OID 70267)
-- Name: budget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE budget (
    idbudget bigint NOT NULL,
    iduniteorganisation integer,
    idindicateur integer,
    idperiode integer,
    cibleideale double precision,
    cibleprogramme double precision,
    coutunitaire double precision,
    total double precision,
    bonusequite double precision,
    scoremoyen double precision,
    bonusqualite double precision,
    total1 double precision,
    total2 double precision,
    idsous_periode integer,
    baq double precision
);


--
-- TOC entry 184 (class 1259 OID 70270)
-- Name: cibleannuelle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cibleannuelle (
    idcibleannuelle bigint NOT NULL,
    idindicateur integer,
    idperiode integer,
    iduniteorganisation integer,
    valeur double precision
);


--
-- TOC entry 185 (class 1259 OID 70273)
-- Name: ciblerealisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ciblerealisation (
    idciblerealisation bigint NOT NULL,
    iduniteorganisation integer,
    idindicateur integer,
    idperiode integer,
    valeurcible double precision,
    valeurrealisee double precision,
    couverture double precision,
    pas double precision DEFAULT 0,
    valeur_annee_fin double precision DEFAULT 0,
    idsousperiode integer,
    c_unitaire_debut double precision DEFAULT 0,
    c_unitaire_fin double precision DEFAULT 0,
    cout_unitaire double precision DEFAULT 0,
    pas_cout_unitaire double precision DEFAULT 0,
    budget double precision DEFAULT 0,
    baq double precision DEFAULT 0,
    bonus_qualite double precision DEFAULT 0,
    bonus_equite double precision DEFAULT 0,
    total1 double precision DEFAULT 0,
    total2 double precision DEFAULT 0,
    pas_val_cible double precision,
    val_cible_fin double precision
);


--
-- TOC entry 186 (class 1259 OID 70288)
-- Name: coutunitaireindicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE coutunitaireindicateur (
    idcoutunitaireindicateur bigint NOT NULL,
    idindicateur integer,
    idperiode integer,
    cout double precision
);


--
-- TOC entry 187 (class 1259 OID 70291)
-- Name: couverture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE couverture (
    idcouverture bigint NOT NULL,
    idperiode integer,
    idindicateur integer,
    iduniteorganisation integer,
    valeur double precision
);


--
-- TOC entry 188 (class 1259 OID 70294)
-- Name: couverturepopulation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE couverturepopulation (
    idcouverturepopulation bigint NOT NULL,
    idperiode integer,
    iduniteorganisation integer,
    valeur double precision,
    pourcentage double precision,
    idsousperiode integer,
    val_debut_score_e double precision,
    val_fin_score_e double precision,
    val_score_equite double precision DEFAULT 0,
    pas_score_equite double precision DEFAULT 0,
    maj_val_debut double precision DEFAULT 0,
    maj_val_fin double precision DEFAULT 0,
    majoration double precision DEFAULT 0,
    pas_majoration double precision DEFAULT 0,
    baq double precision DEFAULT 0,
    val_score_qualite double precision DEFAULT 0
);


--
-- TOC entry 217 (class 1259 OID 70853)
-- Name: devise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devise (
    iddevise integer NOT NULL,
    nom character varying,
    cout_unitaire_default double precision,
    code character varying(30),
    default_m boolean DEFAULT false
);


--
-- TOC entry 218 (class 1259 OID 70862)
-- Name: devise_periode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devise_periode (
    iddevise_periode integer NOT NULL,
    iddevise integer,
    idperiode integer,
    valeur double precision
);


--
-- TOC entry 189 (class 1259 OID 70305)
-- Name: financement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE financement (
    idfinancement bigint NOT NULL,
    idperiode integer,
    idbailleurfond integer,
    idtypeuniteorganisation integer,
    pourcentage double precision,
    idsous_periode integer
);


--
-- TOC entry 190 (class 1259 OID 70308)
-- Name: financementbudget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE financementbudget (
    idfinancementbudget bigint NOT NULL,
    idtype_uo integer,
    idperiode integer,
    idsous_periode integer,
    budget double precision,
    pourcentage double precision,
    financement double precision,
    idbailleurfond integer
);


--
-- TOC entry 191 (class 1259 OID 70311)
-- Name: groupindicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groupindicateur (
    idgroupindicateur integer NOT NULL,
    nom character varying(254),
    code character varying
);


--
-- TOC entry 192 (class 1259 OID 70317)
-- Name: indicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE indicateur (
    idindicateur integer NOT NULL,
    idtypeindicateur integer,
    nom character varying(254),
    code character varying(254),
    pivot double precision,
    ciblemensuelle double precision,
    description character varying(254),
    cible_annuelle double precision,
    numerateur character varying,
    denominateur character varying,
    baseline double precision,
    annee_baseline integer,
    coutunitaire double precision
);


--
-- TOC entry 193 (class 1259 OID 70323)
-- Name: indicateurgroupeindicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE indicateurgroupeindicateur (
    idindicateur integer NOT NULL,
    idgroupindicateur integer NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 70326)
-- Name: indicateurpivot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE indicateurpivot (
    idindicateurpivot integer NOT NULL,
    idtypeindicateur integer,
    idindicateur integer,
    coutunitaire double precision
);


--
-- TOC entry 195 (class 1259 OID 70329)
-- Name: ligne_score_equite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ligne_score_equite (
    id_ligne_score_equite bigint NOT NULL,
    idrubrique_score integer,
    valeur double precision,
    val_debut double precision,
    val_fin double precision,
    pas double precision,
    idcouverture bigint,
    idsous_periode integer
);


--
-- TOC entry 196 (class 1259 OID 70332)
-- Name: lignebaq; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lignebaq (
    id_lignebaq bigint NOT NULL,
    id_type_baq integer,
    quantite double precision,
    cout_unitaire double precision,
    total double precision,
    qte_debut double precision,
    qte_fin double precision,
    cu_debut double precision,
    cu_fin double precision,
    idcouverture bigint,
    idsous_periode integer,
    qte_pas double precision,
    cu_pas double precision
);


--
-- TOC entry 197 (class 1259 OID 70335)
-- Name: menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE menu (
    idmenu integer NOT NULL,
    nom character varying(254),
    ressource character varying(254)
);


--
-- TOC entry 198 (class 1259 OID 70341)
-- Name: mouchard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mouchard (
    idmouchard bigint NOT NULL,
    idutilisateur integer,
    action text,
    date_action date,
    heure time with time zone
);


--
-- TOC entry 199 (class 1259 OID 70347)
-- Name: niveaupyramide; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE niveaupyramide (
    idniveaupyramide integer NOT NULL,
    nom character varying(254),
    numero integer
);


--
-- TOC entry 200 (class 1259 OID 70350)
-- Name: periode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE periode (
    idperiode integer NOT NULL,
    nom character varying(254),
    code character varying(254),
    datedebut date,
    datefin date,
    idparent integer,
    etat boolean,
    idtype_periode integer,
    periode_debut boolean DEFAULT false,
    periode_fin boolean DEFAULT false
);


--
-- TOC entry 201 (class 1259 OID 70358)
-- Name: periodecosting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE periodecosting (
    idperiodecosting integer NOT NULL,
    libelle character varying
);


--
-- TOC entry 202 (class 1259 OID 70364)
-- Name: privilege; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE privilege (
    idprivilege integer NOT NULL,
    idutilisateur bigint,
    idmenu integer
);


--
-- TOC entry 203 (class 1259 OID 70367)
-- Name: rubrique_score_qualite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rubrique_score_qualite (
    id_rubrique_score_qualite integer NOT NULL,
    code character varying,
    nom character varying,
    poids double precision
);


--
-- TOC entry 204 (class 1259 OID 70373)
-- Name: sourcefinancement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sourcefinancement (
    idsourcefinancement integer NOT NULL,
    nom character varying(254),
    code character varying(254)
);


--
-- TOC entry 205 (class 1259 OID 70379)
-- Name: sousperiodecosting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sousperiodecosting (
    idsousperiode integer NOT NULL,
    idperiodecosting integer,
    idperiode integer,
    periodedebut boolean,
    periodefin boolean,
    periodebase integer,
    numero integer
);


--
-- TOC entry 206 (class 1259 OID 70382)
-- Name: tauxurbanisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tauxurbanisation (
    idtauxurbanisation integer NOT NULL,
    iduniteorganisation integer,
    idperiode integer,
    valeur double precision
);


--
-- TOC entry 207 (class 1259 OID 70385)
-- Name: type_baq; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE type_baq (
    id_type_baq integer NOT NULL,
    code character varying(30),
    nom character varying(50)
);


--
-- TOC entry 208 (class 1259 OID 70388)
-- Name: type_periode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE type_periode (
    code character varying,
    nom character varying,
    coef_multiplicateur integer,
    idtype_periode integer NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 70394)
-- Name: typeindicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE typeindicateur (
    idtypeindicateur integer NOT NULL,
    nom character varying(254),
    code character varying
);


--
-- TOC entry 210 (class 1259 OID 70400)
-- Name: typescore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE typescore (
    idtypescore integer NOT NULL,
    nom character varying(254),
    poids integer
);


--
-- TOC entry 211 (class 1259 OID 70403)
-- Name: typestructure_indicateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE typestructure_indicateur (
    id_typestructure_indicateur bigint NOT NULL,
    idtypestructure integer,
    idindicateur integer
);


--
-- TOC entry 212 (class 1259 OID 70406)
-- Name: typeuniteorganisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE typeuniteorganisation (
    idtypeuniteorganisation integer NOT NULL,
    nom character varying(254),
    code character varying(254)
);


--
-- TOC entry 213 (class 1259 OID 70412)
-- Name: uniteorganisation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE uniteorganisation (
    iduniteorganisation integer NOT NULL,
    idniveaupyramide integer,
    idtypeuniteorganisation integer,
    nom character varying(254),
    code character varying(254),
    idparent integer,
    costingfosa boolean DEFAULT true
);


--
-- TOC entry 214 (class 1259 OID 70419)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE utilisateur (
    idutilisateur bigint NOT NULL,
    nom character varying(254),
    prenom character varying(254),
    login character varying(254),
    password character varying(254),
    datecreation date,
    etat boolean,
    photo character varying
);


--
-- TOC entry 215 (class 1259 OID 70425)
-- Name: utilisateur_costing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE utilisateur_costing (
    id_utilisateur_costing bigint NOT NULL,
    idutilisateur integer,
    idperiode_costing integer
);


--
-- TOC entry 216 (class 1259 OID 70428)
-- Name: valeurscore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE valeurscore (
    idvaleurscore integer NOT NULL,
    idtypescore integer,
    iduniteorganisation integer,
    idperiode integer,
    valeur double precision
);


--
-- TOC entry 2486 (class 0 OID 70258)
-- Dependencies: 181
-- Data for Name: bailleurfond; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bailleurfond (idbailleurfond, idsourcefinancement, nom, code) VALUES (3, 1, 'Banque Mondiale', 'BM');
INSERT INTO bailleurfond (idbailleurfond, idsourcefinancement, nom, code) VALUES (4, 1, 'ETAT BIP', 'ETAT_BIP');
INSERT INTO bailleurfond (idbailleurfond, idsourcefinancement, nom, code) VALUES (1, 1, 'Etat - BF', 'Etat - BF');
INSERT INTO bailleurfond (idbailleurfond, idsourcefinancement, nom, code) VALUES (2, 1, 'Etat - FCP', 'Etat - FCP');
INSERT INTO bailleurfond (idbailleurfond, idsourcefinancement, nom, code) VALUES (5, 1, 'Autres - A rechercher', 'Autres - A rechercher');


--
-- TOC entry 2487 (class 0 OID 70264)
-- Dependencies: 182
-- Data for Name: bonusqualite; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2488 (class 0 OID 70267)
-- Dependencies: 183
-- Data for Name: budget; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (177, 19, 9, 9, NULL, NULL, 0, 14804252.265625, 1262531.25, NULL, 1354064.7656250002, 6312656.25, 7575187.5, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (181, 19, 10, 9, NULL, NULL, 0, 6067548.8125, 27225, NULL, 29198.8125, 136125, 163350, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (185, 19, 11, 9, NULL, NULL, 0, 6054022.65625, 25312.5, NULL, 27147.65625, 126562.5, 151875, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (189, 19, 12, 9, NULL, NULL, 0, 6648377.875, 109350, NULL, 117277.87500000003, 546750, 656100, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (193, 19, 13, 9, NULL, NULL, 0, 5951648.21875, 10837.5, NULL, 11623.21875, 54187.5, 65025, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (197, 19, 14, 9, NULL, NULL, 0, 6787420.6991071431, 129009.64285714287, NULL, 138362.84196428573, 645048.21428571432, 774057.85714285716, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (201, 19, 15, 9, NULL, NULL, 0, 6028874.2354910718, 21756.696428571428, NULL, 23334.056919642855, 108783.48214285713, 130540.17857142855, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (205, 19, 16, 9, NULL, NULL, 0, 8940928.75, 433500, NULL, 464928.75, 2167500, 2601000, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (209, 19, 17, 9, NULL, NULL, 0, 7327332.4232812505, 205349.22916666666, NULL, 220237.04828125003, 1026746.1458333333, 1232095.375, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (213, 19, 18, 9, NULL, NULL, 0, 5926982.875, 7350, NULL, 7882.8750000000018, 36750, 44100, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (217, 19, 19, 9, NULL, NULL, 0, 6528737.6968750004, 92433.75, NULL, 99135.196875000009, 462168.75, 554602.5, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (221, 19, 20, 9, NULL, NULL, 0, 5941304.6875, 9375, NULL, 10054.687500000002, 46875, 56250, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (225, 19, 21, 9, NULL, NULL, 0, 7402963.1071428573, 216042.85714285716, NULL, 231705.96428571429, 1080214.2857142857, 1296257.1428571427, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (229, 19, 22, 9, NULL, NULL, 0, 5929829.442584821, 7752.4839285714297, NULL, 8314.5390133928577, 38762.419642857145, 46514.903571428571, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (233, 19, 23, 9, NULL, NULL, 0, 13249003.75, 1042630.4347826089, NULL, 1118221.1413043479, 5213152.1739130439, 6255782.6086956523, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (237, 19, 24, 9, NULL, NULL, 0, 6400848.0625, 74351.086956521758, NULL, 79741.540760869582, 371755.43478260876, 446106.52173913049, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (241, 19, 25, 9, NULL, NULL, 0, 6634557.1645, 107395.85217391304, NULL, 115182.05145652175, 536979.26086956519, 644375.11304347822, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (245, 19, 26, 9, NULL, NULL, 0, 5922739.8988888888, 6750.0740740740748, NULL, 7239.4544444444455, 33750.370370370372, 40500.444444444445, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (249, 19, 27, 9, NULL, NULL, 0, 10925821.8083125, 714149.42499999993, NULL, 765925.25831250008, 3570747.1249999995, 4284896.5499999998, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (253, 19, 28, 9, NULL, NULL, 0, 13233229, 1040400, NULL, 1115829.0000000002, 5202000, 6242400, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (257, 19, 29, 9, NULL, NULL, 0, 19257938.125, 1892250, NULL, 2029438.1250000005, 9461250, 11353500, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (261, 19, 30, 9, NULL, NULL, 0, 6274698.1276785713, 56514.404761904763, NULL, 60611.699107142857, 282572.02380952379, 339086.42857142852, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (265, 19, 31, 9, NULL, NULL, 0, 6274698.1276785713, 56514.404761904763, NULL, 60611.699107142857, 282572.02380952379, 339086.42857142852, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (269, 19, 32, 9, NULL, NULL, 0, 10846708.090803571, 702963.32142857136, NULL, 753928.16223214287, 3514816.6071428568, 4217779.9285714282, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (273, 19, 33, 9, NULL, NULL, 0, 15818423.001517856, 1405927.6071428573, NULL, 1507857.3586607142, 7029638.0357142854, 8435565.6428571418, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (65, 12, 17, NULL, NULL, NULL, NULL, 14750000, 0, NULL, 0, 0, 0, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (66, 12, 17, NULL, NULL, NULL, NULL, 26500000, 0, NULL, 0, 0, 0, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (67, 12, 17, NULL, NULL, NULL, NULL, 38250000, 0, NULL, 0, 0, 0, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (68, 12, 17, NULL, NULL, NULL, NULL, 50000000, 0, NULL, 0, 0, 0, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (277, 19, 34, 9, NULL, NULL, 0, 7569034.1210846156, 239524.08923076923, NULL, 256889.58570000003, 1197620.4461538461, 1437144.5353846154, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (281, 19, 35, 9, NULL, NULL, 0, 6258494.0716346158, 54223.269230769241, NULL, 58154.45625000001, 271116.34615384619, 325339.61538461543, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (285, 19, 36, 9, NULL, NULL, 0, 6258494.0716346158, 54223.269230769241, NULL, 58154.45625000001, 271116.34615384619, 325339.61538461543, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (146, 19, 1, 9, NULL, NULL, 0, 119808009.83796297, 19942361.111111112, NULL, 26141111.689814817, 66474537.037037037, 86416898.148148149, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (150, 19, 2, 9, NULL, NULL, 0, 13528077.135416668, 1112312.5, NULL, 1458056.3020833337, 3707708.3333333335, 4820020.833333334, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (154, 19, 3, 9, NULL, NULL, 0, 8615120.6325972229, 241863.98333333328, NULL, 317043.37148611114, 806213.27777777764, 1048077.2611111109, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (158, 19, 4, 9, NULL, NULL, 0, 96787136.802469134, 15863659.259259259, NULL, 20794613.345679015, 52878864.197530866, 68742523.456790119, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (162, 19, 5, 9, NULL, NULL, 0, 17112099.451388892, 1747308.3333333335, NULL, 2290430.006944445, 5824361.1111111119, 7571669.4444444459, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (166, 19, 6, 9, NULL, NULL, 0, 14180461.797839507, 1227898.1481481483, NULL, 1609569.8225308647, 4092993.8271604944, 5320891.9753086427, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (170, 19, 7, 9, NULL, NULL, 0, 11900087.8125, 823875, NULL, 1079962.8125000002, 2746250, 3570125, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (174, 19, 8, 9, NULL, NULL, 0, 7505961.1945312498, 45349.6875, NULL, 59445.88203125001, 151165.625, 196515.3125, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (178, 19, 9, 9, NULL, NULL, 0, 19889846.6796875, 2239453.125, NULL, 2935549.8046875005, 7464843.75, 9704296.875, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (182, 19, 10, 9, NULL, NULL, 0, 7654475.09375, 71662.499999999985, NULL, 93937.593749999985, 238874.99999999997, 310537.49999999994, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (186, 19, 11, 9, NULL, NULL, 0, 7690703.588541667, 78081.250000000015, NULL, 102351.50520833336, 260270.83333333337, 338352.08333333337, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (190, 19, 12, 9, NULL, NULL, 0, 8840385.0625, 281775, NULL, 369360.06250000006, 939250, 1221025, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (194, 19, 13, 9, NULL, NULL, 0, 7416467.640625, 29493.750000000004, NULL, 38661.390625000015, 98312.500000000015, 127806.25000000001, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (198, 19, 14, 9, NULL, NULL, 0, 9044526.8437003959, 317943.63095238089, NULL, 416771.10957341269, 1059812.1031746031, 1377755.7341269839, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (101, 12, 26, NULL, NULL, NULL, NULL, 14750000, 0, NULL, 0, 0, 0, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (102, 12, 26, NULL, NULL, NULL, NULL, 26500000, 0, NULL, 0, 0, 0, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (103, 12, 26, NULL, NULL, NULL, NULL, 38250000, 0, NULL, 0, 0, 0, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (104, 12, 26, NULL, NULL, NULL, NULL, 50000000, 0, NULL, 0, 0, 0, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (202, 19, 15, 9, NULL, NULL, 0, 7517537.2795758927, 47400.669642857145, NULL, 62134.377790178594, 158002.23214285716, 205402.90178571432, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (206, 19, 16, 9, NULL, NULL, 0, 11707480.625, 789750, NULL, 1035230.6250000002, 2632500, 3422250, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (210, 19, 17, 9, NULL, NULL, 0, 9525210.618055556, 403108.33333333331, NULL, 528407.84027777787, 1343694.4444444445, 1746802.7777777778, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (214, 19, 18, 9, NULL, NULL, 0, 7387576.5625, 24375, NULL, 31951.562500000007, 81250, 105625, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (218, 19, 19, 9, NULL, NULL, 0, 8372640.0362847224, 198902.70833333331, NULL, 260728.30017361112, 663009.02777777775, 861911.73611111101, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (222, 19, 20, 9, NULL, NULL, 0, 7373818.90625, 21937.5, NULL, 28756.406250000007, 73125, 95062.5, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (226, 19, 21, 9, NULL, NULL, 0, 9480749.3670634925, 395230.95238095237, NULL, 518081.90674603189, 1317436.5079365079, 1712667.4603174604, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (230, 19, 22, 9, NULL, NULL, 0, 7362266.4057589285, 19890.696428571431, NULL, 26073.387901785722, 66302.321428571435, 86193.01785714287, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (234, 19, 23, 9, NULL, NULL, 0, 18544038.84963768, 2001010.8695652175, NULL, 2622991.7481884062, 6670036.2318840586, 8671047.1014492754, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (238, 19, 24, 9, NULL, NULL, 0, 8034904.1970108692, 139064.67391304349, NULL, 182290.61005434784, 463548.91304347827, 602613.58695652173, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (138, 12, 35, NULL, NULL, NULL, NULL, 26500000, 0, NULL, 0, 0, 0, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (139, 12, 35, NULL, NULL, NULL, NULL, 38250000, 0, NULL, 0, 0, 0, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (140, 12, 35, NULL, NULL, NULL, NULL, 50000000, 0, NULL, 0, 0, 0, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (141, 12, 36, NULL, NULL, NULL, NULL, 14750000, 0, NULL, 0, 0, 0, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (142, 12, 36, NULL, NULL, NULL, NULL, 26500000, 0, NULL, 0, 0, 0, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (143, 12, 36, NULL, NULL, NULL, NULL, 38250000, 0, NULL, 0, 0, 0, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (144, 12, 36, NULL, NULL, NULL, NULL, 50000000, 0, NULL, 0, 0, 0, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (242, 19, 25, 9, NULL, NULL, 0, 8263368.382706522, 179542.60434782607, NULL, 235350.43053260871, 598475.34782608692, 778017.95217391301, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (246, 19, 26, 9, NULL, NULL, 0, 7360747.0293152006, 19621.502314814818, NULL, 25720.519284336428, 65405.007716049389, 85026.510030864214, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (250, 19, 27, 9, NULL, NULL, 0, 15620158.0625, 1482975, NULL, 1943933.0625000005, 4943250, 6426225, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (254, 19, 28, 9, NULL, NULL, 0, 17170187.333333336, 1757600, NULL, 2303920.666666667, 5858666.666666667, 7616266.666666667, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (258, 19, 29, 9, NULL, NULL, 0, 27510441.770833336, 3589624.9999999995, NULL, 4705400.1041666679, 11965416.666666666, 15555041.666666666, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (262, 19, 30, 9, NULL, NULL, 0, 7802484.6668926366, 97885.958994708984, NULL, 128312.17791556439, 326286.52998236328, 424172.48897707229, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (266, 19, 31, 9, NULL, NULL, 0, 7802484.6668926366, 97885.958994708984, NULL, 128312.17791556439, 326286.52998236328, 424172.48897707229, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (270, 19, 32, 9, NULL, NULL, 0, 13857605.758928571, 1170696.4285714286, NULL, 1534587.9017857146, 3902321.4285714286, 5073017.8571428573, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (274, 19, 33, 9, NULL, NULL, 0, 20465211.517857142, 2341392.8571428573, NULL, 3069175.8035714291, 7804642.8571428573, 10146035.714285715, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (278, 19, 34, 9, NULL, NULL, 0, 10155089.72195, 514706.58000000002, NULL, 674694.5419500001, 1715688.6000000001, 2230395.1800000002, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (282, 19, 35, 9, NULL, NULL, 0, 7807078.6801562505, 98699.899038461546, NULL, 129379.11765625003, 328999.6634615385, 427699.56250000006, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (286, 19, 36, 9, NULL, NULL, 0, 7807078.6801562505, 98699.899038461546, NULL, 129379.11765625003, 328999.6634615385, 427699.56250000006, 3, 7250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (147, 19, 1, 9, NULL, NULL, 0, 173650378.76157409, 33058796.296296299, NULL, 49319591.724537045, 82646990.740740746, 115705787.03703704, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (151, 19, 2, 9, NULL, NULL, 0, 20681834.088541664, 2415291.6666666665, NULL, 3603313.255208333, 6038229.166666666, 8453520.8333333321, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (155, 19, 3, 9, NULL, NULL, 0, 10685355.750201389, 412741.85555555555, NULL, 615759.25575694442, 1031854.6388888888, 1444596.4944444443, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (159, 19, 4, 9, NULL, NULL, 0, 137464529.56172842, 25809846.91358025, NULL, 38505065.364197537, 64524617.283950619, 90334464.197530866, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (163, 19, 5, 9, NULL, NULL, 0, 22881981.612927083, 2856037.3833333333, NULL, 4260850.7712604171, 7140093.458333333, 9996130.8416666668, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (167, 19, 6, 9, NULL, NULL, 0, 23544635.883487653, 2988783.9506172836, NULL, 4458892.0563271604, 7471959.876543209, 10460743.827160493, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (171, 19, 7, 9, NULL, NULL, 0, 18138265.78125, 1905750, NULL, 2843140.7812500005, 4764375, 6670125, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (175, 19, 8, 9, NULL, NULL, 0, 9011318.0863281246, 77389.375, NULL, 115455.27382812501, 193473.4375, 270862.8125, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (179, 19, 9, 9, NULL, NULL, 0, 26082366.85546875, 3497156.25, NULL, 5217319.9804687509, 8742890.625, 12240046.875, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (183, 19, 10, 9, NULL, NULL, 0, 9382392.234375, 151725, NULL, 226354.734375, 379312.5, 531037.5, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (187, 19, 11, 9, NULL, NULL, 0, 9533666.846354166, 182029.16666666669, NULL, 271564.76302083337, 455072.91666666669, 637102.08333333337, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (191, 19, 12, 9, NULL, NULL, 0, 11561962.834020833, 588348.63333333319, NULL, 877742.61735416669, 1470871.583333333, 2059220.2166666663, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (195, 19, 13, 9, NULL, NULL, 0, 8943419.2265625, 63787.5, NULL, 95162.976562500015, 159468.75, 223256.25, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (199, 19, 14, 9, NULL, NULL, 0, 11841333.007465277, 644313.61111111112, NULL, 961235.36857638904, 1610784.0277777778, 2255097.638888889, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (203, 19, 15, 9, NULL, NULL, 0, 9063739.013671875, 87890.625000000015, NULL, 131121.82617187506, 219726.56250000003, 307617.18750000006, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (207, 19, 16, 9, NULL, NULL, 0, 14932234.0625, 1263500, NULL, 1884984.0625, 3158750, 4422250, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (211, 19, 17, 9, NULL, NULL, 0, 12058938.545138888, 687905.55555555562, NULL, 1026269.1006944445, 1719763.888888889, 2407669.4444444445, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (215, 19, 18, 9, NULL, NULL, 0, 8920269.40625, 59150, NULL, 88244.406250000015, 147875, 207025, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (219, 19, 19, 9, NULL, NULL, 0, 10448686.546961807, 365330.97222222225, NULL, 545028.14418402791, 913327.4305555555, 1278658.4027777778, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (223, 19, 20, 9, NULL, NULL, 0, 8839026.640625, 42875, NULL, 63964.140625, 107187.5, 150062.5, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (227, 19, 21, 9, NULL, NULL, 0, 11793232.131944444, 634677.77777777787, NULL, 946859.90972222248, 1586694.4444444445, 2221372.2222222225, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (231, 19, 22, 9, NULL, NULL, 0, 8831717.5194218755, 41410.796428571426, NULL, 61779.731921874991, 103526.99107142857, 144937.78749999998, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (235, 19, 23, 9, NULL, NULL, 0, 25349336.689311594, 3350311.5942028984, NULL, 4998246.1096014502, 8375778.9855072452, 11726090.579710145, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (239, 19, 24, 9, NULL, NULL, 0, 9761753.0305706523, 227720.65217391305, NULL, 339730.74796195654, 569301.63043478259, 797022.28260869568, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (243, 19, 25, 9, NULL, NULL, 0, 9948453.8435923904, 265121.59130434785, NULL, 395528.27402717399, 662803.97826086963, 927925.56956521748, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (247, 19, 26, 9, NULL, NULL, 0, 8845574.139485918, 44186.631172839501, NULL, 65920.930380979946, 110466.57793209875, 154653.20910493826, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (251, 19, 27, 9, NULL, NULL, 0, 21849218.418031253, 2649148.5500000003, NULL, 3952198.4930312508, 6622871.375, 9272019.9250000007, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (255, 19, 28, 9, NULL, NULL, 0, 21712365.083333336, 2621733.333333334, NULL, 3911298.4166666679, 6554333.333333334, 9176066.6666666679, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (259, 19, 29, 9, NULL, NULL, 0, 38329559.774093747, 5950581.6499999994, NULL, 8877523.9990937505, 14876454.124999998, 20827035.774999999, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (263, 19, 30, 9, NULL, NULL, 0, 9371377.9086998459, 149518.54938271604, NULL, 223062.98586033954, 373796.37345679011, 523314.92283950618, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (267, 19, 31, 9, NULL, NULL, 0, 9371377.9086998459, 149518.54938271604, NULL, 223062.98586033954, 373796.37345679011, 523314.92283950618, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (271, 19, 32, 9, NULL, NULL, 0, 17222256.71875, 1722250, NULL, 2569381.7187500005, 4305625, 6027875, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (275, 19, 33, 9, NULL, NULL, 0, 25819513.4375, 3444500, NULL, 5138763.4375000009, 8611250, 12055750, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (279, 19, 34, 9, NULL, NULL, 0, 13339202.475351924, 944375.10461538471, NULL, 1408889.6091980771, 2360937.7615384618, 3305312.8661538465, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (283, 19, 35, 9, NULL, NULL, 0, 9412674.0360977575, 157791.21794871797, NULL, 235404.77327724366, 394478.04487179487, 552269.26282051287, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (287, 19, 36, 9, NULL, NULL, 0, 9412674.0360977575, 157791.21794871797, NULL, 235404.77327724366, 394478.04487179487, 552269.26282051287, 4, 8625000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (148, 19, 1, 9, NULL, NULL, 0, 245406250, 50625000, NULL, 83531250, 101250000, 151875000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (152, 19, 2, 9, NULL, NULL, 0, 31186562.5, 4556250, NULL, 7517812.5000000009, 9112500, 13668750, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (156, 19, 3, 9, NULL, NULL, 0, 13013200, 648000, NULL, 1069200, 1296000, 1944000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (160, 19, 4, 9, NULL, NULL, 0, 190792000, 38880000, NULL, 64152000.000000007, 77760000, 116640000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (164, 19, 5, 9, NULL, NULL, 0, 30088000, 4320000, NULL, 7128000.0000000009, 8640000, 12960000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (168, 19, 6, 9, NULL, NULL, 0, 38248750, 6075000, NULL, 10023750, 12150000, 18225000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (172, 19, 7, 9, NULL, NULL, 0, 27437500, 3750000, NULL, 6187500.0000000009, 7500000, 11250000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (176, 19, 8, 9, NULL, NULL, 0, 10564975, 121500, NULL, 200475.00000000003, 243000, 364500, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (133, 12, 34, NULL, NULL, NULL, NULL, 14750000, 0, NULL, 0, 0, 0, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (134, 12, 34, NULL, NULL, NULL, NULL, 26500000, 0, NULL, 0, 0, 0, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (135, 12, 34, NULL, NULL, NULL, NULL, 38250000, 0, NULL, 0, 0, 0, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (136, 12, 34, NULL, NULL, NULL, NULL, 50000000, 0, NULL, 0, 0, 0, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (137, 12, 35, NULL, NULL, NULL, NULL, 14750000, 0, NULL, 0, 0, 0, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (1, 12, 1, NULL, NULL, NULL, NULL, 28686319.245197497, 2968022.4313717228, NULL, 2946614.5668751732, 8021682.2469506022, 10989704.678322325, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (5, 12, 2, NULL, NULL, NULL, NULL, 16312524.239222888, 332771.29419761966, NULL, 330371.06881548482, 899381.8762097829, 1232153.1704074026, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (9, 12, 3, NULL, NULL, NULL, NULL, 15025863.617445204, 58750.764112903227, NULL, 58327.004378507801, 158785.84895379251, 217536.61306669575, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (13, 12, 4, NULL, NULL, NULL, NULL, 52617746.435078651, 8064706.2446951903, NULL, 8006536.8263424058, 21796503.364041056, 29861209.608736247, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (17, 12, 5, NULL, NULL, NULL, NULL, 17987567.300132718, 689505.75835731102, NULL, 684532.46513402439, 1863529.0766413813, 2553034.8349986924, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (21, 12, 6, NULL, NULL, NULL, NULL, 18481428.08451163, 794683.4498425693, NULL, 788951.52698644146, 2147793.1076826197, 2942476.5575251891, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (25, 12, 7, NULL, NULL, NULL, NULL, 15575867.396060225, 175885.24729655497, NULL, 174616.61552973688, 475365.53323393234, 651250.7805304873, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (29, 12, 8, NULL, NULL, NULL, NULL, 14763595.945578676, 2895.5329411764706, NULL, 2874.6479316176469, 7825.7647058823532, 10721.297647058824, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (33, 12, 9, NULL, NULL, NULL, NULL, 15578945.882991495, 176540.873657141, NULL, 175267.51296370185, 477137.49637065135, 653678.37002779241, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (37, 12, 10, NULL, NULL, NULL, NULL, 17866426.150132615, 663706.28833682009, NULL, 658919.08250709332, 1793800.7792887031, 2457507.0676255231, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (41, 12, 11, NULL, NULL, NULL, NULL, 21775985.955083497, 1496326.5084772371, NULL, 1485533.7480191325, 4044125.6985871275, 5540452.2070643641, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (45, 12, 12, NULL, NULL, NULL, NULL, 21697721.85531947, 1479658.5777572372, NULL, 1468986.0403805086, 3999077.2371817222, 5478735.8149389597, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (49, 12, 13, NULL, NULL, NULL, NULL, 15136524.442964237, 82318.236028257452, NULL, 81724.487940688763, 222481.7189952904, 304799.95502354787, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (53, 12, 14, NULL, NULL, NULL, NULL, 18594307.140290521, 818723.33897608367, NULL, 812818.02029799612, 2212765.7810164425, 3031489.1199925262, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (57, 12, 15, NULL, NULL, NULL, NULL, 15046538.487901485, 63153.897982062779, NULL, 62698.379157090807, 170686.21076233184, 233840.10874439462, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (61, 12, 16, NULL, NULL, NULL, NULL, 21422765.589509688, 1421101.0526165254, NULL, 1410850.8811728219, 3840813.6557203392, 5261914.7083368646, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (69, 12, 18, NULL, NULL, NULL, NULL, 15159421.270804228, 87194.580882352951, NULL, 86565.66051011032, 235661.02941176473, 322855.61029411771, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (73, 12, 19, NULL, NULL, NULL, NULL, 30531613.934174322, 3361015.4399999999, NULL, 3336772.9806608106, 9083825.5135135129, 12444840.953513512, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (77, 12, 20, NULL, NULL, NULL, NULL, 15005272.416711764, 54365.449411764705, NULL, 53973.320241176472, 146933.64705882352, 201299.09647058824, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (81, 12, 21, NULL, NULL, NULL, NULL, 15828262.939973578, 229638.00817502337, NULL, 227981.66646065286, 620643.26533790096, 850281.27351292432, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (85, 12, 22, NULL, NULL, NULL, NULL, 14792078.199373556, 8961.407773109242, NULL, 8896.7705920430653, 24220.021008403357, 33181.428781512601, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (89, 12, 23, NULL, NULL, NULL, NULL, 15672894.650807174, 196549.17322108499, NULL, 195131.49590748022, 531213.98167860811, 727763.15489969309, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (93, 12, 24, NULL, NULL, NULL, NULL, 18508404.862819966, 800428.70307167224, NULL, 794655.34063566546, 2163320.8191126278, 2963749.5221843002, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (97, 12, 25, NULL, NULL, NULL, NULL, 15007897.522224963, 54924.518984641625, NULL, 54528.357335884153, 148444.64590443682, 203369.16488907844, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (105, 12, 27, NULL, NULL, NULL, NULL, 19103592.290692568, 927185.96269781608, NULL, 920498.32070335723, 2505908.0072913948, 3433093.9699892108, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (109, 12, 28, NULL, NULL, NULL, NULL, 18199445.935985465, 734629.62018015957, NULL, 729330.85585892771, 1985485.4599463772, 2720115.080126537, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (113, 12, 29, NULL, NULL, NULL, NULL, 44113960.1091832, 6253652.1117649749, NULL, 6208545.5331885628, 16901762.464229662, 23155414.575994637, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (117, 12, 30, NULL, NULL, NULL, NULL, 15226488.794839082, 101477.97323651453, NULL, 100746.02907144712, 274264.79253112036, 375742.7657676349, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (121, 12, 31, NULL, NULL, NULL, NULL, 17254415.844905678, 533366.25506224064, NULL, 529519.17075630184, 1441530.4190871369, 1974896.6741493775, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (125, 12, 32, NULL, NULL, NULL, NULL, 20477775.194521863, 1219846.1415881913, NULL, 1211047.5891818034, 3296881.4637518683, 4516727.6053400598, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (129, 12, 33, NULL, NULL, NULL, NULL, 29523545.740968272, 3146326.8298191605, NULL, 3123632.8846108369, 8503586.0265382715, 11649912.856357433, 2, 14750000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (2, 12, 1, NULL, NULL, NULL, NULL, 48745246.080295734, 4608122.8627188113, NULL, 5182737.1021206733, 12454386.115456246, 17062508.978175059, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (6, 12, 2, NULL, NULL, NULL, NULL, 29944741.31324444, 713581.28134057019, NULL, 802561.97422665276, 1928598.0576772168, 2642179.339017787, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (10, 12, 3, NULL, NULL, NULL, NULL, 27114554.893084597, 127305.60241935484, NULL, 143180.09493725479, 344069.19572798605, 471374.79814734089, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (14, 12, 4, NULL, NULL, NULL, NULL, 81765122.039329723, 11448220.05839528, NULL, 12875766.687974229, 30941135.292960215, 42389355.351355493, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (18, 12, 5, NULL, NULL, NULL, NULL, 33124530.161966734, 1372277.4198110125, NULL, 1543394.8507746086, 3708857.8913811147, 5081135.3111921269, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (22, 12, 6, NULL, NULL, NULL, NULL, 33237261.185567748, 1395629.753398082, NULL, 1569659.1256883631, 3771972.3064813027, 5167602.0598793849, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (26, 12, 7, NULL, NULL, NULL, NULL, 28267391.10362782, 366116.66702160001, NULL, 411769.93114243523, 989504.50546378375, 1355621.1724853837, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (30, 12, 8, NULL, NULL, NULL, NULL, 26537242.753012501, 7714.869999999999, NULL, 8676.8830124999986, 20850.999999999996, 28565.869999999995, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (34, 12, 9, NULL, NULL, NULL, NULL, 28270469.962283824, 366754.45537928323, NULL, 412487.24912269315, 991228.25778184657, 1357982.7131611297, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (38, 12, 10, NULL, NULL, NULL, NULL, 30133117.748651884, 752603.63046025101, NULL, 846450.25208284508, 2034063.8661087865, 2786667.4965690374, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (42, 12, 11, NULL, NULL, NULL, NULL, 37290513.069936812, 2235264.5503924647, NULL, 2513992.9779430921, 6041255.5416012555, 8276520.0919937203, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (46, 12, 12, NULL, NULL, NULL, NULL, 38162349.923873261, 2415866.3439030345, NULL, 2717115.0829349975, 6529368.4970352286, 8945234.8409382626, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (50, 12, 13, NULL, NULL, NULL, NULL, 27262064.845560439, 157862.42260596546, NULL, 177547.226722135, 426655.19623233908, 584517.61883830454, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (54, 12, 14, NULL, NULL, NULL, NULL, 32162601.248546343, 1173012.9746238168, NULL, 1319282.9371014012, 3170305.3368211263, 4343318.3114449428, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (58, 12, 15, NULL, NULL, NULL, NULL, 27147958.222216927, 134225.13228699553, NULL, 150962.46212724215, 362770.62780269061, 496995.76008968614, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (62, 12, 16, NULL, NULL, NULL, NULL, 34912145.62238577, 1742583.5806497177, NULL, 1959876.6886287075, 4709685.3531073453, 6452268.933757063, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (70, 12, 18, NULL, NULL, NULL, NULL, 27202515.951315489, 145526.81525735292, NULL, 163673.41914636944, 393315.7169117647, 538842.53216911759, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (74, 12, 19, NULL, NULL, NULL, NULL, 48034256.880901262, 4460840.8064516131, NULL, 5017089.5705263726, 12056326.503923278, 16517167.310374891, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (78, 12, 20, NULL, NULL, NULL, NULL, 27137663.695529412, 132092.61176470586, NULL, 148564.02494117644, 357007.05882352934, 489099.6705882352, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (82, 12, 21, NULL, NULL, NULL, NULL, 29089139.09564396, 536342.50744316413, NULL, 603222.24375980999, 1449574.3444409841, 1985916.8518841481, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (86, 12, 22, NULL, NULL, NULL, NULL, 26659746.734558824, 33091.680672268907, NULL, 37218.079096638656, 89436.97478991597, 122528.65546218488, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (90, 12, 23, NULL, NULL, NULL, NULL, 28900702.01112197, 497307.59480450366, NULL, 559319.83576475445, 1344074.5805527125, 1841382.1753572163, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (94, 12, 24, NULL, NULL, NULL, NULL, 30955432.439484321, 922946.86305460741, NULL, 1038034.595201045, 2494450.9812286687, 3417397.8442832762, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (98, 12, 25, NULL, NULL, NULL, NULL, 27374432.68357962, 181139.52197098976, NULL, 203726.88601135879, 489566.27559726965, 670705.79756825941, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (106, 12, 27, NULL, NULL, NULL, NULL, 33619423.946390532, 1474795.115249804, NULL, 1658696.0872223387, 3985932.7439183891, 5460727.8591681933, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (110, 12, 28, NULL, NULL, NULL, NULL, 31715775.283367712, 1080452.5714543553, NULL, 1215180.6269015858, 2920142.0850117709, 4000594.6564661264, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (114, 12, 29, NULL, NULL, NULL, NULL, 64450629.211508147, 7861507.1954191737, NULL, 8841805.2717128266, 21247316.744376145, 29108823.939795319, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (118, 12, 30, NULL, NULL, NULL, NULL, 27474367.497282375, 201841.10909405252, NULL, 227009.87712331422, 545516.51106500684, 747357.6201590593, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (122, 12, 31, NULL, NULL, NULL, NULL, 30135782.326864004, 753155.60024896276, NULL, 847071.05026649369, 2035555.6763485479, 2788711.2765975106, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (126, 12, 32, NULL, NULL, NULL, NULL, 36143234.743623361, 1997604.8065396112, NULL, 2246698.0275172363, 5398931.909566517, 7396536.7161061279, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (130, 12, 33, NULL, NULL, NULL, NULL, 60985869.484158672, 7143779.0814753668, NULL, 8034579.3716687979, 19307511.031014506, 26451290.112489872, 3, 26500000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (3, 12, 1, NULL, NULL, NULL, NULL, 71273698.264092848, 6658933.4728731355, NULL, 8367647.2969679972, 17997117.494251717, 24656050.967124853, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (7, 12, 2, NULL, NULL, NULL, NULL, 44461801.596951157, 1252554.2490727177, NULL, 1573965.5936278473, 3385281.7542505884, 4637836.0033233063, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (11, 12, 3, NULL, NULL, NULL, NULL, 39364331.691515326, 224695.02177419353, NULL, 282352.82710817625, 607283.84263295552, 831978.86440714903, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (15, 12, 4, NULL, NULL, NULL, NULL, 115223881.98265821, 15521095.038244924, NULL, 19503881.435643215, 41948905.508770064, 57470000.547014989, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (19, 12, 5, NULL, NULL, NULL, NULL, 49720507.348179363, 2312925.2429816248, NULL, 2906432.799841994, 6251149.3053557426, 8564074.5483373664, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (23, 12, 6, NULL, NULL, NULL, NULL, 49087243.812231973, 2185233.3132968415, NULL, 2745974.5170517797, 5906035.9818833554, 8091269.2951801969, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (27, 12, 7, NULL, NULL, NULL, NULL, 41386809.312130719, 632509.54994580348, NULL, 794814.49206111941, 1709485.2701237933, 2341994.8200695966, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (31, 12, 8, NULL, NULL, NULL, NULL, 38324667.099323526, 15055.952941176469, NULL, 18919.381676470584, 40691.76470588235, 55747.717647058817, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (35, 12, 9, NULL, NULL, NULL, NULL, 41388912.827865094, 632933.70508501178, NULL, 795347.48741518764, 1710631.6353648966, 2343565.3404499083, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (39, 12, 10, NULL, NULL, NULL, NULL, 42459569.746852875, 848822.09949790791, NULL, 1066633.8649281904, 2294113.7824267782, 3142935.881924686, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (43, 12, 11, NULL, NULL, NULL, NULL, 53844242.079248875, 3144439.4790423862, NULL, 3951317.5217135502, 8498485.0784929357, 11642924.557535322, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (47, 12, 12, NULL, NULL, NULL, NULL, 56157525.504760921, 3610892.3975252877, NULL, 4537464.4652754003, 9759168.6419602372, 13370061.039485525, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (51, 12, 13, NULL, NULL, NULL, NULL, 39541969.808229104, 260514.1596546311, NULL, 327363.32518357545, 704092.32339089492, 964606.48304552608, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (55, 12, 14, NULL, NULL, NULL, NULL, 46190850.190661564, 1601201.4376706528, NULL, 2012077.2998269852, 4327571.4531639265, 5928772.8908345792, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (59, 12, 15, NULL, NULL, NULL, NULL, 39412913.4984354, 234491.10874439465, NULL, 294662.63632777467, 633759.75336322875, 868250.86210762337, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (63, 12, 16, NULL, NULL, NULL, NULL, 48687194.194078669, 2104566.8848481635, NULL, 2644608.7015327658, 5688018.6076977393, 7792585.4925459027, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (71, 12, 18, NULL, NULL, NULL, NULL, 39344314.410253331, 220658.71599264705, NULL, 277280.78617244947, 596374.9080882353, 817033.62408088241, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (75, 12, 19, NULL, NULL, NULL, NULL, 66745071.807186715, 5745776.4406451611, NULL, 7220169.8512843614, 15529125.515257193, 21274901.955902353, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (79, 12, 20, NULL, NULL, NULL, NULL, 39474714.8565, 246952.79999999999, NULL, 310322.05650000001, 667440, 914392.80000000005, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (83, 12, 21, NULL, NULL, NULL, NULL, 43127733.371732734, 983551.3200560573, NULL, 1235935.2407143607, 2658246.810962317, 3641798.1310183741, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (87, 12, 22, NULL, NULL, NULL, NULL, 38615169.341593094, 73633.13256302521, NULL, 92527.742643513659, 199008.46638655462, 272641.59894957981, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (91, 12, 23, NULL, NULL, NULL, NULL, 42950324.097277872, 947778.32617093157, NULL, 1190982.7274017192, 2561563.0437052203, 3509341.3698761519, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (95, 12, 24, NULL, NULL, NULL, NULL, 43490646.613109604, 1056729.5301834471, NULL, 1327891.3256735948, 2856025.7572525595, 3912755.2874360066, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (99, 12, 25, NULL, NULL, NULL, NULL, 40166412.414756358, 386427.42779436859, NULL, 485586.53346369724, 1044398.4534982935, 1430825.8812926621, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (107, 12, 27, NULL, NULL, NULL, NULL, 48993831.619312808, 2166397.5798417469, NULL, 2722305.4453041796, 5855128.5941668842, 8021526.1740086311, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (111, 12, 28, NULL, NULL, NULL, NULL, 45704511.993874446, 1503135.6888915773, NULL, 1888847.4160867117, 4062528.8888961547, 5565664.5777877318, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (115, 12, 29, NULL, NULL, NULL, NULL, 86323123.333802387, 9693515.4734344762, NULL, 12180917.391626084, 26198690.468741827, 35892205.942176305, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (119, 12, 30, NULL, NULL, NULL, NULL, 39936531.910103701, 340074.07951244811, NULL, 427338.69677382644, 919119.13381742733, 1259193.2133298754, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (123, 12, 31, NULL, NULL, NULL, NULL, 43294165.214353666, 1017110.812966805, NULL, 1278106.2582333377, 2748948.1431535268, 3766058.9561203318, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (127, 12, 32, NULL, NULL, NULL, NULL, 53086113.628313206, 2991569.6557324366, NULL, 3759220.5787093197, 8085323.3938714499, 11076893.049603887, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (131, 12, 33, NULL, NULL, NULL, NULL, 102304774.68716602, 12916072.568574065, NULL, 16230397.879202589, 34908304.239389367, 47824376.807963431, 4, 38250000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (4, 12, 1, NULL, NULL, NULL, NULL, 99851813.552749991, 9791729.8019999992, NULL, 13595949.150749998, 26464134.599999998, 36255864.401999995, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (8, 12, 2, NULL, NULL, NULL, NULL, 60684969.075000003, 2098706.6000000001, NULL, 2914082.4750000001, 5672180, 7770886.5999999996, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (12, 12, 3, NULL, NULL, NULL, NULL, 51923289.912500001, 377766.29999999999, NULL, 524533.61249999993, 1020990, 1398756.3, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (16, 12, 4, NULL, NULL, NULL, NULL, 160781804.1275, 21759398.82, NULL, 30213219.307499997, 58809186, 80568584.819999993, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (20, 12, 5, NULL, NULL, NULL, NULL, 69232941.509375006, 3777671.3250000002, NULL, 5245347.6843750002, 10209922.5, 13987593.824999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (24, 12, 6, NULL, NULL, NULL, NULL, 67309651.596874997, 3399905.0249999999, NULL, 4720814.0718749994, 9188932.5, 12588837.525, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (28, 12, 7, NULL, NULL, NULL, NULL, 55342486.892187499, 1049353.7625, NULL, 1457041.8796875, 2836091.25, 3885445.0125000002, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (32, 12, 8, NULL, NULL, NULL, NULL, 50136765.901249997, 26863.110000000001, NULL, 37299.791249999995, 72603, 99466.110000000001, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (36, 12, 9, NULL, NULL, NULL, NULL, 55342484.537500001, 1049353.3, NULL, 1457041.2375, 2836090, 3885443.2999999998, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (40, 12, 10, NULL, NULL, NULL, NULL, 55192882.763750002, 1019969.01, NULL, 1416240.7537499997, 2756673, 3776642.0099999998, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (44, 12, 11, NULL, NULL, NULL, NULL, 73079478.950000003, 4533195.5999999996, NULL, 6294403.3499999996, 12251880, 16785075.600000001, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (48, 12, 12, NULL, NULL, NULL, NULL, 77695442.555000007, 5439848.04, NULL, 7553302.5149999987, 14702292, 20142140.039999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (52, 12, 13, NULL, NULL, NULL, NULL, 52136963.674999997, 419735.40000000002, NULL, 582808.27500000002, 1134420, 1554155.3999999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (56, 12, 14, NULL, NULL, NULL, NULL, 61488478.869999997, 2256529.3599999999, NULL, 3133221.5099999998, 6098728, 8355257.3599999994, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (60, 12, 15, NULL, NULL, NULL, NULL, 51994514.5, 391756, NULL, 543958.5, 1058800, 1450556, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (64, 12, 16, NULL, NULL, NULL, NULL, 63676748.359999999, 2686342.0800000001, NULL, 3730022.2799999998, 7260384, 9946726.0800000001, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (72, 12, 18, NULL, NULL, NULL, NULL, 51709573.765625, 335788.875, NULL, 466247.390625, 907537.5, 1243326.375, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (76, 12, 19, NULL, NULL, NULL, NULL, 89388941.239999995, 7736646.7199999997, NULL, 10742438.52, 20909856, 28646502.719999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (80, 12, 20, NULL, NULL, NULL, NULL, 52188164, 429792, NULL, 596772, 1161600, 1591392, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (84, 12, 21, NULL, NULL, NULL, NULL, 58616347.850000001, 1692394.8, NULL, 2349913.0499999998, 4574040, 6266434.7999999998, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (88, 12, 22, NULL, NULL, NULL, NULL, 50717991.3125, 141025.5, NULL, 195815.8125, 381150, 522175.5, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (92, 12, 23, NULL, NULL, NULL, NULL, 58493269.276250005, 1668220.1100000003, NULL, 2316346.1662500002, 4508703.0000000009, 6176923.1100000013, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (96, 12, 24, NULL, NULL, NULL, NULL, 56553424.96875, 1287202.25, NULL, 1787297.71875, 3478925, 4766127.25, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (100, 12, 25, NULL, NULL, NULL, NULL, 53686310.375, 724053, NULL, 1005357.375, 1956900, 2680953, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (108, 12, 27, NULL, NULL, NULL, NULL, 66412119.130000003, 3223614.6400000001, NULL, 4476032.4900000002, 8712472, 11936086.640000001, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (112, 12, 28, NULL, NULL, NULL, NULL, 60941407.729999997, 2149075.4399999999, NULL, 2984020.2899999996, 5808312, 7957387.4399999995, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (116, 12, 29, NULL, NULL, NULL, NULL, 114109842.70625, 12592245.15, NULL, 17484502.556249999, 34033095, 46625340.149999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (120, 12, 30, NULL, NULL, NULL, NULL, 52827197.931249999, 555308.94999999995, NULL, 771053.98124999995, 1500835, 2056143.95, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (124, 12, 31, NULL, NULL, NULL, NULL, 57237668.899999999, 1421599.2, NULL, 1973909.7, 3842160, 5263759.2000000002, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (128, 12, 32, NULL, NULL, NULL, NULL, 72976957.739999995, 4513058.7199999997, NULL, 6266443.0199999996, 12197456, 16710514.719999999, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (132, 12, 33, NULL, NULL, NULL, NULL, 162192147.03125, 22036413.75, NULL, 30597858.28125, 59557875, 81594288.75, 5, 50000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (180, 19, 9, 9, NULL, NULL, 0, 33606015.625, 5076562.5, NULL, 8376328.1250000009, 10153125, 15229687.5, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (184, 19, 10, 9, NULL, NULL, 0, 11307812.5, 281250, NULL, 464062.50000000006, 562500, 843750, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (188, 19, 11, 9, NULL, NULL, 0, 11674000, 360000, NULL, 594000, 720000, 1080000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (192, 19, 12, 9, NULL, NULL, 0, 15022000, 1080000, NULL, 1782000.0000000002, 2160000, 3240000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (196, 19, 13, 9, NULL, NULL, 0, 10558000, 120000, NULL, 198000.00000000003, 240000, 360000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (200, 19, 14, 9, NULL, NULL, 0, 15382956.25, 1157625, NULL, 1910081.2500000002, 2315250, 3472875, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (145, 19, 1, 9, NULL, NULL, 0, 80224656.25, 10512500, NULL, 11274656.25, 52562500, 63075000, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (149, 19, 2, 9, NULL, NULL, 0, 8747319.0625, 406125, NULL, 435569.0625, 2030625, 2436750, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (153, 19, 3, 9, NULL, NULL, 0, 6746402.7249999996, 123210, NULL, 132142.72500000003, 616050, 739260, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (157, 19, 4, 9, NULL, NULL, 0, 66304321.311194442, 8544266.0037037041, NULL, 9163725.2889722232, 42721330.018518515, 51265596.022222221, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (161, 19, 5, 9, NULL, NULL, 0, 12495920.875, 936150.00000000023, NULL, 1004020.8750000003, 4680750.0000000009, 5616900.0000000009, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (165, 19, 6, 9, NULL, NULL, 0, 8478858.75, 368166.66666666669, NULL, 394858.75, 1840833.3333333333, 2209000, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (169, 19, 7, 9, NULL, NULL, 0, 7789879.375, 270750, NULL, 290379.37500000006, 1353750, 1624500, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (173, 19, 8, 9, NULL, NULL, 0, 6038388.0109374998, 23101.875, NULL, 24776.760937499999, 115509.375, 138611.25, 2, 5875000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (204, 19, 15, 9, NULL, NULL, 0, 10686601.5625, 147656.25, NULL, 243632.81250000003, 295312.5, 442968.75, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (208, 19, 16, 9, NULL, NULL, 0, 18718750, 1875000, NULL, 3093750.0000000005, 3750000, 5625000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (212, 19, 17, 9, NULL, NULL, 0, 15022000, 1080000, NULL, 1782000.0000000002, 2160000, 3240000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (216, 19, 18, 9, NULL, NULL, 0, 10558000, 120000, NULL, 198000.00000000003, 240000, 360000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (220, 19, 19, 9, NULL, NULL, 0, 12832721.875, 609187.5, NULL, 1005159.3750000001, 1218375, 1827562.5, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (224, 19, 20, 9, NULL, NULL, 0, 10348750, 75000, NULL, 123750.00000000001, 150000, 225000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (228, 19, 21, 9, NULL, NULL, 0, 14394250, 945000, NULL, 1559250.0000000002, 1890000, 2835000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (232, 19, 22, 9, NULL, NULL, 0, 10352750.74375, 75860.375, NULL, 125169.61875000001, 151720.75, 227581.125, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (236, 19, 23, 9, NULL, NULL, 0, 34063750, 5175000, NULL, 8538750, 10350000, 15525000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (240, 19, 24, 9, NULL, NULL, 0, 11604250, 345000, NULL, 569250, 690000, 1035000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (244, 19, 25, 9, NULL, NULL, 0, 11697296.5, 365010, NULL, 602266.5, 730020, 1095030, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (248, 19, 26, 9, NULL, NULL, 0, 10397243.6875, 85428.75, NULL, 140957.4375, 170857.5, 256286.25, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (252, 19, 27, 9, NULL, NULL, 0, 30088000, 4320000, NULL, 7128000.0000000009, 8640000, 12960000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (256, 19, 28, 9, NULL, NULL, 0, 26949250, 3645000, NULL, 6014250.0000000009, 7290000, 10935000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (260, 19, 29, 9, NULL, NULL, 0, 52373125, 9112500, NULL, 15035625.000000002, 18225000, 27337500, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (264, 19, 30, 9, NULL, NULL, 0, 10988706.25, 212625, NULL, 350831.25, 425250, 637875, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (268, 19, 31, 9, NULL, NULL, 0, 10988706.25, 212625, NULL, 350831.25, 425250, 637875, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (272, 19, 32, 9, NULL, NULL, 0, 20985625, 2362500, NULL, 3898125.0000000005, 4725000, 7087500, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (276, 19, 33, 9, NULL, NULL, 0, 31971250, 4725000, NULL, 7796250.0000000009, 9450000, 14175000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (280, 19, 34, 9, NULL, NULL, 0, 17316384.399999999, 1573416, NULL, 2596136.4000000004, 3146832, 4720248, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (284, 19, 35, 9, NULL, NULL, 0, 11088100, 234000, NULL, 386100.00000000006, 468000, 702000, 5, 10000000);
INSERT INTO budget (idbudget, iduniteorganisation, idindicateur, idperiode, cibleideale, cibleprogramme, coutunitaire, total, bonusequite, scoremoyen, bonusqualite, total1, total2, idsous_periode, baq) VALUES (288, 19, 36, 9, NULL, NULL, 0, 11088100, 234000, NULL, 386100.00000000006, 468000, 702000, 5, 10000000);


--
-- TOC entry 2489 (class 0 OID 70270)
-- Dependencies: 184
-- Data for Name: cibleannuelle; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2490 (class 0 OID 70273)
-- Dependencies: 185
-- Data for Name: ciblerealisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (2, 12, 2, 9, 19115, 2269, 11.870258958932775, 9.5324352602668068, 50, 1, 1000, 1000, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (65, 12, 8, 1, 73.909999999999997, 10.434352941176469, 14.117647058823529, 8.6274509803921564, 40, 2, 0, 750, 750, 0, 14763595.945578676, 0, 2874.6479316176469, 2895.5329411764706, 7825.7647058823532, 10721.297647058824, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (69, 12, 9, 1, 4328.5299999999997, 954.27499274130275, 22.046167930944286, 9.3179440230185726, 50, 2, 0, 500, 500, 0, 15578945.882991495, 0, 175267.51296370185, 176540.873657141, 477137.49637065135, 653678.37002779241, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (73, 12, 10, 1, 766.14999999999998, 597.93359309623429, 78.043933054393307, 3.9853556485355668, 90, 2, 0, 3000, 3000, 0, 17866426.150132615, 0, 658919.08250709332, 663706.28833682009, 1793800.7792887031, 2457507.0676255231, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (77, 12, 11, 1, 727.55999999999995, 269.60837990580848, 37.056514913657772, 7.6478283621140761, 60, 2, 0, 15000, 15000, 0, 21775985.955083497, 0, 1485533.7480191325, 1496326.5084772371, 4044125.6985871275, 5540452.2070643641, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (81, 12, 12, 1, 1981.3800000000001, 666.51287286362049, 33.63882106731775, 8.7870596442274156, 60, 2, 0, 6000, 6000, 0, 21697721.85531947, 0, 1468986.0403805086, 1479658.5777572372, 3999077.2371817222, 5478735.8149389597, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (85, 12, 13, 1, 77.890000000000001, 9.2700716248037676, 11.90149136577708, 4.3661695447409734, 25, 2, 0, 24000, 24000, 0, 15136524.442964237, 0, 81724.487940688763, 82318.236028257452, 222481.7189952904, 304799.95502354787, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (89, 12, 14, 1, 4271.6499999999996, 2212.7657810164424, 51.801195814648729, 9.3996013951170898, 80, 2, 0, 1000, 1000, 0, 18594307.140290521, 0, 812818.02029799612, 818723.33897608367, 2212765.7810164425, 3031489.1199925262, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (93, 12, 15, 1, 197.72999999999999, 42.671552690582963, 21.58071748878924, 9.4730941704035878, 50, 2, 0, 4000, 4000, 0, 15046538.487901485, 0, 62698.379157090807, 63153.897982062779, 170686.21076233184, 233840.10874439462, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (97, 12, 16, 1, 4093.6300000000001, 2560.5424371468926, 62.549435028248588, 5.8168549905838045, 80, 2, 0, 1500, 1500, 0, 21422765.589509688, 0, 1410850.8811728219, 1421101.0526165254, 3840813.6557203392, 5261914.7083368646, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (105, 12, 18, 1, 114.72, 31.421470588235294, 27.389705882352942, 7.5367647058823533, 50, 2, 0, 7500, 7500, 0, 15159421.270804228, 0, 86565.66051011032, 87194.580882352951, 235661.02941176473, 322855.61029411771, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (109, 12, 19, 1, 1335.48, 756.98545945945943, 56.682650392327808, 7.7724498692240633, 80, 2, 0, 12000, 12000, 0, 30531613.934174322, 0, 3336772.9806608106, 3361015.4399999999, 9083825.5135135129, 12444840.953513512, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (113, 12, 20, 1, 40.030000000000001, 6.1222352941176474, 15.294117647058822, 8.235294117647058, 40, 2, 0, 24000, 24000, 0, 15005272.416711764, 0, 53973.320241176472, 54365.449411764705, 146933.64705882352, 201299.09647058824, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (117, 12, 21, 1, 522.45000000000005, 82.752435378386792, 15.839302398006851, 8.0535658673310486, 40, 2, 0, 7500, 7500, 0, 15828262.939973578, 0, 227981.66646065286, 229638.00817502337, 620643.26533790096, 850281.27351292432, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (121, 12, 22, 1, 29.789999999999999, 2.4220021008403361, 8.1302521008403357, 7.2899159663865545, 30, 2, 0, 10000, 10000, 0, 14792078.199373556, 0, 8896.7705920430653, 8961.407773109242, 24220.021008403357, 33181.428781512601, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (125, 12, 23, 1, 2666.0300000000002, 393.49183828045039, 14.759467758444217, 8.4135107471852617, 40, 2, 0, 1350, 1350, 0, 15672894.650807174, 0, 195131.49590748022, 196549.17322108499, 531213.98167860811, 727763.15489969309, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (129, 12, 24, 1, 1020.8, 865.32832764505122, 84.769624573378834, 5.0767918088737218, 100, 2, 0, 2500, 2500, 0, 18508404.862819966, 0, 794655.34063566546, 800428.70307167224, 2163320.8191126278, 2963749.5221843002, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (133, 12, 25, 1, 133.69999999999999, 11.875571672354948, 8.8822525597269628, 7.0392491467576788, 30, 2, 0, 12500, 12500, 0, 15007897.522224963, 0, 54528.357335884153, 54924.518984641625, 148444.64590443682, 203369.16488907844, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (141, 12, 27, 1, 10866.549999999999, 5011.8160145827887, 46.121501438660744, 11.292832853779753, 80, 2, 0, 500, 500, 0, 19103592.290692568, 0, 920498.32070335723, 927185.96269781608, 2505908.0072913948, 3433093.9699892108, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (145, 12, 28, 1, 7897.6300000000001, 3970.9709198927549, 50.280538843839921, 9.906487052053361, 80, 2, 0, 500, 500, 0, 18199445.935985465, 0, 729330.85585892771, 734629.62018015957, 1985485.4599463772, 2720115.080126537, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (26, 12, 26, 9, 516, 650, 125.96899224806202, 0, 100, 1, 3750, 3750, 3750, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (149, 12, 29, 1, 29747.740000000002, 22535.683285639552, 75.755950823960234, 8.0813497253465876, 100, 2, 0, 750, 750, 0, 44113960.1091832, 0, 6208545.5331885628, 6253652.1117649749, 16901762.464229662, 23155414.575994637, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (62, 12, 7, 4, 4210.1899999999996, 1319.3393406183784, 31.336812367574353, 9.3315938162128234, 50, 3, 0, 750, 750, 0, 28267391.10362782, 0, 411769.93114243523, 366116.66702160001, 989504.50546378375, 1355621.1724853837, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (66, 12, 8, 4, 122.23, 27.801333333333332, 22.745098039215684, 8.6274509803921564, 40, 3, 0, 750, 750, 0, 26537242.753012501, 0, 8676.8830124999986, 7714.869999999999, 20850.999999999996, 28565.869999999995, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (1, 12, 1, 9, 172034, 56456, 32.816768778264759, 9.7958078054338102, 72, 1, 250, 250, 250, 0, 0, 0, 0, 0, 0, 0, 6991.5, 200000);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (27, 12, 27, 9, 22938, 7989, 34.828668584880987, 11.292832853779753, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (70, 12, 9, 4, 6320.7799999999997, 1982.4565155636933, 31.364111953962855, 9.3179440230185726, 50, 3, 0, 500, 500, 0, 28270469.962283824, 0, 412487.24912269315, 366754.45537928323, 991228.25778184657, 1357982.7131611297, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (74, 12, 10, 4, 826.55999999999995, 678.0212887029287, 82.029288702928866, 3.9853556485355668, 90, 3, 0, 3000, 3000, 0, 30133117.748651884, 0, 846450.25208284508, 752603.63046025101, 2034063.8661087865, 2786667.4965690374, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (169, 12, 34, 1, 0, 0, 0, 0, 0, 2, 0, 2500, 2500, 0, 14750000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (170, 12, 34, 4, 0, 0, 0, 0, 0, 3, 0, 2500, 2500, 0, 26500000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (171, 12, 34, 5, 0, 0, 0, 0, 0, 4, 0, 2500, 2500, 0, 38250000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (172, 12, 34, 6, 0, 0, 0, 0, 0, 5, 0, 2500, 2500, 0, 50000000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (173, 12, 35, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 14750000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (174, 12, 35, 4, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 26500000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (175, 12, 35, 5, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 38250000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (176, 12, 35, 6, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 50000000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (177, 12, 36, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 14750000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (178, 12, 36, 4, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 26500000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (179, 12, 36, 5, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 38250000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (180, 12, 36, 6, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 50000000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (78, 12, 11, 4, 900.91999999999996, 402.75036944008372, 44.704343275771848, 7.6478283621140761, 60, 3, 0, 15000, 15000, 0, 37290513.069936812, 0, 2513992.9779430921, 2235264.5503924647, 6041255.5416012555, 8276520.0919937203, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (82, 12, 12, 4, 2565.0100000000002, 1088.2280828392049, 42.425880711545169, 8.7870596442274156, 60, 3, 0, 6000, 6000, 0, 38162349.923873261, 0, 2717115.0829349975, 2415866.3439030345, 6529368.4970352286, 8945234.8409382626, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (86, 12, 13, 4, 109.28, 17.777299843014131, 16.267660910518053, 4.3661695447409734, 25, 3, 0, 24000, 24000, 0, 27262064.845560439, 0, 177547.226722135, 157862.42260596546, 426655.19623233908, 584517.61883830454, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (90, 12, 14, 4, 5180.1700000000001, 3170.3053368211263, 61.200797209765824, 9.3996013951170898, 80, 3, 0, 1000, 1000, 0, 32162601.248546343, 0, 1319282.9371014012, 1173012.9746238168, 3170305.3368211263, 4343318.3114449428, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (94, 12, 15, 4, 292.05000000000001, 90.692656950672642, 31.053811659192824, 9.4730941704035878, 50, 3, 0, 4000, 4000, 0, 27147958.222216927, 0, 150962.46212724215, 134225.13228699553, 362770.62780269061, 496995.76008968614, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (98, 12, 16, 4, 4592.6000000000004, 3139.7902354048965, 68.366290018832387, 5.8168549905838045, 80, 3, 0, 1500, 1500, 0, 34912145.62238577, 0, 1959876.6886287075, 1742583.5806497177, 4709685.3531073453, 6452268.933757063, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (106, 12, 18, 4, 150.15000000000001, 52.44209558823529, 34.92647058823529, 7.5367647058823533, 50, 3, 0, 7500, 7500, 0, 27202515.951315489, 0, 163673.41914636944, 145526.81525735292, 393315.7169117647, 538842.53216911759, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (110, 12, 19, 4, 1558.75, 1004.6938753269399, 64.455100261551877, 7.7724498692240633, 80, 3, 0, 12000, 12000, 0, 48034256.880901262, 0, 5017089.5705263726, 4460840.8064516131, 12056326.503923278, 16517167.310374891, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (28, 12, 28, 9, 15292, 6174, 40.374051791786556, 9.906487052053361, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (114, 12, 20, 4, 63.219999999999999, 14.875294117647057, 23.52941176470588, 8.235294117647058, 40, 3, 0, 24000, 24000, 0, 27137663.695529412, 0, 148564.02494117644, 132092.61176470586, 357007.05882352934, 489099.6705882352, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (118, 12, 21, 4, 808.92999999999995, 193.27657925879785, 23.892868265337899, 8.0535658673310486, 40, 3, 0, 7500, 7500, 0, 29089139.09564396, 0, 603222.24375980999, 536342.50744316413, 1449574.3444409841, 1985916.8518841481, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (29, 12, 29, 9, 38230, 25872, 67.67460109861365, 8.0813497253465876, 100, 1, 750, 750, 750, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (30, 12, 30, 9, 723, 101, 13.969571230982019, 9.0076071922544951, 50, 1, 7000, 7000, 7000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (31, 12, 31, 9, 723, 315, 43.568464730290458, 9.1078838174273855, 80, 1, 7000, 7000, 7000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (122, 12, 22, 4, 58, 8.9436974789915968, 15.420168067226891, 7.2899159663865545, 30, 3, 0, 10000, 10000, 0, 26659746.734558824, 0, 37218.079096638656, 33091.680672268907, 89436.97478991597, 122528.65546218488, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (126, 12, 23, 4, 4296.4300000000003, 995.6108004094167, 23.17297850562948, 8.4135107471852617, 40, 3, 0, 1350, 1350, 0, 28900702.01112197, 0, 559319.83576475445, 497307.59480450366, 1344074.5805527125, 1841382.1753572163, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (130, 12, 24, 4, 1110.54, 997.78039249146752, 89.846416382252556, 5.0767918088737218, 100, 3, 0, 2500, 2500, 0, 30955432.439484321, 0, 1038034.595201045, 922946.86305460741, 2494450.9812286687, 3417397.8442832762, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (134, 12, 25, 4, 245.99000000000001, 39.165302047781573, 15.921501706484641, 7.0392491467576788, 30, 3, 0, 12500, 12500, 0, 27374432.68357962, 0, 203726.88601135879, 181139.52197098976, 489566.27559726965, 670705.79756825941, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (32, 12, 32, 9, 8028, 2645, 32.947184853014448, 11.763203786746388, 80, 1, 2000, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (142, 12, 27, 4, 13884.799999999999, 7971.8654878367779, 57.414334292440493, 11.292832853779753, 80, 3, 0, 500, 500, 0, 33619423.946390532, 0, 1658696.0872223387, 1474795.115249804, 3985932.7439183891, 5460727.8591681933, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (3, 12, 3, 9, 3441, 399, 11.595466434176112, 9.6011333914559724, 50, 1, 1000, 1000, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (4, 12, 4, 9, 206441, 89060, 43.140655199306337, 9.2148362001734156, 80, 1, 375, 375, 375, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (146, 12, 28, 4, 9703.5599999999995, 5840.2841700235413, 60.187025895893278, 9.906487052053361, 80, 3, 0, 500, 500, 0, 31715775.283367712, 0, 1215180.6269015858, 1080452.5714543553, 2920142.0850117709, 4000594.6564661264, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (5, 12, 5, 9, 22938, 3200, 13.950649577120936, 9.0123376057197664, 50, 1, 1500, 1500, 1500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (150, 12, 29, 4, 33791.349999999999, 28329.755659168193, 83.837300549306832, 8.0813497253465876, 100, 3, 0, 750, 750, 0, 64450629.211508147, 0, 8841805.2717128266, 7861507.1954191737, 21247316.744376145, 29108823.939795319, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (55, 12, 5, 5, 10167.530000000001, 4167.4328702371613, 40.987662394280235, 9.0123376057197664, 50, 4, 0, 1500, 1500, 0, 49720507.348179363, 0, 2906432.799841994, 2312925.2429816248, 6251149.3053557426, 8564074.5483373664, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (59, 12, 6, 5, 9375.7199999999993, 3937.3573212555702, 41.995252857973263, 8.0047471420267389, 50, 4, 0, 1500, 1500, 0, 49087243.812231973, 0, 2745974.5170517797, 2185233.3132968415, 5906035.9818833554, 8091269.2951801969, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (6, 12, 6, 9, 20644, 3712, 17.981011431893045, 8.0047471420267389, 50, 1, 1500, 1500, 1500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (7, 12, 7, 9, 12743, 1615, 12.673624735148708, 9.3315938162128234, 50, 1, 750, 750, 750, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (63, 12, 7, 5, 5604.6300000000001, 2279.3136934983913, 40.668406183787177, 9.3315938162128234, 50, 4, 0, 750, 750, 0, 41386809.312130719, 0, 794814.49206111941, 632509.54994580348, 1709485.2701237933, 2341994.8200695966, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (67, 12, 8, 5, 172.94, 54.255686274509806, 31.372549019607845, 8.6274509803921564, 40, 4, 0, 750, 750, 0, 38324667.099323526, 0, 18919.381676470584, 15055.952941176469, 40691.76470588235, 55747.717647058817, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (8, 12, 8, 9, 510, 28, 5.4901960784313726, 8.6274509803921564, 40, 1, 750, 750, 750, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (71, 12, 9, 5, 8409.7600000000002, 3421.2632707297935, 40.682055976981431, 9.3179440230185726, 50, 4, 0, 500, 500, 0, 41388912.827865094, 0, 795347.48741518764, 632933.70508501178, 1710631.6353648966, 2343565.3404499083, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (75, 12, 10, 5, 889.03999999999996, 764.70459414225934, 86.014644351464426, 3.9853556485355668, 90, 4, 0, 3000, 3000, 0, 42459569.746852875, 0, 1066633.8649281904, 848822.09949790791, 2294113.7824267782, 3142935.881924686, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (79, 12, 11, 5, 1082.22, 566.56567189952909, 52.352171637885924, 7.6478283621140761, 60, 4, 0, 15000, 15000, 0, 53844242.079248875, 0, 3951317.5217135502, 3144439.4790423862, 8498485.0784929357, 11642924.557535322, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (83, 12, 12, 5, 3176.0100000000002, 1626.5281069933731, 51.212940355772588, 8.7870596442274156, 60, 4, 0, 6000, 6000, 0, 56157525.504760921, 0, 4537464.4652754003, 3610892.3975252877, 9759168.6419602372, 13370061.039485525, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (87, 12, 13, 5, 142.18000000000001, 29.337180141287284, 20.633830455259027, 4.3661695447409734, 25, 4, 0, 24000, 24000, 0, 39541969.808229104, 0, 327363.32518357545, 260514.1596546311, 704092.32339089492, 964606.48304552608, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (9, 12, 9, 9, 19115, 2433, 12.728223907925711, 9.3179440230185726, 50, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (137, 12, 26, 1, 0, 0, 0, 0, 0, 2, 0, 3750, 3750, 0, 14750000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (138, 12, 26, 4, 0, 0, 0, 0, 0, 3, 0, 3750, 3750, 0, 26500000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (139, 12, 26, 5, 0, 0, 0, 0, 0, 4, 0, 3750, 3750, 0, 38250000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (10, 12, 10, 9, 956, 708, 74.058577405857733, 3.9853556485355668, 90, 1, 3000, 3000, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (11, 12, 11, 9, 1911, 562, 29.408686551543695, 7.6478283621140761, 60, 1, 15000, 15000, 15000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (12, 12, 12, 9, 5734, 1425, 24.851761423090338, 8.7870596442274156, 60, 1, 6000, 6000, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (53, 12, 5, 1, 5410.2399999999998, 1242.3527177609208, 22.962987182840703, 9.0123376057197664, 50, 2, 0, 1500, 1500, 0, 17987567.300132718, 0, 684532.46513402439, 689505.75835731102, 1863529.0766413813, 2553034.8349986924, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (13, 12, 13, 9, 637, 48, 7.5353218210361064, 4.3661695447409734, 25, 1, 24000, 24000, 24000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (14, 12, 14, 9, 8028, 3404, 42.401594419531641, 9.3996013951170898, 80, 1, 1000, 1000, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (15, 12, 15, 9, 892, 108, 12.107623318385651, 9.4730941704035878, 50, 1, 4000, 4000, 4000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (16, 12, 16, 9, 6372, 3615, 56.732580037664782, 5.8168549905838045, 80, 1, 1500, 1500, 1500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (17, 12, 17, 9, 3670, 5617, 153.05177111716623, 0, 100, 1, 2500, 2500, 2500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (18, 12, 18, 9, 408, 81, 19.852941176470587, 7.5367647058823533, 50, 1, 7500, 7500, 7500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (19, 12, 19, 9, 2294, 1122, 48.910200523103747, 7.7724498692240633, 80, 1, 12000, 12000, 12000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (20, 12, 20, 9, 255, 18, 7.0588235294117645, 8.235294117647058, 40, 1, 24000, 24000, 24000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (21, 12, 21, 9, 3211, 250, 7.785736530675802, 8.0535658673310486, 40, 1, 7500, 7500, 7500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (22, 12, 22, 9, 357, 3, 0.84033613445378152, 7.2899159663865545, 30, 1, 10000, 10000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (91, 12, 14, 5, 6129.6700000000001, 4327.5714531639269, 70.600398604882912, 9.3996013951170898, 80, 4, 0, 1000, 1000, 0, 46190850.190661564, 0, 2012077.2998269852, 1601201.4376706528, 4327571.4531639265, 5928772.8908345792, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (95, 12, 15, 5, 390.94999999999999, 158.43993834080717, 40.526905829596416, 9.4730941704035878, 50, 4, 0, 4000, 4000, 0, 39412913.4984354, 0, 294662.63632777467, 234491.10874439465, 633759.75336322875, 868250.86210762337, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (36, 12, 36, 9, 795, 20, 2.5157232704402519, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (35, 12, 35, 9, 795, 35, 4.4025157232704402, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (101, 12, 17, 1, 0, 0, 0, 0, 0, 2, 0, 2500, 2500, 0, 14750000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (102, 12, 17, 4, 0, 0, 0, 0, 0, 3, 0, 2500, 2500, 0, 26500000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (103, 12, 17, 5, 0, 0, 0, 0, 0, 4, 0, 2500, 2500, 0, 38250000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (99, 12, 16, 5, 5111.6899999999996, 3792.0124051318267, 74.183145009416194, 5.8168549905838045, 80, 4, 0, 1500, 1500, 0, 48687194.194078669, 0, 2644608.7015327658, 2104566.8848481635, 5688018.6076977393, 7792585.4925459027, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (107, 12, 18, 5, 187.25999999999999, 79.516654411764691, 42.463235294117645, 7.5367647058823533, 50, 4, 0, 7500, 7500, 0, 39344314.410253331, 0, 277280.78617244947, 220658.71599264705, 596374.9080882353, 817033.62408088241, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (111, 12, 19, 5, 1791.6900000000001, 1294.0937929380996, 72.227550130775938, 7.7724498692240633, 80, 4, 0, 12000, 12000, 0, 66745071.807186715, 0, 7220169.8512843614, 5745776.4406451611, 15529125.515257193, 21274901.955902353, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (115, 12, 20, 5, 87.549999999999997, 27.809999999999995, 31.764705882352938, 8.235294117647058, 40, 4, 0, 24000, 24000, 0, 39474714.8565, 0, 310322.05650000001, 246952.79999999999, 667440, 914392.80000000005, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (119, 12, 21, 5, 1109.46, 354.4329081283089, 31.946434132668948, 8.0535658673310486, 40, 4, 0, 7500, 7500, 0, 43127733.371732734, 0, 1235935.2407143607, 983551.3200560573, 2658246.810962317, 3641798.1310183741, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (123, 12, 22, 5, 87.629999999999995, 19.900846638655459, 22.710084033613445, 7.2899159663865545, 30, 4, 0, 10000, 10000, 0, 38615169.341593094, 0, 92527.742643513659, 73633.13256302521, 199008.46638655462, 272641.59894957981, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (127, 12, 23, 5, 6007.1700000000001, 1897.4541064483114, 31.58648925281474, 8.4135107471852617, 40, 4, 0, 1350, 1350, 0, 42950324.097277872, 0, 1190982.7274017192, 947778.32617093157, 2561563.0437052203, 3509341.3698761519, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (131, 12, 24, 5, 1203.51, 1142.4103029010239, 94.923208191126278, 5.0767918088737218, 100, 4, 0, 2500, 2500, 0, 43490646.613109604, 0, 1327891.3256735948, 1056729.5301834471, 2856025.7572525595, 3912755.2874360066, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (135, 12, 25, 5, 363.88999999999999, 83.551876279863478, 22.96075085324232, 7.0392491467576788, 30, 4, 0, 12500, 12500, 0, 40166412.414756358, 0, 485586.53346369724, 386427.42779436859, 1044398.4534982935, 1430825.8812926621, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (143, 12, 27, 5, 17043.720000000001, 11710.25718833377, 68.707167146220243, 11.292832853779753, 80, 4, 0, 500, 500, 0, 48993831.619312808, 0, 2722305.4453041796, 2166397.5798417469, 5855128.5941668842, 8021526.1740086311, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (147, 12, 28, 5, 11591.74, 8125.0577777923099, 70.093512947946635, 9.906487052053361, 80, 4, 0, 500, 500, 0, 45704511.993874446, 0, 1888847.4160867117, 1503135.6888915773, 4062528.8888961547, 5565664.5777877318, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (151, 12, 29, 5, 38002.720000000001, 34931.587291655771, 91.918650274653416, 8.0813497253465876, 100, 4, 0, 750, 750, 0, 86323123.333802387, 0, 12180917.391626084, 9693515.4734344762, 26198690.468741827, 35892205.942176305, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (23, 12, 23, 9, 17586, 1116, 6.3459570112589558, 8.4135107471852617, 40, 1, 1350, 1350, 1350, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (24, 12, 24, 9, 1172, 934, 79.692832764505113, 5.0767918088737218, 100, 1, 2500, 2500, 2500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (25, 12, 25, 9, 1465, 27, 1.8430034129692834, 7.0392491467576788, 30, 1, 12500, 12500, 12500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (40, 12, 1, 6, 147022.97, 105856.5384, 72, 9.7958078054338102, 72, 5, 250, 250, 250, 0, 99851813.552749991, 0, 13595949.150749998, 9791729.8019999992, 26464134.599999998, 36255864.401999995, 0, 200000);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (44, 12, 2, 6, 11344.360000000001, 5672.1800000000003, 50, 9.5324352602668068, 50, 5, 0, 1000, 1000, 0, 60684969.075000003, 0, 2914082.4750000001, 2098706.6000000001, 5672180, 7770886.5999999996, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (48, 12, 3, 6, 2041.98, 1020.99, 50, 9.6011333914559724, 50, 5, 0, 1000, 1000, 0, 51923289.912500001, 0, 524533.61249999993, 377766.29999999999, 1020990, 1398756.3, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (52, 12, 4, 6, 196030.62, 156824.49599999998, 80, 9.2148362001734156, 80, 5, 0, 375, 375, 0, 160781804.1275, 0, 30213219.307499997, 21759398.82, 58809186, 80568584.819999993, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (56, 12, 5, 6, 13613.23, 6806.6149999999998, 50, 9.0123376057197664, 50, 5, 0, 1500, 1500, 0, 69232941.509375006, 0, 5245347.6843750002, 3777671.3250000002, 10209922.5, 13987593.824999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (37, 12, 1, 1, 75298.729999999996, 32086.728987802406, 42.612576583698569, 9.7958078054338102, 72, 2, 250, 250, 250, 0, 28686319.245197497, 0, 2946614.5668751732, 2968022.4313717228, 8021682.2469506022, 10989704.678322325, 0, 200000);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (60, 12, 6, 6, 12251.91, 6125.9549999999999, 50, 8.0047471420267389, 50, 5, 0, 1500, 1500, 0, 67309651.596874997, 0, 4720814.0718749994, 3399905.0249999999, 9188932.5, 12588837.525, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (64, 12, 7, 6, 7562.9099999999999, 3781.4549999999999, 50, 9.3315938162128234, 50, 5, 0, 750, 750, 0, 55342486.892187499, 0, 1457041.8796875, 1049353.7625, 2836091.25, 3885445.0125000002, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (68, 12, 8, 6, 242.00999999999999, 96.804000000000002, 40, 8.6274509803921564, 40, 5, 0, 750, 750, 0, 50136765.901249997, 0, 37299.791249999995, 26863.110000000001, 72603, 99466.110000000001, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (72, 12, 9, 6, 11344.360000000001, 5672.1800000000003, 50, 9.3179440230185726, 50, 5, 0, 500, 500, 0, 55342484.537500001, 0, 1457041.2375, 1049353.3, 2836090, 3885443.2999999998, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (76, 12, 10, 6, 1020.99, 918.89100000000008, 90, 3.9853556485355668, 90, 5, 0, 3000, 3000, 0, 55192882.763750002, 0, 1416240.7537499997, 1019969.01, 2756673, 3776642.0099999998, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (80, 12, 11, 6, 1361.3199999999999, 816.79199999999992, 60, 7.6478283621140761, 60, 5, 0, 15000, 15000, 0, 73079478.950000003, 0, 6294403.3499999996, 4533195.5999999996, 12251880, 16785075.600000001, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (84, 12, 12, 6, 4083.9699999999998, 2450.3819999999996, 60, 8.7870596442274156, 60, 5, 0, 6000, 6000, 0, 77695442.555000007, 0, 7553302.5149999987, 5439848.04, 14702292, 20142140.039999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (88, 12, 13, 6, 189.06999999999999, 47.267499999999998, 25, 4.3661695447409734, 25, 5, 0, 24000, 24000, 0, 52136963.674999997, 0, 582808.27500000002, 419735.40000000002, 1134420, 1554155.3999999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (92, 12, 14, 6, 7623.4099999999999, 6098.7280000000001, 80, 9.3996013951170898, 80, 5, 0, 1000, 1000, 0, 61488478.869999997, 0, 3133221.5099999998, 2256529.3599999999, 6098728, 8355257.3599999994, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (96, 12, 15, 6, 529.39999999999998, 264.69999999999999, 50, 9.4730941704035878, 50, 5, 0, 4000, 4000, 0, 51994514.5, 0, 543958.5, 391756, 1058800, 1450556, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (100, 12, 16, 6, 6050.3199999999997, 4840.2559999999994, 80, 5.8168549905838045, 80, 5, 0, 1500, 1500, 0, 63676748.359999999, 0, 3730022.2799999998, 2686342.0800000001, 7260384, 9946726.0800000001, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (108, 12, 18, 6, 242.00999999999999, 121.005, 50, 7.5367647058823533, 50, 5, 0, 7500, 7500, 0, 51709573.765625, 0, 466247.390625, 335788.875, 907537.5, 1243326.375, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (112, 12, 19, 6, 2178.1100000000001, 1742.4880000000003, 80, 7.7724498692240633, 80, 5, 0, 12000, 12000, 0, 89388941.239999995, 0, 10742438.52, 7736646.7199999997, 20909856, 28646502.719999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (104, 12, 17, 6, 0, 0, 0, 0, 0, 5, 0, 2500, 2500, 0, 50000000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (116, 12, 20, 6, 121, 48.399999999999999, 40, 8.235294117647058, 40, 5, 0, 24000, 24000, 0, 52188164, 0, 596772, 429792, 1161600, 1591392, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (120, 12, 21, 6, 1524.6800000000001, 609.87200000000007, 40, 8.0535658673310486, 40, 5, 0, 7500, 7500, 0, 58616347.850000001, 0, 2349913.0499999998, 1692394.8, 4574040, 6266434.7999999998, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (124, 12, 22, 6, 127.05, 38.115000000000002, 30, 7.2899159663865545, 30, 5, 0, 10000, 10000, 0, 50717991.3125, 0, 195815.8125, 141025.5, 381150, 522175.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (128, 12, 23, 6, 8349.4500000000007, 3339.7800000000002, 40, 8.4135107471852617, 40, 5, 0, 1350, 1350, 0, 58493269.276250005, 0, 2316346.1662500002, 1668220.1100000003, 4508703.0000000009, 6176923.1100000013, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (132, 12, 24, 6, 1391.5699999999999, 1391.5699999999999, 100, 5.0767918088737218, 100, 5, 0, 2500, 2500, 0, 56553424.96875, 0, 1787297.71875, 1287202.25, 3478925, 4766127.25, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (136, 12, 25, 6, 521.84000000000003, 156.55200000000002, 30, 7.0392491467576788, 30, 5, 0, 12500, 12500, 0, 53686310.375, 0, 1005357.375, 724053, 1956900, 2680953, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (144, 12, 27, 6, 21781.18, 17424.944, 80, 11.292832853779753, 80, 5, 0, 500, 500, 0, 66412119.130000003, 0, 4476032.4900000002, 3223614.6400000001, 8712472, 11936086.640000001, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (148, 12, 28, 6, 14520.780000000001, 11616.624000000002, 80, 9.906487052053361, 80, 5, 0, 500, 500, 0, 60941407.729999997, 0, 2984020.2899999996, 2149075.4399999999, 5808312, 7957387.4399999995, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (41, 12, 2, 1, 4202.1899999999996, 899.38187620978283, 21.402694219199581, 9.5324352602668068, 50, 2, 0, 1000, 1000, 0, 16312524.239222888, 0, 330371.06881548482, 332771.29419761966, 899381.8762097829, 1232153.1704074026, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (45, 12, 3, 1, 749.11000000000001, 158.78584895379251, 21.196599825632084, 9.6011333914559724, 50, 2, 0, 1000, 1000, 0, 15025863.617445204, 0, 58327.004378507801, 58750.764112903227, 158785.84895379251, 217536.61306669575, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (49, 12, 4, 1, 111017.98, 58124.008970776151, 52.355491399479753, 9.2148362001734156, 80, 2, 0, 375, 375, 0, 52617746.435078651, 0, 8006536.8263424058, 8064706.2446951903, 21796503.364041056, 29861209.608736247, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (57, 12, 6, 1, 5510.1800000000003, 1431.8620717884132, 25.985758573919782, 8.0047471420267389, 50, 2, 0, 1500, 1500, 0, 18481428.08451163, 0, 788951.52698644146, 794683.4498425693, 2147793.1076826197, 2942476.5575251891, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (61, 12, 7, 1, 2880.3200000000002, 633.82071097857647, 22.00521855136153, 9.3315938162128234, 50, 2, 0, 750, 750, 0, 15575867.396060225, 0, 174616.61552973688, 175885.24729655497, 475365.53323393234, 651250.7805304873, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (38, 12, 1, 4, 95056.440000000002, 49817.544461824989, 52.40838438913238, 9.7958078054338102, 72, 3, 250, 250, 250, 0, 48745246.080295734, 0, 5182737.1021206733, 4608122.8627188113, 12454386.115456246, 17062508.978175059, 0, 200000);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (42, 12, 2, 4, 6234.3299999999999, 1928.598057677217, 30.93512947946639, 9.5324352602668068, 50, 3, 0, 1000, 1000, 0, 29944741.31324444, 0, 802561.97422665276, 713581.28134057019, 1928598.0576772168, 2642179.339017787, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (46, 12, 3, 4, 1117.1900000000001, 344.06919572798608, 30.797733217088059, 9.6011333914559724, 50, 3, 0, 1000, 1000, 0, 27114554.893084597, 0, 143180.09493725479, 127305.60241935484, 344069.19572798605, 471374.79814734089, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (50, 12, 4, 4, 134008.85999999999, 82509.694114560567, 61.570327599653169, 9.2148362001734156, 80, 3, 0, 375, 375, 0, 81765122.039329723, 0, 12875766.687974229, 11448220.05839528, 30941135.292960215, 42389355.351355493, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (54, 12, 5, 4, 7732.75, 2472.5719275874098, 31.975324788560471, 9.0123376057197664, 50, 3, 0, 1500, 1500, 0, 33124530.161966734, 0, 1543394.8507746086, 1372277.4198110125, 3708857.8913811147, 5081135.3111921269, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (58, 12, 6, 4, 7398.0900000000001, 2514.6482043208684, 33.990505715946526, 8.0047471420267389, 50, 3, 0, 1500, 1500, 0, 33237261.185567748, 0, 1569659.1256883631, 1395629.753398082, 3771972.3064813027, 5167602.0598793849, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (39, 12, 1, 5, 115729.28999999999, 71988.469977006869, 62.20419219456619, 9.7958078054338102, 72, 4, 250, 250, 250, 0, 71273698.264092848, 0, 8367647.2969679972, 6658933.4728731355, 17997117.494251717, 24656050.967124853, 0, 200000);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (43, 12, 2, 5, 8365.4200000000001, 3385.2817542505882, 40.467564739733191, 9.5324352602668068, 50, 4, 0, 1000, 1000, 0, 44461801.596951157, 0, 1573965.5936278473, 1252554.2490727177, 3385281.7542505884, 4637836.0033233063, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (140, 12, 26, 6, 0, 0, 0, 0, 0, 5, 0, 3750, 3750, 0, 50000000, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (33, 12, 33, 9, 16057, 1672, 10.41290402939528, 9.8967739926511804, 50, 1, 12500, 12500, 12500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (34, 12, 34, 9, 7952, 0, 0, 0, 0, 1, 2500, 2500, 2500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (47, 12, 3, 5, 1503.22, 607.2838426329555, 40.398866608544026, 9.6011333914559724, 50, 4, 0, 1000, 1000, 0, 39364331.691515326, 0, 282352.82710817625, 224695.02177419353, 607283.84263295552, 831978.86440714903, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (51, 12, 4, 5, 158032.76000000001, 111863.74802338684, 70.785163799826591, 9.2148362001734156, 80, 4, 0, 375, 375, 0, 115223881.98265821, 0, 19503881.435643215, 15521095.038244924, 41948905.508770064, 57470000.547014989, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (281, 19, 17, 1, 2663.9899999999998, 2053.4922916666665, 77.083333333333329, 7.6388888888888893, 100, 2, 0, 500, 500, 0, 7327332.4232812505, 0, 220237.04828125003, 205349.22916666666, 1026746.1458333333, 1232095.375, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (317, 19, 26, 1, 181.12, 67.500740740740738, 37.268518518518519, 12.577160493827162, 75, 2, 0, 500, 500, 0, 5922739.8988888888, 0, 7239.4544444444455, 6750.0740740740748, 33750.370370370372, 40500.444444444445, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (196, 19, 16, 9, 5000, 4000, 80, 5, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (321, 19, 27, 1, 12419.99, 7141.4942499999997, 57.5, 7.5, 80, 2, 0, 500, 500, 0, 10925821.8083125, 0, 765925.25831250008, 714149.42499999993, 3570747.1249999995, 4284896.5499999998, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (325, 19, 28, 1, 12240, 10404, 85, 1.6666666666666643, 90, 2, 0, 500, 500, 0, 13233229, 0, 1115829.0000000002, 1040400, 5202000, 6242400, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (329, 19, 29, 1, 26100, 18922.5, 72.5, 5.8333333333333357, 90, 2, 0, 500, 500, 0, 19257938.125, 0, 2029438.1250000005, 1892250, 9461250, 11353500, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (181, 19, 1, 9, 135000, 100000, 74.074074074074076, 6.481481481481481, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (182, 19, 2, 9, 15000, 5000, 33.333333333333329, 14.166666666666668, 90, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (183, 19, 3, 9, 2700, 1500, 55.555555555555557, 6.1111111111111107, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (184, 19, 4, 9, 162000, 100000, 61.728395061728392, 4.567901234567902, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (185, 19, 5, 9, 18000, 11000, 61.111111111111114, 4.7222222222222214, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (186, 19, 6, 9, 16200, 4000, 24.691358024691358, 18.827160493827162, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (187, 19, 7, 9, 10000, 3000, 30, 17.5, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (188, 19, 8, 9, 400, 250, 62.5, 6.875, 90, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (189, 19, 9, 9, 15000, 12000, 80, 3.75, 95, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (190, 19, 10, 9, 750, 300, 40, 15, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (191, 19, 11, 9, 1500, 350, 23.333333333333332, 14.166666666666668, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (153, 12, 30, 1, 170.52000000000001, 39.180684647302911, 22.977178423236516, 9.0076071922544951, 50, 2, 0, 7000, 7000, 0, 15226488.794839082, 0, 100746.02907144712, 101477.97323651453, 274264.79253112036, 375742.7657676349, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (157, 12, 31, 1, 390.94, 205.93291701244812, 52.676348547717843, 9.1078838174273855, 80, 2, 0, 7000, 7000, 0, 17254415.844905678, 0, 529519.17075630184, 533366.25506224064, 1441530.4190871369, 1974896.6741493775, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (161, 12, 32, 1, 3686.9299999999998, 1648.440731875934, 44.710388639760836, 11.763203786746388, 80, 2, 0, 2000, 2000, 0, 20477775.194521863, 0, 1211047.5891818034, 1219846.1415881913, 3296881.4637518683, 4516727.6053400598, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (165, 12, 33, 1, 3349.5700000000002, 680.28688212306167, 20.309678022046462, 9.8967739926511804, 50, 2, 0, 12500, 12500, 0, 29523545.740968272, 0, 3123632.8846108369, 3146326.8298191605, 8503586.0265382715, 11649912.856357433, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (154, 12, 30, 4, 243.65000000000001, 77.930930152143844, 31.98478561549101, 9.0076071922544951, 50, 3, 0, 7000, 7000, 0, 27474367.497282375, 0, 227009.87712331422, 201841.10909405252, 545516.51106500684, 747357.6201590593, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (158, 12, 31, 4, 470.66000000000003, 290.79366804979253, 61.784232365145229, 9.1078838174273855, 80, 3, 0, 7000, 7000, 0, 30135782.326864004, 0, 847071.05026649369, 753155.60024896276, 2035555.6763485479, 2788711.2765975106, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (162, 12, 32, 4, 4780.0500000000002, 2699.4659547832584, 56.473592426507224, 11.763203786746388, 80, 3, 0, 2000, 2000, 0, 36143234.743623361, 0, 2246698.0275172363, 1997604.8065396112, 5398931.909566517, 7396536.7161061279, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (166, 12, 33, 4, 5113.4799999999996, 1544.6008824811609, 30.206452014697639, 9.8967739926511804, 50, 3, 0, 12500, 12500, 0, 60985869.484158672, 0, 8034579.3716687979, 7143779.0814753668, 19307511.031014506, 26451290.112489872, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (155, 12, 30, 5, 320.31, 131.30273340248962, 40.992392807745503, 9.0076071922544951, 50, 4, 0, 7000, 7000, 0, 39936531.910103701, 0, 427338.69677382644, 340074.07951244811, 919119.13381742733, 1259193.2133298754, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (159, 12, 31, 5, 553.95000000000005, 392.70687759336101, 70.892116182572607, 9.1078838174273855, 80, 4, 0, 7000, 7000, 0, 43294165.214353666, 0, 1278106.2582333377, 1017110.812966805, 2748948.1431535268, 3766058.9561203318, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (163, 12, 32, 5, 5924.46, 4042.6616969357251, 68.236796213253612, 11.763203786746388, 80, 4, 0, 2000, 2000, 0, 53086113.628313206, 0, 3759220.5787093197, 2991569.6557324366, 8085323.3938714499, 11076893.049603887, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (167, 12, 33, 5, 6963.6899999999996, 2792.6643391511489, 40.103226007348823, 9.8967739926511804, 50, 4, 0, 12500, 12500, 0, 102304774.68716602, 0, 16230397.879202589, 12916072.568574065, 34908304.239389367, 47824376.807963431, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (152, 12, 29, 6, 45377.459999999999, 45377.459999999999, 100, 8.0813497253465876, 100, 5, 0, 750, 750, 0, 114109842.70625, 0, 17484502.556249999, 12592245.15, 34033095, 46625340.149999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (156, 12, 30, 6, 428.81, 214.405, 50, 9.0076071922544951, 50, 5, 0, 7000, 7000, 0, 52827197.931249999, 0, 771053.98124999995, 555308.94999999995, 1500835, 2056143.95, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (160, 12, 31, 6, 686.10000000000002, 548.88, 80, 9.1078838174273855, 80, 5, 0, 7000, 7000, 0, 57237668.899999999, 0, 1973909.7, 1421599.2, 3842160, 5263759.2000000002, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (164, 12, 32, 6, 7623.4099999999999, 6098.7280000000001, 80, 11.763203786746388, 80, 5, 0, 2000, 2000, 0, 72976957.739999995, 0, 6266443.0199999996, 4513058.7199999997, 12197456, 16710514.719999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (168, 12, 33, 6, 9529.2600000000002, 4764.6300000000001, 50, 9.8967739926511804, 50, 5, 0, 12500, 12500, 0, 162192147.03125, 0, 30597858.28125, 22036413.75, 59557875, 81594288.75, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (237, 19, 6, 1, 8460, 3681.666666666667, 43.518518518518519, 18.827160493827162, 100, 2, 0, 500, 500, 0, 8478858.75, 0, 394858.75, 368166.66666666669, 1840833.3333333333, 2209000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (241, 19, 7, 1, 5700, 2707.5, 47.5, 17.5, 100, 2, 0, 500, 500, 0, 7789879.375, 0, 290379.37500000006, 270750, 1353750, 1624500, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (245, 19, 8, 1, 333, 231.01875000000001, 69.375, 6.875, 90, 2, 0, 500, 500, 0, 6038388.0109374998, 0, 24776.760937499999, 23101.875, 115509.375, 138611.25, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (249, 19, 9, 1, 15075, 12625.3125, 83.75, 3.75, 95, 2, 0, 500, 500, 0, 14804252.265625, 0, 1354064.7656250002, 1262531.25, 6312656.25, 7575187.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (253, 19, 10, 1, 495, 272.25, 55, 15, 100, 2, 0, 500, 500, 0, 6067548.8125, 0, 29198.8125, 27225, 136125, 163350, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (257, 19, 11, 1, 675, 253.125, 37.5, 14.166666666666668, 80, 2, 0, 500, 500, 0, 6054022.65625, 0, 27147.65625, 25312.5, 126562.5, 151875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (261, 19, 12, 1, 2430, 1093.5, 45, 11.666666666666668, 80, 2, 0, 500, 500, 0, 6648377.875, 0, 117277.87500000003, 109350, 546750, 656100, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (265, 19, 13, 1, 255, 108.375, 42.5, 12.5, 80, 2, 0, 500, 500, 0, 5951648.21875, 0, 11623.21875, 10837.5, 54187.5, 65025, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (269, 19, 14, 1, 3123, 1290.0964285714285, 41.30952380952381, 9.5634920634920633, 70, 2, 0, 500, 500, 0, 6787420.6991071431, 0, 138362.84196428573, 129009.64285714287, 645048.21428571432, 774057.85714285716, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (273, 19, 15, 1, 427.5, 217.56696428571428, 50.892857142857139, 8.0357142857142865, 75, 2, 0, 500, 500, 0, 6028874.2354910718, 0, 23334.056919642855, 21756.696428571428, 108783.48214285713, 130540.17857142855, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (277, 19, 16, 1, 5100, 4335, 85, 5, 100, 2, 0, 500, 500, 0, 8940928.75, 0, 464928.75, 433500, 2167500, 2601000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (285, 19, 18, 1, 168, 73.5, 43.75, 18.75, 100, 2, 0, 500, 500, 0, 5926982.875, 0, 7882.8750000000018, 7350, 36750, 44100, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (289, 19, 19, 1, 1413, 924.33749999999998, 65.416666666666671, 9.8611111111111107, 95, 2, 0, 500, 500, 0, 6528737.6968750004, 0, 99135.196875000009, 92433.75, 462168.75, 554602.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (293, 19, 20, 1, 150, 93.75, 62.5, 12.5, 100, 2, 0, 500, 500, 0, 5941304.6875, 0, 10054.687500000002, 9375, 46875, 56250, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (297, 19, 21, 1, 2556, 2160.4285714285711, 84.523809523809518, 5.1587301587301582, 100, 2, 0, 500, 500, 0, 7402963.1071428573, 0, 231705.96428571429, 216042.85714285716, 1080214.2857142857, 1296257.1428571427, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (301, 19, 22, 1, 161.38999999999999, 77.524839285714279, 48.035714285714285, 12.321428571428571, 85, 2, 0, 500, 500, 0, 5929829.442584821, 0, 8314.5390133928577, 7752.4839285714297, 38762.419642857145, 46514.903571428571, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (305, 19, 23, 1, 13140, 10426.304347826088, 79.34782608695653, 6.8840579710144922, 100, 2, 0, 500, 500, 0, 13249003.75, 0, 1118221.1413043479, 1042630.4347826089, 5213152.1739130439, 6255782.6086956523, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (309, 19, 24, 1, 906, 743.51086956521749, 82.065217391304358, 5.9782608695652151, 100, 2, 0, 500, 500, 0, 6400848.0625, 0, 79741.540760869582, 74351.086956521758, 371755.43478260876, 446106.52173913049, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (313, 19, 25, 1, 1217.4000000000001, 1073.9585217391304, 88.217391304347828, 1.2608695652173907, 92, 2, 0, 500, 500, 0, 6634557.1645, 0, 115182.05145652175, 107395.85217391304, 536979.26086956519, 644375.11304347822, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (333, 19, 30, 1, 620.10000000000002, 565.14404761904768, 91.137566137566139, 2.954144620811288, 100, 2, 0, 500, 500, 0, 6274698.1276785713, 0, 60611.699107142857, 56514.404761904763, 282572.02380952379, 339086.42857142852, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (337, 19, 31, 1, 620.10000000000002, 565.14404761904768, 91.137566137566139, 2.954144620811288, 100, 2, 0, 500, 500, 0, 6274698.1276785713, 0, 60611.699107142857, 56514.404761904763, 282572.02380952379, 339086.42857142852, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (341, 19, 32, 1, 7289.9899999999998, 7029.6332142857136, 96.428571428571416, 1.1904761904761934, 100, 2, 0, 500, 500, 0, 10846708.090803571, 0, 753928.16223214287, 702963.32142857136, 3514816.6071428568, 4217779.9285714282, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (345, 19, 33, 1, 14579.99, 14059.276071428571, 96.428571428571416, 1.1904761904761934, 100, 2, 0, 500, 500, 0, 15818423.001517856, 0, 1507857.3586607142, 1405927.6071428573, 7029638.0357142854, 8435565.6428571418, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (349, 19, 34, 1, 4235.04, 2395.2408923076923, 56.557692307692307, 8.4807692307692299, 82, 2, 0, 500, 500, 0, 7569034.1210846156, 0, 256889.58570000003, 239524.08923076923, 1197620.4461538461, 1437144.5353846154, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (353, 19, 35, 1, 637.20000000000005, 542.23269230769245, 85.096153846153854, 4.9679487179487154, 100, 2, 0, 500, 500, 0, 6258494.0716346158, 0, 58154.45625000001, 54223.269230769241, 271116.34615384619, 325339.61538461543, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (357, 19, 36, 1, 637.20000000000005, 542.23269230769245, 85.096153846153854, 4.9679487179487154, 100, 2, 0, 500, 500, 0, 6258494.0716346158, 0, 58154.45625000001, 54223.269230769241, 271116.34615384619, 325339.61538461543, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (218, 19, 1, 4, 152750, 132949.07407407407, 87.037037037037038, 6.481481481481481, 100, 3, 0, 500, 500, 0, 119808009.83796297, 0, 26141111.689814817, 19942361.111111112, 66474537.037037037, 86416898.148148149, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (222, 19, 2, 4, 12025, 7415.4166666666661, 61.666666666666664, 14.166666666666668, 90, 3, 0, 500, 500, 0, 13528077.135416668, 0, 1458056.3020833337, 1112312.5, 3707708.3333333335, 4820020.833333334, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (226, 19, 3, 4, 2378.9899999999998, 1612.4265555555553, 67.777777777777771, 6.1111111111111107, 80, 3, 0, 500, 500, 0, 8615120.6325972229, 0, 317043.37148611114, 241863.98333333328, 806213.27777777764, 1048077.2611111109, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (230, 19, 4, 4, 149240, 105757.72839506174, 70.864197530864203, 4.567901234567902, 80, 3, 0, 500, 500, 0, 96787136.802469134, 0, 20794613.345679015, 15863659.259259259, 52878864.197530866, 68742523.456790119, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (234, 19, 5, 4, 16510, 11648.722222222223, 70.555555555555557, 4.7222222222222214, 80, 3, 0, 500, 500, 0, 17112099.451388892, 0, 2290430.006944445, 1747308.3333333335, 5824361.1111111119, 7571669.4444444459, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (238, 19, 6, 4, 13130, 8185.9876543209884, 62.345679012345684, 18.827160493827162, 100, 3, 0, 500, 500, 0, 14180461.797839507, 0, 1609569.8225308647, 1227898.1481481483, 4092993.8271604944, 5320891.9753086427, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (242, 19, 7, 4, 8450, 5492.5, 65, 17.5, 100, 3, 0, 500, 500, 0, 11900087.8125, 0, 1079962.8125000002, 823875, 2746250, 3570125, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (246, 19, 8, 4, 396.5, 302.33125000000001, 76.25, 6.875, 90, 3, 0, 500, 500, 0, 7505961.1945312498, 0, 59445.88203125001, 45349.6875, 151165.625, 196515.3125, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (250, 19, 9, 4, 17062.5, 14929.6875, 87.5, 3.75, 95, 3, 0, 500, 500, 0, 19889846.6796875, 0, 2935549.8046875005, 2239453.125, 7464843.75, 9704296.875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (254, 19, 10, 4, 682.5, 477.75, 70, 15, 100, 3, 0, 500, 500, 0, 7654475.09375, 0, 93937.593749999985, 71662.499999999985, 238874.99999999997, 310537.49999999994, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (258, 19, 11, 4, 1007.5, 520.54166666666674, 51.666666666666671, 14.166666666666668, 80, 3, 0, 500, 500, 0, 7690703.588541667, 0, 102351.50520833336, 78081.250000000015, 260270.83333333337, 338352.08333333337, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (262, 19, 12, 4, 3315, 1878.5, 56.666666666666664, 11.666666666666668, 80, 3, 0, 500, 500, 0, 8840385.0625, 0, 369360.06250000006, 281775, 939250, 1221025, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (266, 19, 13, 4, 357.5, 196.625, 55, 12.5, 80, 3, 0, 500, 500, 0, 7416467.640625, 0, 38661.390625000015, 29493.750000000004, 98312.500000000015, 127806.25000000001, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (270, 19, 14, 4, 4166.5, 2119.6242063492064, 50.873015873015873, 9.5634920634920633, 70, 3, 0, 500, 500, 0, 9044526.8437003959, 0, 416771.10957341269, 317943.63095238089, 1059812.1031746031, 1377755.7341269839, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (274, 19, 15, 4, 536.25, 316.00446428571433, 58.928571428571431, 8.0357142857142865, 75, 3, 0, 500, 500, 0, 7517537.2795758927, 0, 62134.377790178594, 47400.669642857145, 158002.23214285716, 205402.90178571432, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (278, 19, 16, 4, 5850, 5265, 90, 5, 100, 3, 0, 500, 500, 0, 11707480.625, 0, 1035230.6250000002, 789750, 2632500, 3422250, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (282, 19, 17, 4, 3172, 2687.3888888888891, 84.722222222222229, 7.6388888888888893, 100, 3, 0, 500, 500, 0, 9525210.618055556, 0, 528407.84027777787, 403108.33333333331, 1343694.4444444445, 1746802.7777777778, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (286, 19, 18, 4, 260, 162.5, 62.5, 18.75, 100, 3, 0, 500, 500, 0, 7387576.5625, 0, 31951.562500000007, 24375, 81250, 105625, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (290, 19, 19, 4, 1761.5, 1326.0180555555553, 75.277777777777771, 9.8611111111111107, 95, 3, 0, 500, 500, 0, 8372640.0362847224, 0, 260728.30017361112, 198902.70833333331, 663009.02777777775, 861911.73611111101, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (294, 19, 20, 4, 195, 146.25, 75, 12.5, 100, 3, 0, 500, 500, 0, 7373818.90625, 0, 28756.406250000007, 21937.5, 73125, 95062.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (298, 19, 21, 4, 2938, 2634.8730158730159, 89.682539682539684, 5.1587301587301582, 100, 3, 0, 500, 500, 0, 9480749.3670634925, 0, 518081.90674603189, 395230.95238095237, 1317436.5079365079, 1712667.4603174604, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (302, 19, 22, 4, 219.69999999999999, 132.60464285714286, 60.357142857142861, 12.321428571428571, 85, 3, 0, 500, 500, 0, 7362266.4057589285, 0, 26073.387901785722, 19890.696428571431, 66302.321428571435, 86193.01785714287, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (306, 19, 23, 4, 15470, 13340.072463768116, 86.231884057971016, 6.8840579710144922, 100, 3, 0, 500, 500, 0, 18544038.84963768, 0, 2622991.7481884062, 2001010.8695652175, 6670036.2318840586, 8671047.1014492754, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (310, 19, 24, 4, 1053, 927.0978260869565, 88.043478260869563, 5.9782608695652151, 100, 3, 0, 500, 500, 0, 8034904.1970108692, 0, 182290.61005434784, 139064.67391304349, 463548.91304347827, 602613.58695652173, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (314, 19, 25, 4, 1337.7, 1196.9506956521741, 89.478260869565219, 1.2608695652173907, 92, 3, 0, 500, 500, 0, 8263368.382706522, 0, 235350.43053260871, 179542.60434782607, 598475.34782608692, 778017.95217391301, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (318, 19, 26, 4, 262.43000000000001, 130.81001543209879, 49.845679012345684, 12.577160493827162, 75, 3, 0, 500, 500, 0, 7360747.0293152006, 0, 25720.519284336428, 19621.502314814818, 65405.007716049389, 85026.510030864214, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (322, 19, 27, 4, 15210, 9886.5, 65, 7.5, 80, 3, 0, 500, 500, 0, 15620158.0625, 0, 1943933.0625000005, 1482975, 4943250, 6426225, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (326, 19, 28, 4, 13520, 11717.333333333336, 86.666666666666671, 1.6666666666666643, 90, 3, 0, 500, 500, 0, 17170187.333333336, 0, 2303920.666666667, 1757600, 5858666.666666667, 7616266.666666667, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (330, 19, 29, 4, 30550, 23930.833333333328, 78.333333333333329, 5.8333333333333357, 90, 3, 0, 500, 500, 0, 27510441.770833336, 0, 4705400.1041666679, 3589624.9999999995, 11965416.666666666, 15555041.666666666, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (334, 19, 30, 4, 693.54999999999995, 652.57305996472655, 94.091710758377417, 2.954144620811288, 100, 3, 0, 500, 500, 0, 7802484.6668926366, 0, 128312.17791556439, 97885.958994708984, 326286.52998236328, 424172.48897707229, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (338, 19, 31, 4, 693.54999999999995, 652.57305996472655, 94.091710758377417, 2.954144620811288, 100, 3, 0, 500, 500, 0, 7802484.6668926366, 0, 128312.17791556439, 97885.958994708984, 326286.52998236328, 424172.48897707229, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (342, 19, 32, 4, 7995, 7804.6428571428569, 97.61904761904762, 1.1904761904761934, 100, 3, 0, 500, 500, 0, 13857605.758928571, 0, 1534587.9017857146, 1170696.4285714286, 3902321.4285714286, 5073017.8571428573, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (346, 19, 33, 4, 15990, 15609.285714285714, 97.61904761904762, 1.1904761904761934, 100, 3, 0, 500, 500, 0, 20465211.517857142, 0, 3069175.8035714291, 2341392.8571428573, 7804642.8571428573, 10146035.714285715, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (350, 19, 34, 4, 5275.9200000000001, 3431.3772000000004, 65.038461538461547, 8.4807692307692299, 82, 3, 0, 500, 500, 0, 10155089.72195, 0, 674694.5419500001, 514706.58000000002, 1715688.6000000001, 2230395.1800000002, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (354, 19, 35, 4, 730.59000000000003, 657.99932692307698, 90.064102564102569, 4.9679487179487154, 100, 3, 0, 500, 500, 0, 7807078.6801562505, 0, 129379.11765625003, 98699.899038461546, 328999.6634615385, 427699.56250000006, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (219, 19, 1, 5, 176750, 165293.98148148146, 93.518518518518519, 6.481481481481481, 100, 4, 0, 500, 500, 0, 173650378.76157409, 0, 49319591.724537045, 33058796.296296299, 82646990.740740746, 115705787.03703704, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (223, 19, 2, 5, 15925, 12076.458333333332, 75.833333333333329, 14.166666666666668, 90, 4, 0, 500, 500, 0, 20681834.088541664, 0, 3603313.255208333, 2415291.6666666665, 6038229.166666666, 8453520.8333333321, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (227, 19, 3, 5, 2792.9899999999998, 2063.7092777777775, 73.888888888888886, 6.1111111111111107, 80, 4, 0, 500, 500, 0, 10685355.750201389, 0, 615759.25575694442, 412741.85555555555, 1031854.6388888888, 1444596.4944444443, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (231, 19, 4, 5, 171080, 129049.23456790124, 75.432098765432102, 4.567901234567902, 80, 4, 0, 500, 500, 0, 137464529.56172842, 0, 38505065.364197537, 25809846.91358025, 64524617.283950619, 90334464.197530866, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (235, 19, 5, 5, 18969.990000000002, 14280.186916666666, 75.277777777777771, 4.7222222222222214, 80, 4, 0, 500, 500, 0, 22881981.612927083, 0, 4260850.7712604171, 2856037.3833333333, 7140093.458333333, 9996130.8416666668, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (239, 19, 6, 5, 18410, 14943.919753086418, 81.172839506172835, 18.827160493827162, 100, 4, 0, 500, 500, 0, 23544635.883487653, 0, 4458892.0563271604, 2988783.9506172836, 7471959.876543209, 10460743.827160493, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (243, 19, 7, 5, 11550, 9528.75, 82.5, 17.5, 100, 4, 0, 500, 500, 0, 18138265.78125, 0, 2843140.7812500005, 1905750, 4764375, 6670125, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (247, 19, 8, 5, 465.5, 386.94687499999998, 83.125, 6.875, 90, 4, 0, 500, 500, 0, 9011318.0863281246, 0, 115455.27382812501, 77389.375, 193473.4375, 270862.8125, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (251, 19, 9, 5, 19162.5, 17485.78125, 91.25, 3.75, 95, 4, 0, 500, 500, 0, 26082366.85546875, 0, 5217319.9804687509, 3497156.25, 8742890.625, 12240046.875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (255, 19, 10, 5, 892.5, 758.625, 85, 15, 100, 4, 0, 500, 500, 0, 9382392.234375, 0, 226354.734375, 151725, 379312.5, 531037.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (259, 19, 11, 5, 1382.5, 910.14583333333326, 65.833333333333329, 14.166666666666668, 80, 4, 0, 500, 500, 0, 9533666.846354166, 0, 271564.76302083337, 182029.16666666669, 455072.91666666669, 637102.08333333337, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (263, 19, 12, 5, 4304.9899999999998, 2941.7431666666666, 68.333333333333329, 11.666666666666668, 80, 4, 0, 500, 500, 0, 11561962.834020833, 0, 877742.61735416669, 588348.63333333319, 1470871.583333333, 2059220.2166666663, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (267, 19, 13, 5, 472.5, 318.9375, 67.5, 12.5, 80, 4, 0, 500, 500, 0, 8943419.2265625, 0, 95162.976562500015, 63787.5, 159468.75, 223256.25, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (271, 19, 14, 5, 5330.5, 3221.5680555555555, 60.436507936507937, 9.5634920634920633, 70, 4, 0, 500, 500, 0, 11841333.007465277, 0, 961235.36857638904, 644313.61111111112, 1610784.0277777778, 2255097.638888889, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (275, 19, 15, 5, 656.25, 439.45312500000006, 66.964285714285722, 8.0357142857142865, 75, 4, 0, 500, 500, 0, 9063739.013671875, 0, 131121.82617187506, 87890.625000000015, 219726.56250000003, 307617.18750000006, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (279, 19, 16, 5, 6650, 6317.5, 95, 5, 100, 4, 0, 500, 500, 0, 14932234.0625, 0, 1884984.0625, 1263500, 3158750, 4422250, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (217, 19, 1, 1, 130500, 105125, 80.555555555555557, 6.481481481481481, 100, 2, 0, 500, 500, 0, 80224656.25, 0, 11274656.25, 10512500, 52562500, 63075000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (221, 19, 2, 1, 8550, 4061.25, 47.5, 14.166666666666668, 90, 2, 0, 500, 500, 0, 8747319.0625, 0, 435569.0625, 406125, 2030625, 2436750, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (225, 19, 3, 1, 1998, 1232.1000000000001, 61.666666666666671, 6.1111111111111107, 80, 2, 0, 500, 500, 0, 6746402.7249999996, 0, 132142.72500000003, 123210, 616050, 739260, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (229, 19, 4, 1, 128879.99000000001, 85442.660037037043, 66.296296296296291, 4.567901234567902, 80, 2, 0, 500, 500, 0, 66304321.311194442, 0, 9163725.2889722232, 8544266.0037037041, 42721330.018518515, 51265596.022222221, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (233, 19, 5, 1, 14220, 9361.5000000000018, 65.833333333333343, 4.7222222222222214, 80, 2, 0, 500, 500, 0, 12495920.875, 0, 1004020.8750000003, 936150.00000000023, 4680750.0000000009, 5616900.0000000009, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (283, 19, 17, 5, 3724, 3439.5277777777783, 92.361111111111114, 7.6388888888888893, 100, 4, 0, 500, 500, 0, 12058938.545138888, 0, 1026269.1006944445, 687905.55555555562, 1719763.888888889, 2407669.4444444445, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (287, 19, 18, 5, 364, 295.75, 81.25, 18.75, 100, 4, 0, 500, 500, 0, 8920269.40625, 0, 88244.406250000015, 59150, 147875, 207025, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (291, 19, 19, 5, 2145.5, 1826.6548611111109, 85.138888888888886, 9.8611111111111107, 95, 4, 0, 500, 500, 0, 10448686.546961807, 0, 545028.14418402791, 365330.97222222225, 913327.4305555555, 1278658.4027777778, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (295, 19, 20, 5, 245, 214.375, 87.5, 12.5, 100, 4, 0, 500, 500, 0, 8839026.640625, 0, 63964.140625, 42875, 107187.5, 150062.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (299, 19, 21, 5, 3346, 3173.3888888888891, 94.841269841269849, 5.1587301587301582, 100, 4, 0, 500, 500, 0, 11793232.131944444, 0, 946859.90972222248, 634677.77777777787, 1586694.4444444445, 2221372.2222222225, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (303, 19, 22, 5, 284.88999999999999, 207.05398214285714, 72.678571428571431, 12.321428571428571, 85, 4, 0, 500, 500, 0, 8831717.5194218755, 0, 61779.731921874991, 41410.796428571426, 103526.99107142857, 144937.78749999998, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (307, 19, 23, 5, 17990, 16751.557971014492, 93.115942028985501, 6.8840579710144922, 100, 4, 0, 500, 500, 0, 25349336.689311594, 0, 4998246.1096014502, 3350311.5942028984, 8375778.9855072452, 11726090.579710145, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (311, 19, 24, 5, 1211, 1138.6032608695652, 94.021739130434781, 5.9782608695652151, 100, 4, 0, 500, 500, 0, 9761753.0305706523, 0, 339730.74796195654, 227720.65217391305, 569301.63043478259, 797022.28260869568, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (315, 19, 25, 5, 1460.9000000000001, 1325.6079565217392, 90.739130434782609, 1.2608695652173907, 92, 4, 0, 500, 500, 0, 9948453.8435923904, 0, 395528.27402717399, 265121.59130434785, 662803.97826086963, 927925.56956521748, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (319, 19, 26, 5, 353.93000000000001, 220.93315586419752, 62.422839506172835, 12.577160493827162, 75, 4, 0, 500, 500, 0, 8845574.139485918, 0, 65920.930380979946, 44186.631172839501, 110466.57793209875, 154653.20910493826, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (323, 19, 27, 5, 18269.990000000002, 13245.742750000001, 72.5, 7.5, 80, 4, 0, 500, 500, 0, 21849218.418031253, 0, 3952198.4930312508, 2649148.5500000003, 6622871.375, 9272019.9250000007, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (327, 19, 28, 5, 14840, 13108.666666666668, 88.333333333333343, 1.6666666666666643, 90, 4, 0, 500, 500, 0, 21712365.083333336, 0, 3911298.4166666679, 2621733.333333334, 6554333.333333334, 9176066.6666666679, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (331, 19, 29, 5, 35349.989999999998, 29752.908249999997, 84.166666666666657, 5.8333333333333357, 90, 4, 0, 500, 500, 0, 38329559.774093747, 0, 8877523.9990937505, 5950581.6499999994, 14876454.124999998, 20827035.774999999, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (335, 19, 30, 5, 770.35000000000002, 747.59274691358019, 97.045855379188708, 2.954144620811288, 100, 4, 0, 500, 500, 0, 9371377.9086998459, 0, 223062.98586033954, 149518.54938271604, 373796.37345679011, 523314.92283950618, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (339, 19, 31, 5, 770.35000000000002, 747.59274691358019, 97.045855379188708, 2.954144620811288, 100, 4, 0, 500, 500, 0, 9371377.9086998459, 0, 223062.98586033954, 149518.54938271604, 373796.37345679011, 523314.92283950618, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (343, 19, 32, 5, 8715, 8611.25, 98.80952380952381, 1.1904761904761934, 100, 4, 0, 500, 500, 0, 17222256.71875, 0, 2569381.7187500005, 1722250, 4305625, 6027875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (347, 19, 33, 5, 17430, 17222.5, 98.80952380952381, 1.1904761904761934, 100, 4, 0, 500, 500, 0, 25819513.4375, 0, 5138763.4375000009, 3444500, 8611250, 12055750, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (351, 19, 34, 5, 6422.6400000000003, 4721.8755230769239, 73.519230769230774, 8.4807692307692299, 82, 4, 0, 500, 500, 0, 13339202.475351924, 0, 1408889.6091980771, 944375.10461538471, 2360937.7615384618, 3305312.8661538465, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (355, 19, 35, 5, 830.20000000000005, 788.95608974358981, 95.032051282051285, 4.9679487179487154, 100, 4, 0, 500, 500, 0, 9412674.0360977575, 0, 235404.77327724366, 157791.21794871797, 394478.04487179487, 552269.26282051287, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (220, 19, 1, 6, 202500, 202500, 100, 6.481481481481481, 100, 5, 0, 500, 500, 0, 245406250, 0, 83531250, 50625000, 101250000, 151875000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (224, 19, 2, 6, 20250, 18225, 90, 14.166666666666668, 90, 5, 0, 500, 500, 0, 31186562.5, 0, 7517812.5000000009, 4556250, 9112500, 13668750, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (228, 19, 3, 6, 3240, 2592, 80, 6.1111111111111107, 80, 5, 0, 500, 500, 0, 13013200, 0, 1069200, 648000, 1296000, 1944000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (232, 19, 4, 6, 194400, 155520, 80, 4.567901234567902, 80, 5, 0, 500, 500, 0, 190792000, 0, 64152000.000000007, 38880000, 77760000, 116640000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (236, 19, 5, 6, 21600, 17280, 80, 4.7222222222222214, 80, 5, 0, 500, 500, 0, 30088000, 0, 7128000.0000000009, 4320000, 8640000, 12960000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (240, 19, 6, 6, 24300, 24300, 100, 18.827160493827162, 100, 5, 0, 500, 500, 0, 38248750, 0, 10023750, 6075000, 12150000, 18225000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (244, 19, 7, 6, 15000, 15000, 100, 17.5, 100, 5, 0, 500, 500, 0, 27437500, 0, 6187500.0000000009, 3750000, 7500000, 11250000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (248, 19, 8, 6, 540, 486, 90, 6.875, 90, 5, 0, 500, 500, 0, 10564975, 0, 200475.00000000003, 121500, 243000, 364500, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (252, 19, 9, 6, 21375, 20306.25, 95, 3.75, 95, 5, 0, 500, 500, 0, 33606015.625, 0, 8376328.1250000009, 5076562.5, 10153125, 15229687.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (256, 19, 10, 6, 1125, 1125, 100, 15, 100, 5, 0, 500, 500, 0, 11307812.5, 0, 464062.50000000006, 281250, 562500, 843750, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (260, 19, 11, 6, 1800, 1440, 80, 14.166666666666668, 80, 5, 0, 500, 500, 0, 11674000, 0, 594000, 360000, 720000, 1080000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (264, 19, 12, 6, 5400, 4320, 80, 11.666666666666668, 80, 5, 0, 500, 500, 0, 15022000, 0, 1782000.0000000002, 1080000, 2160000, 3240000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (268, 19, 13, 6, 600, 480, 80, 12.5, 80, 5, 0, 500, 500, 0, 10558000, 0, 198000.00000000003, 120000, 240000, 360000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (272, 19, 14, 6, 6615, 4630.5, 70, 9.5634920634920633, 70, 5, 0, 500, 500, 0, 15382956.25, 0, 1910081.2500000002, 1157625, 2315250, 3472875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (276, 19, 15, 6, 787.5, 590.625, 75, 8.0357142857142865, 75, 5, 0, 500, 500, 0, 10686601.5625, 0, 243632.81250000003, 147656.25, 295312.5, 442968.75, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (280, 19, 16, 6, 7500, 7500, 100, 5, 100, 5, 0, 500, 500, 0, 18718750, 0, 3093750.0000000005, 1875000, 3750000, 5625000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (284, 19, 17, 6, 4320, 4320, 100, 7.6388888888888893, 100, 5, 0, 500, 500, 0, 15022000, 0, 1782000.0000000002, 1080000, 2160000, 3240000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (288, 19, 18, 6, 480, 480, 100, 18.75, 100, 5, 0, 500, 500, 0, 10558000, 0, 198000.00000000003, 120000, 240000, 360000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (292, 19, 19, 6, 2565, 2436.75, 95, 9.8611111111111107, 95, 5, 0, 500, 500, 0, 12832721.875, 0, 1005159.3750000001, 609187.5, 1218375, 1827562.5, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (296, 19, 20, 6, 300, 300, 100, 12.5, 100, 5, 0, 500, 500, 0, 10348750, 0, 123750.00000000001, 75000, 150000, 225000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (300, 19, 21, 6, 3780, 3780, 100, 5.1587301587301582, 100, 5, 0, 500, 500, 0, 14394250, 0, 1559250.0000000002, 945000, 1890000, 2835000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (304, 19, 22, 6, 356.99000000000001, 303.44150000000002, 85, 12.321428571428571, 85, 5, 0, 500, 500, 0, 10352750.74375, 0, 125169.61875000001, 75860.375, 151720.75, 227581.125, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (308, 19, 23, 6, 20700, 20700, 100, 6.8840579710144922, 100, 5, 0, 500, 500, 0, 34063750, 0, 8538750, 5175000, 10350000, 15525000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (192, 19, 12, 9, 4500, 1500, 33.333333333333329, 11.666666666666668, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (312, 19, 24, 6, 1380, 1380, 100, 5.9782608695652151, 100, 5, 0, 500, 500, 0, 11604250, 0, 569250, 345000, 690000, 1035000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (316, 19, 25, 6, 1587, 1460.04, 92, 1.2608695652173907, 92, 5, 0, 500, 500, 0, 11697296.5, 0, 602266.5, 365010, 730020, 1095030, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (320, 19, 26, 6, 455.62, 341.71499999999997, 75, 12.577160493827162, 75, 5, 0, 500, 500, 0, 10397243.6875, 0, 140957.4375, 85428.75, 170857.5, 256286.25, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (324, 19, 27, 6, 21600, 17280, 80, 7.5, 80, 5, 0, 500, 500, 0, 30088000, 0, 7128000.0000000009, 4320000, 8640000, 12960000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (193, 19, 13, 9, 500, 150, 30, 12.5, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (328, 19, 28, 6, 16200, 14580, 90, 1.6666666666666643, 90, 5, 0, 500, 500, 0, 26949250, 0, 6014250.0000000009, 3645000, 7290000, 10935000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (332, 19, 29, 6, 40500, 36450, 90, 5.8333333333333357, 90, 5, 0, 500, 500, 0, 52373125, 0, 15035625.000000002, 9112500, 18225000, 27337500, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (336, 19, 30, 6, 850.5, 850.5, 100, 2.954144620811288, 100, 5, 0, 500, 500, 0, 10988706.25, 0, 350831.25, 212625, 425250, 637875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (340, 19, 31, 6, 850.5, 850.5, 100, 2.954144620811288, 100, 5, 0, 500, 500, 0, 10988706.25, 0, 350831.25, 212625, 425250, 637875, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (194, 19, 14, 9, 6300, 2000, 31.746031746031743, 9.5634920634920633, 70, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (344, 19, 32, 6, 9450, 9450, 100, 1.1904761904761934, 100, 5, 0, 500, 500, 0, 20985625, 0, 3898125.0000000005, 2362500, 4725000, 7087500, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (348, 19, 33, 6, 18900, 18900, 100, 1.1904761904761934, 100, 5, 0, 500, 500, 0, 31971250, 0, 7796250.0000000009, 4725000, 9450000, 14175000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (352, 19, 34, 6, 7675.1999999999998, 6293.6640000000007, 82, 8.4807692307692299, 82, 5, 0, 500, 500, 0, 17316384.399999999, 0, 2596136.4000000004, 1573416, 3146832, 4720248, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (356, 19, 35, 6, 936, 936, 100, 4.9679487179487154, 100, 5, 0, 500, 500, 0, 11088100, 0, 386100.00000000006, 234000, 468000, 702000, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (195, 19, 15, 9, 700, 300, 42.857142857142854, 8.0357142857142865, 75, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (197, 19, 17, 9, 2880, 2000, 69.444444444444443, 7.6388888888888893, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (198, 19, 18, 9, 320, 80, 25, 18.75, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (199, 19, 19, 9, 1800, 1000, 55.555555555555557, 9.8611111111111107, 95, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (200, 19, 20, 9, 200, 100, 50, 12.5, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (201, 19, 21, 9, 2520, 2000, 79.365079365079367, 5.1587301587301582, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (202, 19, 22, 9, 280, 100, 35.714285714285715, 12.321428571428571, 85, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (203, 19, 23, 9, 13800, 10000, 72.463768115942031, 6.8840579710144922, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (204, 19, 24, 9, 920, 700, 76.08695652173914, 5.9782608695652151, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (205, 19, 25, 9, 1150, 1000, 86.956521739130437, 1.2608695652173907, 92, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (206, 19, 26, 9, 405, 100, 24.691358024691358, 12.577160493827162, 75, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (207, 19, 27, 9, 18000, 9000, 50, 7.5, 80, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (208, 19, 28, 9, 12000, 10000, 83.333333333333343, 1.6666666666666643, 90, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (209, 19, 29, 9, 30000, 20000, 66.666666666666657, 5.8333333333333357, 90, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (210, 19, 30, 9, 567, 500, 88.183421516754848, 2.954144620811288, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (211, 19, 31, 9, 567, 500, 88.183421516754848, 2.954144620811288, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (212, 19, 32, 9, 6300, 6000, 95.238095238095227, 1.1904761904761934, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (213, 19, 33, 9, 12600, 12000, 95.238095238095227, 1.1904761904761934, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (214, 19, 34, 9, 6240, 3000, 48.07692307692308, 8.4807692307692299, 82, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (215, 19, 35, 9, 624, 500, 80.128205128205138, 4.9679487179487154, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (216, 19, 36, 9, 624, 500, 80.128205128205138, 4.9679487179487154, 100, 1, 500, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (358, 19, 36, 4, 730.59000000000003, 657.99932692307698, 90.064102564102569, 4.9679487179487154, 100, 3, 0, 500, 500, 0, 7807078.6801562505, 0, 129379.11765625003, 98699.899038461546, 328999.6634615385, 427699.56250000006, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (359, 19, 36, 5, 830.20000000000005, 788.95608974358981, 95.032051282051285, 4.9679487179487154, 100, 4, 0, 500, 500, 0, 9412674.0360977575, 0, 235404.77327724366, 157791.21794871797, 394478.04487179487, 552269.26282051287, 0, NULL);
INSERT INTO ciblerealisation (idciblerealisation, iduniteorganisation, idindicateur, idperiode, valeurcible, valeurrealisee, couverture, pas, valeur_annee_fin, idsousperiode, c_unitaire_debut, c_unitaire_fin, cout_unitaire, pas_cout_unitaire, budget, baq, bonus_qualite, bonus_equite, total1, total2, pas_val_cible, val_cible_fin) VALUES (360, 19, 36, 6, 936, 936, 100, 4.9679487179487154, 100, 5, 0, 500, 500, 0, 11088100, 0, 386100.00000000006, 234000, 468000, 702000, 0, NULL);


--
-- TOC entry 2491 (class 0 OID 70288)
-- Dependencies: 186
-- Data for Name: coutunitaireindicateur; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2492 (class 0 OID 70291)
-- Dependencies: 187
-- Data for Name: couverture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2493 (class 0 OID 70294)
-- Dependencies: 188
-- Data for Name: couverturepopulation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (1, 9, 12, 1274329, 0, 1, 37, 37, 37, 0, 15, 15, 15, 0, 3000000, 155);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (2, 1, 12, 1308929, 0, 2, 37, 37, 37, 0, 15, 15, 15, 0, 14750000, 178.75);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (3, 4, 12, 1343529, 0, 3, 37, 37, 37, 0, 15, 15, 15, 0, 26500000, 202.5);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (4, 5, 12, 1378129, 0, 4, 37, 37, 37, 0, 15, 15, 15, 0, 38250000, 226.25);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (5, 6, 12, 1512582, 0, 5, 37, 37, 37, 0, 15, 15, 15, 0, 50000000, 250);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (6, 9, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (7, 1, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (8, 4, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (9, 5, 3, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (10, 6, 3, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (11, 9, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (12, 1, 4, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (13, 4, 4, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (14, 5, 4, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (15, 6, 4, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (16, 9, 6, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (17, 1, 6, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (18, 4, 6, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (19, 5, 6, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (20, 6, 6, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (21, 9, 10, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (22, 1, 10, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (23, 4, 10, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (24, 5, 10, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (25, 6, 10, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (30, 6, 19, 1500000, 0, 5, 10, 50, 50, 10, 10, 100, 100, 22.5, 10000000, 55);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (26, 9, 19, 1000000, 0, 1, 10, 50, 10, 10, 10, 100, 10, 22.5, 4500000, 55);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (27, 1, 19, 1200000, 0, 2, 10, 50, 20, 10, 10, 100, 32.5, 22.5, 5875000, 55);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (28, 4, 19, 1300000, 0, 3, 10, 50, 30, 10, 10, 100, 55, 22.5, 7250000, 55);
INSERT INTO couverturepopulation (idcouverturepopulation, idperiode, iduniteorganisation, valeur, pourcentage, idsousperiode, val_debut_score_e, val_fin_score_e, val_score_equite, pas_score_equite, maj_val_debut, maj_val_fin, majoration, pas_majoration, baq, val_score_qualite) VALUES (29, 5, 19, 1400000, 0, 4, 10, 50, 40, 10, 10, 100, 77.5, 22.5, 8625000, 55);


--
-- TOC entry 2522 (class 0 OID 70853)
-- Dependencies: 217
-- Data for Name: devise; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO devise (iddevise, nom, cout_unitaire_default, code, default_m) VALUES (2, 'Euro', 650, ' E', false);
INSERT INTO devise (iddevise, nom, cout_unitaire_default, code, default_m) VALUES (3, 'Fcfa', 1, ' F', false);
INSERT INTO devise (iddevise, nom, cout_unitaire_default, code, default_m) VALUES (1, 'Dollar', 550, ' D', true);


--
-- TOC entry 2523 (class 0 OID 70862)
-- Dependencies: 218
-- Data for Name: devise_periode; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (1, 1, 9, 550);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (2, 1, 1, 550);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (3, 1, 4, 550);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (4, 1, 5, 550);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (5, 1, 6, 550);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (6, 2, 9, 650);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (7, 2, 1, 650);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (8, 2, 4, 650);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (9, 2, 5, 650);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (10, 2, 6, 650);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (11, 3, 9, 1);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (12, 3, 1, 1);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (13, 3, 4, 1);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (14, 3, 5, 1);
INSERT INTO devise_periode (iddevise_periode, iddevise, idperiode, valeur) VALUES (15, 3, 6, 1);


--
-- TOC entry 2494 (class 0 OID 70305)
-- Dependencies: 189
-- Data for Name: financement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (1, 9, 3, 3, 89, 1);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (2, 9, 1, 3, 11, 1);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (3, 1, 3, 3, 89, 2);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (4, 1, 1, 3, 11, 2);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (5, 4, 3, 3, 89, 3);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (6, 4, 1, 3, 11, 3);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (7, 5, 3, 3, 89, 4);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (8, 5, 1, 3, 11, 4);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (9, 6, 3, 3, 89, 5);
INSERT INTO financement (idfinancement, idperiode, idbailleurfond, idtypeuniteorganisation, pourcentage, idsous_periode) VALUES (10, 6, 1, 3, 11, 5);


--
-- TOC entry 2495 (class 0 OID 70308)
-- Dependencies: 190
-- Data for Name: financementbudget; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (1, 3, 1, 2, 531000000, 89, 472590000, 3);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (2, 3, 1, 2, 531000000, 11, 58410000, 1);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (3, 3, 4, 3, 954000000, 89, 849060000, 3);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (4, 3, 4, 3, 954000000, 11, 104940000, 1);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (5, 3, 5, 4, 1377000000, 89, 1225530000, 3);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (6, 3, 5, 4, 1377000000, 11, 151470000, 1);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (7, 3, 6, 5, 1800000000, 89, 1602000000, 3);
INSERT INTO financementbudget (idfinancementbudget, idtype_uo, idperiode, idsous_periode, budget, pourcentage, financement, idbailleurfond) VALUES (8, 3, 6, 5, 1800000000, 11, 198000000, 1);


--
-- TOC entry 2496 (class 0 OID 70311)
-- Dependencies: 191
-- Data for Name: groupindicateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO groupindicateur (idgroupindicateur, nom, code) VALUES (1, '-', '-');
INSERT INTO groupindicateur (idgroupindicateur, nom, code) VALUES (2, 'TYPE 1', 'T_1');


--
-- TOC entry 2497 (class 0 OID 70317)
-- Dependencies: 192
-- Data for Name: indicateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (1, 3, 'Consultation externe nvx cas - médecin', '51.1', NULL, 0.01125, '', 0.13500000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (2, 3, 'Consultation  externe nouveau cas - indigent ', '51.2', NULL, 0.00125, '', 0.014999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (3, 3, 'Nouvelle consultation curative-médecin (nouveau cas) malnutris aigue sévère avec complications médicales MAS', '51.3', NULL, 0.00022499999999999999, '', 0.0027000000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (4, 3, 'Journée d’hospitalisation', '52.1', NULL, 0.0135, '', 0.16200000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (5, 3, 'Journée d’hospitalisation  des indigents (pauvres)/vulnérables ', '52.2', NULL, 0.0015, '', 0.017999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (6, 3, 'Journée d’hospitalisation – MAS avec complication médicale (limite à 14 jours)', '52.3', NULL, 0.0013500000000000001, '', 0.016199999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (7, 3, 'Contre référence arrive au CS', '53.1', NULL, 0.00083333333333333295, '', 0.01, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (8, 3, 'Contre référence MAS arrivée au CS ', '53.2', NULL, 3.3333333333333301e-005, '', 0.00040000000000000002, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (9, 3, 'Cas d''IST traité selon protocole', '54.1', NULL, 0.00125, '', 0.014999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (10, 3, 'Dépistage des  cas  TBC positifs', '55.1', NULL, 6.2500000000000001e-005, '', 0.00075000000000000002, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (11, 3, 'Cas TBC traité et guéris', '56.1', NULL, 0.000125, '', 0.0015, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (12, 3, 'Actes Chirurgie Majeure en dehors des césariennes', '57.1', NULL, 0.00037500000000000001, '', 0.0044999999999999997, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (13, 3, 'Actes Chirurgie Majeure en dehors des césariennes indigentes', '57.2', NULL, 4.1666666666666699e-005, '', 0.00050000000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (14, 3, 'Petite chirurgie', '58.1', NULL, 0.00052499999999999997, '', 0.0063, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (15, 3, 'Petite Chirurgie - indigent', '58.2', NULL, 5.8333333333333299e-005, '', 0.00069999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (16, 3, 'Transfusion  Sanguine', '59.1', NULL, 0.00041666666666666702, '', 0.0050000000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (17, 3, 'Accouchement eutocique', '60.1', NULL, 0.00024000000000000001, '', 0.0028800000000000002, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (18, 3, 'Accouchement eutocique indigent', '60.2', NULL, 2.66666666666667e-005, '', 0.00032000000000000003, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (19, 3, 'Césariennes ', '61.1', NULL, 0.00014999999999999999, '', 0.0018, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (20, 3, 'Césarienne indigentes', '61.2', NULL, 1.6666666666666701e-005, '', 0.00020000000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (21, 3, 'Accouchement dystocique', '62.1', NULL, 0.00021000000000000001, '', 0.0025200000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (22, 3, 'Accouchement dystocique - indigent', '62.2', NULL, 2.3333333333333299e-005, '', 0.00027999999999999998, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (23, 3, 'PF : Nouvelles ou Ancienne acceptantes  pilules ou injectables ', '63.1', NULL, 0.00115, '', 0.0138, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (24, 3, 'PF : Implants ou DIU', '64.1', NULL, 7.6666666666666696e-005, '', 0.00092000000000000003, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (25, 3, 'PF : methode definitive - vasectomie ou ligature des trompes', '65.1', NULL, 9.5833333333333296e-005, '', 0.00115, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (26, 3, 'Curetage après avortement spontané (ou indication médicale)', '66.1', NULL, 3.375e-005, '', 0.00040499999999999998, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (27, 3, 'CPN1 ou CPN2 ou CPN3 ou CPN4', '67.1', NULL, 0.0015, '', 0.017999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (28, 3, 'TPI1 ou TPI2 ou TPI3', '68.1', NULL, 0.001, '', 0.012, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (29, 3, 'Dépistage volontaire du VIH/SIDA y compris femme enceinte', '69.1', NULL, 0.0025000000000000001, '', 0.029999999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (30, 3, 'Femme enceinte VIH + mise sous  prophylaxie ARV', '70.1', NULL, 4.7250000000000003e-005, '', 0.00056700000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (31, 3, 'Prise en charge du nouveau-ne d une femme VIH +', '71.1', NULL, 4.7250000000000003e-005, '', 0.00056700000000000001, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (32, 3, 'Nouveaux cas de VIH mis sous ARV', '72.1', NULL, 0.00052499999999999997, '', 0.0063, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (33, 3, 'Patients sous  ARV suivis semestriellement', '73.1', NULL, 0.0010499999999999999, '', 0.0126, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (34, 3, 'Séance de dialyse', '74.1', NULL, 0.00051999999999999995, '', 0.0062399999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (35, 3, 'Référence des cas de fistule arrivée à l''hôpital Régional de Bertoua ', '75.1', NULL, 5.1999999999999997e-005, '', 0.00062399999999999999, '-', '-', 0, 0, 0);
INSERT INTO indicateur (idindicateur, idtypeindicateur, nom, code, pivot, ciblemensuelle, description, cible_annuelle, numerateur, denominateur, baseline, annee_baseline, coutunitaire) VALUES (36, 3, 'Prise en charge médicale et psychosociale des victimes de viol  suivant le protocole national ', '76.1', NULL, 5.1999999999999997e-005, '', 0.00062399999999999999, '-', '-', 0, 0, 0);


--
-- TOC entry 2498 (class 0 OID 70323)
-- Dependencies: 193
-- Data for Name: indicateurgroupeindicateur; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2499 (class 0 OID 70326)
-- Dependencies: 194
-- Data for Name: indicateurpivot; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2500 (class 0 OID 70329)
-- Dependencies: 195
-- Data for Name: ligne_score_equite; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (1, 1, 60, 60, 80, 5, 1, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (2, 1, 65, 60, 80, 5, 2, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (3, 1, 70, 60, 80, 5, 3, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (4, 1, 75, 60, 80, 5, 4, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (5, 1, 80, 60, 80, 5, 5, 5);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (6, 2, 50, 50, 80, 7.5, 1, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (7, 2, 57.5, 50, 80, 7.5, 2, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (8, 2, 65, 50, 80, 7.5, 3, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (9, 2, 72.5, 50, 80, 7.5, 4, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (10, 2, 80, 50, 80, 7.5, 5, 5);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (11, 3, 45, 45, 90, 11.25, 1, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (12, 3, 56.25, 45, 90, 11.25, 2, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (13, 3, 67.5, 45, 90, 11.25, 3, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (14, 3, 78.75, 45, 90, 11.25, 4, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (15, 3, 90, 45, 90, 11.25, 5, 5);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (16, 1, 15, 15, 35, 0, 26, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (17, 1, 15, 15, 35, 0, 27, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (18, 1, 15, 15, 35, 0, 28, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (19, 1, 15, 15, 35, 0, 29, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (20, 1, 15, 15, 35, 0, 30, 5);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (21, 2, 20, 20, 35, 0, 26, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (22, 2, 20, 20, 35, 0, 27, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (23, 2, 20, 20, 35, 0, 28, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (24, 2, 20, 20, 35, 0, 29, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (25, 2, 20, 20, 35, 0, 30, 5);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (26, 3, 20, 20, 30, 0, 26, 1);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (27, 3, 20, 20, 30, 0, 27, 2);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (28, 3, 20, 20, 30, 0, 28, 3);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (29, 3, 20, 20, 30, 0, 29, 4);
INSERT INTO ligne_score_equite (id_ligne_score_equite, idrubrique_score, valeur, val_debut, val_fin, pas, idcouverture, idsous_periode) VALUES (30, 3, 20, 20, 30, 0, 30, 5);


--
-- TOC entry 2501 (class 0 OID 70332)
-- Dependencies: 196
-- Data for Name: lignebaq; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (1, 1, 3, 1000000, 3000000, 3, 50, 1000000, 1000000, 1, 1, 11.75, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (2, 1, 14.75, 1000000, 14750000, 3, 50, 1000000, 1000000, 2, 2, 11.75, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (3, 1, 26.5, 1000000, 26500000, 3, 50, 1000000, 1000000, 3, 3, 11.75, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (4, 1, 38.25, 1000000, 38250000, 3, 50, 1000000, 1000000, 4, 4, 11.75, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (5, 1, 50, 1000000, 50000000, 3, 50, 1000000, 1000000, 5, 5, 11.75, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (6, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (7, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (8, 2, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (9, 2, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (10, 2, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (11, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (12, 3, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (13, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (14, 3, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (15, 3, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (16, 1, 10, 100000, 1000000, 10, 30, 100000, 100000, 26, 1, 5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (17, 1, 15, 100000, 1500000, 10, 30, 100000, 100000, 27, 2, 5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (18, 1, 20, 100000, 2000000, 10, 30, 100000, 100000, 28, 3, 5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (19, 1, 25, 100000, 2500000, 10, 30, 100000, 100000, 29, 4, 5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (20, 1, 30, 100000, 3000000, 10, 30, 100000, 100000, 30, 5, 5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (21, 2, 25, 50000, 1250000, 25, 50, 50000, 50000, 26, 1, 6.25, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (22, 2, 31.25, 50000, 1562500, 25, 50, 50000, 50000, 27, 2, 6.25, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (23, 2, 37.5, 50000, 1875000, 25, 50, 50000, 50000, 28, 3, 6.25, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (24, 2, 43.75, 50000, 2187500, 25, 50, 50000, 50000, 29, 4, 6.25, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (25, 2, 50, 50000, 2500000, 25, 50, 50000, 50000, 30, 5, 6.25, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (26, 3, 30, 75000, 2250000, 30, 60, 75000, 75000, 26, 1, 7.5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (27, 3, 37.5, 75000, 2812500, 30, 60, 75000, 75000, 27, 2, 7.5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (28, 3, 45, 75000, 3375000, 30, 60, 75000, 75000, 28, 3, 7.5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (29, 3, 52.5, 75000, 3937500, 30, 60, 75000, 75000, 29, 4, 7.5, 0);
INSERT INTO lignebaq (id_lignebaq, id_type_baq, quantite, cout_unitaire, total, qte_debut, qte_fin, cu_debut, cu_fin, idcouverture, idsous_periode, qte_pas, cu_pas) VALUES (30, 3, 60, 75000, 4500000, 30, 60, 75000, 75000, 30, 5, 7.5, 0);


--
-- TOC entry 2502 (class 0 OID 70335)
-- Dependencies: 197
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO menu (idmenu, nom, ressource) VALUES (1, 'Privilège super administrateur', '-');
INSERT INTO menu (idmenu, nom, ressource) VALUES (2, 'Enregistrer les utilisateurs', '/s2bi-war/securite/utilisateur/utilisateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (3, 'Modifier les utilisateurs', '/s2bi-war/securite/utilisateur/utilisateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (4, 'Supprimer les utilisateurs', '/s2bi-war/securite/utilisateur/utilisateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (6, 'Activer les comptes utilisateur', '/s2bi-war/securite/utilisateur/utilisateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (7, 'Désactiver les comptes utilisateur', '/s2bi-war/securite/utilisateur/utilisateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (8, 'Attribution / Retrait privilège', '/s2bi-war/securite/privilege/privilege.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (5, 'Ré-initialiser les mot de passe utilisateur', '/s2bi-war/securite/reset-compte/reset-compte.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (9, 'Visualiser les actions utilisateur', '/s2bi-war/securite/mouchard/mouchard.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (10, 'Enregistrer les groupes d''indicateur', '/s2bi-war/parametrage/groupe-indicateur/groupe-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (11, 'Modifier les groupes d''indicateur', '/s2bi-war/parametrage/groupe-indicateur/groupe-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (12, 'Supprimer les groupes d''indicateur', '/s2bi-war/parametrage/groupe-indicateur/groupe-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (13, 'Enregistrer les types d''indicateurs', '/s2bi-war/parametrage/type-indicateur/type-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (14, 'Modifier les types d''indicateurs', '/s2bi-war/parametrage/type-indicateur/type-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (15, 'Supprimer les types d''indicateurs', '/s2bi-war/parametrage/type-indicateur/type-indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (16, 'Enregistrer les periodes', '/s2bi-war/parametrage/periode/periode.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (17, 'Modifier les périodes', '/s2bi-war/parametrage/periode/periode.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (18, 'Supprimes les périodes', '/s2bi-war/parametrage/periode/periode.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (19, 'Gérer les niveaux de pyramide', '/s2bi-war/parametrage/niveau-pyramide/niveau-pyramide.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (20, 'Gérer les types d''unités d''organisation', '/s2bi-war/parametrage/type-unite-organisation/type-unite-organisation.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (21, 'Enregistrer les unités d''organisations', '/s2bi-war/parametrage/unite-organisation/unite-organisation.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (22, 'Modifier les unités d''organisation', '/s2bi-war/parametrage/unite-organisation/unite-organisation.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (23, 'Supprimer les unités d''organisation', '/s2bi-war/parametrage/unite-organisation/unite-organisation.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (24, 'Gérer les sources de financements', '/s2bi-war/parametrage/source-financement/source-financement.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (25, 'Gérer les bailleurs de fond', '/s2bi-war/parametrage/bailleur-fond/bailleur-fond.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (26, 'Gérer les périodes de costing', '/s2bi-war/parametrage/periode-costing/periode-costing.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (27, 'Gérer les dévises', '/s2bi-war/parametrage/devise/devise.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (28, 'Enregistrer les indicateurs', '/s2bi-war/operation/indicateur/indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (29, 'Modifier les indicateurs', '/s2bi-war/operation/indicateur/indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (30, 'Supprimer les indicateurs', '/s2bi-war/operation/indicateur/indicateur.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (31, 'Grouper les indicateurs par type d''unité d''organisation', '/s2bi-war/operation/indicateur_par_tuo/indicateur_par_tuo.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (32, 'Gérer les couvertures de population', '/s2bi-war/operation/population/population.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (33, 'Programmation des cibles;/s2bi-war/operation/cible_autre/cible_autre.html', '/s2bi-war/operation/cible/cible.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (34, 'Saisie des réalisations (valeurs)', '/s2bi-war/operation/realisation/realisation.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (35, 'Projection des couvertures', '/s2bi-war/operation/projection/projection.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (36, 'Projection des cibles', '/s2bi-war/operation/projection_cible/projection_cible.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (37, 'Costing du score équité', '/s2bi-war/operation/projection-score-equite/projection-score-equite.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (38, 'Costing des couts unitaire des indicateurs', '/s2bi-war/operation/projection_cu/projection_cu.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (39, 'Costing de la majoration', '/s2bi-war/operation/projection_majoration/projection_majoration.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (40, 'Costing du BAQ', '/s2bi-war/operation/baq/baq.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (48, 'Visualiser le budget par source de financement', '/s2bi-war/analyse/budget_par_sf/budget_par_sf.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (41, 'Costing du score qualité', '/s2bi-war/operation/score_qualite/score_qualite.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (42, 'Engagement de financement', '/s2bi-war/operation/costing_financement/costing_financement.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (45, 'Costing des dévises', '/s2bi-war/operation/projection_devise/projection_devise.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (43, 'Générer le budget / Mise à jour', '/s2bi-war/operation/budget/budget.html;/s2bi-war/analyse/budget/budget.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (44, 'Générer le financement du budget', '/s2bi-war/operation/financement_budget/financement_budget.html;/s2bi-war/analyse/financement_budget/financement_budget.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (46, 'Visualiser le budget par unité d''organisation', '/s2bi-war/analyse/budget_par_uo/budget_par_uo.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (49, 'Visualiser le budget par habitant', '/s2bi-war/analyse/budget_par_habitant/budget_par_habitant.html');
INSERT INTO menu (idmenu, nom, ressource) VALUES (47, 'Visualiser le budget par type  d''unité d''organisation', '/s2bi-war/analyse/budget_par_tuo/budget_par_tuo.html');


--
-- TOC entry 2503 (class 0 OID 70341)
-- Dependencies: 198
-- Data for Name: mouchard; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (1, 1, 'Enregistrement de l''utilisateur : gervais null', '2019-02-19', '15:17:43+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (2, 1, 'Suppresion de l''utilisateur : gervais null', '2019-02-19', '15:20:19+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (3, 1, 'Enregistrement de l''utilisateur : Kenne Java', '2019-02-19', '15:20:46+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (4, 1, 'Déconnexion', '2019-02-19', '15:44:50+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (5, 1, 'ATTRIBUTION DU PRIVILEGE -> Enregistrer les utilisateurs à l''utilisateur -> Kenne Java', '2019-02-19', '16:17:00+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (6, 1, 'Désativation du compte de l''utilisateur : Kenne Java', '2019-02-19', '16:39:47+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (7, 1, 'Enregistrement du groupe d''indicateur  : -', '2019-02-20', '10:18:19+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (8, 1, 'Enregistrement du groupe d''indicateur  : Groupe 1', '2019-02-20', '10:18:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (9, 1, 'Suppresion du groupe d''indicateur : Groupe 2', '2019-02-20', '10:19:28+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (10, 1, 'Enregistrement du type d''indicateur  : -', '2019-02-20', '10:59:43+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (11, 1, 'Enregistrement du type d''indicateur  : TYPE 1', '2019-02-20', '11:00:01+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (12, 1, 'Suppresion du type d''indicateur : TYPE 2', '2019-02-20', '11:01:47+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (13, 1, 'Enregistrement du groupe d''indicateur  : TYPE 1', '2019-02-20', '11:14:32+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (14, 1, 'Enregistrement de la période : 2019', '2019-02-20', '11:57:50+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (15, 1, 'Enregistrement de la période : Janvier 2019', '2019-02-20', '11:58:06+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (16, 1, 'Enregistrement de la période : Fevrier 2019', '2019-02-20', '11:58:22+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (17, 1, 'Enregistrement du niveau de pyramide  : Région', '2019-02-20', '14:13:26+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (18, 1, 'Enregistrement du niveau de pyramide  : District', '2019-02-20', '14:18:27+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (19, 1, 'Enregistrement du niveau de pyramide  : DEP', '2019-02-20', '14:38:05+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (20, 1, 'Suppresion du niveau de pyramide : DEP', '2019-02-20', '14:40:01+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (21, 1, 'Enregistrement du type d''unité d''organisation  : REGION', '2019-02-20', '16:36:17+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (22, 1, 'Enregistrement du type d''unité d''organisation  : DISTRICT', '2019-02-20', '16:37:51+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (23, 1, 'Enregistrement de l''unité d''organisation : OUEST', '2019-02-21', '09:57:18+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (24, 1, 'Enregistrement du type d''unité d''organisation  : HOPITAL REGIONAL', '2019-02-21', '09:59:12+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (25, 1, 'Enregistrement de l''unité d''organisation : HOPITAL REGIONAL OUEST', '2019-02-21', '10:00:06+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (26, 1, 'Suppresion de l''unité d''organisation : OUEST', '2019-02-21', '10:25:30+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (27, 1, 'Suppresion de l''unité d''organisation : HOPITAL REGIONAL OUEST', '2019-02-21', '10:29:00+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (28, 1, 'Enregistrement de l''unité d''organisation : REGION OUEST', '2019-02-21', '10:29:34+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (29, 1, 'Enregistrement de l''unité d''organisation : HOPITAL REGIONAL OUEST', '2019-02-21', '10:30:18+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (30, 1, 'Enregistrement de la source de financement  : -', '2019-02-21', '11:31:25+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (31, 1, 'Enregistrement du bailleur de fond  : -', '2019-02-21', '14:12:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (32, 1, 'Suppresion de la source de financement : -', '2019-02-21', '14:18:10+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (33, 1, 'Enregistrement du bailleur de fond  : Bailleur_1', '2019-02-21', '14:19:14+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (34, 1, 'Enregistrement de la période : 2020', '2019-02-21', '17:06:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (35, 1, 'Enregistrement de la période : 2021', '2019-02-21', '17:07:01+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (36, 1, 'Enregistrement de la période : 2022', '2019-02-21', '17:07:15+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (37, 1, 'Enregistrement de la période : 2023', '2019-02-21', '17:07:27+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (38, 1, 'Enregistrement de la periode de costing  : Evaluation 2019 / 2023', '2019-02-22', '09:19:12+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (39, 1, 'Suppresion de la periode de costing : Evaluation 2019 / 2023', '2019-02-22', '09:35:34+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (40, 1, 'Enregistrement de la periode de costing  : Costing 2019 / 2023', '2019-02-22', '09:57:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (41, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 100000.0', '2019-03-04', '16:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (42, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 110000.0', '2019-03-04', '16:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (43, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 120000.0', '2019-03-04', '16:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (44, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 130000.0', '2019-03-04', '16:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (45, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2023 Valeur : 140000.0', '2019-03-04', '16:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (46, 1, 'Enregistrement du type d''indicateur  : INDICATEURS GENERAUX DE SANTE', '2019-03-06', '11:35:25+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (47, 1, 'Enregistrement de l''indicateur : Consultation externe nvx cas - infirmier', '2019-03-06', '11:36:54+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (48, 1, 'Suppresion de la periode de costing : null', '2019-03-06', '16:16:33+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (49, 1, 'Suppresion de la periode de costing : null', '2019-03-06', '16:16:36+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (50, 1, 'Suppresion de la periode de costing : null', '2019-03-06', '16:16:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (51, 1, 'Suppresion de la periode de costing : null', '2019-03-06', '16:16:43+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (52, 1, 'Suppresion de la periode de costing : null', '2019-03-06', '16:16:47+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (53, 1, 'Suppresion de l''unité d''organisation : OUEST', '2019-03-06', '16:17:06+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (54, 1, 'Enregistrement de l''unité d''organisation : EST', '2019-03-06', '16:17:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (55, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 1070381.0', '2019-03-06', '16:22:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (56, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 1095167.0', '2019-03-06', '16:22:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (57, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 1119953.0', '2019-03-06', '16:22:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (58, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 1144739.0', '2019-03-06', '16:22:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (59, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2023 Valeur : 1169525.0', '2019-03-06', '16:22:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (60, 1, 'Enregistrement de l''indicateur : Consultation  externe nouveau cas - indigent', '2019-03-06', '16:28:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (61, 1, 'Enregistrement de l''indicateur : Consultation externe, nouveau cas de malnutrition aigue sévère MAS', '2019-03-06', '16:29:53+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (62, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation', '2019-03-06', '16:32:12+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (63, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation  des indigents (pauvres)/vulnérables ', '2019-03-06', '16:40:56+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (64, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation – MAS avec complication médicale (limite à 14 jours)', '2019-03-06', '16:42:40+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (65, 1, 'Enregistrement de l''indicateur : Contre référence arrive au CS', '2019-03-06', '16:44:11+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (66, 1, 'Enregistrement de l''indicateur : Contre référence MAS arrivée au CS ', '2019-03-06', '16:45:35+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (67, 1, 'Enregistrement de l''indicateur : Cas d''IST traité selon protocole', '2019-03-06', '16:47:04+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (68, 1, 'Enregistrement de l''indicateur : Dépistage des  cas  TBC positifs', '2019-03-06', '16:48:37+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (69, 1, 'Enregistrement de la période : 2024', '2019-03-07', '13:59:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (70, 1, 'Déconnexion', '2019-03-08', '19:10:04+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (71, 1, 'Déconnexion', '2019-03-18', '11:51:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (72, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:23+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (73, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:28+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (74, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:32+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (75, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:35+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (76, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (77, 1, 'Suppresion de la periode de costing : null', '2019-03-18', '11:56:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (78, 1, 'Suppresion de la periode de costing : Costing 2019 / 2023', '2019-03-18', '11:58:54+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (79, 1, 'Enregistrement de la période : 2018', '2019-03-18', '12:00:14+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (80, 1, 'Enregistrement de la periode de costing  : Costing du PBF 2018 - 2022', '2019-03-18', '12:01:48+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (81, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2018 Valeur : 800000.0', '2019-03-18', '12:04:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (82, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 1400000.0', '2019-03-18', '12:04:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (83, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 1500000.0', '2019-03-18', '12:04:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (84, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 1800000.0', '2019-03-18', '12:04:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (85, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 2000000.0', '2019-03-18', '12:04:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (86, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2018 Valeur : 1070381.0', '2019-03-20', '13:54:16+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (87, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 1095167.0', '2019-03-20', '13:54:16+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (88, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 1119953.0', '2019-03-20', '13:54:16+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (89, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 1144739.0', '2019-03-20', '13:54:16+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (90, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 1169525.0', '2019-03-20', '13:54:16+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (91, 1, 'ATTRIBUTION DU COSTING -> Costing du PBF 2018 - 2022 à l''utilisateur -> kenne Gervais', '2019-04-03', '09:03:49+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (92, 1, 'RETRAIT DU COSTING -> Costing du PBF 2018 - 2022 à l''utilisateur -> kenne Gervais', '2019-04-03', '09:04:07+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (93, 1, 'ATTRIBUTION DU COSTING -> Costing du PBF 2018 - 2022 à l''utilisateur -> kenne Gervais', '2019-04-03', '09:04:23+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (94, 1, 'Enregistrement du bailleur de fond  : Fond Monétaire International', '2019-04-03', '17:43:15+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (95, 1, 'Enregistrement du bailleur de fond  : Banque Mondiale', '2019-04-03', '17:43:37+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (96, 1, 'Enregistrement du bailleur de fond  : ETAT BIP', '2019-04-03', '17:44:01+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (97, 1, 'Déconnexion', '2019-04-04', '18:59:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (98, 1, 'Déconnexion', '2019-04-08', '18:05:08+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (99, 1, 'Enregistrement de l''unité d''organisation : ACV CENTRE', '2019-04-10', '10:24:02+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (100, 1, 'Enregistrement du type d''unité d''organisation  : ACV', '2019-04-10', '10:29:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (101, 1, 'Enregistrement de l''unité d''organisation : ACV_OUEST', '2019-04-10', '15:10:33+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (102, 1, 'Déconnexion', '2019-04-16', '17:57:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (103, 1, 'Enregistrement du type d''indicateur  : PCA', '2019-04-21', '00:12:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (104, 1, 'Enregistrement du type d''indicateur  : Paquet Minimum d''Activité', '2019-04-21', '00:13:42+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (105, 1, 'Suppresion de la periode : 2023', '2019-04-21', '00:14:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (106, 1, 'Suppresion de la periode : 2024', '2019-04-21', '00:14:42+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (107, 1, 'Suppresion de la periode : Fevrier 2019', '2019-04-21', '00:14:46+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (108, 1, 'Suppresion de la periode : Janvier 2019', '2019-04-21', '00:14:52+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (109, 1, 'Enregistrement du niveau de pyramide  : Central', '2019-04-21', '00:15:46+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (110, 1, 'Enregistrement de l''unité d''organisation : FOSA EST', '2019-04-21', '00:23:05+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (111, 1, 'Enregistrement de l''unité d''organisation : DRSP Adamaoua', '2019-04-21', '00:25:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (112, 1, 'Enregistrement de l''unité d''organisation : DRSP Extrême Nord', '2019-04-21', '00:26:29+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (113, 1, 'Enregistrement de l''unité d''organisation : DRSP Littoral', '2019-04-21', '00:27:00+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (114, 1, 'Enregistrement de l''unité d''organisation : DRSP Nord Ouest', '2019-04-21', '00:27:37+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (115, 1, 'Enregistrement de l''unité d''organisation : DRSP Sud Ouest', '2019-04-21', '00:28:03+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (116, 1, 'Enregistrement de l''unité d''organisation : FOSA Ouest', '2019-04-21', '00:28:53+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (117, 1, 'Enregistrement de l''unité d''organisation : FOSA Adamaoua', '2019-04-21', '00:29:15+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (118, 1, 'Enregistrement de l''unité d''organisation : FOSA Extrême Nord', '2019-04-21', '00:29:50+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (119, 1, 'Enregistrement de l''unité d''organisation : FOSA Littoral', '2019-04-21', '00:30:12+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (120, 1, 'Enregistrement de l''unité d''organisation : FOSA Nord Ouest', '2019-04-21', '00:30:52+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (121, 1, 'Enregistrement de l''unité d''organisation : FOSA Sud Ouest', '2019-04-21', '00:31:20+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (122, 1, 'Enregistrement de l''unité d''organisation : DRSP Centre', '2019-04-21', '00:32:02+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (123, 1, 'Enregistrement de l''unité d''organisation : DRSP Sud', '2019-04-21', '00:32:37+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (124, 1, 'Enregistrement de l''unité d''organisation : FOSA Centre', '2019-04-21', '00:38:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (125, 1, 'Enregistrement de l''unité d''organisation : FOSA Sud', '2019-04-21', '00:39:13+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (126, 1, 'Enregistrement de la source de financement  : Etat-BF', '2019-04-21', '00:40:42+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (127, 1, 'Enregistrement de la source de financement  : Etat-BF', '2019-04-21', '00:40:56+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (128, 1, 'Enregistrement de la source de financement  : Etat-FCP', '2019-04-21', '00:41:08+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (129, 1, 'Enregistrement de la source de financement  : Banque Mondiale', '2019-04-21', '00:41:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (130, 1, 'Suppresion de la source de financement : Etat-BF', '2019-04-21', '00:47:43+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (131, 1, 'Suppresion de la source de financement : Etat-FCP', '2019-04-21', '00:47:50+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (132, 1, 'Enregistrement du bailleur de fond  : Autres - A rechercher', '2019-04-21', '00:51:38+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (133, 1, 'Enregistrement de l''indicateur : Consultation externe nvx cas - médecin', '2019-04-21', '03:14:23+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (134, 1, 'Enregistrement de l''indicateur : Consultation  externe nouveau cas - indigent ', '2019-04-21', '03:15:53+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (135, 1, 'Enregistrement de l''indicateur : Nouvelle consultation curative-médecin (nouveau cas) malnutris aigue sévère avec complications médicales MAS', '2019-04-21', '03:16:47+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (136, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation', '2019-04-21', '03:17:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (137, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation  des indigents (pauvres)/vulnérables ', '2019-04-21', '03:18:33+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (138, 1, 'Enregistrement de l''indicateur : Journée d’hospitalisation – MAS avec complication médicale (limite à 14 jours)', '2019-04-21', '03:19:23+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (139, 1, 'Enregistrement de l''indicateur : Contre référence arrive au CS', '2019-04-21', '03:20:09+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (140, 1, 'Enregistrement de l''indicateur : Contre référence MAS arrivée au CS ', '2019-04-21', '03:20:59+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (141, 1, 'Enregistrement de l''indicateur : Cas d''IST traité selon protocole', '2019-04-21', '03:21:41+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (142, 1, 'Enregistrement de l''indicateur : Dépistage des  cas  TBC positifs', '2019-04-21', '03:22:15+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (143, 1, 'Enregistrement de l''indicateur : Cas TBC traité et guéris', '2019-04-21', '03:22:55+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (144, 1, 'Enregistrement de l''indicateur : Actes Chirurgie Majeure en dehors des césariennes', '2019-04-21', '03:23:47+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (145, 1, 'Enregistrement de l''indicateur : Actes Chirurgie Majeure en dehors des césariennes indigentes', '2019-04-21', '03:24:22+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (146, 1, 'Enregistrement de l''indicateur : Petite chirurgie', '2019-04-21', '03:25:18+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (147, 1, 'Enregistrement de l''indicateur : Petite Chirurgie - indigent', '2019-04-21', '03:26:06+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (148, 1, 'Enregistrement de l''indicateur : Transfusion  Sanguine', '2019-04-21', '03:26:45+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (149, 1, 'Enregistrement de l''indicateur : Accouchement eutocique', '2019-04-21', '03:27:33+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (150, 1, 'Enregistrement de l''indicateur : Accouchement eutocique indigent', '2019-04-21', '03:28:28+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (151, 1, 'Enregistrement de l''indicateur : Césariennes ', '2019-04-21', '03:29:13+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (152, 1, 'Enregistrement de l''indicateur : Césarienne indigentes', '2019-04-21', '03:30:11+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (153, 1, 'Enregistrement de l''indicateur : Accouchement dystocique', '2019-04-21', '03:30:54+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (154, 1, 'Enregistrement de l''indicateur : Accouchement dystocique - indigent', '2019-04-21', '03:31:29+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (155, 1, 'Enregistrement de l''indicateur : PF : Nouvelles ou Ancienne acceptantes  pilules ou injectables ', '2019-04-21', '03:32:04+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (156, 1, 'Enregistrement de l''indicateur : PF : Implants ou DIU', '2019-04-21', '03:32:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (157, 1, 'Enregistrement de l''indicateur : PF : methode definitive - vasectomie ou ligature des trompes', '2019-04-21', '03:33:32+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (158, 1, 'Enregistrement de l''indicateur : Curetage après avortement spontané (ou indication médicale)', '2019-04-21', '03:34:11+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (159, 1, 'Enregistrement de l''indicateur : CPN1 ou CPN2 ou CPN3 ou CPN4', '2019-04-21', '03:35:07+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (160, 1, 'Enregistrement de l''indicateur : TPI1 ou TPI2 ou TPI3', '2019-04-21', '03:36:04+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (161, 1, 'Enregistrement de l''indicateur : Dépistage volontaire du VIH/SIDA y compris femme enceinte', '2019-04-21', '03:36:36+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (162, 1, 'Enregistrement de l''indicateur : Femme enceinte VIH + mise sous  prophylaxie ARV', '2019-04-21', '03:37:14+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (163, 1, 'Enregistrement de l''indicateur : Prise en charge du nouveau-ne d une femme VIH +', '2019-04-21', '03:37:49+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (164, 1, 'Enregistrement de l''indicateur : Nouveaux cas de VIH mis sous ARV', '2019-04-21', '03:38:23+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (165, 1, 'Enregistrement de l''indicateur : Patients sous  ARV suivis semestriellement', '2019-04-21', '03:38:56+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (166, 1, 'Enregistrement de l''indicateur : Séance de dialyse', '2019-04-21', '03:39:39+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (167, 1, 'Enregistrement de l''indicateur : Référence des cas de fistule arrivée à l''hôpital Régional de Bertoua ', '2019-04-21', '03:40:13+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (168, 1, 'Enregistrement de l''indicateur : Prise en charge médicale et psychosociale des victimes de viol  suivant le protocole national ', '2019-04-21', '03:40:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (169, 1, 'Déconnexion', '2019-04-21', '03:44:24+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (170, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2018 Valeur : 1274329.0', '2019-04-21', '03:54:21+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (171, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 1308929.0', '2019-04-21', '03:54:21+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (172, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 1343529.0', '2019-04-21', '03:54:21+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (173, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 1378129.0', '2019-04-21', '03:54:21+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (174, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 1412582.0', '2019-04-21', '03:54:21+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (175, 1, 'Déconnexion', '2019-04-21', '13:31:27+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (176, 1, 'Déconnexion', '2019-04-21', '13:37:44+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (177, 1, 'Enregistrement de la periode de costing  : Costing PBF 2019 -2022 (Synthese nationale)', '2019-05-06', '16:01:51+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (178, 1, 'Déconnexion', '2019-05-06', '16:02:01+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (179, 1, 'Enregistrement du niveau de pyramide  : National', '2019-05-06', '16:06:25+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (180, 1, 'Enregistrement de l''unité d''organisation : FOSA Cameroun', '2019-05-06', '16:09:43+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (181, 1, 'Déconnexion', '2019-05-22', '15:16:10+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (182, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2018 Valeur : 1000000.0', '2019-05-31', '15:08:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (183, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2019 Valeur : 1200000.0', '2019-05-31', '15:08:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (184, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2020 Valeur : 1300000.0', '2019-05-31', '15:08:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (185, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2021 Valeur : 1400000.0', '2019-05-31', '15:08:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (186, 1, 'Saisie de la population de l''unité d''organisation  : null A la periode : 2022 Valeur : 1500000.0', '2019-05-31', '15:08:58+01');
INSERT INTO mouchard (idmouchard, idutilisateur, action, date_action, heure) VALUES (187, 1, 'Déconnexion', '2020-02-19', '16:26:55+01');


--
-- TOC entry 2504 (class 0 OID 70347)
-- Dependencies: 199
-- Data for Name: niveaupyramide; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO niveaupyramide (idniveaupyramide, nom, numero) VALUES (2, 'District', 2);
INSERT INTO niveaupyramide (idniveaupyramide, nom, numero) VALUES (4, 'National', 0);
INSERT INTO niveaupyramide (idniveaupyramide, nom, numero) VALUES (3, 'Central', 1);
INSERT INTO niveaupyramide (idniveaupyramide, nom, numero) VALUES (1, 'Région', 3);


--
-- TOC entry 2505 (class 0 OID 70350)
-- Dependencies: 200
-- Data for Name: periode; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO periode (idperiode, nom, code, datedebut, datefin, idparent, etat, idtype_periode, periode_debut, periode_fin) VALUES (4, '2020', '2020', NULL, NULL, NULL, true, 1, false, false);
INSERT INTO periode (idperiode, nom, code, datedebut, datefin, idparent, etat, idtype_periode, periode_debut, periode_fin) VALUES (5, '2021', '2021', NULL, NULL, NULL, true, 1, false, false);
INSERT INTO periode (idperiode, nom, code, datedebut, datefin, idparent, etat, idtype_periode, periode_debut, periode_fin) VALUES (1, '2019', '2019', NULL, NULL, 0, true, 1, true, false);
INSERT INTO periode (idperiode, nom, code, datedebut, datefin, idparent, etat, idtype_periode, periode_debut, periode_fin) VALUES (9, '2018', '2018', NULL, NULL, NULL, true, 1, true, false);
INSERT INTO periode (idperiode, nom, code, datedebut, datefin, idparent, etat, idtype_periode, periode_debut, periode_fin) VALUES (6, '2022', '2022', NULL, NULL, NULL, true, 1, false, true);


--
-- TOC entry 2506 (class 0 OID 70358)
-- Dependencies: 201
-- Data for Name: periodecosting; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO periodecosting (idperiodecosting, libelle) VALUES (1, 'Costing du PBF 2018 - 2022(Par régions)');
INSERT INTO periodecosting (idperiodecosting, libelle) VALUES (2, 'Costing PBF 2019 -2022 (Synthese nationale)');


--
-- TOC entry 2507 (class 0 OID 70364)
-- Dependencies: 202
-- Data for Name: privilege; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO privilege (idprivilege, idutilisateur, idmenu) VALUES (1, 1, 1);
INSERT INTO privilege (idprivilege, idutilisateur, idmenu) VALUES (2, 2, 2);


--
-- TOC entry 2508 (class 0 OID 70367)
-- Dependencies: 203
-- Data for Name: rubrique_score_qualite; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rubrique_score_qualite (id_rubrique_score_qualite, code, nom, poids) VALUES (1, '1', 'Qualité technique', 35);
INSERT INTO rubrique_score_qualite (id_rubrique_score_qualite, code, nom, poids) VALUES (2, '2', 'Satisfaction patient', 35);
INSERT INTO rubrique_score_qualite (id_rubrique_score_qualite, code, nom, poids) VALUES (3, '3', 'Outil indice', 30);


--
-- TOC entry 2509 (class 0 OID 70373)
-- Dependencies: 204
-- Data for Name: sourcefinancement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sourcefinancement (idsourcefinancement, nom, code) VALUES (1, 'Autres - A rechercher', 'Autres - A rechercher');
INSERT INTO sourcefinancement (idsourcefinancement, nom, code) VALUES (5, 'FINEX', 'FINEX');
INSERT INTO sourcefinancement (idsourcefinancement, nom, code) VALUES (2, 'Etat', 'Etat');


--
-- TOC entry 2510 (class 0 OID 70379)
-- Dependencies: 205
-- Data for Name: sousperiodecosting; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (1, 1, 9, true, false, NULL, 1);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (2, 1, 1, false, false, NULL, 2);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (3, 1, 4, false, false, NULL, 3);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (4, 1, 5, false, false, NULL, 4);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (5, 1, 6, false, true, NULL, 5);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (6, 2, 9, true, false, NULL, 1);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (7, 2, 1, false, false, NULL, 2);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (8, 2, 4, false, false, NULL, 3);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (9, 2, 5, false, false, NULL, 4);
INSERT INTO sousperiodecosting (idsousperiode, idperiodecosting, idperiode, periodedebut, periodefin, periodebase, numero) VALUES (10, 2, 6, false, true, NULL, 5);


--
-- TOC entry 2511 (class 0 OID 70382)
-- Dependencies: 206
-- Data for Name: tauxurbanisation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2512 (class 0 OID 70385)
-- Dependencies: 207
-- Data for Name: type_baq; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO type_baq (id_type_baq, code, nom) VALUES (1, '1', 'BAQ 1');
INSERT INTO type_baq (id_type_baq, code, nom) VALUES (2, '2', 'BAQ 2');
INSERT INTO type_baq (id_type_baq, code, nom) VALUES (3, '3', 'BAQ 3');


--
-- TOC entry 2513 (class 0 OID 70388)
-- Dependencies: 208
-- Data for Name: type_periode; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO type_periode (code, nom, coef_multiplicateur, idtype_periode) VALUES ('1', 'Annuel', 1, 1);
INSERT INTO type_periode (code, nom, coef_multiplicateur, idtype_periode) VALUES ('2', 'Sémestriel', 2, 2);
INSERT INTO type_periode (code, nom, coef_multiplicateur, idtype_periode) VALUES ('3', 'Trimestriel', 3, 3);
INSERT INTO type_periode (code, nom, coef_multiplicateur, idtype_periode) VALUES ('4', 'Mensuel', 12, 4);


--
-- TOC entry 2514 (class 0 OID 70394)
-- Dependencies: 209
-- Data for Name: typeindicateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO typeindicateur (idtypeindicateur, nom, code) VALUES (1, '-', '-');
INSERT INTO typeindicateur (idtypeindicateur, nom, code) VALUES (2, 'INDICATEURS GENERAUX DE SANTE', 'IGS');
INSERT INTO typeindicateur (idtypeindicateur, nom, code) VALUES (3, 'Paquet Complémentaire d''Activité', 'PCA');
INSERT INTO typeindicateur (idtypeindicateur, nom, code) VALUES (4, 'Paquet Minimum d''Activité', 'PMA');


--
-- TOC entry 2515 (class 0 OID 70400)
-- Dependencies: 210
-- Data for Name: typescore; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2516 (class 0 OID 70403)
-- Dependencies: 211
-- Data for Name: typestructure_indicateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (1, 3, 1);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (2, 3, 2);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (3, 3, 3);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (4, 3, 4);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (5, 3, 5);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (6, 3, 6);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (7, 3, 7);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (8, 3, 8);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (9, 3, 9);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (10, 3, 10);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (11, 3, 11);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (12, 3, 12);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (13, 3, 13);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (14, 3, 14);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (15, 3, 15);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (16, 3, 16);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (17, 3, 17);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (18, 3, 18);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (19, 3, 19);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (20, 3, 20);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (21, 3, 21);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (22, 3, 22);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (23, 3, 23);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (24, 3, 24);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (25, 3, 25);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (26, 3, 26);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (27, 3, 27);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (28, 3, 28);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (29, 3, 29);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (30, 3, 30);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (31, 3, 31);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (32, 3, 32);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (33, 3, 33);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (34, 3, 34);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (35, 3, 35);
INSERT INTO typestructure_indicateur (id_typestructure_indicateur, idtypestructure, idindicateur) VALUES (36, 3, 36);


--
-- TOC entry 2517 (class 0 OID 70406)
-- Dependencies: 212
-- Data for Name: typeuniteorganisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO typeuniteorganisation (idtypeuniteorganisation, nom, code) VALUES (2, 'DISTRICT', 'DIST');
INSERT INTO typeuniteorganisation (idtypeuniteorganisation, nom, code) VALUES (4, 'ACV', 'ACV');
INSERT INTO typeuniteorganisation (idtypeuniteorganisation, nom, code) VALUES (1, 'DRSP', 'DRSP');
INSERT INTO typeuniteorganisation (idtypeuniteorganisation, nom, code) VALUES (3, 'FOSA', 'FOSA');


--
-- TOC entry 2518 (class 0 OID 70412)
-- Dependencies: 213
-- Data for Name: uniteorganisation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (3, 1, 4, 'ACV CENTRE', 'ACV_CENTRE', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (4, 1, 4, 'ACV_OUEST', 'ACV_OUEST', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (2, 1, 1, 'DRSP EST', 'DRSP EST', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (1, 1, 1, 'DRSP OUEST', 'DRSP OUEST', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (5, 2, 3, 'FOSA EST', 'FOSA EST', 2, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (6, 1, 1, 'DRSP Adamaoua', 'DRSP Adamaoua', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (7, 1, 1, 'DRSP Extrême Nord', 'DRSP Extrême Nord', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (8, 1, 1, 'DRSP Littoral', 'DRSP Littoral', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (9, 1, 1, 'DRSP Nord Ouest', 'DRSP Nord Ouest', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (10, 1, 1, 'DRSP Sud Ouest', 'DRSP Sud Ouest', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (11, 2, 3, 'FOSA Ouest', 'FOSA Ouest', 1, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (12, 2, 3, 'FOSA Adamaoua', 'FOSA Adamaoua', 6, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (13, 2, 3, 'FOSA Extrême Nord', 'FOSA Extrême Nord', 7, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (14, 2, 3, 'FOSA Littoral', 'FOSA Littoral', 8, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (15, 2, 3, 'FOSA Nord Ouest', 'FOSA Nord Ouest', 9, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (16, 2, 3, 'FOSA Sud Ouest', 'FOSA Sud Ouest', 10, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (17, 1, 1, 'DRSP Centre', 'DRSP Centre', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (18, 1, 1, 'DRSP Sud', 'DRSP Sud', 0, false);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (19, 2, 3, 'FOSA Centre', 'FOSA Centre', 17, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (20, 2, 3, 'FOSA Sud', 'FOSA Sud', 18, true);
INSERT INTO uniteorganisation (iduniteorganisation, idniveaupyramide, idtypeuniteorganisation, nom, code, idparent, costingfosa) VALUES (21, 4, 3, 'FOSA Cameroun', 'NAT-FOSA', 3, true);


--
-- TOC entry 2519 (class 0 OID 70419)
-- Dependencies: 214
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO utilisateur (idutilisateur, nom, prenom, login, password, datecreation, etat, photo) VALUES (1, 'kenne', 'Gervais', 'admin', '0DPiKuNIrrVmD8IUCuw1hQxNqZc=', NULL, true, NULL);
INSERT INTO utilisateur (idutilisateur, nom, prenom, login, password, datecreation, etat, photo) VALUES (2, 'Kenne', 'Java', 'kenne', 'Xa3iJ8LVSqrhp+9p15lWy/0/xEc=', '2019-02-19', false, 'user_avatar.png');


--
-- TOC entry 2520 (class 0 OID 70425)
-- Dependencies: 215
-- Data for Name: utilisateur_costing; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO utilisateur_costing (id_utilisateur_costing, idutilisateur, idperiode_costing) VALUES (1, 1, 1);


--
-- TOC entry 2521 (class 0 OID 70428)
-- Dependencies: 216
-- Data for Name: valeurscore; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2169 (class 2606 OID 70432)
-- Name: pk_bailleurfond; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bailleurfond
    ADD CONSTRAINT pk_bailleurfond PRIMARY KEY (idbailleurfond);


--
-- TOC entry 2174 (class 2606 OID 70434)
-- Name: pk_bonusqualite; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bonusqualite
    ADD CONSTRAINT pk_bonusqualite PRIMARY KEY (idbonusqualite);


--
-- TOC entry 2181 (class 2606 OID 70436)
-- Name: pk_budget; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT pk_budget PRIMARY KEY (idbudget);


--
-- TOC entry 2187 (class 2606 OID 70438)
-- Name: pk_cibleannuelle; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cibleannuelle
    ADD CONSTRAINT pk_cibleannuelle PRIMARY KEY (idcibleannuelle);


--
-- TOC entry 2194 (class 2606 OID 70440)
-- Name: pk_ciblerealisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciblerealisation
    ADD CONSTRAINT pk_ciblerealisation PRIMARY KEY (idciblerealisation);


--
-- TOC entry 2199 (class 2606 OID 70442)
-- Name: pk_coutunitaireindicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coutunitaireindicateur
    ADD CONSTRAINT pk_coutunitaireindicateur PRIMARY KEY (idcoutunitaireindicateur);


--
-- TOC entry 2205 (class 2606 OID 70444)
-- Name: pk_couverture; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverture
    ADD CONSTRAINT pk_couverture PRIMARY KEY (idcouverture);


--
-- TOC entry 2211 (class 2606 OID 70446)
-- Name: pk_couverturepopulation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverturepopulation
    ADD CONSTRAINT pk_couverturepopulation PRIMARY KEY (idcouverturepopulation);


--
-- TOC entry 2312 (class 2606 OID 70861)
-- Name: pk_devise; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devise
    ADD CONSTRAINT pk_devise PRIMARY KEY (iddevise);


--
-- TOC entry 2314 (class 2606 OID 70866)
-- Name: pk_devise_periode; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devise_periode
    ADD CONSTRAINT pk_devise_periode PRIMARY KEY (iddevise_periode);


--
-- TOC entry 2218 (class 2606 OID 70448)
-- Name: pk_financement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financement
    ADD CONSTRAINT pk_financement PRIMARY KEY (idfinancement);


--
-- TOC entry 2221 (class 2606 OID 70450)
-- Name: pk_financementbudget; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financementbudget
    ADD CONSTRAINT pk_financementbudget PRIMARY KEY (idfinancementbudget);


--
-- TOC entry 2224 (class 2606 OID 70452)
-- Name: pk_groupindicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groupindicateur
    ADD CONSTRAINT pk_groupindicateur PRIMARY KEY (idgroupindicateur);


--
-- TOC entry 2228 (class 2606 OID 70454)
-- Name: pk_indicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateur
    ADD CONSTRAINT pk_indicateur PRIMARY KEY (idindicateur);


--
-- TOC entry 2233 (class 2606 OID 70456)
-- Name: pk_indicateurgroupeindicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurgroupeindicateur
    ADD CONSTRAINT pk_indicateurgroupeindicateur PRIMARY KEY (idindicateur, idgroupindicateur);


--
-- TOC entry 2238 (class 2606 OID 70458)
-- Name: pk_indicateurpivot; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurpivot
    ADD CONSTRAINT pk_indicateurpivot PRIMARY KEY (idindicateurpivot);


--
-- TOC entry 2241 (class 2606 OID 70460)
-- Name: pk_ligne_score_equite; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ligne_score_equite
    ADD CONSTRAINT pk_ligne_score_equite PRIMARY KEY (id_ligne_score_equite);


--
-- TOC entry 2244 (class 2606 OID 70462)
-- Name: pk_lignebaq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lignebaq
    ADD CONSTRAINT pk_lignebaq PRIMARY KEY (id_lignebaq);


--
-- TOC entry 2247 (class 2606 OID 70464)
-- Name: pk_menu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (idmenu);


--
-- TOC entry 2249 (class 2606 OID 70466)
-- Name: pk_mouchard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mouchard
    ADD CONSTRAINT pk_mouchard PRIMARY KEY (idmouchard);


--
-- TOC entry 2252 (class 2606 OID 70468)
-- Name: pk_niveaupyramide; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY niveaupyramide
    ADD CONSTRAINT pk_niveaupyramide PRIMARY KEY (idniveaupyramide);


--
-- TOC entry 2256 (class 2606 OID 70470)
-- Name: pk_periode; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT pk_periode PRIMARY KEY (idperiode);


--
-- TOC entry 2259 (class 2606 OID 70472)
-- Name: pk_periodecosting; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY periodecosting
    ADD CONSTRAINT pk_periodecosting PRIMARY KEY (idperiodecosting);


--
-- TOC entry 2263 (class 2606 OID 70474)
-- Name: pk_privilege; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT pk_privilege PRIMARY KEY (idprivilege);


--
-- TOC entry 2266 (class 2606 OID 70476)
-- Name: pk_rubrique_score_qualite; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rubrique_score_qualite
    ADD CONSTRAINT pk_rubrique_score_qualite PRIMARY KEY (id_rubrique_score_qualite);


--
-- TOC entry 2268 (class 2606 OID 70478)
-- Name: pk_sourcefinancement; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sourcefinancement
    ADD CONSTRAINT pk_sourcefinancement PRIMARY KEY (idsourcefinancement);


--
-- TOC entry 2273 (class 2606 OID 70480)
-- Name: pk_sousperiodecosting; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sousperiodecosting
    ADD CONSTRAINT pk_sousperiodecosting PRIMARY KEY (idsousperiode);


--
-- TOC entry 2278 (class 2606 OID 70482)
-- Name: pk_tauxurbanisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tauxurbanisation
    ADD CONSTRAINT pk_tauxurbanisation PRIMARY KEY (idtauxurbanisation);


--
-- TOC entry 2281 (class 2606 OID 70484)
-- Name: pk_type_baq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY type_baq
    ADD CONSTRAINT pk_type_baq PRIMARY KEY (id_type_baq);


--
-- TOC entry 2283 (class 2606 OID 70486)
-- Name: pk_type_periode; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY type_periode
    ADD CONSTRAINT pk_type_periode PRIMARY KEY (idtype_periode);


--
-- TOC entry 2285 (class 2606 OID 70488)
-- Name: pk_typeindicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typeindicateur
    ADD CONSTRAINT pk_typeindicateur PRIMARY KEY (idtypeindicateur);


--
-- TOC entry 2288 (class 2606 OID 70490)
-- Name: pk_typescore; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typescore
    ADD CONSTRAINT pk_typescore PRIMARY KEY (idtypescore);


--
-- TOC entry 2291 (class 2606 OID 70492)
-- Name: pk_typestructure_indicateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typestructure_indicateur
    ADD CONSTRAINT pk_typestructure_indicateur PRIMARY KEY (id_typestructure_indicateur);


--
-- TOC entry 2293 (class 2606 OID 70494)
-- Name: pk_typeuniteorganisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typeuniteorganisation
    ADD CONSTRAINT pk_typeuniteorganisation PRIMARY KEY (idtypeuniteorganisation);


--
-- TOC entry 2298 (class 2606 OID 70496)
-- Name: pk_uniteorganisation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uniteorganisation
    ADD CONSTRAINT pk_uniteorganisation PRIMARY KEY (iduniteorganisation);


--
-- TOC entry 2301 (class 2606 OID 70498)
-- Name: pk_utilisateur; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT pk_utilisateur PRIMARY KEY (idutilisateur);


--
-- TOC entry 2304 (class 2606 OID 70500)
-- Name: pk_utilisateur_costing; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur_costing
    ADD CONSTRAINT pk_utilisateur_costing PRIMARY KEY (id_utilisateur_costing);


--
-- TOC entry 2309 (class 2606 OID 70502)
-- Name: pk_valeurscore; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valeurscore
    ADD CONSTRAINT pk_valeurscore PRIMARY KEY (idvaleurscore);


--
-- TOC entry 2275 (class 1259 OID 70503)
-- Name: association10_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association10_fk ON tauxurbanisation USING btree (idperiode);


--
-- TOC entry 2206 (class 1259 OID 70504)
-- Name: association11_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association11_fk ON couverturepopulation USING btree (iduniteorganisation);


--
-- TOC entry 2207 (class 1259 OID 70505)
-- Name: association12_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association12_fk ON couverturepopulation USING btree (idperiode);


--
-- TOC entry 2195 (class 1259 OID 70506)
-- Name: association13_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association13_fk ON coutunitaireindicateur USING btree (idperiode);


--
-- TOC entry 2175 (class 1259 OID 70507)
-- Name: association14_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association14_fk ON budget USING btree (idperiode);


--
-- TOC entry 2176 (class 1259 OID 70508)
-- Name: association15_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association15_fk ON budget USING btree (iduniteorganisation);


--
-- TOC entry 2177 (class 1259 OID 70509)
-- Name: association16_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association16_fk ON budget USING btree (idindicateur);


--
-- TOC entry 2295 (class 1259 OID 70510)
-- Name: association17_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association17_fk ON uniteorganisation USING btree (idniveaupyramide);


--
-- TOC entry 2166 (class 1259 OID 70511)
-- Name: association18_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association18_fk ON bailleurfond USING btree (idsourcefinancement);


--
-- TOC entry 2212 (class 1259 OID 70512)
-- Name: association19_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association19_fk ON financement USING btree (idbailleurfond);


--
-- TOC entry 2213 (class 1259 OID 70513)
-- Name: association20_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association20_fk ON financement USING btree (idtypeuniteorganisation);


--
-- TOC entry 2214 (class 1259 OID 70514)
-- Name: association21_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association21_fk ON financement USING btree (idperiode);


--
-- TOC entry 2296 (class 1259 OID 70515)
-- Name: association22_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association22_fk ON uniteorganisation USING btree (idtypeuniteorganisation);


--
-- TOC entry 2170 (class 1259 OID 70516)
-- Name: association23_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association23_fk ON bonusqualite USING btree (idtypeuniteorganisation);


--
-- TOC entry 2171 (class 1259 OID 70517)
-- Name: association24_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association24_fk ON bonusqualite USING btree (idperiode);


--
-- TOC entry 2196 (class 1259 OID 70518)
-- Name: association25_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association25_fk ON coutunitaireindicateur USING btree (idindicateur);


--
-- TOC entry 2200 (class 1259 OID 70519)
-- Name: association26_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association26_fk ON couverture USING btree (idperiode);


--
-- TOC entry 2201 (class 1259 OID 70520)
-- Name: association27_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association27_fk ON couverture USING btree (idindicateur);


--
-- TOC entry 2182 (class 1259 OID 70521)
-- Name: association28_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association28_fk ON cibleannuelle USING btree (idindicateur);


--
-- TOC entry 2183 (class 1259 OID 70522)
-- Name: association29_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association29_fk ON cibleannuelle USING btree (idperiode);


--
-- TOC entry 2229 (class 1259 OID 70523)
-- Name: association2_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association2_fk ON indicateurgroupeindicateur USING btree (idindicateur);


--
-- TOC entry 2230 (class 1259 OID 70524)
-- Name: association2_fk2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association2_fk2 ON indicateurgroupeindicateur USING btree (idgroupindicateur);


--
-- TOC entry 2184 (class 1259 OID 70525)
-- Name: association30_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association30_fk ON cibleannuelle USING btree (iduniteorganisation);


--
-- TOC entry 2188 (class 1259 OID 70526)
-- Name: association31_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association31_fk ON ciblerealisation USING btree (idperiode);


--
-- TOC entry 2189 (class 1259 OID 70527)
-- Name: association32_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association32_fk ON ciblerealisation USING btree (idindicateur);


--
-- TOC entry 2190 (class 1259 OID 70528)
-- Name: association33_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association33_fk ON ciblerealisation USING btree (iduniteorganisation);


--
-- TOC entry 2202 (class 1259 OID 70529)
-- Name: association34_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association34_fk ON couverture USING btree (iduniteorganisation);


--
-- TOC entry 2270 (class 1259 OID 70530)
-- Name: association35_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association35_fk ON sousperiodecosting USING btree (idperiodecosting);


--
-- TOC entry 2271 (class 1259 OID 70531)
-- Name: association36_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association36_fk ON sousperiodecosting USING btree (idperiode);


--
-- TOC entry 2260 (class 1259 OID 70532)
-- Name: association37_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association37_fk ON privilege USING btree (idutilisateur);


--
-- TOC entry 2261 (class 1259 OID 70533)
-- Name: association38_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association38_fk ON privilege USING btree (idmenu);


--
-- TOC entry 2225 (class 1259 OID 70534)
-- Name: association3_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association3_fk ON indicateur USING btree (idtypeindicateur);


--
-- TOC entry 2305 (class 1259 OID 70535)
-- Name: association4_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association4_fk ON valeurscore USING btree (idtypescore);


--
-- TOC entry 2306 (class 1259 OID 70536)
-- Name: association5_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association5_fk ON valeurscore USING btree (iduniteorganisation);


--
-- TOC entry 2307 (class 1259 OID 70537)
-- Name: association6_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association6_fk ON valeurscore USING btree (idperiode);


--
-- TOC entry 2234 (class 1259 OID 70538)
-- Name: association7_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association7_fk ON indicateurpivot USING btree (idtypeindicateur);


--
-- TOC entry 2235 (class 1259 OID 70539)
-- Name: association8_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association8_fk ON indicateurpivot USING btree (idindicateur);


--
-- TOC entry 2276 (class 1259 OID 70540)
-- Name: association9_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX association9_fk ON tauxurbanisation USING btree (iduniteorganisation);


--
-- TOC entry 2167 (class 1259 OID 70541)
-- Name: bailleurfond_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX bailleurfond_pk ON bailleurfond USING btree (idbailleurfond);


--
-- TOC entry 2172 (class 1259 OID 70542)
-- Name: bonusqualite_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX bonusqualite_pk ON bonusqualite USING btree (idbonusqualite);


--
-- TOC entry 2178 (class 1259 OID 70543)
-- Name: budget_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX budget_pk ON budget USING btree (idbudget);


--
-- TOC entry 2185 (class 1259 OID 70544)
-- Name: cibleannuelle_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cibleannuelle_pk ON cibleannuelle USING btree (idcibleannuelle);


--
-- TOC entry 2191 (class 1259 OID 70545)
-- Name: ciblerealisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ciblerealisation_pk ON ciblerealisation USING btree (idciblerealisation);


--
-- TOC entry 2197 (class 1259 OID 70546)
-- Name: coutunitaireindicateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX coutunitaireindicateur_pk ON coutunitaireindicateur USING btree (idcoutunitaireindicateur);


--
-- TOC entry 2203 (class 1259 OID 70547)
-- Name: couverture_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX couverture_pk ON couverture USING btree (idcouverture);


--
-- TOC entry 2208 (class 1259 OID 70548)
-- Name: couverturepopulation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX couverturepopulation_pk ON couverturepopulation USING btree (idcouverturepopulation);


--
-- TOC entry 2215 (class 1259 OID 70549)
-- Name: financement_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX financement_pk ON financement USING btree (idfinancement);


--
-- TOC entry 2219 (class 1259 OID 70550)
-- Name: fki_bailleurfond_financementbudget; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_bailleurfond_financementbudget ON financementbudget USING btree (idbailleurfond);


--
-- TOC entry 2242 (class 1259 OID 70551)
-- Name: fki_couverture_lignebaq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_couverture_lignebaq ON lignebaq USING btree (idcouverture);


--
-- TOC entry 2239 (class 1259 OID 70552)
-- Name: fki_couveruture_ligne_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_couveruture_ligne_score ON ligne_score_equite USING btree (idcouverture);


--
-- TOC entry 2179 (class 1259 OID 70553)
-- Name: fki_sous_periode_budget; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_sous_periode_budget ON budget USING btree (idsous_periode);


--
-- TOC entry 2192 (class 1259 OID 70554)
-- Name: fki_sous_periode_cible_realisation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_sous_periode_cible_realisation ON ciblerealisation USING btree (idsousperiode);


--
-- TOC entry 2209 (class 1259 OID 70555)
-- Name: fki_sous_periode_couverture; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_sous_periode_couverture ON couverturepopulation USING btree (idsousperiode);


--
-- TOC entry 2216 (class 1259 OID 70556)
-- Name: fki_sous_periode_financement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_sous_periode_financement ON financement USING btree (idsous_periode);


--
-- TOC entry 2253 (class 1259 OID 70557)
-- Name: fki_typeperiode_periode; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_typeperiode_periode ON periode USING btree (idtype_periode);


--
-- TOC entry 2222 (class 1259 OID 70558)
-- Name: groupindicateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX groupindicateur_pk ON groupindicateur USING btree (idgroupindicateur);


--
-- TOC entry 2226 (class 1259 OID 70559)
-- Name: indicateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX indicateur_pk ON indicateur USING btree (idindicateur);


--
-- TOC entry 2231 (class 1259 OID 70560)
-- Name: indicateurgroupeindicateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX indicateurgroupeindicateur_pk ON indicateurgroupeindicateur USING btree (idindicateur, idgroupindicateur);


--
-- TOC entry 2236 (class 1259 OID 70561)
-- Name: indicateurpivot_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX indicateurpivot_pk ON indicateurpivot USING btree (idindicateurpivot);


--
-- TOC entry 2245 (class 1259 OID 70562)
-- Name: menu_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX menu_pk ON menu USING btree (idmenu);


--
-- TOC entry 2250 (class 1259 OID 70563)
-- Name: niveaupyramide_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX niveaupyramide_pk ON niveaupyramide USING btree (idniveaupyramide);


--
-- TOC entry 2254 (class 1259 OID 70564)
-- Name: periode_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX periode_pk ON periode USING btree (idperiode);


--
-- TOC entry 2257 (class 1259 OID 70565)
-- Name: periodecosting_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX periodecosting_pk ON periodecosting USING btree (idperiodecosting);


--
-- TOC entry 2264 (class 1259 OID 70566)
-- Name: privilege_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX privilege_pk ON privilege USING btree (idprivilege);


--
-- TOC entry 2269 (class 1259 OID 70567)
-- Name: sourcefinancement_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sourcefinancement_pk ON sourcefinancement USING btree (idsourcefinancement);


--
-- TOC entry 2274 (class 1259 OID 70568)
-- Name: sousperiodecosting_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sousperiodecosting_pk ON sousperiodecosting USING btree (idsousperiode);


--
-- TOC entry 2279 (class 1259 OID 70569)
-- Name: tauxurbanisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tauxurbanisation_pk ON tauxurbanisation USING btree (idtauxurbanisation);


--
-- TOC entry 2286 (class 1259 OID 70570)
-- Name: typeindicateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX typeindicateur_pk ON typeindicateur USING btree (idtypeindicateur);


--
-- TOC entry 2289 (class 1259 OID 70571)
-- Name: typescore_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX typescore_pk ON typescore USING btree (idtypescore);


--
-- TOC entry 2294 (class 1259 OID 70572)
-- Name: typeuniteorganisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX typeuniteorganisation_pk ON typeuniteorganisation USING btree (idtypeuniteorganisation);


--
-- TOC entry 2299 (class 1259 OID 70573)
-- Name: uniteorganisation_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uniteorganisation_pk ON uniteorganisation USING btree (iduniteorganisation);


--
-- TOC entry 2302 (class 1259 OID 70574)
-- Name: utilisateur_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX utilisateur_pk ON utilisateur USING btree (idutilisateur);


--
-- TOC entry 2310 (class 1259 OID 70575)
-- Name: valeurscore_pk; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX valeurscore_pk ON valeurscore USING btree (idvaleurscore);


--
-- TOC entry 2315 (class 2606 OID 70576)
-- Name: fk_bailleur_associati_sourcefi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bailleurfond
    ADD CONSTRAINT fk_bailleur_associati_sourcefi FOREIGN KEY (idsourcefinancement) REFERENCES sourcefinancement(idsourcefinancement) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2341 (class 2606 OID 70581)
-- Name: fk_bailleurfond_financementbudget; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financementbudget
    ADD CONSTRAINT fk_bailleurfond_financementbudget FOREIGN KEY (idbailleurfond) REFERENCES bailleurfond(idbailleurfond);


--
-- TOC entry 2316 (class 2606 OID 70586)
-- Name: fk_bonusqua_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bonusqualite
    ADD CONSTRAINT fk_bonusqua_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2317 (class 2606 OID 70591)
-- Name: fk_bonusqua_associati_typeunit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bonusqualite
    ADD CONSTRAINT fk_bonusqua_associati_typeunit FOREIGN KEY (idtypeuniteorganisation) REFERENCES typeuniteorganisation(idtypeuniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2318 (class 2606 OID 70596)
-- Name: fk_budget_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT fk_budget_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2319 (class 2606 OID 70601)
-- Name: fk_budget_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT fk_budget_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2320 (class 2606 OID 70606)
-- Name: fk_budget_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT fk_budget_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2322 (class 2606 OID 70611)
-- Name: fk_cibleann_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cibleannuelle
    ADD CONSTRAINT fk_cibleann_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2323 (class 2606 OID 70616)
-- Name: fk_cibleann_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cibleannuelle
    ADD CONSTRAINT fk_cibleann_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2324 (class 2606 OID 70621)
-- Name: fk_cibleann_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cibleannuelle
    ADD CONSTRAINT fk_cibleann_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2325 (class 2606 OID 70626)
-- Name: fk_ciblerea_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciblerealisation
    ADD CONSTRAINT fk_ciblerea_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2326 (class 2606 OID 70631)
-- Name: fk_ciblerea_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciblerealisation
    ADD CONSTRAINT fk_ciblerea_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2327 (class 2606 OID 70636)
-- Name: fk_ciblerea_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciblerealisation
    ADD CONSTRAINT fk_ciblerea_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2329 (class 2606 OID 70641)
-- Name: fk_coutunit_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coutunitaireindicateur
    ADD CONSTRAINT fk_coutunit_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2330 (class 2606 OID 70646)
-- Name: fk_coutunit_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coutunitaireindicateur
    ADD CONSTRAINT fk_coutunit_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2331 (class 2606 OID 70651)
-- Name: fk_couvertu_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverture
    ADD CONSTRAINT fk_couvertu_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2332 (class 2606 OID 70656)
-- Name: fk_couvertu_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverture
    ADD CONSTRAINT fk_couvertu_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2334 (class 2606 OID 70661)
-- Name: fk_couvertu_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverturepopulation
    ADD CONSTRAINT fk_couvertu_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2333 (class 2606 OID 70666)
-- Name: fk_couvertu_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverture
    ADD CONSTRAINT fk_couvertu_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2335 (class 2606 OID 70671)
-- Name: fk_couvertu_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverturepopulation
    ADD CONSTRAINT fk_couvertu_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2351 (class 2606 OID 70676)
-- Name: fk_couverture_lignebaq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lignebaq
    ADD CONSTRAINT fk_couverture_lignebaq FOREIGN KEY (idcouverture) REFERENCES couverturepopulation(idcouverturepopulation);


--
-- TOC entry 2349 (class 2606 OID 70681)
-- Name: fk_couveruture_ligne_score; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ligne_score_equite
    ADD CONSTRAINT fk_couveruture_ligne_score FOREIGN KEY (idcouverture) REFERENCES couverturepopulation(idcouverturepopulation);


--
-- TOC entry 2370 (class 2606 OID 70867)
-- Name: fk_devise_devise_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devise_periode
    ADD CONSTRAINT fk_devise_devise_periode FOREIGN KEY (iddevise) REFERENCES devise(iddevise);


--
-- TOC entry 2337 (class 2606 OID 70686)
-- Name: fk_financem_associati_bailleur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financement
    ADD CONSTRAINT fk_financem_associati_bailleur FOREIGN KEY (idbailleurfond) REFERENCES bailleurfond(idbailleurfond) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2338 (class 2606 OID 70691)
-- Name: fk_financem_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financement
    ADD CONSTRAINT fk_financem_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2339 (class 2606 OID 70696)
-- Name: fk_financem_associati_typeunit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financement
    ADD CONSTRAINT fk_financem_associati_typeunit FOREIGN KEY (idtypeuniteorganisation) REFERENCES typeuniteorganisation(idtypeuniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2361 (class 2606 OID 70701)
-- Name: fk_ind_ts_indicateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typestructure_indicateur
    ADD CONSTRAINT fk_ind_ts_indicateur FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur);


--
-- TOC entry 2345 (class 2606 OID 70706)
-- Name: fk_indicate_associati_groupind; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurgroupeindicateur
    ADD CONSTRAINT fk_indicate_associati_groupind FOREIGN KEY (idgroupindicateur) REFERENCES groupindicateur(idgroupindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2346 (class 2606 OID 70711)
-- Name: fk_indicate_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurgroupeindicateur
    ADD CONSTRAINT fk_indicate_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2347 (class 2606 OID 70716)
-- Name: fk_indicate_associati_indicate; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurpivot
    ADD CONSTRAINT fk_indicate_associati_indicate FOREIGN KEY (idindicateur) REFERENCES indicateur(idindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2344 (class 2606 OID 70721)
-- Name: fk_indicate_associati_typeindi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateur
    ADD CONSTRAINT fk_indicate_associati_typeindi FOREIGN KEY (idtypeindicateur) REFERENCES typeindicateur(idtypeindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2348 (class 2606 OID 70726)
-- Name: fk_indicate_associati_typeindi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY indicateurpivot
    ADD CONSTRAINT fk_indicate_associati_typeindi FOREIGN KEY (idtypeindicateur) REFERENCES typeindicateur(idtypeindicateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2371 (class 2606 OID 70872)
-- Name: fk_periode_devise_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devise_periode
    ADD CONSTRAINT fk_periode_devise_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode);


--
-- TOC entry 2365 (class 2606 OID 70731)
-- Name: fk_periodecosting_user_costing; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur_costing
    ADD CONSTRAINT fk_periodecosting_user_costing FOREIGN KEY (idperiode_costing) REFERENCES periodecosting(idperiodecosting);


--
-- TOC entry 2355 (class 2606 OID 70736)
-- Name: fk_privileg_associati_menu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT fk_privileg_associati_menu FOREIGN KEY (idmenu) REFERENCES menu(idmenu) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2356 (class 2606 OID 70741)
-- Name: fk_privileg_associati_utilisat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY privilege
    ADD CONSTRAINT fk_privileg_associati_utilisat FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2350 (class 2606 OID 70746)
-- Name: fk_rubrique_ligne_score; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ligne_score_equite
    ADD CONSTRAINT fk_rubrique_ligne_score FOREIGN KEY (idrubrique_score) REFERENCES rubrique_score_qualite(id_rubrique_score_qualite);


--
-- TOC entry 2321 (class 2606 OID 70751)
-- Name: fk_sous_periode_budget; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT fk_sous_periode_budget FOREIGN KEY (idsous_periode) REFERENCES sousperiodecosting(idsousperiode);


--
-- TOC entry 2328 (class 2606 OID 70756)
-- Name: fk_sous_periode_cible_realisation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciblerealisation
    ADD CONSTRAINT fk_sous_periode_cible_realisation FOREIGN KEY (idsousperiode) REFERENCES sousperiodecosting(idsousperiode);


--
-- TOC entry 2336 (class 2606 OID 70761)
-- Name: fk_sous_periode_couverture; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY couverturepopulation
    ADD CONSTRAINT fk_sous_periode_couverture FOREIGN KEY (idsousperiode) REFERENCES sousperiodecosting(idsousperiode);


--
-- TOC entry 2340 (class 2606 OID 70766)
-- Name: fk_sous_periode_financement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financement
    ADD CONSTRAINT fk_sous_periode_financement FOREIGN KEY (idsous_periode) REFERENCES sousperiodecosting(idsousperiode);


--
-- TOC entry 2357 (class 2606 OID 70771)
-- Name: fk_sousperi_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sousperiodecosting
    ADD CONSTRAINT fk_sousperi_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2358 (class 2606 OID 70776)
-- Name: fk_sousperi_associati_periodec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sousperiodecosting
    ADD CONSTRAINT fk_sousperi_associati_periodec FOREIGN KEY (idperiodecosting) REFERENCES periodecosting(idperiodecosting) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2342 (class 2606 OID 70781)
-- Name: fk_sousperiode_financementbudget; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financementbudget
    ADD CONSTRAINT fk_sousperiode_financementbudget FOREIGN KEY (idsous_periode) REFERENCES sousperiodecosting(idsousperiode);


--
-- TOC entry 2359 (class 2606 OID 70786)
-- Name: fk_tauxurba_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tauxurbanisation
    ADD CONSTRAINT fk_tauxurba_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2360 (class 2606 OID 70791)
-- Name: fk_tauxurba_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tauxurbanisation
    ADD CONSTRAINT fk_tauxurba_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2362 (class 2606 OID 70796)
-- Name: fk_ts_indicateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY typestructure_indicateur
    ADD CONSTRAINT fk_ts_indicateur FOREIGN KEY (idtypestructure) REFERENCES typeuniteorganisation(idtypeuniteorganisation);


--
-- TOC entry 2343 (class 2606 OID 70801)
-- Name: fk_type_uo_financementbudget; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY financementbudget
    ADD CONSTRAINT fk_type_uo_financementbudget FOREIGN KEY (idtype_uo) REFERENCES typeuniteorganisation(idtypeuniteorganisation);


--
-- TOC entry 2352 (class 2606 OID 70806)
-- Name: fk_typebaq_lignebaq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lignebaq
    ADD CONSTRAINT fk_typebaq_lignebaq FOREIGN KEY (id_type_baq) REFERENCES type_baq(id_type_baq);


--
-- TOC entry 2354 (class 2606 OID 70811)
-- Name: fk_typeperiode_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT fk_typeperiode_periode FOREIGN KEY (idtype_periode) REFERENCES type_periode(idtype_periode);


--
-- TOC entry 2363 (class 2606 OID 70816)
-- Name: fk_uniteorg_associati_niveaupy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uniteorganisation
    ADD CONSTRAINT fk_uniteorg_associati_niveaupy FOREIGN KEY (idniveaupyramide) REFERENCES niveaupyramide(idniveaupyramide) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2364 (class 2606 OID 70821)
-- Name: fk_uniteorg_associati_typeunit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uniteorganisation
    ADD CONSTRAINT fk_uniteorg_associati_typeunit FOREIGN KEY (idtypeuniteorganisation) REFERENCES typeuniteorganisation(idtypeuniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2366 (class 2606 OID 70826)
-- Name: fk_utilisateur_costing; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY utilisateur_costing
    ADD CONSTRAINT fk_utilisateur_costing FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur);


--
-- TOC entry 2353 (class 2606 OID 70831)
-- Name: fk_utilisateur_mouchard; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mouchard
    ADD CONSTRAINT fk_utilisateur_mouchard FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur);


--
-- TOC entry 2367 (class 2606 OID 70836)
-- Name: fk_valeursc_associati_periode; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valeurscore
    ADD CONSTRAINT fk_valeursc_associati_periode FOREIGN KEY (idperiode) REFERENCES periode(idperiode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2368 (class 2606 OID 70841)
-- Name: fk_valeursc_associati_typescor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valeurscore
    ADD CONSTRAINT fk_valeursc_associati_typescor FOREIGN KEY (idtypescore) REFERENCES typescore(idtypescore) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2369 (class 2606 OID 70846)
-- Name: fk_valeursc_associati_uniteorg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valeurscore
    ADD CONSTRAINT fk_valeursc_associati_uniteorg FOREIGN KEY (iduniteorganisation) REFERENCES uniteorganisation(iduniteorganisation) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2020-04-03 15:29:03

--
-- PostgreSQL database dump complete
--

