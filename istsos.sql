--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: weather; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA weather;


ALTER SCHEMA weather OWNER TO postgres;

--
-- Name: weatherstation; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA weatherstation;


ALTER SCHEMA weatherstation OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = weather, pg_catalog;

--
-- Name: status; Type: TYPE; Schema: weather; Owner: postgres
--

CREATE TYPE status AS ENUM (
    'verified',
    'pending'
);


ALTER TYPE weather.status OWNER TO postgres;

SET search_path = weatherstation, pg_catalog;

--
-- Name: status; Type: TYPE; Schema: weatherstation; Owner: postgres
--

CREATE TYPE status AS ENUM (
    'verified',
    'pending'
);


ALTER TYPE weatherstation.status OWNER TO postgres;

SET search_path = weather, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cron_log; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE cron_log (
    id_clo integer NOT NULL,
    id_prc_fk integer NOT NULL,
    process_clo character varying NOT NULL,
    element_clo character varying NOT NULL,
    datetime_clo timestamp with time zone NOT NULL,
    message_clo character varying NOT NULL,
    details_clo character varying,
    status_clo status
);


ALTER TABLE weather.cron_log OWNER TO postgres;

--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE cron_log_id_clo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.cron_log_id_clo_seq OWNER TO postgres;

--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE cron_log_id_clo_seq OWNED BY cron_log.id_clo;


--
-- Name: event_time; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE event_time (
    id_eti bigint NOT NULL,
    id_prc_fk integer NOT NULL,
    time_eti timestamp with time zone NOT NULL
);


ALTER TABLE weather.event_time OWNER TO postgres;

--
-- Name: TABLE event_time; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE event_time IS 'Stores Observation''s eventTime.';


--
-- Name: event_time_id_eti_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE event_time_id_eti_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.event_time_id_eti_seq OWNER TO postgres;

--
-- Name: event_time_id_eti_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE event_time_id_eti_seq OWNED BY event_time.id_eti;


--
-- Name: feature_type; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE feature_type (
    name_fty character varying(25) NOT NULL,
    id_fty integer NOT NULL
);


ALTER TABLE weather.feature_type OWNER TO postgres;

--
-- Name: TABLE feature_type; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE feature_type IS 'Definition of FeatureOfInterest type.';


--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE feature_type_id_fty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.feature_type_id_fty_seq OWNER TO postgres;

--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE feature_type_id_fty_seq OWNED BY feature_type.id_fty;


--
-- Name: foi; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE foi (
    desc_foi text,
    id_fty_fk integer NOT NULL,
    id_foi integer NOT NULL,
    name_foi character varying(25) NOT NULL,
    geom_foi public.geometry(PointZ,4326)
);


ALTER TABLE weather.foi OWNER TO postgres;

--
-- Name: TABLE foi; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE foi IS 'Stores FeatureOfInterest type.';


--
-- Name: foi_id_foi_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE foi_id_foi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.foi_id_foi_seq OWNER TO postgres;

--
-- Name: foi_id_foi_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE foi_id_foi_seq OWNED BY foi.id_foi;


--
-- Name: measures; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE measures (
    id_msr bigint NOT NULL,
    id_eti_fk bigint NOT NULL,
    id_qi_fk integer NOT NULL,
    id_pro_fk integer NOT NULL,
    val_msr numeric(10,6) NOT NULL
);


ALTER TABLE weather.measures OWNER TO postgres;

--
-- Name: TABLE measures; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE measures IS 'Stores the measures of the Procedure.';


--
-- Name: measures_id_msr_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE measures_id_msr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.measures_id_msr_seq OWNER TO postgres;

--
-- Name: measures_id_msr_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE measures_id_msr_seq OWNED BY measures.id_msr;


--
-- Name: positions; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE positions (
    id_pos bigint NOT NULL,
    id_qi_fk integer NOT NULL,
    id_eti_fk bigint NOT NULL,
    geom_pos public.geometry(PointZ,4326)
);


ALTER TABLE weather.positions OWNER TO postgres;

--
-- Name: TABLE positions; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE positions IS 'Stores the location for mobile-points Procedure.';


--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE measures_mobile_id_mmo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.measures_mobile_id_mmo_seq OWNER TO postgres;

--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE measures_mobile_id_mmo_seq OWNED BY positions.id_pos;


--
-- Name: observed_properties; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE observed_properties (
    name_opr character varying(60) NOT NULL,
    def_opr character varying(80) NOT NULL,
    desc_opr text,
    constr_opr character varying,
    id_opr integer NOT NULL
);


ALTER TABLE weather.observed_properties OWNER TO postgres;

--
-- Name: TABLE observed_properties; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE observed_properties IS 'Stores the ObservedProperties.';


--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE obs_pr_id_opr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.obs_pr_id_opr_seq OWNER TO postgres;

--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE obs_pr_id_opr_seq OWNED BY observed_properties.id_opr;


--
-- Name: obs_type; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE obs_type (
    id_oty integer NOT NULL,
    name_oty character varying(60) NOT NULL,
    desc_oty character varying(120)
);


ALTER TABLE weather.obs_type OWNER TO postgres;

--
-- Name: TABLE obs_type; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE obs_type IS 'Stores the type of observation (e.g.: mobile or fix).';


--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE obs_type_id_oty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.obs_type_id_oty_seq OWNER TO postgres;

--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE obs_type_id_oty_seq OWNED BY obs_type.id_oty;


--
-- Name: off_proc; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE off_proc (
    id_off_prc integer NOT NULL,
    id_off_fk integer NOT NULL,
    id_prc_fk integer NOT NULL
);


ALTER TABLE weather.off_proc OWNER TO postgres;

--
-- Name: TABLE off_proc; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE off_proc IS 'Association table between Offerings and Procedures.';


--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE off_proc_id_opr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.off_proc_id_opr_seq OWNER TO postgres;

--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE off_proc_id_opr_seq OWNED BY off_proc.id_off_prc;


--
-- Name: offerings; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE offerings (
    name_off character varying(64) NOT NULL,
    desc_off text,
    expiration_off timestamp with time zone,
    active_off boolean DEFAULT true NOT NULL,
    id_off integer NOT NULL
);


ALTER TABLE weather.offerings OWNER TO postgres;

--
-- Name: TABLE offerings; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE offerings IS 'Stores the Offerings.';


--
-- Name: offerings_id_off_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE offerings_id_off_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.offerings_id_off_seq OWNER TO postgres;

--
-- Name: offerings_id_off_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE offerings_id_off_seq OWNED BY offerings.id_off;


--
-- Name: proc_obs; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE proc_obs (
    id_pro integer NOT NULL,
    id_prc_fk integer NOT NULL,
    id_uom_fk integer NOT NULL,
    id_opr_fk integer NOT NULL,
    constr_pro character varying
);


ALTER TABLE weather.proc_obs OWNER TO postgres;

--
-- Name: TABLE proc_obs; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE proc_obs IS 'Association table between Procedures, ObservedProperty and UnitOfMeasure.';


--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE prc_obs_id_pro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.prc_obs_id_pro_seq OWNER TO postgres;

--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE prc_obs_id_pro_seq OWNED BY proc_obs.id_pro;


--
-- Name: procedures; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE procedures (
    id_prc integer NOT NULL,
    assignedid_prc character varying(32) NOT NULL,
    name_prc character varying(30) NOT NULL,
    desc_prc text,
    stime_prc timestamp with time zone,
    etime_prc timestamp with time zone,
    time_res_prc integer,
    time_acq_prc integer,
    id_oty_fk integer,
    id_foi_fk integer,
    mqtt_prc character varying
);


ALTER TABLE weather.procedures OWNER TO postgres;

--
-- Name: TABLE procedures; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE procedures IS 'Stores the Procedures.';


--
-- Name: procedures_id_prc_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE procedures_id_prc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.procedures_id_prc_seq OWNER TO postgres;

--
-- Name: procedures_id_prc_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE procedures_id_prc_seq OWNED BY procedures.id_prc;


--
-- Name: quality_index; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE quality_index (
    name_qi character varying(25) NOT NULL,
    desc_qi text,
    id_qi integer NOT NULL
);


ALTER TABLE weather.quality_index OWNER TO postgres;

--
-- Name: TABLE quality_index; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE quality_index IS 'Stores the QualityIndexes.';


--
-- Name: tran_log; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE tran_log (
    id_trl integer NOT NULL,
    transaction_time_trl timestamp without time zone DEFAULT now(),
    operation_trl character varying NOT NULL,
    procedure_trl character varying(30) NOT NULL,
    begin_trl timestamp with time zone,
    end_trl timestamp with time zone,
    count integer,
    stime_prc timestamp with time zone,
    etime_prc timestamp with time zone
);


ALTER TABLE weather.tran_log OWNER TO postgres;

--
-- Name: TABLE tran_log; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE tran_log IS 'Log table for transactional operations.';


--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE tran_log_id_trl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.tran_log_id_trl_seq OWNER TO postgres;

--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE tran_log_id_trl_seq OWNED BY tran_log.id_trl;


--
-- Name: uoms; Type: TABLE; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE TABLE uoms (
    name_uom character varying(20) NOT NULL,
    desc_uom text,
    id_uom integer NOT NULL
);


ALTER TABLE weather.uoms OWNER TO postgres;

--
-- Name: TABLE uoms; Type: COMMENT; Schema: weather; Owner: postgres
--

COMMENT ON TABLE uoms IS 'Stores the Units of Measures.';


--
-- Name: uoms_id_uom_seq; Type: SEQUENCE; Schema: weather; Owner: postgres
--

CREATE SEQUENCE uoms_id_uom_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather.uoms_id_uom_seq OWNER TO postgres;

--
-- Name: uoms_id_uom_seq; Type: SEQUENCE OWNED BY; Schema: weather; Owner: postgres
--

ALTER SEQUENCE uoms_id_uom_seq OWNED BY uoms.id_uom;


SET search_path = weatherstation, pg_catalog;

--
-- Name: cron_log; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE cron_log (
    id_clo integer NOT NULL,
    id_prc_fk integer NOT NULL,
    process_clo character varying NOT NULL,
    element_clo character varying NOT NULL,
    datetime_clo timestamp with time zone NOT NULL,
    message_clo character varying NOT NULL,
    details_clo character varying,
    status_clo status
);


ALTER TABLE weatherstation.cron_log OWNER TO postgres;

--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE cron_log_id_clo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.cron_log_id_clo_seq OWNER TO postgres;

--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE cron_log_id_clo_seq OWNED BY cron_log.id_clo;


--
-- Name: event_time; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE event_time (
    id_eti bigint NOT NULL,
    id_prc_fk integer NOT NULL,
    time_eti timestamp with time zone NOT NULL
);


ALTER TABLE weatherstation.event_time OWNER TO postgres;

--
-- Name: TABLE event_time; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE event_time IS 'Stores Observation''s eventTime.';


--
-- Name: event_time_id_eti_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE event_time_id_eti_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.event_time_id_eti_seq OWNER TO postgres;

--
-- Name: event_time_id_eti_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE event_time_id_eti_seq OWNED BY event_time.id_eti;


--
-- Name: feature_type; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE feature_type (
    name_fty character varying(25) NOT NULL,
    id_fty integer NOT NULL
);


ALTER TABLE weatherstation.feature_type OWNER TO postgres;

--
-- Name: TABLE feature_type; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE feature_type IS 'Definition of FeatureOfInterest type.';


--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE feature_type_id_fty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.feature_type_id_fty_seq OWNER TO postgres;

--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE feature_type_id_fty_seq OWNED BY feature_type.id_fty;


--
-- Name: foi; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE foi (
    desc_foi text,
    id_fty_fk integer NOT NULL,
    id_foi integer NOT NULL,
    name_foi character varying(25) NOT NULL,
    geom_foi public.geometry(PointZ,4326)
);


ALTER TABLE weatherstation.foi OWNER TO postgres;

--
-- Name: TABLE foi; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE foi IS 'Stores FeatureOfInterest type.';


--
-- Name: foi_id_foi_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE foi_id_foi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.foi_id_foi_seq OWNER TO postgres;

--
-- Name: foi_id_foi_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE foi_id_foi_seq OWNED BY foi.id_foi;


--
-- Name: measures; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE measures (
    id_msr bigint NOT NULL,
    id_eti_fk bigint NOT NULL,
    id_qi_fk integer NOT NULL,
    id_pro_fk integer NOT NULL,
    val_msr numeric(10,6) NOT NULL
);


ALTER TABLE weatherstation.measures OWNER TO postgres;

--
-- Name: TABLE measures; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE measures IS 'Stores the measures of the Procedure.';


--
-- Name: measures_id_msr_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE measures_id_msr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.measures_id_msr_seq OWNER TO postgres;

--
-- Name: measures_id_msr_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE measures_id_msr_seq OWNED BY measures.id_msr;


--
-- Name: positions; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE positions (
    id_pos bigint NOT NULL,
    id_qi_fk integer NOT NULL,
    id_eti_fk bigint NOT NULL,
    geom_pos public.geometry(PointZ,4326)
);


ALTER TABLE weatherstation.positions OWNER TO postgres;

--
-- Name: TABLE positions; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE positions IS 'Stores the location for mobile-points Procedure.';


--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE measures_mobile_id_mmo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.measures_mobile_id_mmo_seq OWNER TO postgres;

--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE measures_mobile_id_mmo_seq OWNED BY positions.id_pos;


--
-- Name: observed_properties; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE observed_properties (
    name_opr character varying(60) NOT NULL,
    def_opr character varying(80) NOT NULL,
    desc_opr text,
    constr_opr character varying,
    id_opr integer NOT NULL
);


ALTER TABLE weatherstation.observed_properties OWNER TO postgres;

--
-- Name: TABLE observed_properties; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE observed_properties IS 'Stores the ObservedProperties.';


--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE obs_pr_id_opr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.obs_pr_id_opr_seq OWNER TO postgres;

--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE obs_pr_id_opr_seq OWNED BY observed_properties.id_opr;


--
-- Name: obs_type; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE obs_type (
    id_oty integer NOT NULL,
    name_oty character varying(60) NOT NULL,
    desc_oty character varying(120)
);


ALTER TABLE weatherstation.obs_type OWNER TO postgres;

--
-- Name: TABLE obs_type; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE obs_type IS 'Stores the type of observation (e.g.: mobile or fix).';


--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE obs_type_id_oty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.obs_type_id_oty_seq OWNER TO postgres;

--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE obs_type_id_oty_seq OWNED BY obs_type.id_oty;


--
-- Name: off_proc; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE off_proc (
    id_off_prc integer NOT NULL,
    id_off_fk integer NOT NULL,
    id_prc_fk integer NOT NULL
);


ALTER TABLE weatherstation.off_proc OWNER TO postgres;

--
-- Name: TABLE off_proc; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE off_proc IS 'Association table between Offerings and Procedures.';


--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE off_proc_id_opr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.off_proc_id_opr_seq OWNER TO postgres;

--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE off_proc_id_opr_seq OWNED BY off_proc.id_off_prc;


--
-- Name: offerings; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE offerings (
    name_off character varying(64) NOT NULL,
    desc_off text,
    expiration_off timestamp with time zone,
    active_off boolean DEFAULT true NOT NULL,
    id_off integer NOT NULL
);


ALTER TABLE weatherstation.offerings OWNER TO postgres;

--
-- Name: TABLE offerings; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE offerings IS 'Stores the Offerings.';


--
-- Name: offerings_id_off_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE offerings_id_off_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.offerings_id_off_seq OWNER TO postgres;

--
-- Name: offerings_id_off_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE offerings_id_off_seq OWNED BY offerings.id_off;


--
-- Name: proc_obs; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE proc_obs (
    id_pro integer NOT NULL,
    id_prc_fk integer NOT NULL,
    id_uom_fk integer NOT NULL,
    id_opr_fk integer NOT NULL,
    constr_pro character varying
);


ALTER TABLE weatherstation.proc_obs OWNER TO postgres;

--
-- Name: TABLE proc_obs; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE proc_obs IS 'Association table between Procedures, ObservedProperty and UnitOfMeasure.';


--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE prc_obs_id_pro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.prc_obs_id_pro_seq OWNER TO postgres;

--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE prc_obs_id_pro_seq OWNED BY proc_obs.id_pro;


--
-- Name: procedures; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE procedures (
    id_prc integer NOT NULL,
    assignedid_prc character varying(32) NOT NULL,
    name_prc character varying(30) NOT NULL,
    desc_prc text,
    stime_prc timestamp with time zone,
    etime_prc timestamp with time zone,
    time_res_prc integer,
    time_acq_prc integer,
    id_oty_fk integer,
    id_foi_fk integer,
    mqtt_prc character varying
);


ALTER TABLE weatherstation.procedures OWNER TO postgres;

--
-- Name: TABLE procedures; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE procedures IS 'Stores the Procedures.';


--
-- Name: procedures_id_prc_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE procedures_id_prc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.procedures_id_prc_seq OWNER TO postgres;

--
-- Name: procedures_id_prc_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE procedures_id_prc_seq OWNED BY procedures.id_prc;


--
-- Name: quality_index; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE quality_index (
    name_qi character varying(25) NOT NULL,
    desc_qi text,
    id_qi integer NOT NULL
);


ALTER TABLE weatherstation.quality_index OWNER TO postgres;

--
-- Name: TABLE quality_index; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE quality_index IS 'Stores the QualityIndexes.';


--
-- Name: tran_log; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE tran_log (
    id_trl integer NOT NULL,
    transaction_time_trl timestamp without time zone DEFAULT now(),
    operation_trl character varying NOT NULL,
    procedure_trl character varying(30) NOT NULL,
    begin_trl timestamp with time zone,
    end_trl timestamp with time zone,
    count integer,
    stime_prc timestamp with time zone,
    etime_prc timestamp with time zone
);


ALTER TABLE weatherstation.tran_log OWNER TO postgres;

--
-- Name: TABLE tran_log; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE tran_log IS 'Log table for transactional operations.';


--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE tran_log_id_trl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.tran_log_id_trl_seq OWNER TO postgres;

--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE tran_log_id_trl_seq OWNED BY tran_log.id_trl;


--
-- Name: uoms; Type: TABLE; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE TABLE uoms (
    name_uom character varying(20) NOT NULL,
    desc_uom text,
    id_uom integer NOT NULL
);


ALTER TABLE weatherstation.uoms OWNER TO postgres;

--
-- Name: TABLE uoms; Type: COMMENT; Schema: weatherstation; Owner: postgres
--

COMMENT ON TABLE uoms IS 'Stores the Units of Measures.';


--
-- Name: uoms_id_uom_seq; Type: SEQUENCE; Schema: weatherstation; Owner: postgres
--

CREATE SEQUENCE uoms_id_uom_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weatherstation.uoms_id_uom_seq OWNER TO postgres;

--
-- Name: uoms_id_uom_seq; Type: SEQUENCE OWNED BY; Schema: weatherstation; Owner: postgres
--

ALTER SEQUENCE uoms_id_uom_seq OWNED BY uoms.id_uom;


SET search_path = weather, pg_catalog;

--
-- Name: id_clo; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY cron_log ALTER COLUMN id_clo SET DEFAULT nextval('cron_log_id_clo_seq'::regclass);


--
-- Name: id_eti; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY event_time ALTER COLUMN id_eti SET DEFAULT nextval('event_time_id_eti_seq'::regclass);


--
-- Name: id_fty; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY feature_type ALTER COLUMN id_fty SET DEFAULT nextval('feature_type_id_fty_seq'::regclass);


--
-- Name: id_foi; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY foi ALTER COLUMN id_foi SET DEFAULT nextval('foi_id_foi_seq'::regclass);


--
-- Name: id_msr; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY measures ALTER COLUMN id_msr SET DEFAULT nextval('measures_id_msr_seq'::regclass);


--
-- Name: id_oty; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY obs_type ALTER COLUMN id_oty SET DEFAULT nextval('obs_type_id_oty_seq'::regclass);


--
-- Name: id_opr; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY observed_properties ALTER COLUMN id_opr SET DEFAULT nextval('obs_pr_id_opr_seq'::regclass);


--
-- Name: id_off_prc; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY off_proc ALTER COLUMN id_off_prc SET DEFAULT nextval('off_proc_id_opr_seq'::regclass);


--
-- Name: id_off; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY offerings ALTER COLUMN id_off SET DEFAULT nextval('offerings_id_off_seq'::regclass);


--
-- Name: id_pos; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY positions ALTER COLUMN id_pos SET DEFAULT nextval('measures_mobile_id_mmo_seq'::regclass);


--
-- Name: id_pro; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY proc_obs ALTER COLUMN id_pro SET DEFAULT nextval('prc_obs_id_pro_seq'::regclass);


--
-- Name: id_prc; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY procedures ALTER COLUMN id_prc SET DEFAULT nextval('procedures_id_prc_seq'::regclass);


--
-- Name: id_trl; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY tran_log ALTER COLUMN id_trl SET DEFAULT nextval('tran_log_id_trl_seq'::regclass);


--
-- Name: id_uom; Type: DEFAULT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY uoms ALTER COLUMN id_uom SET DEFAULT nextval('uoms_id_uom_seq'::regclass);


SET search_path = weatherstation, pg_catalog;

--
-- Name: id_clo; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY cron_log ALTER COLUMN id_clo SET DEFAULT nextval('cron_log_id_clo_seq'::regclass);


--
-- Name: id_eti; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY event_time ALTER COLUMN id_eti SET DEFAULT nextval('event_time_id_eti_seq'::regclass);


--
-- Name: id_fty; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY feature_type ALTER COLUMN id_fty SET DEFAULT nextval('feature_type_id_fty_seq'::regclass);


--
-- Name: id_foi; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY foi ALTER COLUMN id_foi SET DEFAULT nextval('foi_id_foi_seq'::regclass);


--
-- Name: id_msr; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY measures ALTER COLUMN id_msr SET DEFAULT nextval('measures_id_msr_seq'::regclass);


--
-- Name: id_oty; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY obs_type ALTER COLUMN id_oty SET DEFAULT nextval('obs_type_id_oty_seq'::regclass);


--
-- Name: id_opr; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY observed_properties ALTER COLUMN id_opr SET DEFAULT nextval('obs_pr_id_opr_seq'::regclass);


--
-- Name: id_off_prc; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY off_proc ALTER COLUMN id_off_prc SET DEFAULT nextval('off_proc_id_opr_seq'::regclass);


--
-- Name: id_off; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY offerings ALTER COLUMN id_off SET DEFAULT nextval('offerings_id_off_seq'::regclass);


--
-- Name: id_pos; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY positions ALTER COLUMN id_pos SET DEFAULT nextval('measures_mobile_id_mmo_seq'::regclass);


--
-- Name: id_pro; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY proc_obs ALTER COLUMN id_pro SET DEFAULT nextval('prc_obs_id_pro_seq'::regclass);


--
-- Name: id_prc; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY procedures ALTER COLUMN id_prc SET DEFAULT nextval('procedures_id_prc_seq'::regclass);


--
-- Name: id_trl; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY tran_log ALTER COLUMN id_trl SET DEFAULT nextval('tran_log_id_trl_seq'::regclass);


--
-- Name: id_uom; Type: DEFAULT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY uoms ALTER COLUMN id_uom SET DEFAULT nextval('uoms_id_uom_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys  FROM stdin;
\.


SET search_path = weather, pg_catalog;

--
-- Data for Name: cron_log; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY cron_log (id_clo, id_prc_fk, process_clo, element_clo, datetime_clo, message_clo, details_clo, status_clo) FROM stdin;
\.


--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('cron_log_id_clo_seq', 1, false);


--
-- Data for Name: event_time; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY event_time (id_eti, id_prc_fk, time_eti) FROM stdin;
5	1	1992-01-01 04:40:00+05:30
6	1	1992-01-02 04:40:00+05:30
7	1	1992-02-01 04:40:00+05:30
8	1	1992-03-01 04:40:00+05:30
9	1	1992-04-01 04:40:00+05:30
10	1	1992-05-01 04:40:00+05:30
11	1	1992-06-01 04:40:00+05:30
12	1	1992-07-01 04:40:00+05:30
13	1	1992-08-01 04:40:00+05:30
14	1	1992-09-01 04:40:00+05:30
15	1	1992-10-01 04:40:00+05:30
16	1	1992-11-01 04:40:00+05:30
17	1	1992-12-01 04:40:00+05:30
18	1	1993-01-01 04:40:00+05:30
19	1	1993-02-01 04:40:00+05:30
20	1	1993-03-01 04:40:00+05:30
21	1	1993-04-01 04:40:00+05:30
22	1	1993-05-01 04:40:00+05:30
23	1	1993-06-01 04:40:00+05:30
24	1	1993-07-01 04:40:00+05:30
25	1	1993-08-01 04:40:00+05:30
26	1	1993-09-01 04:40:00+05:30
27	1	1993-10-01 04:40:00+05:30
28	1	1993-11-01 04:40:00+05:30
29	1	1993-12-01 04:40:00+05:30
30	1	1994-01-01 04:40:00+05:30
31	1	1994-02-01 04:40:00+05:30
32	1	1994-03-01 04:40:00+05:30
33	1	1994-04-01 04:40:00+05:30
34	1	1994-05-01 04:40:00+05:30
35	1	1994-06-01 04:40:00+05:30
36	1	1994-07-01 04:40:00+05:30
37	1	1994-08-01 04:40:00+05:30
38	1	1994-09-01 04:40:00+05:30
39	1	1994-10-01 04:40:00+05:30
40	1	1994-11-01 04:40:00+05:30
41	1	1994-12-01 04:40:00+05:30
42	1	1995-01-01 04:40:00+05:30
43	1	1995-02-01 04:40:00+05:30
44	1	1995-03-01 04:40:00+05:30
45	1	1995-04-01 04:40:00+05:30
46	1	1995-05-01 04:40:00+05:30
47	1	1995-06-01 04:40:00+05:30
48	1	1995-07-01 04:40:00+05:30
49	1	1995-08-01 04:40:00+05:30
50	1	1995-09-01 04:40:00+05:30
51	1	1995-10-01 04:40:00+05:30
52	1	1995-11-01 04:40:00+05:30
53	1	1995-12-01 04:40:00+05:30
54	1	1996-01-01 04:40:00+05:30
55	1	1996-02-01 04:40:00+05:30
56	1	1996-03-01 04:40:00+05:30
57	1	1996-04-01 04:40:00+05:30
58	1	1996-05-01 04:40:00+05:30
59	1	1996-06-01 04:40:00+05:30
60	1	1996-07-01 04:40:00+05:30
61	1	1996-08-01 04:40:00+05:30
62	1	1996-09-01 04:40:00+05:30
63	1	1996-10-01 04:40:00+05:30
64	1	1996-11-01 04:40:00+05:30
65	1	1996-12-01 04:40:00+05:30
66	1	1997-01-01 04:40:00+05:30
67	1	1997-02-01 04:40:00+05:30
68	1	1997-03-01 04:40:00+05:30
69	1	1997-04-01 04:40:00+05:30
70	1	1997-05-01 04:40:00+05:30
71	1	1997-06-01 04:40:00+05:30
72	1	1997-07-01 04:40:00+05:30
73	1	1997-08-01 04:40:00+05:30
74	1	1997-09-01 04:40:00+05:30
75	1	1997-10-01 04:40:00+05:30
76	1	1997-11-01 04:40:00+05:30
77	1	1997-12-01 04:40:00+05:30
78	1	1998-01-01 04:40:00+05:30
79	1	1998-02-01 04:40:00+05:30
80	1	1998-03-01 04:40:00+05:30
81	1	1998-04-01 04:40:00+05:30
82	1	1998-05-01 04:40:00+05:30
83	1	1998-06-01 04:40:00+05:30
84	1	1998-07-01 04:40:00+05:30
85	1	1998-08-01 04:40:00+05:30
86	1	1998-09-01 04:40:00+05:30
87	1	1998-10-01 04:40:00+05:30
88	1	1998-11-01 04:40:00+05:30
89	1	1998-12-01 04:40:00+05:30
90	1	1999-01-01 04:40:00+05:30
91	1	1999-02-01 04:40:00+05:30
92	1	1999-03-01 04:40:00+05:30
93	1	1999-04-01 04:40:00+05:30
94	1	1999-05-01 04:40:00+05:30
95	1	1999-06-01 04:40:00+05:30
96	1	1999-07-01 04:40:00+05:30
97	1	1999-08-01 04:40:00+05:30
98	1	1999-09-01 04:40:00+05:30
99	1	1999-10-01 04:40:00+05:30
100	1	1999-11-01 04:40:00+05:30
101	1	1999-12-01 04:40:00+05:30
102	1	2000-01-01 04:40:00+05:30
103	1	2000-02-01 04:40:00+05:30
104	1	2000-03-01 04:40:00+05:30
105	1	2000-04-01 04:40:00+05:30
106	1	2000-05-01 04:40:00+05:30
107	1	2000-06-01 04:40:00+05:30
108	1	2000-07-01 04:40:00+05:30
109	1	2000-08-01 04:40:00+05:30
110	1	2000-09-01 04:40:00+05:30
111	1	2000-10-01 04:40:00+05:30
112	1	2000-11-01 04:40:00+05:30
113	1	2000-12-01 04:40:00+05:30
114	1	2001-01-01 04:40:00+05:30
115	1	2001-02-01 04:40:00+05:30
116	1	2001-03-01 04:40:00+05:30
117	1	2001-04-01 04:40:00+05:30
118	1	2001-05-01 04:40:00+05:30
119	1	2001-06-01 04:40:00+05:30
120	1	2001-07-01 04:40:00+05:30
121	1	2001-08-01 04:40:00+05:30
122	1	2001-09-01 04:40:00+05:30
123	1	2001-10-01 04:40:00+05:30
124	1	2001-11-01 04:40:00+05:30
125	1	2001-12-01 04:40:00+05:30
126	1	2002-01-01 04:40:00+05:30
127	1	2002-02-01 04:40:00+05:30
128	1	2002-03-01 04:40:00+05:30
129	1	2002-04-01 04:40:00+05:30
130	1	2002-05-01 04:40:00+05:30
131	1	2002-06-01 04:40:00+05:30
132	1	2002-07-01 04:40:00+05:30
133	1	2002-08-01 04:40:00+05:30
134	1	2002-09-01 04:40:00+05:30
135	1	2002-10-01 04:40:00+05:30
136	1	2002-11-01 04:40:00+05:30
137	1	2002-12-01 04:40:00+05:30
138	2	1992-01-02 04:40:00+05:30
139	2	1992-02-01 04:40:00+05:30
140	2	1992-03-01 04:40:00+05:30
141	2	1992-04-01 04:40:00+05:30
142	2	1992-05-01 04:40:00+05:30
143	2	1992-06-01 04:40:00+05:30
144	2	1992-07-01 04:40:00+05:30
145	2	1992-08-01 04:40:00+05:30
146	2	1992-09-01 04:40:00+05:30
147	2	1992-10-01 04:40:00+05:30
148	2	1992-11-01 04:40:00+05:30
149	2	1992-12-01 04:40:00+05:30
150	2	1993-01-01 04:40:00+05:30
151	2	1993-02-01 04:40:00+05:30
152	2	1993-03-01 04:40:00+05:30
153	2	1993-04-01 04:40:00+05:30
154	2	1993-05-01 04:40:00+05:30
155	2	1993-06-01 04:40:00+05:30
156	2	1993-07-01 04:40:00+05:30
157	2	1993-08-01 04:40:00+05:30
158	2	1993-09-01 04:40:00+05:30
159	2	1993-10-01 04:40:00+05:30
160	2	1993-11-01 04:40:00+05:30
161	2	1993-12-01 04:40:00+05:30
162	2	1994-01-01 04:40:00+05:30
163	2	1994-02-01 04:40:00+05:30
164	2	1994-03-01 04:40:00+05:30
165	2	1994-04-01 04:40:00+05:30
166	2	1994-05-01 04:40:00+05:30
167	2	1994-06-01 04:40:00+05:30
168	2	1994-07-01 04:40:00+05:30
169	2	1994-08-01 04:40:00+05:30
170	2	1994-09-01 04:40:00+05:30
171	2	1994-10-01 04:40:00+05:30
172	2	1994-11-01 04:40:00+05:30
173	2	1994-12-01 04:40:00+05:30
174	2	1995-01-01 04:40:00+05:30
175	2	1995-02-01 04:40:00+05:30
176	2	1995-03-01 04:40:00+05:30
177	2	1995-04-01 04:40:00+05:30
178	2	1995-05-01 04:40:00+05:30
179	2	1995-06-01 04:40:00+05:30
180	2	1995-07-01 04:40:00+05:30
181	2	1995-08-01 04:40:00+05:30
182	2	1995-09-01 04:40:00+05:30
183	2	1995-10-01 04:40:00+05:30
184	2	1995-11-01 04:40:00+05:30
185	2	1995-12-01 04:40:00+05:30
186	2	1996-01-01 04:40:00+05:30
187	2	1996-02-01 04:40:00+05:30
188	2	1996-03-01 04:40:00+05:30
189	2	1996-04-01 04:40:00+05:30
190	2	1996-05-01 04:40:00+05:30
191	2	1996-06-01 04:40:00+05:30
192	2	1996-07-01 04:40:00+05:30
193	2	1996-08-01 04:40:00+05:30
194	2	1996-09-01 04:40:00+05:30
195	2	1996-10-01 04:40:00+05:30
196	2	1996-11-01 04:40:00+05:30
197	2	1996-12-01 04:40:00+05:30
198	2	1997-01-01 04:40:00+05:30
199	2	1997-02-01 04:40:00+05:30
200	2	1997-03-01 04:40:00+05:30
201	2	1997-04-01 04:40:00+05:30
202	2	1997-05-01 04:40:00+05:30
203	2	1997-06-01 04:40:00+05:30
204	2	1997-07-01 04:40:00+05:30
205	2	1997-08-01 04:40:00+05:30
206	2	1997-09-01 04:40:00+05:30
207	2	1997-10-01 04:40:00+05:30
208	2	1997-11-01 04:40:00+05:30
209	2	1997-12-01 04:40:00+05:30
210	2	1998-01-01 04:40:00+05:30
211	2	1998-02-01 04:40:00+05:30
212	2	1998-03-01 04:40:00+05:30
213	2	1998-04-01 04:40:00+05:30
214	2	1998-05-01 04:40:00+05:30
215	2	1998-06-01 04:40:00+05:30
216	2	1998-07-01 04:40:00+05:30
217	2	1998-08-01 04:40:00+05:30
218	2	1998-09-01 04:40:00+05:30
219	2	1998-10-01 04:40:00+05:30
220	2	1998-11-01 04:40:00+05:30
221	2	1998-12-01 04:40:00+05:30
222	2	1999-01-01 04:40:00+05:30
223	2	1999-02-01 04:40:00+05:30
224	2	1999-03-01 04:40:00+05:30
225	2	1999-04-01 04:40:00+05:30
226	2	1999-05-01 04:40:00+05:30
227	2	1999-06-01 04:40:00+05:30
228	2	1999-07-01 04:40:00+05:30
229	2	1999-08-01 04:40:00+05:30
230	2	1999-09-01 04:40:00+05:30
231	2	1999-10-01 04:40:00+05:30
232	2	1999-11-01 04:40:00+05:30
233	2	1999-12-01 04:40:00+05:30
234	2	2000-01-01 04:40:00+05:30
235	2	2000-02-01 04:40:00+05:30
236	2	2000-03-01 04:40:00+05:30
237	2	2000-04-01 04:40:00+05:30
238	2	2000-05-01 04:40:00+05:30
239	2	2000-06-01 04:40:00+05:30
240	2	2000-07-01 04:40:00+05:30
241	2	2000-08-01 04:40:00+05:30
242	2	2000-09-01 04:40:00+05:30
243	2	2000-10-01 04:40:00+05:30
244	2	2000-11-01 04:40:00+05:30
245	2	2000-12-01 04:40:00+05:30
246	2	2001-01-01 04:40:00+05:30
247	2	2001-02-01 04:40:00+05:30
248	2	2001-03-01 04:40:00+05:30
249	2	2001-04-01 04:40:00+05:30
250	2	2001-05-01 04:40:00+05:30
251	2	2001-06-01 04:40:00+05:30
252	2	2001-07-01 04:40:00+05:30
253	2	2001-08-01 04:40:00+05:30
254	2	2001-09-01 04:40:00+05:30
255	2	2001-10-01 04:40:00+05:30
256	2	2001-11-01 04:40:00+05:30
257	2	2001-12-01 04:40:00+05:30
258	2	2002-01-01 04:40:00+05:30
259	2	2002-02-01 04:40:00+05:30
260	2	2002-03-01 04:40:00+05:30
261	2	2002-04-01 04:40:00+05:30
262	2	2002-05-01 04:40:00+05:30
263	2	2002-06-01 04:40:00+05:30
264	2	2002-07-01 04:40:00+05:30
265	2	2002-08-01 04:40:00+05:30
266	2	2002-09-01 04:40:00+05:30
267	2	2002-10-01 04:40:00+05:30
268	2	2002-11-01 04:40:00+05:30
269	2	2002-12-01 04:40:00+05:30
270	3	1992-01-02 04:40:00+05:30
271	3	1992-02-01 04:40:00+05:30
272	3	1992-03-01 04:40:00+05:30
273	3	1992-04-01 04:40:00+05:30
274	3	1992-05-01 04:40:00+05:30
275	3	1992-06-01 04:40:00+05:30
276	3	1992-07-01 04:40:00+05:30
277	3	1992-08-01 04:40:00+05:30
278	3	1992-09-01 04:40:00+05:30
279	3	1992-10-01 04:40:00+05:30
280	3	1992-11-01 04:40:00+05:30
281	3	1992-12-01 04:40:00+05:30
282	3	1993-01-01 04:40:00+05:30
283	3	1993-02-01 04:40:00+05:30
284	3	1993-03-01 04:40:00+05:30
285	3	1993-04-01 04:40:00+05:30
286	3	1993-05-01 04:40:00+05:30
287	3	1993-06-01 04:40:00+05:30
288	3	1993-07-01 04:40:00+05:30
289	3	1993-08-01 04:40:00+05:30
290	3	1993-09-01 04:40:00+05:30
291	3	1993-10-01 04:40:00+05:30
292	3	1993-11-01 04:40:00+05:30
293	3	1993-12-01 04:40:00+05:30
294	3	1994-01-01 04:40:00+05:30
295	3	1994-02-01 04:40:00+05:30
296	3	1994-03-01 04:40:00+05:30
297	3	1994-04-01 04:40:00+05:30
298	3	1994-05-01 04:40:00+05:30
299	3	1994-06-01 04:40:00+05:30
300	3	1994-07-01 04:40:00+05:30
301	3	1994-08-01 04:40:00+05:30
302	3	1994-09-01 04:40:00+05:30
303	3	1994-10-01 04:40:00+05:30
304	3	1994-11-01 04:40:00+05:30
305	3	1994-12-01 04:40:00+05:30
306	3	1995-01-01 04:40:00+05:30
307	3	1995-02-01 04:40:00+05:30
308	3	1995-03-01 04:40:00+05:30
309	3	1995-04-01 04:40:00+05:30
310	3	1995-05-01 04:40:00+05:30
311	3	1995-06-01 04:40:00+05:30
312	3	1995-07-01 04:40:00+05:30
313	3	1995-08-01 04:40:00+05:30
314	3	1995-09-01 04:40:00+05:30
315	3	1995-10-01 04:40:00+05:30
316	3	1995-11-01 04:40:00+05:30
317	3	1995-12-01 04:40:00+05:30
318	3	1996-01-01 04:40:00+05:30
319	3	1996-02-01 04:40:00+05:30
320	3	1996-03-01 04:40:00+05:30
321	3	1996-04-01 04:40:00+05:30
322	3	1996-05-01 04:40:00+05:30
323	3	1996-06-01 04:40:00+05:30
324	3	1996-07-01 04:40:00+05:30
325	3	1996-08-01 04:40:00+05:30
326	3	1996-09-01 04:40:00+05:30
327	3	1996-10-01 04:40:00+05:30
328	3	1996-11-01 04:40:00+05:30
329	3	1996-12-01 04:40:00+05:30
330	3	1997-01-01 04:40:00+05:30
331	3	1997-02-01 04:40:00+05:30
332	3	1997-03-01 04:40:00+05:30
333	3	1997-04-01 04:40:00+05:30
334	3	1997-05-01 04:40:00+05:30
335	3	1997-06-01 04:40:00+05:30
336	3	1997-07-01 04:40:00+05:30
337	3	1997-08-01 04:40:00+05:30
338	3	1997-09-01 04:40:00+05:30
339	3	1997-10-01 04:40:00+05:30
340	3	1997-11-01 04:40:00+05:30
341	3	1997-12-01 04:40:00+05:30
342	3	1998-01-01 04:40:00+05:30
343	3	1998-02-01 04:40:00+05:30
344	3	1998-03-01 04:40:00+05:30
345	3	1998-04-01 04:40:00+05:30
346	3	1998-05-01 04:40:00+05:30
347	3	1998-06-01 04:40:00+05:30
348	3	1998-07-01 04:40:00+05:30
349	3	1998-08-01 04:40:00+05:30
350	3	1998-09-01 04:40:00+05:30
351	3	1998-10-01 04:40:00+05:30
352	3	1998-11-01 04:40:00+05:30
353	3	1998-12-01 04:40:00+05:30
354	3	1999-01-01 04:40:00+05:30
355	3	1999-02-01 04:40:00+05:30
356	3	1999-03-01 04:40:00+05:30
357	3	1999-04-01 04:40:00+05:30
358	3	1999-05-01 04:40:00+05:30
359	3	1999-06-01 04:40:00+05:30
360	3	1999-07-01 04:40:00+05:30
361	3	1999-08-01 04:40:00+05:30
362	3	1999-09-01 04:40:00+05:30
363	3	1999-10-01 04:40:00+05:30
364	3	1999-11-01 04:40:00+05:30
365	3	1999-12-01 04:40:00+05:30
366	3	2000-01-01 04:40:00+05:30
367	3	2000-02-01 04:40:00+05:30
368	3	2000-03-01 04:40:00+05:30
369	3	2000-04-01 04:40:00+05:30
370	3	2000-05-01 04:40:00+05:30
371	3	2000-06-01 04:40:00+05:30
372	3	2000-07-01 04:40:00+05:30
373	3	2000-08-01 04:40:00+05:30
374	3	2000-09-01 04:40:00+05:30
375	3	2000-10-01 04:40:00+05:30
376	3	2000-11-01 04:40:00+05:30
377	3	2000-12-01 04:40:00+05:30
378	3	2001-01-01 04:40:00+05:30
379	3	2001-02-01 04:40:00+05:30
380	3	2001-03-01 04:40:00+05:30
381	3	2001-04-01 04:40:00+05:30
382	3	2001-05-01 04:40:00+05:30
383	3	2001-06-01 04:40:00+05:30
384	3	2001-07-01 04:40:00+05:30
385	3	2001-08-01 04:40:00+05:30
386	3	2001-09-01 04:40:00+05:30
387	3	2001-10-01 04:40:00+05:30
388	3	2001-11-01 04:40:00+05:30
389	3	2001-12-01 04:40:00+05:30
390	3	2002-01-01 04:40:00+05:30
391	3	2002-02-01 04:40:00+05:30
392	3	2002-03-01 04:40:00+05:30
393	3	2002-04-01 04:40:00+05:30
394	3	2002-05-01 04:40:00+05:30
395	3	2002-06-01 04:40:00+05:30
396	3	2002-07-01 04:40:00+05:30
397	3	2002-08-01 04:40:00+05:30
398	3	2002-09-01 04:40:00+05:30
399	3	2002-10-01 04:40:00+05:30
400	3	2002-11-01 04:40:00+05:30
401	3	2002-12-01 04:40:00+05:30
402	4	1992-01-02 04:40:00+05:30
403	4	1992-02-01 04:40:00+05:30
404	4	1992-03-01 04:40:00+05:30
405	4	1992-04-01 04:40:00+05:30
406	4	1992-05-01 04:40:00+05:30
407	4	1992-06-01 04:40:00+05:30
408	4	1992-07-01 04:40:00+05:30
409	4	1992-08-01 04:40:00+05:30
410	4	1992-09-01 04:40:00+05:30
411	4	1992-10-01 04:40:00+05:30
412	4	1992-11-01 04:40:00+05:30
413	4	1992-12-01 04:40:00+05:30
414	4	1993-01-01 04:40:00+05:30
415	4	1993-02-01 04:40:00+05:30
416	4	1993-03-01 04:40:00+05:30
417	4	1993-04-01 04:40:00+05:30
418	4	1993-05-01 04:40:00+05:30
419	4	1993-06-01 04:40:00+05:30
420	4	1993-07-01 04:40:00+05:30
421	4	1993-08-01 04:40:00+05:30
422	4	1993-09-01 04:40:00+05:30
423	4	1993-10-01 04:40:00+05:30
424	4	1993-11-01 04:40:00+05:30
425	4	1993-12-01 04:40:00+05:30
426	4	1994-01-01 04:40:00+05:30
427	4	1994-02-01 04:40:00+05:30
428	4	1994-03-01 04:40:00+05:30
429	4	1994-04-01 04:40:00+05:30
430	4	1994-05-01 04:40:00+05:30
431	4	1994-06-01 04:40:00+05:30
432	4	1994-07-01 04:40:00+05:30
433	4	1994-08-01 04:40:00+05:30
434	4	1994-09-01 04:40:00+05:30
435	4	1994-10-01 04:40:00+05:30
436	4	1994-11-01 04:40:00+05:30
437	4	1994-12-01 04:40:00+05:30
438	4	1995-01-01 04:40:00+05:30
439	4	1995-02-01 04:40:00+05:30
440	4	1995-03-01 04:40:00+05:30
441	4	1995-04-01 04:40:00+05:30
442	4	1995-05-01 04:40:00+05:30
443	4	1995-06-01 04:40:00+05:30
444	4	1995-07-01 04:40:00+05:30
445	4	1995-08-01 04:40:00+05:30
446	4	1995-09-01 04:40:00+05:30
447	4	1995-10-01 04:40:00+05:30
448	4	1995-11-01 04:40:00+05:30
449	4	1995-12-01 04:40:00+05:30
450	4	1996-01-01 04:40:00+05:30
451	4	1996-02-01 04:40:00+05:30
452	4	1996-03-01 04:40:00+05:30
453	4	1996-04-01 04:40:00+05:30
454	4	1996-05-01 04:40:00+05:30
455	4	1996-06-01 04:40:00+05:30
456	4	1996-07-01 04:40:00+05:30
457	4	1996-08-01 04:40:00+05:30
458	4	1996-09-01 04:40:00+05:30
459	4	1996-10-01 04:40:00+05:30
460	4	1996-11-01 04:40:00+05:30
461	4	1996-12-01 04:40:00+05:30
462	4	1997-01-01 04:40:00+05:30
463	4	1997-02-01 04:40:00+05:30
464	4	1997-03-01 04:40:00+05:30
465	4	1997-04-01 04:40:00+05:30
466	4	1997-05-01 04:40:00+05:30
467	4	1997-06-01 04:40:00+05:30
468	4	1997-07-01 04:40:00+05:30
469	4	1997-08-01 04:40:00+05:30
470	4	1997-09-01 04:40:00+05:30
471	4	1997-10-01 04:40:00+05:30
472	4	1997-11-01 04:40:00+05:30
473	4	1997-12-01 04:40:00+05:30
474	4	1998-01-01 04:40:00+05:30
475	4	1998-02-01 04:40:00+05:30
476	4	1998-03-01 04:40:00+05:30
477	4	1998-04-01 04:40:00+05:30
478	4	1998-05-01 04:40:00+05:30
479	4	1998-06-01 04:40:00+05:30
480	4	1998-07-01 04:40:00+05:30
481	4	1998-08-01 04:40:00+05:30
482	4	1998-09-01 04:40:00+05:30
483	4	1998-10-01 04:40:00+05:30
484	4	1998-11-01 04:40:00+05:30
485	4	1998-12-01 04:40:00+05:30
486	4	1999-01-01 04:40:00+05:30
487	4	1999-02-01 04:40:00+05:30
488	4	1999-03-01 04:40:00+05:30
489	4	1999-04-01 04:40:00+05:30
490	4	1999-05-01 04:40:00+05:30
491	4	1999-06-01 04:40:00+05:30
492	4	1999-07-01 04:40:00+05:30
493	4	1999-08-01 04:40:00+05:30
494	4	1999-09-01 04:40:00+05:30
495	4	1999-10-01 04:40:00+05:30
496	4	1999-11-01 04:40:00+05:30
497	4	1999-12-01 04:40:00+05:30
498	4	2000-01-01 04:40:00+05:30
499	4	2000-02-01 04:40:00+05:30
500	4	2000-03-01 04:40:00+05:30
501	4	2000-04-01 04:40:00+05:30
502	4	2000-05-01 04:40:00+05:30
503	4	2000-06-01 04:40:00+05:30
504	4	2000-07-01 04:40:00+05:30
505	4	2000-08-01 04:40:00+05:30
506	4	2000-09-01 04:40:00+05:30
507	4	2000-10-01 04:40:00+05:30
508	4	2000-11-01 04:40:00+05:30
509	4	2000-12-01 04:40:00+05:30
510	4	2001-01-01 04:40:00+05:30
511	4	2001-02-01 04:40:00+05:30
512	4	2001-03-01 04:40:00+05:30
513	4	2001-04-01 04:40:00+05:30
514	4	2001-05-01 04:40:00+05:30
515	4	2001-06-01 04:40:00+05:30
516	4	2001-07-01 04:40:00+05:30
517	4	2001-08-01 04:40:00+05:30
518	4	2001-09-01 04:40:00+05:30
519	4	2001-10-01 04:40:00+05:30
520	4	2001-11-01 04:40:00+05:30
521	4	2001-12-01 04:40:00+05:30
522	4	2002-01-01 04:40:00+05:30
523	4	2002-02-01 04:40:00+05:30
524	4	2002-03-01 04:40:00+05:30
525	4	2002-04-01 04:40:00+05:30
526	4	2002-05-01 04:40:00+05:30
527	4	2002-06-01 04:40:00+05:30
528	4	2002-07-01 04:40:00+05:30
529	4	2002-08-01 04:40:00+05:30
530	4	2002-09-01 04:40:00+05:30
531	4	2002-10-01 04:40:00+05:30
532	4	2002-11-01 04:40:00+05:30
533	4	2002-12-01 04:40:00+05:30
534	5	1992-01-02 04:40:00+05:30
535	5	1992-02-01 04:40:00+05:30
536	5	1992-03-01 04:40:00+05:30
537	5	1992-04-01 04:40:00+05:30
538	5	1992-05-01 04:40:00+05:30
539	5	1992-06-01 04:40:00+05:30
540	5	1992-07-01 04:40:00+05:30
541	5	1992-08-01 04:40:00+05:30
542	5	1992-09-01 04:40:00+05:30
543	5	1992-10-01 04:40:00+05:30
544	5	1992-11-01 04:40:00+05:30
545	5	1992-12-01 04:40:00+05:30
546	5	1993-01-01 04:40:00+05:30
547	5	1993-02-01 04:40:00+05:30
548	5	1993-03-01 04:40:00+05:30
549	5	1993-04-01 04:40:00+05:30
550	5	1993-05-01 04:40:00+05:30
551	5	1993-06-01 04:40:00+05:30
552	5	1993-07-01 04:40:00+05:30
553	5	1993-08-01 04:40:00+05:30
554	5	1993-09-01 04:40:00+05:30
555	5	1993-10-01 04:40:00+05:30
556	5	1993-11-01 04:40:00+05:30
557	5	1993-12-01 04:40:00+05:30
558	5	1994-01-01 04:40:00+05:30
559	5	1994-02-01 04:40:00+05:30
560	5	1994-03-01 04:40:00+05:30
561	5	1994-04-01 04:40:00+05:30
562	5	1994-05-01 04:40:00+05:30
563	5	1994-06-01 04:40:00+05:30
564	5	1994-07-01 04:40:00+05:30
565	5	1994-08-01 04:40:00+05:30
566	5	1994-09-01 04:40:00+05:30
567	5	1994-10-01 04:40:00+05:30
568	5	1994-11-01 04:40:00+05:30
569	5	1994-12-01 04:40:00+05:30
570	5	1995-01-01 04:40:00+05:30
571	5	1995-02-01 04:40:00+05:30
572	5	1995-03-01 04:40:00+05:30
573	5	1995-04-01 04:40:00+05:30
574	5	1995-05-01 04:40:00+05:30
575	5	1995-06-01 04:40:00+05:30
576	5	1995-07-01 04:40:00+05:30
577	5	1995-08-01 04:40:00+05:30
578	5	1995-09-01 04:40:00+05:30
579	5	1995-10-01 04:40:00+05:30
580	5	1995-11-01 04:40:00+05:30
581	5	1995-12-01 04:40:00+05:30
582	5	1996-01-01 04:40:00+05:30
583	5	1996-02-01 04:40:00+05:30
584	5	1996-03-01 04:40:00+05:30
585	5	1996-04-01 04:40:00+05:30
586	5	1996-05-01 04:40:00+05:30
587	5	1996-06-01 04:40:00+05:30
588	5	1996-07-01 04:40:00+05:30
589	5	1996-08-01 04:40:00+05:30
590	5	1996-09-01 04:40:00+05:30
591	5	1996-10-01 04:40:00+05:30
592	5	1996-11-01 04:40:00+05:30
593	5	1996-12-01 04:40:00+05:30
594	5	1997-01-01 04:40:00+05:30
595	5	1997-02-01 04:40:00+05:30
596	5	1997-03-01 04:40:00+05:30
597	5	1997-04-01 04:40:00+05:30
598	5	1997-05-01 04:40:00+05:30
599	5	1997-06-01 04:40:00+05:30
600	5	1997-07-01 04:40:00+05:30
601	5	1997-08-01 04:40:00+05:30
602	5	1997-09-01 04:40:00+05:30
603	5	1997-10-01 04:40:00+05:30
604	5	1997-11-01 04:40:00+05:30
605	5	1997-12-01 04:40:00+05:30
606	5	1998-01-01 04:40:00+05:30
607	5	1998-02-01 04:40:00+05:30
608	5	1998-03-01 04:40:00+05:30
609	5	1998-04-01 04:40:00+05:30
610	5	1998-05-01 04:40:00+05:30
611	5	1998-06-01 04:40:00+05:30
612	5	1998-07-01 04:40:00+05:30
613	5	1998-08-01 04:40:00+05:30
614	5	1998-09-01 04:40:00+05:30
615	5	1998-10-01 04:40:00+05:30
616	5	1998-11-01 04:40:00+05:30
617	5	1998-12-01 04:40:00+05:30
618	5	1999-01-01 04:40:00+05:30
619	5	1999-02-01 04:40:00+05:30
620	5	1999-03-01 04:40:00+05:30
621	5	1999-04-01 04:40:00+05:30
622	5	1999-05-01 04:40:00+05:30
623	5	1999-06-01 04:40:00+05:30
624	5	1999-07-01 04:40:00+05:30
625	5	1999-08-01 04:40:00+05:30
626	5	1999-09-01 04:40:00+05:30
627	5	1999-10-01 04:40:00+05:30
628	5	1999-11-01 04:40:00+05:30
629	5	1999-12-01 04:40:00+05:30
630	5	2000-01-01 04:40:00+05:30
631	5	2000-02-01 04:40:00+05:30
632	5	2000-03-01 04:40:00+05:30
633	5	2000-04-01 04:40:00+05:30
634	5	2000-05-01 04:40:00+05:30
635	5	2000-06-01 04:40:00+05:30
636	5	2000-07-01 04:40:00+05:30
637	5	2000-08-01 04:40:00+05:30
638	5	2000-09-01 04:40:00+05:30
639	5	2000-10-01 04:40:00+05:30
640	5	2000-11-01 04:40:00+05:30
641	5	2000-12-01 04:40:00+05:30
642	5	2001-01-01 04:40:00+05:30
643	5	2001-02-01 04:40:00+05:30
644	5	2001-03-01 04:40:00+05:30
645	5	2001-04-01 04:40:00+05:30
646	5	2001-05-01 04:40:00+05:30
647	5	2001-06-01 04:40:00+05:30
648	5	2001-07-01 04:40:00+05:30
649	5	2001-08-01 04:40:00+05:30
650	5	2001-09-01 04:40:00+05:30
651	5	2001-10-01 04:40:00+05:30
652	5	2001-11-01 04:40:00+05:30
653	5	2001-12-01 04:40:00+05:30
654	5	2002-01-01 04:40:00+05:30
655	5	2002-02-01 04:40:00+05:30
656	5	2002-03-01 04:40:00+05:30
657	5	2002-04-01 04:40:00+05:30
658	5	2002-05-01 04:40:00+05:30
659	5	2002-06-01 04:40:00+05:30
660	5	2002-07-01 04:40:00+05:30
661	5	2002-08-01 04:40:00+05:30
662	5	2002-09-01 04:40:00+05:30
663	5	2002-10-01 04:40:00+05:30
664	5	2002-11-01 04:40:00+05:30
665	5	2002-12-01 04:40:00+05:30
\.


--
-- Name: event_time_id_eti_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('event_time_id_eti_seq', 665, true);


--
-- Data for Name: feature_type; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY feature_type (name_fty, id_fty) FROM stdin;
Point	1
\.


--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('feature_type_id_fty_seq', 1, true);


--
-- Data for Name: foi; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY foi (desc_foi, id_fty_fk, id_foi, name_foi, geom_foi) FROM stdin;
NULL	1	1	YavatmalCity	01010000A0E61000006519E25817875340CBA145B6F31D34400000000000000000
NULL	1	2	YCity	01010000A0E610000000000000008853406F1283C0CA6134400000000000000000
NULL	1	3	ChandigarhCity	01010000A0E610000027A089B0E131534024287E8CB9BB3E400000000000000000
NULL	1	4	Trial	01010000A0E610000027A089B0E131534024287E8CB9BB3E400000000000000000
NULL	1	5	Try	01010000A0E610000027A089B0E131534024287E8CB9BB3E400000000000000000
\.


--
-- Name: foi_id_foi_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('foi_id_foi_seq', 5, true);


--
-- Data for Name: measures; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY measures (id_msr, id_eti_fk, id_qi_fk, id_pro_fk, val_msr) FROM stdin;
1	5	100	1	20.117000
2	6	100	1	20.117000
3	7	100	1	20.117000
4	8	100	1	20.117000
5	9	100	1	20.117000
6	10	100	1	20.117000
7	11	100	1	20.117000
8	12	100	1	20.117000
9	13	100	1	20.117000
10	14	100	1	20.117000
11	15	100	1	20.117000
12	16	100	1	20.117000
13	17	100	1	20.117000
14	18	100	1	20.117000
15	19	100	1	20.117000
16	20	100	1	20.117000
17	21	100	1	20.117000
18	22	100	1	20.117000
19	23	100	1	20.117000
20	24	100	1	20.117000
21	25	100	1	20.117000
22	26	100	1	20.117000
23	27	100	1	20.117000
24	28	100	1	20.117000
25	29	100	1	20.117000
26	30	100	1	20.117000
27	31	100	1	20.117000
28	32	100	1	20.117000
29	33	100	1	20.117000
30	34	100	1	20.117000
31	35	100	1	20.117000
32	36	100	1	20.117000
33	37	100	1	20.117000
34	38	100	1	20.117000
35	39	100	1	20.117000
36	40	100	1	20.117000
37	41	100	1	20.117000
38	42	100	1	20.117000
39	43	100	1	20.117000
40	44	100	1	20.117000
41	45	100	1	20.117000
42	46	100	1	20.117000
43	47	100	1	20.117000
44	48	100	1	20.117000
45	49	100	1	20.117000
46	50	100	1	20.117000
47	51	100	1	20.117000
48	52	100	1	20.117000
49	53	100	1	20.117000
50	54	100	1	20.117000
51	55	100	1	20.117000
52	56	100	1	20.117000
53	57	100	1	20.117000
54	58	100	1	20.117000
55	59	100	1	20.117000
56	60	100	1	20.117000
57	61	100	1	20.117000
58	62	100	1	20.117000
59	63	100	1	20.117000
60	64	100	1	20.117000
61	65	100	1	20.117000
62	66	100	1	20.117000
63	67	100	1	20.117000
64	68	100	1	20.117000
65	69	100	1	20.117000
66	70	100	1	20.117000
67	71	100	1	20.117000
68	72	100	1	20.117000
69	73	100	1	20.117000
70	74	100	1	20.117000
71	75	100	1	20.117000
72	76	100	1	20.117000
73	77	100	1	20.117000
74	78	100	1	20.117000
75	79	100	1	20.117000
76	80	100	1	20.117000
77	81	100	1	20.117000
78	82	100	1	20.117000
79	83	100	1	20.117000
80	84	100	1	20.117000
81	85	100	1	20.117000
82	86	100	1	20.117000
83	87	100	1	20.117000
84	88	100	1	20.117000
85	89	100	1	20.117000
86	90	100	1	20.117000
87	91	100	1	20.117000
88	92	100	1	20.117000
89	93	100	1	20.117000
90	94	100	1	20.117000
91	95	100	1	20.117000
92	96	100	1	20.117000
93	97	100	1	20.117000
94	98	100	1	20.117000
95	99	100	1	20.117000
96	100	100	1	20.117000
97	101	100	1	20.117000
98	102	100	1	20.117000
99	103	100	1	20.117000
100	104	100	1	20.117000
101	105	100	1	20.117000
102	106	100	1	20.117000
103	107	100	1	20.117000
104	108	100	1	20.117000
105	109	100	1	20.117000
106	110	100	1	20.117000
107	111	100	1	20.117000
108	112	100	1	20.117000
109	113	100	1	20.117000
110	114	100	1	20.117000
111	115	100	1	20.117000
112	116	100	1	20.117000
113	117	100	1	20.117000
114	118	100	1	20.117000
115	119	100	1	20.117000
116	120	100	1	20.117000
117	121	100	1	20.117000
118	122	100	1	20.117000
119	123	100	1	20.117000
120	124	100	1	20.117000
121	125	100	1	20.117000
122	126	100	1	20.117000
123	127	100	1	20.117000
124	128	100	1	20.117000
125	129	100	1	20.117000
126	130	100	1	20.117000
127	131	100	1	20.117000
128	132	100	1	20.117000
129	133	100	1	20.117000
130	134	100	1	20.117000
131	135	100	1	20.117000
132	136	100	1	20.117000
133	137	100	1	20.117000
134	5	200	3	22.563000
135	6	200	3	22.563000
136	7	200	3	24.421000
137	8	200	3	30.186000
138	9	200	3	32.345000
139	10	200	3	34.633000
140	11	200	3	32.583000
141	12	200	3	28.779000
142	13	200	3	26.064000
143	14	200	3	26.740000
144	15	200	3	26.562000
145	16	200	3	23.507000
146	17	200	3	20.622000
147	18	200	3	22.856000
148	19	200	3	24.233000
149	20	200	3	28.004000
150	21	200	3	32.776000
151	22	200	3	35.333000
152	23	200	3	32.854000
153	24	200	3	27.525000
154	25	200	3	26.659000
155	26	200	3	26.943000
156	27	200	3	26.922000
157	28	200	3	23.402000
158	29	200	3	19.917000
159	30	200	3	22.430000
160	31	200	3	24.671000
161	32	200	3	29.835000
162	33	200	3	31.051000
163	34	200	3	35.228000
164	35	200	3	29.419000
165	36	200	3	25.955000
166	37	200	3	25.754000
167	38	200	3	26.749000
168	39	200	3	27.066000
169	40	200	3	23.327000
170	41	200	3	20.852000
171	42	200	3	19.777000
172	43	200	3	24.639000
173	44	200	3	28.065000
174	45	200	3	32.013000
175	46	200	3	33.321000
176	47	200	3	33.108000
177	48	200	3	27.804000
178	49	200	3	27.753000
179	50	200	3	27.496000
180	51	200	3	26.879000
181	52	200	3	24.454000
182	53	200	3	23.823000
183	54	200	3	24.386000
184	55	200	3	25.954000
185	56	200	3	30.364000
186	57	200	3	32.643000
187	58	200	3	35.348000
188	59	200	3	31.316000
189	60	200	3	28.338000
190	61	200	3	26.922000
191	62	200	3	27.138000
192	63	200	3	25.866000
193	64	200	3	23.298000
194	65	200	3	21.107000
195	66	200	3	20.545000
196	67	200	3	23.397000
197	68	200	3	28.804000
198	69	200	3	29.841000
199	70	200	3	33.428000
200	71	200	3	30.343000
201	72	200	3	27.268000
202	73	200	3	27.000000
203	74	200	3	26.710000
204	75	200	3	26.287000
205	76	200	3	25.805000
206	77	200	3	22.807000
207	78	200	3	23.012000
208	79	200	3	24.665000
209	80	200	3	28.520000
210	81	200	3	33.150000
211	82	200	3	35.695000
212	83	200	3	33.001000
213	84	200	3	28.438000
214	85	200	3	27.587000
215	86	200	3	27.074000
216	87	200	3	27.296000
217	88	200	3	24.127000
218	89	200	3	20.663000
219	90	200	3	21.151000
220	91	200	3	25.861000
221	92	200	3	29.496000
222	93	200	3	33.650000
223	94	200	3	33.568000
224	95	200	3	29.445000
225	96	200	3	27.260000
226	97	200	3	26.537000
227	98	200	3	26.180000
228	99	200	3	26.364000
229	100	200	3	23.762000
230	101	200	3	20.968000
231	102	200	3	22.798000
232	103	200	3	24.545000
233	104	200	3	28.256000
234	105	200	3	33.980000
235	106	200	3	33.323000
236	107	200	3	29.255000
237	108	200	3	26.648000
238	109	200	3	27.502000
239	110	200	3	27.505000
240	111	200	3	28.087000
241	112	200	3	25.087000
242	113	200	3	21.873000
243	114	200	3	22.863000
244	115	200	3	26.361000
245	116	200	3	29.661000
246	117	200	3	31.424000
247	118	200	3	35.057000
248	119	200	3	29.414000
249	120	200	3	27.540000
250	121	200	3	26.595000
251	122	200	3	28.532000
252	123	200	3	26.685000
253	124	200	3	24.656000
254	125	200	3	23.387000
255	126	200	3	22.433000
256	127	200	3	26.582000
257	128	200	3	29.671000
258	129	200	3	33.487000
259	130	200	3	35.010000
260	131	200	3	30.206000
261	132	200	3	28.131000
262	133	200	3	25.556000
263	134	200	3	26.620000
264	135	200	3	27.048000
265	136	200	3	23.801000
266	137	200	3	22.951000
267	138	100	5	20.382000
268	139	100	5	20.382000
269	140	100	5	20.382000
270	141	100	5	20.382000
271	142	100	5	20.382000
272	143	100	5	20.382000
273	144	100	5	20.382000
274	145	100	5	20.382000
275	146	100	5	20.382000
276	147	100	5	20.382000
277	148	100	5	20.382000
278	149	100	5	20.382000
279	150	100	5	20.382000
280	151	100	5	20.382000
281	152	100	5	20.382000
282	153	100	5	20.382000
283	154	100	5	20.382000
284	155	100	5	20.382000
285	156	100	5	20.382000
286	157	100	5	20.382000
287	158	100	5	20.382000
288	159	100	5	20.382000
289	160	100	5	20.382000
290	161	100	5	20.382000
291	162	100	5	20.382000
292	163	100	5	20.382000
293	164	100	5	20.382000
294	165	100	5	20.382000
295	166	100	5	20.382000
296	167	100	5	20.382000
297	168	100	5	20.382000
298	169	100	5	20.382000
299	170	100	5	20.382000
300	171	100	5	20.382000
301	172	100	5	20.382000
302	173	100	5	20.382000
303	174	100	5	20.382000
304	175	100	5	20.382000
305	176	100	5	20.382000
306	177	100	5	20.382000
307	178	100	5	20.382000
308	179	100	5	20.382000
309	180	100	5	20.382000
310	181	100	5	20.382000
311	182	100	5	20.382000
312	183	100	5	20.382000
313	184	100	5	20.382000
314	185	100	5	20.382000
315	186	100	5	20.382000
316	187	100	5	20.382000
317	188	100	5	20.382000
318	189	100	5	20.382000
319	190	100	5	20.382000
320	191	100	5	20.382000
321	192	100	5	20.382000
322	193	100	5	20.382000
323	194	100	5	20.382000
324	195	100	5	20.382000
325	196	100	5	20.382000
326	197	100	5	20.382000
327	198	100	5	20.382000
328	199	100	5	20.382000
329	200	100	5	20.382000
330	201	100	5	20.382000
331	202	100	5	20.382000
332	203	100	5	20.382000
333	204	100	5	20.382000
334	205	100	5	20.382000
335	206	100	5	20.382000
336	207	100	5	20.382000
337	208	100	5	20.382000
338	209	100	5	20.382000
339	210	100	5	20.382000
340	211	100	5	20.382000
341	212	100	5	20.382000
342	213	100	5	20.382000
343	214	100	5	20.382000
344	215	100	5	20.382000
345	216	100	5	20.382000
346	217	100	5	20.382000
347	218	100	5	20.382000
348	219	100	5	20.382000
349	220	100	5	20.382000
350	221	100	5	20.382000
351	222	100	5	20.382000
352	223	100	5	20.382000
353	224	100	5	20.382000
354	225	100	5	20.382000
355	226	100	5	20.382000
356	227	100	5	20.382000
357	228	100	5	20.382000
358	229	100	5	20.382000
359	230	100	5	20.382000
360	231	100	5	20.382000
361	232	100	5	20.382000
362	233	100	5	20.382000
363	234	100	5	20.382000
364	235	100	5	20.382000
365	236	100	5	20.382000
366	237	100	5	20.382000
367	238	100	5	20.382000
368	239	100	5	20.382000
369	240	100	5	20.382000
370	241	100	5	20.382000
371	242	100	5	20.382000
372	243	100	5	20.382000
373	244	100	5	20.382000
374	245	100	5	20.382000
375	246	100	5	20.382000
376	247	100	5	20.382000
377	248	100	5	20.382000
378	249	100	5	20.382000
379	250	100	5	20.382000
380	251	100	5	20.382000
381	252	100	5	20.382000
382	253	100	5	20.382000
383	254	100	5	20.382000
384	255	100	5	20.382000
385	256	100	5	20.382000
386	257	100	5	20.382000
387	258	100	5	20.382000
388	259	100	5	20.382000
389	260	100	5	20.382000
390	261	100	5	20.382000
391	262	100	5	20.382000
392	263	100	5	20.382000
393	264	100	5	20.382000
394	265	100	5	20.382000
395	266	100	5	20.382000
396	267	100	5	20.382000
397	268	100	5	20.382000
398	269	100	5	20.382000
399	138	200	6	22.563000
400	139	200	6	24.421000
401	140	200	6	30.186000
402	141	200	6	32.345000
403	142	200	6	34.633000
404	143	200	6	32.583000
405	144	200	6	28.779000
406	145	200	6	26.064000
407	146	200	6	26.740000
408	147	200	6	26.562000
409	148	200	6	23.507000
410	149	200	6	20.622000
411	150	200	6	22.856000
412	151	200	6	24.233000
413	152	200	6	28.004000
414	153	200	6	32.776000
415	154	200	6	35.333000
416	155	200	6	32.854000
417	156	200	6	27.525000
418	157	200	6	26.659000
419	158	200	6	26.943000
420	159	200	6	26.922000
421	160	200	6	23.402000
422	161	200	6	19.917000
423	162	200	6	22.430000
424	163	200	6	24.671000
425	164	200	6	29.835000
426	165	200	6	31.051000
427	166	200	6	35.228000
428	167	200	6	29.419000
429	168	200	6	25.955000
430	169	200	6	25.754000
431	170	200	6	26.749000
432	171	200	6	27.066000
433	172	200	6	23.327000
434	173	200	6	20.852000
435	174	200	6	19.777000
436	175	200	6	24.639000
437	176	200	6	28.065000
438	177	200	6	32.013000
439	178	200	6	33.321000
440	179	200	6	33.108000
441	180	200	6	27.804000
442	181	200	6	27.753000
443	182	200	6	27.496000
444	183	200	6	26.879000
445	184	200	6	24.454000
446	185	200	6	23.823000
447	186	200	6	24.386000
448	187	200	6	25.954000
449	188	200	6	30.364000
450	189	200	6	32.643000
451	190	200	6	35.348000
452	191	200	6	31.316000
453	192	200	6	28.338000
454	193	200	6	26.922000
455	194	200	6	27.138000
456	195	200	6	25.866000
457	196	200	6	23.298000
458	197	200	6	21.107000
459	198	200	6	20.545000
460	199	200	6	23.397000
461	200	200	6	28.804000
462	201	200	6	29.841000
463	202	200	6	33.428000
464	203	200	6	30.343000
465	204	200	6	27.268000
466	205	200	6	27.000000
467	206	200	6	26.710000
468	207	200	6	26.287000
469	208	200	6	25.805000
470	209	200	6	22.807000
471	210	200	6	23.012000
472	211	200	6	24.665000
473	212	200	6	28.520000
474	213	200	6	33.150000
475	214	200	6	35.695000
476	215	200	6	33.001000
477	216	200	6	28.438000
478	217	200	6	27.587000
479	218	200	6	27.074000
480	219	200	6	27.296000
481	220	200	6	24.127000
482	221	200	6	20.663000
483	222	200	6	21.151000
484	223	200	6	25.861000
485	224	200	6	29.496000
486	225	200	6	33.650000
487	226	200	6	33.568000
488	227	200	6	29.445000
489	228	200	6	27.260000
490	229	200	6	26.537000
491	230	200	6	26.180000
492	231	200	6	26.364000
493	232	200	6	23.762000
494	233	200	6	20.968000
495	234	200	6	22.798000
496	235	200	6	24.545000
497	236	200	6	28.256000
498	237	200	6	33.980000
499	238	200	6	33.323000
500	239	200	6	29.255000
501	240	200	6	26.648000
502	241	200	6	27.502000
503	242	200	6	27.505000
504	243	200	6	28.087000
505	244	200	6	25.087000
506	245	200	6	21.873000
507	246	200	6	22.863000
508	247	200	6	26.361000
509	248	200	6	29.661000
510	249	200	6	31.424000
511	250	200	6	35.057000
512	251	200	6	29.414000
513	252	200	6	27.540000
514	253	200	6	26.595000
515	254	200	6	28.532000
516	255	200	6	26.685000
517	256	200	6	24.656000
518	257	200	6	23.387000
519	258	200	6	22.433000
520	259	200	6	26.582000
521	260	200	6	29.671000
522	261	200	6	33.487000
523	262	200	6	35.010000
524	263	200	6	30.206000
525	264	200	6	28.131000
526	265	200	6	25.556000
527	266	200	6	26.620000
528	267	200	6	27.048000
529	268	200	6	23.801000
530	269	200	6	22.951000
531	270	100	7	30.733300
532	271	100	7	30.733300
533	272	100	7	30.733300
534	273	100	7	30.733300
535	274	100	7	30.733300
536	275	100	7	30.733300
537	276	100	7	30.733300
538	277	100	7	30.733300
539	278	100	7	30.733300
540	279	100	7	30.733300
541	280	100	7	30.733300
542	281	100	7	30.733300
543	282	100	7	30.733300
544	283	100	7	30.733300
545	284	100	7	30.733300
546	285	100	7	30.733300
547	286	100	7	30.733300
548	287	100	7	30.733300
549	288	100	7	30.733300
550	289	100	7	30.733300
551	290	100	7	30.733300
552	291	100	7	30.733300
553	292	100	7	30.733300
554	293	100	7	30.733300
555	294	100	7	30.733300
556	295	100	7	30.733300
557	296	100	7	30.733300
558	297	100	7	30.733300
559	298	100	7	30.733300
560	299	100	7	30.733300
561	300	100	7	30.733300
562	301	100	7	30.733300
563	302	100	7	30.733300
564	303	100	7	30.733300
565	304	100	7	30.733300
566	305	100	7	30.733300
567	306	100	7	30.733300
568	307	100	7	30.733300
569	308	100	7	30.733300
570	309	100	7	30.733300
571	310	100	7	30.733300
572	311	100	7	30.733300
573	312	100	7	30.733300
574	313	100	7	30.733300
575	314	100	7	30.733300
576	315	100	7	30.733300
577	316	100	7	30.733300
578	317	100	7	30.733300
579	318	100	7	30.733300
580	319	100	7	30.733300
581	320	100	7	30.733300
582	321	100	7	30.733300
583	322	100	7	30.733300
584	323	100	7	30.733300
585	324	100	7	30.733300
586	325	100	7	30.733300
587	326	100	7	30.733300
588	327	100	7	30.733300
589	328	100	7	30.733300
590	329	100	7	30.733300
591	330	100	7	30.733300
592	331	100	7	30.733300
593	332	100	7	30.733300
594	333	100	7	30.733300
595	334	100	7	30.733300
596	335	100	7	30.733300
597	336	100	7	30.733300
598	337	100	7	30.733300
599	338	100	7	30.733300
600	339	100	7	30.733300
601	340	100	7	30.733300
602	341	100	7	30.733300
603	342	100	7	30.733300
604	343	100	7	30.733300
605	344	100	7	30.733300
606	345	100	7	30.733300
607	346	100	7	30.733300
608	347	100	7	30.733300
609	348	100	7	30.733300
610	349	100	7	30.733300
611	350	100	7	30.733300
612	351	100	7	30.733300
613	352	100	7	30.733300
614	353	100	7	30.733300
615	354	100	7	30.733300
616	355	100	7	30.733300
617	356	100	7	30.733300
618	357	100	7	30.733300
619	358	100	7	30.733300
620	359	100	7	30.733300
621	360	100	7	30.733300
622	361	100	7	30.733300
623	362	100	7	30.733300
624	363	100	7	30.733300
625	364	100	7	30.733300
626	365	100	7	30.733300
627	366	100	7	30.733300
628	367	100	7	30.733300
629	368	100	7	30.733300
630	369	100	7	30.733300
631	370	100	7	30.733300
632	371	100	7	30.733300
633	372	100	7	30.733300
634	373	100	7	30.733300
635	374	100	7	30.733300
636	375	100	7	30.733300
637	376	100	7	30.733300
638	377	100	7	30.733300
639	378	100	7	30.733300
640	379	100	7	30.733300
641	380	100	7	30.733300
642	381	100	7	30.733300
643	382	100	7	30.733300
644	383	100	7	30.733300
645	384	100	7	30.733300
646	385	100	7	30.733300
647	386	100	7	30.733300
648	387	100	7	30.733300
649	388	100	7	30.733300
650	389	100	7	30.733300
651	390	100	7	30.733300
652	391	100	7	30.733300
653	392	100	7	30.733300
654	393	100	7	30.733300
655	394	100	7	30.733300
656	395	100	7	30.733300
657	396	100	7	30.733300
658	397	100	7	30.733300
659	398	100	7	30.733300
660	399	100	7	30.733300
661	400	100	7	30.733300
662	401	100	7	30.733300
663	270	200	9	14.400000
664	271	200	9	15.300000
665	272	200	9	21.200000
666	273	200	9	27.600000
667	274	200	9	31.300000
668	275	200	9	34.200000
669	276	200	9	30.300000
670	277	200	9	29.600000
671	278	200	9	28.900000
672	279	200	9	25.400000
673	280	200	9	20.200000
674	281	200	9	16.100000
675	282	200	9	13.700000
676	283	200	9	17.900000
677	284	200	9	19.800000
678	285	200	9	27.400000
679	286	200	9	33.500000
680	287	200	9	33.900000
681	288	200	9	31.000000
682	289	200	9	31.400000
683	290	200	9	28.400000
684	291	200	9	25.300000
685	292	200	9	20.600000
686	293	200	9	15.300000
687	294	200	9	14.300000
688	295	200	9	16.500000
689	296	200	9	23.200000
690	297	200	9	26.300000
691	298	200	9	33.000000
692	299	200	9	34.900000
693	300	200	9	30.600000
694	301	200	9	29.900000
695	302	200	9	28.700000
696	303	200	9	25.000000
697	304	200	9	20.200000
698	305	200	9	16.100000
699	306	200	9	13.400000
700	307	200	9	16.300000
701	308	200	9	20.400000
702	309	200	9	26.600000
703	310	200	9	34.100000
704	311	200	9	35.600000
705	312	200	9	31.000000
706	313	200	9	28.700000
707	314	200	9	29.200000
708	315	200	9	26.500000
709	316	200	9	20.500000
710	317	200	9	16.200000
711	318	200	9	14.100000
712	319	200	9	17.200000
713	320	200	9	22.500000
714	321	200	9	28.500000
715	322	200	9	31.800000
716	323	200	9	32.700000
717	324	200	9	31.100000
718	325	200	9	28.800000
719	326	200	9	28.800000
720	327	200	9	25.500000
721	328	200	9	19.400000
722	329	200	9	14.300000
723	330	200	9	13.800000
724	331	200	9	16.400000
725	332	200	9	21.300000
726	333	200	9	26.900000
727	334	200	9	30.500000
728	335	200	9	32.200000
729	336	200	9	31.800000
730	337	200	9	29.700000
731	338	200	9	30.000000
732	339	200	9	23.700000
733	340	200	9	19.400000
734	341	200	9	13.400000
735	342	200	9	11.200000
736	343	200	9	17.000000
737	344	200	9	19.900000
738	345	200	9	28.000000
739	346	200	9	33.500000
740	347	200	9	35.100000
741	348	200	9	31.100000
742	349	200	9	30.300000
743	350	200	9	29.800000
744	351	200	9	26.300000
745	352	200	9	21.300000
746	353	200	9	16.500000
747	354	200	9	13.500000
748	355	200	9	19.000000
749	356	200	9	23.900000
750	357	200	9	32.100000
751	358	200	9	33.600000
752	359	200	9	32.800000
753	360	200	9	32.100000
754	361	200	9	30.800000
755	362	200	9	30.500000
756	363	200	9	27.000000
757	364	200	9	21.800000
758	365	200	9	16.400000
759	366	200	9	14.800000
760	367	200	9	15.200000
761	368	200	9	21.100000
762	369	200	9	30.300000
763	370	200	9	34.000000
764	371	200	9	32.900000
765	372	200	9	30.700000
766	373	200	9	30.600000
767	374	200	9	30.200000
768	375	200	9	27.800000
769	376	200	9	21.700000
770	377	200	9	16.800000
771	378	200	9	13.900000
772	379	200	9	17.400000
773	380	200	9	22.700000
774	381	200	9	27.600000
775	382	200	9	33.400000
776	383	200	9	32.400000
777	384	200	9	31.400000
778	385	200	9	31.500000
779	386	200	9	30.600000
780	387	200	9	27.700000
781	388	200	9	22.000000
782	389	200	9	16.700000
783	390	200	9	16.000000
784	391	200	9	16.300000
785	392	200	9	20.900000
786	393	200	9	30.000000
787	394	200	9	34.800000
788	395	200	9	34.200000
789	396	200	9	33.200000
790	397	200	9	31.000000
791	398	200	9	28.300000
792	399	200	9	26.400000
793	400	200	9	21.300000
794	401	200	9	16.000000
795	402	100	10	30.733300
796	403	100	10	30.733300
797	404	100	10	30.733300
798	405	100	10	30.733300
799	406	100	10	30.733300
800	407	100	10	30.733300
801	408	100	10	30.733300
802	409	100	10	30.733300
803	410	100	10	30.733300
804	411	100	10	30.733300
805	412	100	10	30.733300
806	413	100	10	30.733300
807	414	100	10	30.733300
808	415	100	10	30.733300
809	416	100	10	30.733300
810	417	100	10	30.733300
811	418	100	10	30.733300
812	419	100	10	30.733300
813	420	100	10	30.733300
814	421	100	10	30.733300
815	422	100	10	30.733300
816	423	100	10	30.733300
817	424	100	10	30.733300
818	425	100	10	30.733300
819	426	100	10	30.733300
820	427	100	10	30.733300
821	428	100	10	30.733300
822	429	100	10	30.733300
823	430	100	10	30.733300
824	431	100	10	30.733300
825	432	100	10	30.733300
826	433	100	10	30.733300
827	434	100	10	30.733300
828	435	100	10	30.733300
829	436	100	10	30.733300
830	437	100	10	30.733300
831	438	100	10	30.733300
832	439	100	10	30.733300
833	440	100	10	30.733300
834	441	100	10	30.733300
835	442	100	10	30.733300
836	443	100	10	30.733300
837	444	100	10	30.733300
838	445	100	10	30.733300
839	446	100	10	30.733300
840	447	100	10	30.733300
841	448	100	10	30.733300
842	449	100	10	30.733300
843	450	100	10	30.733300
844	451	100	10	30.733300
845	452	100	10	30.733300
846	453	100	10	30.733300
847	454	100	10	30.733300
848	455	100	10	30.733300
849	456	100	10	30.733300
850	457	100	10	30.733300
851	458	100	10	30.733300
852	459	100	10	30.733300
853	460	100	10	30.733300
854	461	100	10	30.733300
855	462	100	10	30.733300
856	463	100	10	30.733300
857	464	100	10	30.733300
858	465	100	10	30.733300
859	466	100	10	30.733300
860	467	100	10	30.733300
861	468	100	10	30.733300
862	469	100	10	30.733300
863	470	100	10	30.733300
864	471	100	10	30.733300
865	472	100	10	30.733300
866	473	100	10	30.733300
867	474	100	10	30.733300
868	475	100	10	30.733300
869	476	100	10	30.733300
870	477	100	10	30.733300
871	478	100	10	30.733300
872	479	100	10	30.733300
873	480	100	10	30.733300
874	481	100	10	30.733300
875	482	100	10	30.733300
876	483	100	10	30.733300
877	484	100	10	30.733300
878	485	100	10	30.733300
879	486	100	10	30.733300
880	487	100	10	30.733300
881	488	100	10	30.733300
882	489	100	10	30.733300
883	490	100	10	30.733300
884	491	100	10	30.733300
885	492	100	10	30.733300
886	493	100	10	30.733300
887	494	100	10	30.733300
888	495	100	10	30.733300
889	496	100	10	30.733300
890	497	100	10	30.733300
891	498	100	10	30.733300
892	499	100	10	30.733300
893	500	100	10	30.733300
894	501	100	10	30.733300
895	502	100	10	30.733300
896	503	100	10	30.733300
897	504	100	10	30.733300
898	505	100	10	30.733300
899	506	100	10	30.733300
900	507	100	10	30.733300
901	508	100	10	30.733300
902	509	100	10	30.733300
903	510	100	10	30.733300
904	511	100	10	30.733300
905	512	100	10	30.733300
906	513	100	10	30.733300
907	514	100	10	30.733300
908	515	100	10	30.733300
909	516	100	10	30.733300
910	517	100	10	30.733300
911	518	100	10	30.733300
912	519	100	10	30.733300
913	520	100	10	30.733300
914	521	100	10	30.733300
915	522	100	10	30.733300
916	523	100	10	30.733300
917	524	100	10	30.733300
918	525	100	10	30.733300
919	526	100	10	30.733300
920	527	100	10	30.733300
921	528	100	10	30.733300
922	529	100	10	30.733300
923	530	100	10	30.733300
924	531	100	10	30.733300
925	532	100	10	30.733300
926	533	100	10	30.733300
927	402	200	12	14.400000
928	403	200	12	15.300000
929	404	200	12	21.200000
930	405	200	12	27.600000
931	406	200	12	31.300000
932	407	200	12	34.200000
933	408	200	12	30.300000
934	409	200	12	29.600000
935	410	200	12	28.900000
936	411	200	12	25.400000
937	412	200	12	20.200000
938	413	200	12	16.100000
939	414	200	12	13.700000
940	415	200	12	17.900000
941	416	200	12	19.800000
942	417	200	12	27.400000
943	418	200	12	33.500000
944	419	200	12	33.900000
945	420	200	12	31.000000
946	421	200	12	31.400000
947	422	200	12	28.400000
948	423	200	12	25.300000
949	424	200	12	20.600000
950	425	200	12	15.300000
951	426	200	12	14.300000
952	427	200	12	16.500000
953	428	200	12	23.200000
954	429	200	12	26.300000
955	430	200	12	33.000000
956	431	200	12	34.900000
957	432	200	12	30.600000
958	433	200	12	29.900000
959	434	200	12	28.700000
960	435	200	12	25.000000
961	436	200	12	20.200000
962	437	200	12	16.100000
963	438	200	12	13.400000
964	439	200	12	16.300000
965	440	200	12	20.400000
966	441	200	12	26.600000
967	442	200	12	34.100000
968	443	200	12	35.600000
969	444	200	12	31.000000
970	445	200	12	28.700000
971	446	200	12	29.200000
972	447	200	12	26.500000
973	448	200	12	20.500000
974	449	200	12	16.200000
975	450	200	12	14.100000
976	451	200	12	17.200000
977	452	200	12	22.500000
978	453	200	12	28.500000
979	454	200	12	31.800000
980	455	200	12	32.700000
981	456	200	12	31.100000
982	457	200	12	28.800000
983	458	200	12	28.800000
984	459	200	12	25.500000
985	460	200	12	19.400000
986	461	200	12	14.300000
987	462	200	12	13.800000
988	463	200	12	16.400000
989	464	200	12	21.300000
990	465	200	12	26.900000
991	466	200	12	30.500000
992	467	200	12	32.200000
993	468	200	12	31.800000
994	469	200	12	29.700000
995	470	200	12	30.000000
996	471	200	12	23.700000
997	472	200	12	19.400000
998	473	200	12	13.400000
999	474	200	12	11.200000
1000	475	200	12	17.000000
1001	476	200	12	19.900000
1002	477	200	12	28.000000
1003	478	200	12	33.500000
1004	479	200	12	35.100000
1005	480	200	12	31.100000
1006	481	200	12	30.300000
1007	482	200	12	29.800000
1008	483	200	12	26.300000
1009	484	200	12	21.300000
1010	485	200	12	16.500000
1011	486	200	12	13.500000
1012	487	200	12	19.000000
1013	488	200	12	23.900000
1014	489	200	12	32.100000
1015	490	200	12	33.600000
1016	491	200	12	32.800000
1017	492	200	12	32.100000
1018	493	200	12	30.800000
1019	494	200	12	30.500000
1020	495	200	12	27.000000
1021	496	200	12	21.800000
1022	497	200	12	16.400000
1023	498	200	12	14.800000
1024	499	200	12	15.200000
1025	500	200	12	21.100000
1026	501	200	12	30.300000
1027	502	200	12	34.000000
1028	503	200	12	32.900000
1029	504	200	12	30.700000
1030	505	200	12	30.600000
1031	506	200	12	30.200000
1032	507	200	12	27.800000
1033	508	200	12	21.700000
1034	509	200	12	16.800000
1035	510	200	12	13.900000
1036	511	200	12	17.400000
1037	512	200	12	22.700000
1038	513	200	12	27.600000
1039	514	200	12	33.400000
1040	515	200	12	32.400000
1041	516	200	12	31.400000
1042	517	200	12	31.500000
1043	518	200	12	30.600000
1044	519	200	12	27.700000
1045	520	200	12	22.000000
1046	521	200	12	16.700000
1047	522	200	12	16.000000
1048	523	200	12	16.300000
1049	524	200	12	20.900000
1050	525	200	12	30.000000
1051	526	200	12	34.800000
1052	527	200	12	34.200000
1053	528	200	12	33.200000
1054	529	200	12	31.000000
1055	530	200	12	28.300000
1056	531	200	12	26.400000
1057	532	200	12	21.300000
1058	533	200	12	16.000000
1059	534	100	13	30.733300
1060	535	100	13	30.733300
1061	536	100	13	30.733300
1062	537	100	13	30.733300
1063	538	100	13	30.733300
1064	539	100	13	30.733300
1065	540	100	13	30.733300
1066	541	100	13	30.733300
1067	542	100	13	30.733300
1068	543	100	13	30.733300
1069	544	100	13	30.733300
1070	545	100	13	30.733300
1071	546	100	13	30.733300
1072	547	100	13	30.733300
1073	548	100	13	30.733300
1074	549	100	13	30.733300
1075	550	100	13	30.733300
1076	551	100	13	30.733300
1077	552	100	13	30.733300
1078	553	100	13	30.733300
1079	554	100	13	30.733300
1080	555	100	13	30.733300
1081	556	100	13	30.733300
1082	557	100	13	30.733300
1083	558	100	13	30.733300
1084	559	100	13	30.733300
1085	560	100	13	30.733300
1086	561	100	13	30.733300
1087	562	100	13	30.733300
1088	563	100	13	30.733300
1089	564	100	13	30.733300
1090	565	100	13	30.733300
1091	566	100	13	30.733300
1092	567	100	13	30.733300
1093	568	100	13	30.733300
1094	569	100	13	30.733300
1095	570	100	13	30.733300
1096	571	100	13	30.733300
1097	572	100	13	30.733300
1098	573	100	13	30.733300
1099	574	100	13	30.733300
1100	575	100	13	30.733300
1101	576	100	13	30.733300
1102	577	100	13	30.733300
1103	578	100	13	30.733300
1104	579	100	13	30.733300
1105	580	100	13	30.733300
1106	581	100	13	30.733300
1107	582	100	13	30.733300
1108	583	100	13	30.733300
1109	584	100	13	30.733300
1110	585	100	13	30.733300
1111	586	100	13	30.733300
1112	587	100	13	30.733300
1113	588	100	13	30.733300
1114	589	100	13	30.733300
1115	590	100	13	30.733300
1116	591	100	13	30.733300
1117	592	100	13	30.733300
1118	593	100	13	30.733300
1119	594	100	13	30.733300
1120	595	100	13	30.733300
1121	596	100	13	30.733300
1122	597	100	13	30.733300
1123	598	100	13	30.733300
1124	599	100	13	30.733300
1125	600	100	13	30.733300
1126	601	100	13	30.733300
1127	602	100	13	30.733300
1128	603	100	13	30.733300
1129	604	100	13	30.733300
1130	605	100	13	30.733300
1131	606	100	13	30.733300
1132	607	100	13	30.733300
1133	608	100	13	30.733300
1134	609	100	13	30.733300
1135	610	100	13	30.733300
1136	611	100	13	30.733300
1137	612	100	13	30.733300
1138	613	100	13	30.733300
1139	614	100	13	30.733300
1140	615	100	13	30.733300
1141	616	100	13	30.733300
1142	617	100	13	30.733300
1143	618	100	13	30.733300
1144	619	100	13	30.733300
1145	620	100	13	30.733300
1146	621	100	13	30.733300
1147	622	100	13	30.733300
1148	623	100	13	30.733300
1149	624	100	13	30.733300
1150	625	100	13	30.733300
1151	626	100	13	30.733300
1152	627	100	13	30.733300
1153	628	100	13	30.733300
1154	629	100	13	30.733300
1155	630	100	13	30.733300
1156	631	100	13	30.733300
1157	632	100	13	30.733300
1158	633	100	13	30.733300
1159	634	100	13	30.733300
1160	635	100	13	30.733300
1161	636	100	13	30.733300
1162	637	100	13	30.733300
1163	638	100	13	30.733300
1164	639	100	13	30.733300
1165	640	100	13	30.733300
1166	641	100	13	30.733300
1167	642	100	13	30.733300
1168	643	100	13	30.733300
1169	644	100	13	30.733300
1170	645	100	13	30.733300
1171	646	100	13	30.733300
1172	647	100	13	30.733300
1173	648	100	13	30.733300
1174	649	100	13	30.733300
1175	650	100	13	30.733300
1176	651	100	13	30.733300
1177	652	100	13	30.733300
1178	653	100	13	30.733300
1179	654	100	13	30.733300
1180	655	100	13	30.733300
1181	656	100	13	30.733300
1182	657	100	13	30.733300
1183	658	100	13	30.733300
1184	659	100	13	30.733300
1185	660	100	13	30.733300
1186	661	100	13	30.733300
1187	662	100	13	30.733300
1188	663	100	13	30.733300
1189	664	100	13	30.733300
1190	665	100	13	30.733300
1191	534	200	15	14.400000
1192	535	200	15	15.300000
1193	536	200	15	21.200000
1194	537	200	15	27.600000
1195	538	200	15	31.300000
1196	539	200	15	34.200000
1197	540	200	15	30.300000
1198	541	200	15	29.600000
1199	542	200	15	28.900000
1200	543	200	15	25.400000
1201	544	200	15	20.200000
1202	545	200	15	16.100000
1203	546	200	15	13.700000
1204	547	200	15	17.900000
1205	548	200	15	19.800000
1206	549	200	15	27.400000
1207	550	200	15	33.500000
1208	551	200	15	33.900000
1209	552	200	15	31.000000
1210	553	200	15	31.400000
1211	554	200	15	28.400000
1212	555	200	15	25.300000
1213	556	200	15	20.600000
1214	557	200	15	15.300000
1215	558	200	15	14.300000
1216	559	200	15	16.500000
1217	560	200	15	23.200000
1218	561	200	15	26.300000
1219	562	200	15	33.000000
1220	563	200	15	34.900000
1221	564	200	15	30.600000
1222	565	200	15	29.900000
1223	566	200	15	28.700000
1224	567	200	15	25.000000
1225	568	200	15	20.200000
1226	569	200	15	16.100000
1227	570	200	15	13.400000
1228	571	200	15	16.300000
1229	572	200	15	20.400000
1230	573	200	15	26.600000
1231	574	200	15	34.100000
1232	575	200	15	35.600000
1233	576	200	15	31.000000
1234	577	200	15	28.700000
1235	578	200	15	29.200000
1236	579	200	15	26.500000
1237	580	200	15	20.500000
1238	581	200	15	16.200000
1239	582	200	15	14.100000
1240	583	200	15	17.200000
1241	584	200	15	22.500000
1242	585	200	15	28.500000
1243	586	200	15	31.800000
1244	587	200	15	32.700000
1245	588	200	15	31.100000
1246	589	200	15	28.800000
1247	590	200	15	28.800000
1248	591	200	15	25.500000
1249	592	200	15	19.400000
1250	593	200	15	14.300000
1251	594	200	15	13.800000
1252	595	200	15	16.400000
1253	596	200	15	21.300000
1254	597	200	15	26.900000
1255	598	200	15	30.500000
1256	599	200	15	32.200000
1257	600	200	15	31.800000
1258	601	200	15	29.700000
1259	602	200	15	30.000000
1260	603	200	15	23.700000
1261	604	200	15	19.400000
1262	605	200	15	13.400000
1263	606	200	15	11.200000
1264	607	200	15	17.000000
1265	608	200	15	19.900000
1266	609	200	15	28.000000
1267	610	200	15	33.500000
1268	611	200	15	35.100000
1269	612	200	15	31.100000
1270	613	200	15	30.300000
1271	614	200	15	29.800000
1272	615	200	15	26.300000
1273	616	200	15	21.300000
1274	617	200	15	16.500000
1275	618	200	15	13.500000
1276	619	200	15	19.000000
1277	620	200	15	23.900000
1278	621	200	15	32.100000
1279	622	200	15	33.600000
1280	623	200	15	32.800000
1281	624	200	15	32.100000
1282	625	200	15	30.800000
1283	626	200	15	30.500000
1284	627	200	15	27.000000
1285	628	200	15	21.800000
1286	629	200	15	16.400000
1287	630	200	15	14.800000
1288	631	200	15	15.200000
1289	632	200	15	21.100000
1290	633	200	15	30.300000
1291	634	200	15	34.000000
1292	635	200	15	32.900000
1293	636	200	15	30.700000
1294	637	200	15	30.600000
1295	638	200	15	30.200000
1296	639	200	15	27.800000
1297	640	200	15	21.700000
1298	641	200	15	16.800000
1299	642	200	15	13.900000
1300	643	200	15	17.400000
1301	644	200	15	22.700000
1302	645	200	15	27.600000
1303	646	200	15	33.400000
1304	647	200	15	32.400000
1305	648	200	15	31.400000
1306	649	200	15	31.500000
1307	650	200	15	30.600000
1308	651	200	15	27.700000
1309	652	200	15	22.000000
1310	653	200	15	16.700000
1311	654	200	15	16.000000
1312	655	200	15	16.300000
1313	656	200	15	20.900000
1314	657	200	15	30.000000
1315	658	200	15	34.800000
1316	659	200	15	34.200000
1317	660	200	15	33.200000
1318	661	200	15	31.000000
1319	662	200	15	28.300000
1320	663	200	15	26.400000
1321	664	200	15	21.300000
1322	665	200	15	16.000000
1323	534	100	14	76.779400
1324	535	100	14	76.779400
1325	536	100	14	76.779400
1326	537	100	14	76.779400
1327	538	100	14	76.779400
1328	539	100	14	76.779400
1329	540	100	14	76.779400
1330	541	100	14	76.779400
1331	542	100	14	76.779400
1332	543	100	14	76.779400
1333	544	100	14	76.779400
1334	545	100	14	76.779400
1335	546	100	14	76.779400
1336	547	100	14	76.779400
1337	548	100	14	76.779400
1338	549	100	14	76.779400
1339	550	100	14	76.779400
1340	551	100	14	76.779400
1341	552	100	14	76.779400
1342	553	100	14	76.779400
1343	554	100	14	76.779400
1344	555	100	14	76.779400
1345	556	100	14	76.779400
1346	557	100	14	76.779400
1347	558	100	14	76.779400
1348	559	100	14	76.779400
1349	560	100	14	76.779400
1350	561	100	14	76.779400
1351	562	100	14	76.779400
1352	563	100	14	76.779400
1353	564	100	14	76.779400
1354	565	100	14	76.779400
1355	566	100	14	76.779400
1356	567	100	14	76.779400
1357	568	100	14	76.779400
1358	569	100	14	76.779400
1359	570	100	14	76.779400
1360	571	100	14	76.779400
1361	572	100	14	76.779400
1362	573	100	14	76.779400
1363	574	100	14	76.779400
1364	575	100	14	76.779400
1365	576	100	14	76.779400
1366	577	100	14	76.779400
1367	578	100	14	76.779400
1368	579	100	14	76.779400
1369	580	100	14	76.779400
1370	581	100	14	76.779400
1371	582	100	14	76.779400
1372	583	100	14	76.779400
1373	584	100	14	76.779400
1374	585	100	14	76.779400
1375	586	100	14	76.779400
1376	587	100	14	76.779400
1377	588	100	14	76.779400
1378	589	100	14	76.779400
1379	590	100	14	76.779400
1380	591	100	14	76.779400
1381	592	100	14	76.779400
1382	593	100	14	76.779400
1383	594	100	14	76.779400
1384	595	100	14	76.779400
1385	596	100	14	76.779400
1386	597	100	14	76.779400
1387	598	100	14	76.779400
1388	599	100	14	76.779400
1389	600	100	14	76.779400
1390	601	100	14	76.779400
1391	602	100	14	76.779400
1392	603	100	14	76.779400
1393	604	100	14	76.779400
1394	605	100	14	76.779400
1395	606	100	14	76.779400
1396	607	100	14	76.779400
1397	608	100	14	76.779400
1398	609	100	14	76.779400
1399	610	100	14	76.779400
1400	611	100	14	76.779400
1401	612	100	14	76.779400
1402	613	100	14	76.779400
1403	614	100	14	76.779400
1404	615	100	14	76.779400
1405	616	100	14	76.779400
1406	617	100	14	76.779400
1407	618	100	14	76.779400
1408	619	100	14	76.779400
1409	620	100	14	76.779400
1410	621	100	14	76.779400
1411	622	100	14	76.779400
1412	623	100	14	76.779400
1413	624	100	14	76.779400
1414	625	100	14	76.779400
1415	626	100	14	76.779400
1416	627	100	14	76.779400
1417	628	100	14	76.779400
1418	629	100	14	76.779400
1419	630	100	14	76.779400
1420	631	100	14	76.779400
1421	632	100	14	76.779400
1422	633	100	14	76.779400
1423	634	100	14	76.779400
1424	635	100	14	76.779400
1425	636	100	14	76.779400
1426	637	100	14	76.779400
1427	638	100	14	76.779400
1428	639	100	14	76.779400
1429	640	100	14	76.779400
1430	641	100	14	76.779400
1431	642	100	14	76.779400
1432	643	100	14	76.779400
1433	644	100	14	76.779400
1434	645	100	14	76.779400
1435	646	100	14	76.779400
1436	647	100	14	76.779400
1437	648	100	14	76.779400
1438	649	100	14	76.779400
1439	650	100	14	76.779400
1440	651	100	14	76.779400
1441	652	100	14	76.779400
1442	653	100	14	76.779400
1443	654	100	14	76.779400
1444	655	100	14	76.779400
1445	656	100	14	76.779400
1446	657	100	14	76.779400
1447	658	100	14	76.779400
1448	659	100	14	76.779400
1449	660	100	14	76.779400
1450	661	100	14	76.779400
1451	662	100	14	76.779400
1452	663	100	14	76.779400
1453	664	100	14	76.779400
1454	665	100	14	76.779400
\.


--
-- Name: measures_id_msr_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('measures_id_msr_seq', 1454, true);


--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('measures_mobile_id_mmo_seq', 1, false);


--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('obs_pr_id_opr_seq', 12, true);


--
-- Data for Name: obs_type; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY obs_type (id_oty, name_oty, desc_oty) FROM stdin;
1	insitu-fixed-point	fixed, in-situ, pointwise observation
2	insitu-mobile-point	mobile, in-situ, pointwise observation
3	virtual	virtual procedure
\.


--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('obs_type_id_oty_seq', 1, false);


--
-- Data for Name: observed_properties; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY observed_properties (name_opr, def_opr, desc_opr, constr_opr, id_opr) FROM stdin;
air-temperature	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:temperature	air temperature at 2 meters above terrain	{"interval": ["-40", "100"], "role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0"}	1
air-rainfall	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:rainfall	liquid precipitation or snow water equivalent	{"role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0", "min": "0"}	2
air-relative-humidity	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:humidity:relative	absolute humidity relative to the maximum for that air	{"interval": ["0", "100"], "role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0"}	3
air-wind-velocity	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:wind:velocity	wind speed at 1 meter above terrain	{"role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0", "min": "0"}	4
solar-radiation	urn:ogc:def:parameter:x-istsos:1.0:meteo:solar:radiation	Direct radiation sum in spectrum rand	\N	5
river-height	urn:ogc:def:parameter:x-istsos:1.0:river:water:height		{"interval": ["0", "10"], "role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0"}	6
river-discharge	urn:ogc:def:parameter:x-istsos:1.0:river:water:discharge		\N	7
soil-evapotranspiration	urn:ogc:def:parameter:x-istsos:1.0:meteo:soil:evapotranspiration		\N	8
air-heatindex	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:heatindex		\N	9
lat	urn:ogc:def:parameter:x-istsos:1.0:lattitude		\N	10
long	urn:ogc:def:parameter:x-istsos:1.0:longitude		\N	11
longi	urn:ogc:def:parameter:x-istsos:1.0:longittude		\N	12
\.


--
-- Data for Name: off_proc; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY off_proc (id_off_prc, id_off_fk, id_prc_fk) FROM stdin;
2	2	1
4	2	2
6	2	3
8	2	4
10	2	5
\.


--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('off_proc_id_opr_seq', 10, true);


--
-- Data for Name: offerings; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY offerings (name_off, desc_off, expiration_off, active_off, id_off) FROM stdin;
temporary	temporary offering to hold self-registered procedures/sensors waiting for service adimistration acceptance	\N	t	1
temperatureOffering	Offers Temperature	\N	t	2
\.


--
-- Name: offerings_id_off_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('offerings_id_off_seq', 2, true);


--
-- Data for Name: positions; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY positions (id_pos, id_qi_fk, id_eti_fk, geom_pos) FROM stdin;
\.


--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('prc_obs_id_pro_seq', 15, true);


--
-- Data for Name: proc_obs; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY proc_obs (id_pro, id_prc_fk, id_uom_fk, id_opr_fk, constr_pro) FROM stdin;
1	1	10	10	\N
2	1	11	11	\N
3	1	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
4	2	11	11	\N
5	2	10	10	\N
6	2	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
7	3	10	10	\N
8	3	11	11	\N
9	3	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
10	4	12	10	\N
11	4	12	11	\N
12	4	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
13	5	10	10	\N
14	5	11	12	\N
15	5	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
\.


--
-- Data for Name: procedures; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY procedures (id_prc, assignedid_prc, name_prc, desc_prc, stime_prc, etime_prc, time_res_prc, time_acq_prc, id_oty_fk, id_foi_fk, mqtt_prc) FROM stdin;
1	3604ff0aaa7911e68b19acd1b8c9a681	temp_yavatmal	Mean temperature of Yavatmal City	1992-01-01 04:40:00+05:30	2002-12-01 19:50:00+05:30	0	0	1	1	\N
2	4da16afeaa7e11e6b605acd1b8c9a681	temp_ytl	\N	1992-01-02 04:40:00+05:30	2002-12-01 19:50:00+05:30	0	0	1	2	\N
3	42895738aa8011e6b605acd1b8c9a681	temp_chandigarh	Mean temperature of Chandigarh	1992-01-02 04:40:00+05:30	2002-12-01 19:50:00+05:30	0	0	1	3	\N
4	adb4822caa9311e6b9d9acd1b8c9a681	temp_trial	TemperatureTrial	1992-01-02 04:40:00+05:30	2002-12-01 19:50:00+05:30	0	0	1	4	\N
5	3b6b7da0aa9411e68f24acd1b8c9a681	temp_try	Try	1992-01-02 04:40:00+05:30	2002-12-01 19:50:00+05:30	0	0	1	5	\N
\.


--
-- Name: procedures_id_prc_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('procedures_id_prc_seq', 5, true);


--
-- Data for Name: quality_index; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY quality_index (name_qi, desc_qi, id_qi) FROM stdin;
aggregation no data	no values are present for this aggregation interval	-100
outboud	gross error	0
raw	the format is correct	100
acceptable	the value is acceptable for the observed property	110
reasonable	the value is in a resonable range for that observed property and station	200
timely coherent	the value is coherent with time-series	300
spatilly coherent	the value is coherent with close by observations	400
manually adjusted	the value has been manually corrected	500
correct	the value has not been modified and is correct	600
\.


--
-- Data for Name: tran_log; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY tran_log (id_trl, transaction_time_trl, operation_trl, procedure_trl, begin_trl, end_trl, count, stime_prc, etime_prc) FROM stdin;
\.


--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('tran_log_id_trl_seq', 1, false);


--
-- Data for Name: uoms; Type: TABLE DATA; Schema: weather; Owner: postgres
--

COPY uoms (name_uom, desc_uom, id_uom) FROM stdin;
null		0
mm	millimeter	1
°C	Celsius degree	2
%	percentage	3
m/s	metre per second	4
W/m2	Watt per square metre	5
°F	Fahrenheit degree	6
m	metre	7
m3/s	cube meter per second	8
mm/h	evapotranspiration	9
°N	Lattitude	10
°E	Longitude	11
deg	Degree of Latitude and Longitude	12
\.


--
-- Name: uoms_id_uom_seq; Type: SEQUENCE SET; Schema: weather; Owner: postgres
--

SELECT pg_catalog.setval('uoms_id_uom_seq', 12, true);


SET search_path = weatherstation, pg_catalog;

--
-- Data for Name: cron_log; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY cron_log (id_clo, id_prc_fk, process_clo, element_clo, datetime_clo, message_clo, details_clo, status_clo) FROM stdin;
\.


--
-- Name: cron_log_id_clo_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('cron_log_id_clo_seq', 1, false);


--
-- Data for Name: event_time; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY event_time (id_eti, id_prc_fk, time_eti) FROM stdin;
1	54	1992-01-02 04:40:00+05:30
2	54	1992-02-01 04:40:00+05:30
3	54	1992-03-01 04:40:00+05:30
4	54	1992-04-01 04:40:00+05:30
5	54	1992-05-01 04:40:00+05:30
6	54	1992-06-01 04:40:00+05:30
7	54	1992-07-01 04:40:00+05:30
8	54	1992-08-01 04:40:00+05:30
9	54	1992-09-01 04:40:00+05:30
10	54	1992-10-01 04:40:00+05:30
11	54	1992-11-01 04:40:00+05:30
12	54	1992-12-01 04:40:00+05:30
13	54	1993-01-01 04:40:00+05:30
14	54	1993-02-01 04:40:00+05:30
15	54	1993-03-01 04:40:00+05:30
16	54	1993-04-01 04:40:00+05:30
17	54	1993-05-01 04:40:00+05:30
18	54	1993-06-01 04:40:00+05:30
19	54	1993-07-01 04:40:00+05:30
20	54	1993-08-01 04:40:00+05:30
21	54	1993-09-01 04:40:00+05:30
22	54	1993-10-01 04:40:00+05:30
23	54	1993-11-01 04:40:00+05:30
24	54	1993-12-01 04:40:00+05:30
25	54	1994-01-01 04:40:00+05:30
26	54	1994-02-01 04:40:00+05:30
27	54	1994-03-01 04:40:00+05:30
28	54	1994-04-01 04:40:00+05:30
29	54	1994-05-01 04:40:00+05:30
30	54	1994-06-01 04:40:00+05:30
31	54	1994-07-01 04:40:00+05:30
32	54	1994-08-01 04:40:00+05:30
33	54	1994-09-01 04:40:00+05:30
34	54	1994-10-01 04:40:00+05:30
35	54	1994-11-01 04:40:00+05:30
36	54	1994-12-01 04:40:00+05:30
37	54	1995-01-01 04:40:00+05:30
38	54	1995-02-01 04:40:00+05:30
39	54	1995-03-01 04:40:00+05:30
40	54	1995-04-01 04:40:00+05:30
41	54	1995-05-01 04:40:00+05:30
42	54	1995-06-01 04:40:00+05:30
43	54	1995-07-01 04:40:00+05:30
44	54	1995-08-01 04:40:00+05:30
45	54	1995-09-01 04:40:00+05:30
46	54	1995-10-01 04:40:00+05:30
47	54	1995-11-01 04:40:00+05:30
48	54	1995-12-01 04:40:00+05:30
49	54	1996-01-01 04:40:00+05:30
50	54	1996-02-01 04:40:00+05:30
51	54	1996-03-01 04:40:00+05:30
52	54	1996-04-01 04:40:00+05:30
53	54	1996-05-01 04:40:00+05:30
54	54	1996-06-01 04:40:00+05:30
55	54	1996-07-01 04:40:00+05:30
56	54	1996-08-01 04:40:00+05:30
57	54	1996-09-01 04:40:00+05:30
58	54	1996-10-01 04:40:00+05:30
59	54	1996-11-01 04:40:00+05:30
60	54	1996-12-01 04:40:00+05:30
61	54	1997-01-01 04:40:00+05:30
62	54	1997-02-01 04:40:00+05:30
63	54	1997-03-01 04:40:00+05:30
64	54	1997-04-01 04:40:00+05:30
65	54	1997-05-01 04:40:00+05:30
66	54	1997-06-01 04:40:00+05:30
67	54	1997-07-01 04:40:00+05:30
68	54	1997-08-01 04:40:00+05:30
69	54	1997-09-01 04:40:00+05:30
70	54	1997-10-01 04:40:00+05:30
71	54	1997-11-01 04:40:00+05:30
72	54	1997-12-01 04:40:00+05:30
73	54	1998-01-01 04:40:00+05:30
74	54	1998-02-01 04:40:00+05:30
75	54	1998-03-01 04:40:00+05:30
76	54	1998-04-01 04:40:00+05:30
77	54	1998-05-01 04:40:00+05:30
78	54	1998-06-01 04:40:00+05:30
79	54	1998-07-01 04:40:00+05:30
80	54	1998-08-01 04:40:00+05:30
81	54	1998-09-01 04:40:00+05:30
82	54	1998-10-01 04:40:00+05:30
83	54	1998-11-01 04:40:00+05:30
84	54	1998-12-01 04:40:00+05:30
85	54	1999-01-01 04:40:00+05:30
86	54	1999-02-01 04:40:00+05:30
87	54	1999-03-01 04:40:00+05:30
88	54	1999-04-01 04:40:00+05:30
89	54	1999-05-01 04:40:00+05:30
90	54	1999-06-01 04:40:00+05:30
91	54	1999-07-01 04:40:00+05:30
92	54	1999-08-01 04:40:00+05:30
93	54	1999-09-01 04:40:00+05:30
94	54	1999-10-01 04:40:00+05:30
95	54	1999-11-01 04:40:00+05:30
96	54	1999-12-01 04:40:00+05:30
97	54	2000-01-01 04:40:00+05:30
98	54	2000-02-01 04:40:00+05:30
99	54	2000-03-01 04:40:00+05:30
100	54	2000-04-01 04:40:00+05:30
101	54	2000-05-01 04:40:00+05:30
102	54	2000-06-01 04:40:00+05:30
103	54	2000-07-01 04:40:00+05:30
104	54	2000-08-01 04:40:00+05:30
105	54	2000-09-01 04:40:00+05:30
106	54	2000-10-01 04:40:00+05:30
107	54	2000-11-01 04:40:00+05:30
108	54	2000-12-01 04:40:00+05:30
109	54	2001-01-01 04:40:00+05:30
110	54	2001-02-01 04:40:00+05:30
111	54	2001-03-01 04:40:00+05:30
112	54	2001-04-01 04:40:00+05:30
113	54	2001-05-01 04:40:00+05:30
114	54	2001-06-01 04:40:00+05:30
115	54	2001-07-01 04:40:00+05:30
116	54	2001-08-01 04:40:00+05:30
117	54	2001-09-01 04:40:00+05:30
118	54	2001-10-01 04:40:00+05:30
119	54	2001-11-01 04:40:00+05:30
120	54	2001-12-01 04:40:00+05:30
121	54	2002-01-01 04:40:00+05:30
122	54	2002-02-01 04:40:00+05:30
123	54	2002-03-01 04:40:00+05:30
124	54	2002-04-01 04:40:00+05:30
125	54	2002-05-01 04:40:00+05:30
126	54	2002-06-01 04:40:00+05:30
127	54	2002-07-01 04:40:00+05:30
128	54	2002-08-01 04:40:00+05:30
129	54	2002-09-01 04:40:00+05:30
130	54	2002-10-01 04:40:00+05:30
131	54	2002-11-01 04:40:00+05:30
132	54	2002-12-01 04:40:00+05:30
133	55	1992-01-02 04:40:00+05:30
134	55	1992-02-01 04:40:00+05:30
135	55	1992-03-01 04:40:00+05:30
136	55	1992-04-01 04:40:00+05:30
137	55	1992-05-01 04:40:00+05:30
138	55	1992-06-01 04:40:00+05:30
139	55	1992-07-01 04:40:00+05:30
140	55	1992-08-01 04:40:00+05:30
141	55	1992-09-01 04:40:00+05:30
142	55	1992-10-01 04:40:00+05:30
143	55	1992-11-01 04:40:00+05:30
144	55	1992-12-01 04:40:00+05:30
145	55	1993-01-01 04:40:00+05:30
146	55	1993-02-01 04:40:00+05:30
147	55	1993-03-01 04:40:00+05:30
148	55	1993-04-01 04:40:00+05:30
149	55	1993-05-01 04:40:00+05:30
150	55	1993-06-01 04:40:00+05:30
151	55	1993-07-01 04:40:00+05:30
152	55	1993-08-01 04:40:00+05:30
153	55	1993-09-01 04:40:00+05:30
154	55	1993-10-01 04:40:00+05:30
155	55	1993-11-01 04:40:00+05:30
156	55	1993-12-01 04:40:00+05:30
157	55	1994-01-01 04:40:00+05:30
158	55	1994-02-01 04:40:00+05:30
159	55	1994-03-01 04:40:00+05:30
160	55	1994-04-01 04:40:00+05:30
161	55	1994-05-01 04:40:00+05:30
162	55	1994-06-01 04:40:00+05:30
163	55	1994-07-01 04:40:00+05:30
164	55	1994-08-01 04:40:00+05:30
165	55	1994-09-01 04:40:00+05:30
166	55	1994-10-01 04:40:00+05:30
167	55	1994-11-01 04:40:00+05:30
168	55	1994-12-01 04:40:00+05:30
169	55	1995-01-01 04:40:00+05:30
170	55	1995-02-01 04:40:00+05:30
171	55	1995-03-01 04:40:00+05:30
172	55	1995-04-01 04:40:00+05:30
173	55	1995-05-01 04:40:00+05:30
174	55	1995-06-01 04:40:00+05:30
175	55	1995-07-01 04:40:00+05:30
176	55	1995-08-01 04:40:00+05:30
177	55	1995-09-01 04:40:00+05:30
178	55	1995-10-01 04:40:00+05:30
179	55	1995-11-01 04:40:00+05:30
180	55	1995-12-01 04:40:00+05:30
181	55	1996-01-01 04:40:00+05:30
182	55	1996-02-01 04:40:00+05:30
183	55	1996-03-01 04:40:00+05:30
184	55	1996-04-01 04:40:00+05:30
185	55	1996-05-01 04:40:00+05:30
186	55	1996-06-01 04:40:00+05:30
187	55	1996-07-01 04:40:00+05:30
188	55	1996-08-01 04:40:00+05:30
189	55	1996-09-01 04:40:00+05:30
190	55	1996-10-01 04:40:00+05:30
191	55	1996-11-01 04:40:00+05:30
192	55	1996-12-01 04:40:00+05:30
193	55	1997-01-01 04:40:00+05:30
194	55	1997-02-01 04:40:00+05:30
195	55	1997-03-01 04:40:00+05:30
196	55	1997-04-01 04:40:00+05:30
197	55	1997-05-01 04:40:00+05:30
198	55	1997-06-01 04:40:00+05:30
199	55	1997-07-01 04:40:00+05:30
200	55	1997-08-01 04:40:00+05:30
201	55	1997-09-01 04:40:00+05:30
202	55	1997-10-01 04:40:00+05:30
203	55	1997-11-01 04:40:00+05:30
204	55	1997-12-01 04:40:00+05:30
205	55	1998-01-01 04:40:00+05:30
206	55	1998-02-01 04:40:00+05:30
207	55	1998-03-01 04:40:00+05:30
208	55	1998-04-01 04:40:00+05:30
209	55	1998-05-01 04:40:00+05:30
210	55	1998-06-01 04:40:00+05:30
211	55	1998-07-01 04:40:00+05:30
212	55	1998-08-01 04:40:00+05:30
213	55	1998-09-01 04:40:00+05:30
214	55	1998-10-01 04:40:00+05:30
215	55	1998-11-01 04:40:00+05:30
216	55	1998-12-01 04:40:00+05:30
217	55	1999-01-01 04:40:00+05:30
218	55	1999-02-01 04:40:00+05:30
219	55	1999-03-01 04:40:00+05:30
220	55	1999-04-01 04:40:00+05:30
221	55	1999-05-01 04:40:00+05:30
222	55	1999-06-01 04:40:00+05:30
223	55	1999-07-01 04:40:00+05:30
224	55	1999-08-01 04:40:00+05:30
225	55	1999-09-01 04:40:00+05:30
226	55	1999-10-01 04:40:00+05:30
227	55	1999-11-01 04:40:00+05:30
228	55	1999-12-01 04:40:00+05:30
229	55	2000-01-01 04:40:00+05:30
230	55	2000-02-01 04:40:00+05:30
231	55	2000-03-01 04:40:00+05:30
232	55	2000-04-01 04:40:00+05:30
233	55	2000-05-01 04:40:00+05:30
234	55	2000-06-01 04:40:00+05:30
235	55	2000-07-01 04:40:00+05:30
236	55	2000-08-01 04:40:00+05:30
237	55	2000-09-01 04:40:00+05:30
238	55	2000-10-01 04:40:00+05:30
239	55	2000-11-01 04:40:00+05:30
240	55	2000-12-01 04:40:00+05:30
241	55	2001-01-01 04:40:00+05:30
242	55	2001-02-01 04:40:00+05:30
243	55	2001-03-01 04:40:00+05:30
244	55	2001-04-01 04:40:00+05:30
245	55	2001-05-01 04:40:00+05:30
246	55	2001-06-01 04:40:00+05:30
247	55	2001-07-01 04:40:00+05:30
248	55	2001-08-01 04:40:00+05:30
249	55	2001-09-01 04:40:00+05:30
250	55	2001-10-01 04:40:00+05:30
251	55	2001-11-01 04:40:00+05:30
252	55	2001-12-01 04:40:00+05:30
253	55	2002-01-01 04:40:00+05:30
254	55	2002-02-01 04:40:00+05:30
255	55	2002-03-01 04:40:00+05:30
256	55	2002-04-01 04:40:00+05:30
257	55	2002-05-01 04:40:00+05:30
258	55	2002-06-01 04:40:00+05:30
259	55	2002-07-01 04:40:00+05:30
260	55	2002-08-01 04:40:00+05:30
261	55	2002-09-01 04:40:00+05:30
262	55	2002-10-01 04:40:00+05:30
263	55	2002-11-01 04:40:00+05:30
264	55	2002-12-01 04:40:00+05:30
265	56	1992-01-02 04:40:00+05:30
266	56	1992-02-01 04:40:00+05:30
267	56	1992-03-01 04:40:00+05:30
268	56	1992-04-01 04:40:00+05:30
269	56	1992-05-01 04:40:00+05:30
270	56	1992-06-01 04:40:00+05:30
271	56	1992-07-01 04:40:00+05:30
272	56	1992-08-01 04:40:00+05:30
273	56	1992-09-01 04:40:00+05:30
274	56	1992-10-01 04:40:00+05:30
275	56	1992-11-01 04:40:00+05:30
276	56	1992-12-01 04:40:00+05:30
277	56	1993-01-01 04:40:00+05:30
278	56	1993-02-01 04:40:00+05:30
279	56	1993-03-01 04:40:00+05:30
280	56	1993-04-01 04:40:00+05:30
281	56	1993-05-01 04:40:00+05:30
282	56	1993-06-01 04:40:00+05:30
283	56	1993-07-01 04:40:00+05:30
284	56	1993-08-01 04:40:00+05:30
285	56	1993-09-01 04:40:00+05:30
286	56	1993-10-01 04:40:00+05:30
287	56	1993-11-01 04:40:00+05:30
288	56	1993-12-01 04:40:00+05:30
289	56	1994-01-01 04:40:00+05:30
290	56	1994-02-01 04:40:00+05:30
291	56	1994-03-01 04:40:00+05:30
292	56	1994-04-01 04:40:00+05:30
293	56	1994-05-01 04:40:00+05:30
294	56	1994-06-01 04:40:00+05:30
295	56	1994-07-01 04:40:00+05:30
296	56	1994-08-01 04:40:00+05:30
297	56	1994-09-01 04:40:00+05:30
298	56	1994-10-01 04:40:00+05:30
299	56	1994-11-01 04:40:00+05:30
300	56	1994-12-01 04:40:00+05:30
301	56	1995-01-01 04:40:00+05:30
302	56	1995-02-01 04:40:00+05:30
303	56	1995-03-01 04:40:00+05:30
304	56	1995-04-01 04:40:00+05:30
305	56	1995-05-01 04:40:00+05:30
306	56	1995-06-01 04:40:00+05:30
307	56	1995-07-01 04:40:00+05:30
308	56	1995-08-01 04:40:00+05:30
309	56	1995-09-01 04:40:00+05:30
310	56	1995-10-01 04:40:00+05:30
311	56	1995-11-01 04:40:00+05:30
312	56	1995-12-01 04:40:00+05:30
313	56	1996-01-01 04:40:00+05:30
314	56	1996-02-01 04:40:00+05:30
315	56	1996-03-01 04:40:00+05:30
316	56	1996-04-01 04:40:00+05:30
317	56	1996-05-01 04:40:00+05:30
318	56	1996-06-01 04:40:00+05:30
319	56	1996-07-01 04:40:00+05:30
320	56	1996-08-01 04:40:00+05:30
321	56	1996-09-01 04:40:00+05:30
322	56	1996-10-01 04:40:00+05:30
323	56	1996-11-01 04:40:00+05:30
324	56	1996-12-01 04:40:00+05:30
325	56	1997-01-01 04:40:00+05:30
326	56	1997-02-01 04:40:00+05:30
327	56	1997-03-01 04:40:00+05:30
328	56	1997-04-01 04:40:00+05:30
329	56	1997-05-01 04:40:00+05:30
330	56	1997-06-01 04:40:00+05:30
331	56	1997-07-01 04:40:00+05:30
332	56	1997-08-01 04:40:00+05:30
333	56	1997-09-01 04:40:00+05:30
334	56	1997-10-01 04:40:00+05:30
335	56	1997-11-01 04:40:00+05:30
336	56	1997-12-01 04:40:00+05:30
337	56	1998-01-01 04:40:00+05:30
338	56	1998-02-01 04:40:00+05:30
339	56	1998-03-01 04:40:00+05:30
340	56	1998-04-01 04:40:00+05:30
341	56	1998-05-01 04:40:00+05:30
342	56	1998-06-01 04:40:00+05:30
343	56	1998-07-01 04:40:00+05:30
344	56	1998-08-01 04:40:00+05:30
345	56	1998-09-01 04:40:00+05:30
346	56	1998-10-01 04:40:00+05:30
347	56	1998-11-01 04:40:00+05:30
348	56	1998-12-01 04:40:00+05:30
349	56	1999-01-01 04:40:00+05:30
350	56	1999-02-01 04:40:00+05:30
351	56	1999-03-01 04:40:00+05:30
352	56	1999-04-01 04:40:00+05:30
353	56	1999-05-01 04:40:00+05:30
354	56	1999-06-01 04:40:00+05:30
355	56	1999-07-01 04:40:00+05:30
356	56	1999-08-01 04:40:00+05:30
357	56	1999-09-01 04:40:00+05:30
358	56	1999-10-01 04:40:00+05:30
359	56	1999-11-01 04:40:00+05:30
360	56	1999-12-01 04:40:00+05:30
361	56	2000-01-01 04:40:00+05:30
362	56	2000-02-01 04:40:00+05:30
363	56	2000-03-01 04:40:00+05:30
364	56	2000-04-01 04:40:00+05:30
365	56	2000-05-01 04:40:00+05:30
366	56	2000-06-01 04:40:00+05:30
367	56	2000-07-01 04:40:00+05:30
368	56	2000-08-01 04:40:00+05:30
369	56	2000-09-01 04:40:00+05:30
370	56	2000-10-01 04:40:00+05:30
371	56	2000-11-01 04:40:00+05:30
372	56	2000-12-01 04:40:00+05:30
373	56	2001-01-01 04:40:00+05:30
374	56	2001-02-01 04:40:00+05:30
375	56	2001-03-01 04:40:00+05:30
376	56	2001-04-01 04:40:00+05:30
377	56	2001-05-01 04:40:00+05:30
378	56	2001-06-01 04:40:00+05:30
379	56	2001-07-01 04:40:00+05:30
380	56	2001-08-01 04:40:00+05:30
381	56	2001-09-01 04:40:00+05:30
382	56	2001-10-01 04:40:00+05:30
383	56	2001-11-01 04:40:00+05:30
384	56	2001-12-01 04:40:00+05:30
385	56	2002-01-01 04:40:00+05:30
386	56	2002-02-01 04:40:00+05:30
387	56	2002-03-01 04:40:00+05:30
388	56	2002-04-01 04:40:00+05:30
389	56	2002-05-01 04:40:00+05:30
390	56	2002-06-01 04:40:00+05:30
391	56	2002-07-01 04:40:00+05:30
392	56	2002-08-01 04:40:00+05:30
393	56	2002-09-01 04:40:00+05:30
394	56	2002-10-01 04:40:00+05:30
395	56	2002-11-01 04:40:00+05:30
396	56	2002-12-01 04:40:00+05:30
397	57	1992-01-02 04:40:00+05:30
398	57	1992-02-01 04:40:00+05:30
399	57	1992-03-01 04:40:00+05:30
400	57	1992-04-01 04:40:00+05:30
401	57	1992-05-01 04:40:00+05:30
402	57	1992-06-01 04:40:00+05:30
403	57	1992-07-01 04:40:00+05:30
404	57	1992-08-01 04:40:00+05:30
405	57	1992-09-01 04:40:00+05:30
406	57	1992-10-01 04:40:00+05:30
407	57	1992-11-01 04:40:00+05:30
408	57	1992-12-01 04:40:00+05:30
409	57	1993-01-01 04:40:00+05:30
410	57	1993-02-01 04:40:00+05:30
411	57	1993-03-01 04:40:00+05:30
412	57	1993-04-01 04:40:00+05:30
413	57	1993-05-01 04:40:00+05:30
414	57	1993-06-01 04:40:00+05:30
415	57	1993-07-01 04:40:00+05:30
416	57	1993-08-01 04:40:00+05:30
417	57	1993-09-01 04:40:00+05:30
418	57	1993-10-01 04:40:00+05:30
419	57	1993-11-01 04:40:00+05:30
420	57	1993-12-01 04:40:00+05:30
421	57	1994-01-01 04:40:00+05:30
422	57	1994-02-01 04:40:00+05:30
423	57	1994-03-01 04:40:00+05:30
424	57	1994-04-01 04:40:00+05:30
425	57	1994-05-01 04:40:00+05:30
426	57	1994-06-01 04:40:00+05:30
427	57	1994-07-01 04:40:00+05:30
428	57	1994-08-01 04:40:00+05:30
429	57	1994-09-01 04:40:00+05:30
430	57	1994-10-01 04:40:00+05:30
431	57	1994-11-01 04:40:00+05:30
432	57	1994-12-01 04:40:00+05:30
433	57	1995-01-01 04:40:00+05:30
434	57	1995-02-01 04:40:00+05:30
435	57	1995-03-01 04:40:00+05:30
436	57	1995-04-01 04:40:00+05:30
437	57	1995-05-01 04:40:00+05:30
438	57	1995-06-01 04:40:00+05:30
439	57	1995-07-01 04:40:00+05:30
440	57	1995-08-01 04:40:00+05:30
441	57	1995-09-01 04:40:00+05:30
442	57	1995-10-01 04:40:00+05:30
443	57	1995-11-01 04:40:00+05:30
444	57	1995-12-01 04:40:00+05:30
445	57	1996-01-01 04:40:00+05:30
446	57	1996-02-01 04:40:00+05:30
447	57	1996-03-01 04:40:00+05:30
448	57	1996-04-01 04:40:00+05:30
449	57	1996-05-01 04:40:00+05:30
450	57	1996-06-01 04:40:00+05:30
451	57	1996-07-01 04:40:00+05:30
452	57	1996-08-01 04:40:00+05:30
453	57	1996-09-01 04:40:00+05:30
454	57	1996-10-01 04:40:00+05:30
455	57	1996-11-01 04:40:00+05:30
456	57	1996-12-01 04:40:00+05:30
457	57	1997-01-01 04:40:00+05:30
458	57	1997-02-01 04:40:00+05:30
459	57	1997-03-01 04:40:00+05:30
460	57	1997-04-01 04:40:00+05:30
461	57	1997-05-01 04:40:00+05:30
462	57	1997-06-01 04:40:00+05:30
463	57	1997-07-01 04:40:00+05:30
464	57	1997-08-01 04:40:00+05:30
465	57	1997-09-01 04:40:00+05:30
466	57	1997-10-01 04:40:00+05:30
467	57	1997-11-01 04:40:00+05:30
468	57	1997-12-01 04:40:00+05:30
469	57	1998-01-01 04:40:00+05:30
470	57	1998-02-01 04:40:00+05:30
471	57	1998-03-01 04:40:00+05:30
472	57	1998-04-01 04:40:00+05:30
473	57	1998-05-01 04:40:00+05:30
474	57	1998-06-01 04:40:00+05:30
475	57	1998-07-01 04:40:00+05:30
476	57	1998-08-01 04:40:00+05:30
477	57	1998-09-01 04:40:00+05:30
478	57	1998-10-01 04:40:00+05:30
479	57	1998-11-01 04:40:00+05:30
480	57	1998-12-01 04:40:00+05:30
481	57	1999-01-01 04:40:00+05:30
482	57	1999-02-01 04:40:00+05:30
483	57	1999-03-01 04:40:00+05:30
484	57	1999-04-01 04:40:00+05:30
485	57	1999-05-01 04:40:00+05:30
486	57	1999-06-01 04:40:00+05:30
487	57	1999-07-01 04:40:00+05:30
488	57	1999-08-01 04:40:00+05:30
489	57	1999-09-01 04:40:00+05:30
490	57	1999-10-01 04:40:00+05:30
491	57	1999-11-01 04:40:00+05:30
492	57	1999-12-01 04:40:00+05:30
493	57	2000-01-01 04:40:00+05:30
494	57	2000-02-01 04:40:00+05:30
495	57	2000-03-01 04:40:00+05:30
496	57	2000-04-01 04:40:00+05:30
497	57	2000-05-01 04:40:00+05:30
498	57	2000-06-01 04:40:00+05:30
499	57	2000-07-01 04:40:00+05:30
500	57	2000-08-01 04:40:00+05:30
501	57	2000-09-01 04:40:00+05:30
502	57	2000-10-01 04:40:00+05:30
503	57	2000-11-01 04:40:00+05:30
504	57	2000-12-01 04:40:00+05:30
505	57	2001-01-01 04:40:00+05:30
506	57	2001-02-01 04:40:00+05:30
507	57	2001-03-01 04:40:00+05:30
508	57	2001-04-01 04:40:00+05:30
509	57	2001-05-01 04:40:00+05:30
510	57	2001-06-01 04:40:00+05:30
511	57	2001-07-01 04:40:00+05:30
512	57	2001-08-01 04:40:00+05:30
513	57	2001-09-01 04:40:00+05:30
514	57	2001-10-01 04:40:00+05:30
515	57	2001-11-01 04:40:00+05:30
516	57	2001-12-01 04:40:00+05:30
517	57	2002-01-01 04:40:00+05:30
518	57	2002-02-01 04:40:00+05:30
519	57	2002-03-01 04:40:00+05:30
520	57	2002-04-01 04:40:00+05:30
521	57	2002-05-01 04:40:00+05:30
522	57	2002-06-01 04:40:00+05:30
523	57	2002-07-01 04:40:00+05:30
524	57	2002-08-01 04:40:00+05:30
525	57	2002-09-01 04:40:00+05:30
526	57	2002-10-01 04:40:00+05:30
527	57	2002-11-01 04:40:00+05:30
528	57	2002-12-01 04:40:00+05:30
529	58	1992-01-02 04:40:00+05:30
530	58	1992-02-01 04:40:00+05:30
531	58	1992-03-01 04:40:00+05:30
532	58	1992-04-01 04:40:00+05:30
533	58	1992-05-01 04:40:00+05:30
534	58	1992-06-01 04:40:00+05:30
535	58	1992-07-01 04:40:00+05:30
536	58	1992-08-01 04:40:00+05:30
537	58	1992-09-01 04:40:00+05:30
538	58	1992-10-01 04:40:00+05:30
539	58	1992-11-01 04:40:00+05:30
540	58	1992-12-01 04:40:00+05:30
541	58	1993-01-01 04:40:00+05:30
542	58	1993-02-01 04:40:00+05:30
543	58	1993-03-01 04:40:00+05:30
544	58	1993-04-01 04:40:00+05:30
545	58	1993-05-01 04:40:00+05:30
546	58	1993-06-01 04:40:00+05:30
547	58	1993-07-01 04:40:00+05:30
548	58	1993-08-01 04:40:00+05:30
549	58	1993-09-01 04:40:00+05:30
550	58	1993-10-01 04:40:00+05:30
551	58	1993-11-01 04:40:00+05:30
552	58	1993-12-01 04:40:00+05:30
553	58	1994-01-01 04:40:00+05:30
554	58	1994-02-01 04:40:00+05:30
555	58	1994-03-01 04:40:00+05:30
556	58	1994-04-01 04:40:00+05:30
557	58	1994-05-01 04:40:00+05:30
558	58	1994-06-01 04:40:00+05:30
559	58	1994-07-01 04:40:00+05:30
560	58	1994-08-01 04:40:00+05:30
561	58	1994-09-01 04:40:00+05:30
562	58	1994-10-01 04:40:00+05:30
563	58	1994-11-01 04:40:00+05:30
564	58	1994-12-01 04:40:00+05:30
565	58	1995-01-01 04:40:00+05:30
566	58	1995-02-01 04:40:00+05:30
567	58	1995-03-01 04:40:00+05:30
568	58	1995-04-01 04:40:00+05:30
569	58	1995-05-01 04:40:00+05:30
570	58	1995-06-01 04:40:00+05:30
571	58	1995-07-01 04:40:00+05:30
572	58	1995-08-01 04:40:00+05:30
573	58	1995-09-01 04:40:00+05:30
574	58	1995-10-01 04:40:00+05:30
575	58	1995-11-01 04:40:00+05:30
576	58	1995-12-01 04:40:00+05:30
577	58	1996-01-01 04:40:00+05:30
578	58	1996-02-01 04:40:00+05:30
579	58	1996-03-01 04:40:00+05:30
580	58	1996-04-01 04:40:00+05:30
581	58	1996-05-01 04:40:00+05:30
582	58	1996-06-01 04:40:00+05:30
583	58	1996-07-01 04:40:00+05:30
584	58	1996-08-01 04:40:00+05:30
585	58	1996-09-01 04:40:00+05:30
586	58	1996-10-01 04:40:00+05:30
587	58	1996-11-01 04:40:00+05:30
588	58	1996-12-01 04:40:00+05:30
589	58	1997-01-01 04:40:00+05:30
590	58	1997-02-01 04:40:00+05:30
591	58	1997-03-01 04:40:00+05:30
592	58	1997-04-01 04:40:00+05:30
593	58	1997-05-01 04:40:00+05:30
594	58	1997-06-01 04:40:00+05:30
595	58	1997-07-01 04:40:00+05:30
596	58	1997-08-01 04:40:00+05:30
597	58	1997-09-01 04:40:00+05:30
598	58	1997-10-01 04:40:00+05:30
599	58	1997-11-01 04:40:00+05:30
600	58	1997-12-01 04:40:00+05:30
601	58	1998-01-01 04:40:00+05:30
602	58	1998-02-01 04:40:00+05:30
603	58	1998-03-01 04:40:00+05:30
604	58	1998-04-01 04:40:00+05:30
605	58	1998-05-01 04:40:00+05:30
606	58	1998-06-01 04:40:00+05:30
607	58	1998-07-01 04:40:00+05:30
608	58	1998-08-01 04:40:00+05:30
609	58	1998-09-01 04:40:00+05:30
610	58	1998-10-01 04:40:00+05:30
611	58	1998-11-01 04:40:00+05:30
612	58	1998-12-01 04:40:00+05:30
613	58	1999-01-01 04:40:00+05:30
614	58	1999-02-01 04:40:00+05:30
615	58	1999-03-01 04:40:00+05:30
616	58	1999-04-01 04:40:00+05:30
617	58	1999-05-01 04:40:00+05:30
618	58	1999-06-01 04:40:00+05:30
619	58	1999-07-01 04:40:00+05:30
620	58	1999-08-01 04:40:00+05:30
621	58	1999-09-01 04:40:00+05:30
622	58	1999-10-01 04:40:00+05:30
623	58	1999-11-01 04:40:00+05:30
624	58	1999-12-01 04:40:00+05:30
625	58	2000-01-01 04:40:00+05:30
626	58	2000-02-01 04:40:00+05:30
627	58	2000-03-01 04:40:00+05:30
628	58	2000-04-01 04:40:00+05:30
629	58	2000-05-01 04:40:00+05:30
630	58	2000-06-01 04:40:00+05:30
631	58	2000-07-01 04:40:00+05:30
632	58	2000-08-01 04:40:00+05:30
633	58	2000-09-01 04:40:00+05:30
634	58	2000-10-01 04:40:00+05:30
635	58	2000-11-01 04:40:00+05:30
636	58	2000-12-01 04:40:00+05:30
637	58	2001-01-01 04:40:00+05:30
638	58	2001-02-01 04:40:00+05:30
639	58	2001-03-01 04:40:00+05:30
640	58	2001-04-01 04:40:00+05:30
641	58	2001-05-01 04:40:00+05:30
642	58	2001-06-01 04:40:00+05:30
643	58	2001-07-01 04:40:00+05:30
644	58	2001-08-01 04:40:00+05:30
645	58	2001-09-01 04:40:00+05:30
646	58	2001-10-01 04:40:00+05:30
647	58	2001-11-01 04:40:00+05:30
648	58	2001-12-01 04:40:00+05:30
649	58	2002-01-01 04:40:00+05:30
650	58	2002-02-01 04:40:00+05:30
651	58	2002-03-01 04:40:00+05:30
652	58	2002-04-01 04:40:00+05:30
653	58	2002-05-01 04:40:00+05:30
654	58	2002-06-01 04:40:00+05:30
655	58	2002-07-01 04:40:00+05:30
656	58	2002-08-01 04:40:00+05:30
657	58	2002-09-01 04:40:00+05:30
658	58	2002-10-01 04:40:00+05:30
659	58	2002-11-01 04:40:00+05:30
660	58	2002-12-01 04:40:00+05:30
661	59	1992-01-02 04:40:00+05:30
662	59	1992-02-01 04:40:00+05:30
663	59	1992-03-01 04:40:00+05:30
664	59	1992-04-01 04:40:00+05:30
665	59	1992-05-01 04:40:00+05:30
666	59	1992-06-01 04:40:00+05:30
667	59	1992-07-01 04:40:00+05:30
668	59	1992-08-01 04:40:00+05:30
669	59	1992-09-01 04:40:00+05:30
670	59	1992-10-01 04:40:00+05:30
671	59	1992-11-01 04:40:00+05:30
672	59	1992-12-01 04:40:00+05:30
673	59	1993-01-01 04:40:00+05:30
674	59	1993-02-01 04:40:00+05:30
675	59	1993-03-01 04:40:00+05:30
676	59	1993-04-01 04:40:00+05:30
677	59	1993-05-01 04:40:00+05:30
678	59	1993-06-01 04:40:00+05:30
679	59	1993-07-01 04:40:00+05:30
680	59	1993-08-01 04:40:00+05:30
681	59	1993-09-01 04:40:00+05:30
682	59	1993-10-01 04:40:00+05:30
683	59	1993-11-01 04:40:00+05:30
684	59	1993-12-01 04:40:00+05:30
685	59	1994-01-01 04:40:00+05:30
686	59	1994-02-01 04:40:00+05:30
687	59	1994-03-01 04:40:00+05:30
688	59	1994-04-01 04:40:00+05:30
689	59	1994-05-01 04:40:00+05:30
690	59	1994-06-01 04:40:00+05:30
691	59	1994-07-01 04:40:00+05:30
692	59	1994-08-01 04:40:00+05:30
693	59	1994-09-01 04:40:00+05:30
694	59	1994-10-01 04:40:00+05:30
695	59	1994-11-01 04:40:00+05:30
696	59	1994-12-01 04:40:00+05:30
697	59	1995-01-01 04:40:00+05:30
698	59	1995-02-01 04:40:00+05:30
699	59	1995-03-01 04:40:00+05:30
700	59	1995-04-01 04:40:00+05:30
701	59	1995-05-01 04:40:00+05:30
702	59	1995-06-01 04:40:00+05:30
703	59	1995-07-01 04:40:00+05:30
704	59	1995-08-01 04:40:00+05:30
705	59	1995-09-01 04:40:00+05:30
706	59	1995-10-01 04:40:00+05:30
707	59	1995-11-01 04:40:00+05:30
708	59	1995-12-01 04:40:00+05:30
709	59	1996-01-01 04:40:00+05:30
710	59	1996-02-01 04:40:00+05:30
711	59	1996-03-01 04:40:00+05:30
712	59	1996-04-01 04:40:00+05:30
713	59	1996-05-01 04:40:00+05:30
714	59	1996-06-01 04:40:00+05:30
715	59	1996-07-01 04:40:00+05:30
716	59	1996-08-01 04:40:00+05:30
717	59	1996-09-01 04:40:00+05:30
718	59	1996-10-01 04:40:00+05:30
719	59	1996-11-01 04:40:00+05:30
720	59	1996-12-01 04:40:00+05:30
721	59	1997-01-01 04:40:00+05:30
722	59	1997-02-01 04:40:00+05:30
723	59	1997-03-01 04:40:00+05:30
724	59	1997-04-01 04:40:00+05:30
725	59	1997-05-01 04:40:00+05:30
726	59	1997-06-01 04:40:00+05:30
727	59	1997-07-01 04:40:00+05:30
728	59	1997-08-01 04:40:00+05:30
729	59	1997-09-01 04:40:00+05:30
730	59	1997-10-01 04:40:00+05:30
731	59	1997-11-01 04:40:00+05:30
732	59	1997-12-01 04:40:00+05:30
733	59	1998-01-01 04:40:00+05:30
734	59	1998-02-01 04:40:00+05:30
735	59	1998-03-01 04:40:00+05:30
736	59	1998-04-01 04:40:00+05:30
737	59	1998-05-01 04:40:00+05:30
738	59	1998-06-01 04:40:00+05:30
739	59	1998-07-01 04:40:00+05:30
740	59	1998-08-01 04:40:00+05:30
741	59	1998-09-01 04:40:00+05:30
742	59	1998-10-01 04:40:00+05:30
743	59	1998-11-01 04:40:00+05:30
744	59	1998-12-01 04:40:00+05:30
745	59	1999-01-01 04:40:00+05:30
746	59	1999-02-01 04:40:00+05:30
747	59	1999-03-01 04:40:00+05:30
748	59	1999-04-01 04:40:00+05:30
749	59	1999-05-01 04:40:00+05:30
750	59	1999-06-01 04:40:00+05:30
751	59	1999-07-01 04:40:00+05:30
752	59	1999-08-01 04:40:00+05:30
753	59	1999-09-01 04:40:00+05:30
754	59	1999-10-01 04:40:00+05:30
755	59	1999-11-01 04:40:00+05:30
756	59	1999-12-01 04:40:00+05:30
757	59	2000-01-01 04:40:00+05:30
758	59	2000-02-01 04:40:00+05:30
759	59	2000-03-01 04:40:00+05:30
760	59	2000-04-01 04:40:00+05:30
761	59	2000-05-01 04:40:00+05:30
762	59	2000-06-01 04:40:00+05:30
763	59	2000-07-01 04:40:00+05:30
764	59	2000-08-01 04:40:00+05:30
765	59	2000-09-01 04:40:00+05:30
766	59	2000-10-01 04:40:00+05:30
767	59	2000-11-01 04:40:00+05:30
768	59	2000-12-01 04:40:00+05:30
769	59	2001-01-01 04:40:00+05:30
770	59	2001-02-01 04:40:00+05:30
771	59	2001-03-01 04:40:00+05:30
772	59	2001-04-01 04:40:00+05:30
773	59	2001-05-01 04:40:00+05:30
774	59	2001-06-01 04:40:00+05:30
775	59	2001-07-01 04:40:00+05:30
776	59	2001-08-01 04:40:00+05:30
777	59	2001-09-01 04:40:00+05:30
778	59	2001-10-01 04:40:00+05:30
779	59	2001-11-01 04:40:00+05:30
780	59	2001-12-01 04:40:00+05:30
781	59	2002-01-01 04:40:00+05:30
782	59	2002-02-01 04:40:00+05:30
783	59	2002-03-01 04:40:00+05:30
784	59	2002-04-01 04:40:00+05:30
785	59	2002-05-01 04:40:00+05:30
786	59	2002-06-01 04:40:00+05:30
787	59	2002-07-01 04:40:00+05:30
788	59	2002-08-01 04:40:00+05:30
789	59	2002-09-01 04:40:00+05:30
790	59	2002-10-01 04:40:00+05:30
791	59	2002-11-01 04:40:00+05:30
792	59	2002-12-01 04:40:00+05:30
793	60	1992-01-02 04:40:00+05:30
794	60	1992-02-01 04:40:00+05:30
795	60	1992-03-01 04:40:00+05:30
796	60	1992-04-01 04:40:00+05:30
797	60	1992-05-01 04:40:00+05:30
798	60	1992-06-01 04:40:00+05:30
799	60	1992-07-01 04:40:00+05:30
800	60	1992-08-01 04:40:00+05:30
801	60	1992-09-01 04:40:00+05:30
802	60	1992-10-01 04:40:00+05:30
803	60	1992-11-01 04:40:00+05:30
804	60	1992-12-01 04:40:00+05:30
805	60	1993-01-01 04:40:00+05:30
806	60	1993-02-01 04:40:00+05:30
807	60	1993-03-01 04:40:00+05:30
808	60	1993-04-01 04:40:00+05:30
809	60	1993-05-01 04:40:00+05:30
810	60	1993-06-01 04:40:00+05:30
811	60	1993-07-01 04:40:00+05:30
812	60	1993-08-01 04:40:00+05:30
813	60	1993-09-01 04:40:00+05:30
814	60	1993-10-01 04:40:00+05:30
815	60	1993-11-01 04:40:00+05:30
816	60	1993-12-01 04:40:00+05:30
817	60	1994-01-01 04:40:00+05:30
818	60	1994-02-01 04:40:00+05:30
819	60	1994-03-01 04:40:00+05:30
820	60	1994-04-01 04:40:00+05:30
821	60	1994-05-01 04:40:00+05:30
822	60	1994-06-01 04:40:00+05:30
823	60	1994-07-01 04:40:00+05:30
824	60	1994-08-01 04:40:00+05:30
825	60	1994-09-01 04:40:00+05:30
826	60	1994-10-01 04:40:00+05:30
827	60	1994-11-01 04:40:00+05:30
828	60	1994-12-01 04:40:00+05:30
829	60	1995-01-01 04:40:00+05:30
830	60	1995-02-01 04:40:00+05:30
831	60	1995-03-01 04:40:00+05:30
832	60	1995-04-01 04:40:00+05:30
833	60	1995-05-01 04:40:00+05:30
834	60	1995-06-01 04:40:00+05:30
835	60	1995-07-01 04:40:00+05:30
836	60	1995-08-01 04:40:00+05:30
837	60	1995-09-01 04:40:00+05:30
838	60	1995-10-01 04:40:00+05:30
839	60	1995-11-01 04:40:00+05:30
840	60	1995-12-01 04:40:00+05:30
841	60	1996-01-01 04:40:00+05:30
842	60	1996-02-01 04:40:00+05:30
843	60	1996-03-01 04:40:00+05:30
844	60	1996-04-01 04:40:00+05:30
845	60	1996-05-01 04:40:00+05:30
846	60	1996-06-01 04:40:00+05:30
847	60	1996-07-01 04:40:00+05:30
848	60	1996-08-01 04:40:00+05:30
849	60	1996-09-01 04:40:00+05:30
850	60	1996-10-01 04:40:00+05:30
851	60	1996-11-01 04:40:00+05:30
852	60	1996-12-01 04:40:00+05:30
853	60	1997-01-01 04:40:00+05:30
854	60	1997-02-01 04:40:00+05:30
855	60	1997-03-01 04:40:00+05:30
856	60	1997-04-01 04:40:00+05:30
857	60	1997-05-01 04:40:00+05:30
858	60	1997-06-01 04:40:00+05:30
859	60	1997-07-01 04:40:00+05:30
860	60	1997-08-01 04:40:00+05:30
861	60	1997-09-01 04:40:00+05:30
862	60	1997-10-01 04:40:00+05:30
863	60	1997-11-01 04:40:00+05:30
864	60	1997-12-01 04:40:00+05:30
865	60	1998-01-01 04:40:00+05:30
866	60	1998-02-01 04:40:00+05:30
867	60	1998-03-01 04:40:00+05:30
868	60	1998-04-01 04:40:00+05:30
869	60	1998-05-01 04:40:00+05:30
870	60	1998-06-01 04:40:00+05:30
871	60	1998-07-01 04:40:00+05:30
872	60	1998-08-01 04:40:00+05:30
873	60	1998-09-01 04:40:00+05:30
874	60	1998-10-01 04:40:00+05:30
875	60	1998-11-01 04:40:00+05:30
876	60	1998-12-01 04:40:00+05:30
877	60	1999-01-01 04:40:00+05:30
878	60	1999-02-01 04:40:00+05:30
879	60	1999-03-01 04:40:00+05:30
880	60	1999-04-01 04:40:00+05:30
881	60	1999-05-01 04:40:00+05:30
882	60	1999-06-01 04:40:00+05:30
883	60	1999-07-01 04:40:00+05:30
884	60	1999-08-01 04:40:00+05:30
885	60	1999-09-01 04:40:00+05:30
886	60	1999-10-01 04:40:00+05:30
887	60	1999-11-01 04:40:00+05:30
888	60	1999-12-01 04:40:00+05:30
889	60	2000-01-01 04:40:00+05:30
890	60	2000-02-01 04:40:00+05:30
891	60	2000-03-01 04:40:00+05:30
892	60	2000-04-01 04:40:00+05:30
893	60	2000-05-01 04:40:00+05:30
894	60	2000-06-01 04:40:00+05:30
895	60	2000-07-01 04:40:00+05:30
896	60	2000-08-01 04:40:00+05:30
897	60	2000-09-01 04:40:00+05:30
898	60	2000-10-01 04:40:00+05:30
899	60	2000-11-01 04:40:00+05:30
900	60	2000-12-01 04:40:00+05:30
901	60	2001-01-01 04:40:00+05:30
902	60	2001-02-01 04:40:00+05:30
903	60	2001-03-01 04:40:00+05:30
904	60	2001-04-01 04:40:00+05:30
905	60	2001-05-01 04:40:00+05:30
906	60	2001-06-01 04:40:00+05:30
907	60	2001-07-01 04:40:00+05:30
908	60	2001-08-01 04:40:00+05:30
909	60	2001-09-01 04:40:00+05:30
910	60	2001-10-01 04:40:00+05:30
911	60	2001-11-01 04:40:00+05:30
912	60	2001-12-01 04:40:00+05:30
913	60	2002-01-01 04:40:00+05:30
914	60	2002-02-01 04:40:00+05:30
915	60	2002-03-01 04:40:00+05:30
916	60	2002-04-01 04:40:00+05:30
917	60	2002-05-01 04:40:00+05:30
918	60	2002-06-01 04:40:00+05:30
919	60	2002-07-01 04:40:00+05:30
920	60	2002-08-01 04:40:00+05:30
921	60	2002-09-01 04:40:00+05:30
922	60	2002-10-01 04:40:00+05:30
923	60	2002-11-01 04:40:00+05:30
924	60	2002-12-01 04:40:00+05:30
925	62	1992-01-02 04:40:00+05:30
926	62	1992-02-01 04:40:00+05:30
927	62	1992-03-01 04:40:00+05:30
928	62	1992-04-01 04:40:00+05:30
929	62	1992-05-01 04:40:00+05:30
930	62	1992-06-01 04:40:00+05:30
931	62	1992-07-01 04:40:00+05:30
932	62	1992-08-01 04:40:00+05:30
933	62	1992-09-01 04:40:00+05:30
934	62	1992-10-01 04:40:00+05:30
935	62	1992-11-01 04:40:00+05:30
936	62	1992-12-01 04:40:00+05:30
937	62	1993-01-01 04:40:00+05:30
938	62	1993-02-01 04:40:00+05:30
939	62	1993-03-01 04:40:00+05:30
940	62	1993-04-01 04:40:00+05:30
941	62	1993-05-01 04:40:00+05:30
942	62	1993-06-01 04:40:00+05:30
943	62	1993-07-01 04:40:00+05:30
944	62	1993-08-01 04:40:00+05:30
945	62	1993-09-01 04:40:00+05:30
946	62	1993-10-01 04:40:00+05:30
947	62	1993-11-01 04:40:00+05:30
948	62	1993-12-01 04:40:00+05:30
949	62	1994-01-01 04:40:00+05:30
950	62	1994-02-01 04:40:00+05:30
951	62	1994-03-01 04:40:00+05:30
952	62	1994-04-01 04:40:00+05:30
953	62	1994-05-01 04:40:00+05:30
954	62	1994-06-01 04:40:00+05:30
955	62	1994-07-01 04:40:00+05:30
956	62	1994-08-01 04:40:00+05:30
957	62	1994-09-01 04:40:00+05:30
958	62	1994-10-01 04:40:00+05:30
959	62	1994-11-01 04:40:00+05:30
960	62	1994-12-01 04:40:00+05:30
961	62	1995-01-01 04:40:00+05:30
962	62	1995-02-01 04:40:00+05:30
963	62	1995-03-01 04:40:00+05:30
964	62	1995-04-01 04:40:00+05:30
965	62	1995-05-01 04:40:00+05:30
966	62	1995-06-01 04:40:00+05:30
967	62	1995-07-01 04:40:00+05:30
968	62	1995-08-01 04:40:00+05:30
969	62	1995-09-01 04:40:00+05:30
970	62	1995-10-01 04:40:00+05:30
971	62	1995-11-01 04:40:00+05:30
972	62	1995-12-01 04:40:00+05:30
973	62	1996-01-01 04:40:00+05:30
974	62	1996-02-01 04:40:00+05:30
975	62	1996-03-01 04:40:00+05:30
976	62	1996-04-01 04:40:00+05:30
977	62	1996-05-01 04:40:00+05:30
978	62	1996-06-01 04:40:00+05:30
979	62	1996-07-01 04:40:00+05:30
980	62	1996-08-01 04:40:00+05:30
981	62	1996-09-01 04:40:00+05:30
982	62	1996-10-01 04:40:00+05:30
983	62	1996-11-01 04:40:00+05:30
984	62	1996-12-01 04:40:00+05:30
985	62	1997-01-01 04:40:00+05:30
986	62	1997-02-01 04:40:00+05:30
987	62	1997-03-01 04:40:00+05:30
988	62	1997-04-01 04:40:00+05:30
989	62	1997-05-01 04:40:00+05:30
990	62	1997-06-01 04:40:00+05:30
991	62	1997-07-01 04:40:00+05:30
992	62	1997-08-01 04:40:00+05:30
993	62	1997-09-01 04:40:00+05:30
994	62	1997-10-01 04:40:00+05:30
995	62	1997-11-01 04:40:00+05:30
996	62	1997-12-01 04:40:00+05:30
997	62	1998-01-01 04:40:00+05:30
998	62	1998-02-01 04:40:00+05:30
999	62	1998-03-01 04:40:00+05:30
1000	62	1998-04-01 04:40:00+05:30
1001	62	1998-05-01 04:40:00+05:30
1002	62	1998-06-01 04:40:00+05:30
1003	62	1998-07-01 04:40:00+05:30
1004	62	1998-08-01 04:40:00+05:30
1005	62	1998-09-01 04:40:00+05:30
1006	62	1998-10-01 04:40:00+05:30
1007	62	1998-11-01 04:40:00+05:30
1008	62	1998-12-01 04:40:00+05:30
1009	62	1999-01-01 04:40:00+05:30
1010	62	1999-02-01 04:40:00+05:30
1011	62	1999-03-01 04:40:00+05:30
1012	62	1999-04-01 04:40:00+05:30
1013	62	1999-05-01 04:40:00+05:30
1014	62	1999-06-01 04:40:00+05:30
1015	62	1999-07-01 04:40:00+05:30
1016	62	1999-08-01 04:40:00+05:30
1017	62	1999-09-01 04:40:00+05:30
1018	62	1999-10-01 04:40:00+05:30
1019	62	1999-11-01 04:40:00+05:30
1020	62	1999-12-01 04:40:00+05:30
1021	62	2000-01-01 04:40:00+05:30
1022	62	2000-02-01 04:40:00+05:30
1023	62	2000-03-01 04:40:00+05:30
1024	62	2000-04-01 04:40:00+05:30
1025	62	2000-05-01 04:40:00+05:30
1026	62	2000-06-01 04:40:00+05:30
1027	62	2000-07-01 04:40:00+05:30
1028	62	2000-08-01 04:40:00+05:30
1029	62	2000-09-01 04:40:00+05:30
1030	62	2000-10-01 04:40:00+05:30
1031	62	2000-11-01 04:40:00+05:30
1032	62	2000-12-01 04:40:00+05:30
1033	62	2001-01-01 04:40:00+05:30
1034	62	2001-02-01 04:40:00+05:30
1035	62	2001-03-01 04:40:00+05:30
1036	62	2001-04-01 04:40:00+05:30
1037	62	2001-05-01 04:40:00+05:30
1038	62	2001-06-01 04:40:00+05:30
1039	62	2001-07-01 04:40:00+05:30
1040	62	2001-08-01 04:40:00+05:30
1041	62	2001-09-01 04:40:00+05:30
1042	62	2001-10-01 04:40:00+05:30
1043	62	2001-11-01 04:40:00+05:30
1044	62	2001-12-01 04:40:00+05:30
1045	62	2002-01-01 04:40:00+05:30
1046	62	2002-02-01 04:40:00+05:30
1047	62	2002-03-01 04:40:00+05:30
1048	62	2002-04-01 04:40:00+05:30
1049	62	2002-05-01 04:40:00+05:30
1050	62	2002-06-01 04:40:00+05:30
1051	62	2002-07-01 04:40:00+05:30
1052	62	2002-08-01 04:40:00+05:30
1053	62	2002-09-01 04:40:00+05:30
1054	62	2002-10-01 04:40:00+05:30
1055	62	2002-11-01 04:40:00+05:30
1056	62	2002-12-01 04:40:00+05:30
1057	61	1992-01-02 04:40:00+05:30
1058	61	1992-02-01 04:40:00+05:30
1059	61	1992-03-01 04:40:00+05:30
1060	61	1992-04-01 04:40:00+05:30
1061	61	1992-05-01 04:40:00+05:30
1062	61	1992-06-01 04:40:00+05:30
1063	61	1992-07-01 04:40:00+05:30
1064	61	1992-08-01 04:40:00+05:30
1065	61	1992-09-01 04:40:00+05:30
1066	61	1992-10-01 04:40:00+05:30
1067	61	1992-11-01 04:40:00+05:30
1068	61	1992-12-01 04:40:00+05:30
1069	61	1993-01-01 04:40:00+05:30
1070	61	1993-02-01 04:40:00+05:30
1071	61	1993-03-01 04:40:00+05:30
1072	61	1993-04-01 04:40:00+05:30
1073	61	1993-05-01 04:40:00+05:30
1074	61	1993-06-01 04:40:00+05:30
1075	61	1993-07-01 04:40:00+05:30
1076	61	1993-08-01 04:40:00+05:30
1077	61	1993-09-01 04:40:00+05:30
1078	61	1993-10-01 04:40:00+05:30
1079	61	1993-11-01 04:40:00+05:30
1080	61	1993-12-01 04:40:00+05:30
1081	61	1994-01-01 04:40:00+05:30
1082	61	1994-02-01 04:40:00+05:30
1083	61	1994-03-01 04:40:00+05:30
1084	61	1994-04-01 04:40:00+05:30
1085	61	1994-05-01 04:40:00+05:30
1086	61	1994-06-01 04:40:00+05:30
1087	61	1994-07-01 04:40:00+05:30
1088	61	1994-08-01 04:40:00+05:30
1089	61	1994-09-01 04:40:00+05:30
1090	61	1994-10-01 04:40:00+05:30
1091	61	1994-11-01 04:40:00+05:30
1092	61	1994-12-01 04:40:00+05:30
1093	61	1995-01-01 04:40:00+05:30
1094	61	1995-02-01 04:40:00+05:30
1095	61	1995-03-01 04:40:00+05:30
1096	61	1995-04-01 04:40:00+05:30
1097	61	1995-05-01 04:40:00+05:30
1098	61	1995-06-01 04:40:00+05:30
1099	61	1995-07-01 04:40:00+05:30
1100	61	1995-08-01 04:40:00+05:30
1101	61	1995-09-01 04:40:00+05:30
1102	61	1995-10-01 04:40:00+05:30
1103	61	1995-11-01 04:40:00+05:30
1104	61	1995-12-01 04:40:00+05:30
1105	61	1996-01-01 04:40:00+05:30
1106	61	1996-02-01 04:40:00+05:30
1107	61	1996-03-01 04:40:00+05:30
1108	61	1996-04-01 04:40:00+05:30
1109	61	1996-05-01 04:40:00+05:30
1110	61	1996-06-01 04:40:00+05:30
1111	61	1996-07-01 04:40:00+05:30
1112	61	1996-08-01 04:40:00+05:30
1113	61	1996-09-01 04:40:00+05:30
1114	61	1996-10-01 04:40:00+05:30
1115	61	1996-11-01 04:40:00+05:30
1116	61	1996-12-01 04:40:00+05:30
1117	61	1997-01-01 04:40:00+05:30
1118	61	1997-02-01 04:40:00+05:30
1119	61	1997-03-01 04:40:00+05:30
1120	61	1997-04-01 04:40:00+05:30
1121	61	1997-05-01 04:40:00+05:30
1122	61	1997-06-01 04:40:00+05:30
1123	61	1997-07-01 04:40:00+05:30
1124	61	1997-08-01 04:40:00+05:30
1125	61	1997-09-01 04:40:00+05:30
1126	61	1997-10-01 04:40:00+05:30
1127	61	1997-11-01 04:40:00+05:30
1128	61	1997-12-01 04:40:00+05:30
1129	61	1998-01-01 04:40:00+05:30
1130	61	1998-02-01 04:40:00+05:30
1131	61	1998-03-01 04:40:00+05:30
1132	61	1998-04-01 04:40:00+05:30
1133	61	1998-05-01 04:40:00+05:30
1134	61	1998-06-01 04:40:00+05:30
1135	61	1998-07-01 04:40:00+05:30
1136	61	1998-08-01 04:40:00+05:30
1137	61	1998-09-01 04:40:00+05:30
1138	61	1998-10-01 04:40:00+05:30
1139	61	1998-11-01 04:40:00+05:30
1140	61	1998-12-01 04:40:00+05:30
1141	61	1999-01-01 04:40:00+05:30
1142	61	1999-02-01 04:40:00+05:30
1143	61	1999-03-01 04:40:00+05:30
1144	61	1999-04-01 04:40:00+05:30
1145	61	1999-05-01 04:40:00+05:30
1146	61	1999-06-01 04:40:00+05:30
1147	61	1999-07-01 04:40:00+05:30
1148	61	1999-08-01 04:40:00+05:30
1149	61	1999-09-01 04:40:00+05:30
1150	61	1999-10-01 04:40:00+05:30
1151	61	1999-11-01 04:40:00+05:30
1152	61	1999-12-01 04:40:00+05:30
1153	61	2000-01-01 04:40:00+05:30
1154	61	2000-02-01 04:40:00+05:30
1155	61	2000-03-01 04:40:00+05:30
1156	61	2000-04-01 04:40:00+05:30
1157	61	2000-05-01 04:40:00+05:30
1158	61	2000-06-01 04:40:00+05:30
1159	61	2000-07-01 04:40:00+05:30
1160	61	2000-08-01 04:40:00+05:30
1161	61	2000-09-01 04:40:00+05:30
1162	61	2000-10-01 04:40:00+05:30
1163	61	2000-11-01 04:40:00+05:30
1164	61	2000-12-01 04:40:00+05:30
1165	61	2001-01-01 04:40:00+05:30
1166	61	2001-02-01 04:40:00+05:30
1167	61	2001-03-01 04:40:00+05:30
1168	61	2001-04-01 04:40:00+05:30
1169	61	2001-05-01 04:40:00+05:30
1170	61	2001-06-01 04:40:00+05:30
1171	61	2001-07-01 04:40:00+05:30
1172	61	2001-08-01 04:40:00+05:30
1173	61	2001-09-01 04:40:00+05:30
1174	61	2001-10-01 04:40:00+05:30
1175	61	2001-11-01 04:40:00+05:30
1176	61	2001-12-01 04:40:00+05:30
1177	61	2002-01-01 04:40:00+05:30
1178	61	2002-02-01 04:40:00+05:30
1179	61	2002-03-01 04:40:00+05:30
1180	61	2002-04-01 04:40:00+05:30
1181	61	2002-05-01 04:40:00+05:30
1182	61	2002-06-01 04:40:00+05:30
1183	61	2002-07-01 04:40:00+05:30
1184	61	2002-08-01 04:40:00+05:30
1185	61	2002-09-01 04:40:00+05:30
1186	61	2002-10-01 04:40:00+05:30
1187	61	2002-11-01 04:40:00+05:30
1188	61	2002-12-01 04:40:00+05:30
1189	63	1992-01-02 04:40:00+05:30
1190	63	1992-02-01 04:40:00+05:30
1191	63	1992-03-01 04:40:00+05:30
1192	63	1992-04-01 04:40:00+05:30
1193	63	1992-05-01 04:40:00+05:30
1194	63	1992-06-01 04:40:00+05:30
1195	63	1992-07-01 04:40:00+05:30
1196	63	1992-08-01 04:40:00+05:30
1197	63	1992-09-01 04:40:00+05:30
1198	63	1992-10-01 04:40:00+05:30
1199	63	1992-11-01 04:40:00+05:30
1200	63	1992-12-01 04:40:00+05:30
1201	63	1993-01-01 04:40:00+05:30
1202	63	1993-02-01 04:40:00+05:30
1203	63	1993-03-01 04:40:00+05:30
1204	63	1993-04-01 04:40:00+05:30
1205	63	1993-05-01 04:40:00+05:30
1206	63	1993-06-01 04:40:00+05:30
1207	63	1993-07-01 04:40:00+05:30
1208	63	1993-08-01 04:40:00+05:30
1209	63	1993-09-01 04:40:00+05:30
1210	63	1993-10-01 04:40:00+05:30
1211	63	1993-11-01 04:40:00+05:30
1212	63	1993-12-01 04:40:00+05:30
1213	63	1994-01-01 04:40:00+05:30
1214	63	1994-02-01 04:40:00+05:30
1215	63	1994-03-01 04:40:00+05:30
1216	63	1994-04-01 04:40:00+05:30
1217	63	1994-05-01 04:40:00+05:30
1218	63	1994-06-01 04:40:00+05:30
1219	63	1994-07-01 04:40:00+05:30
1220	63	1994-08-01 04:40:00+05:30
1221	63	1994-09-01 04:40:00+05:30
1222	63	1994-10-01 04:40:00+05:30
1223	63	1994-11-01 04:40:00+05:30
1224	63	1994-12-01 04:40:00+05:30
1225	63	1995-01-01 04:40:00+05:30
1226	63	1995-02-01 04:40:00+05:30
1227	63	1995-03-01 04:40:00+05:30
1228	63	1995-04-01 04:40:00+05:30
1229	63	1995-05-01 04:40:00+05:30
1230	63	1995-06-01 04:40:00+05:30
1231	63	1995-07-01 04:40:00+05:30
1232	63	1995-08-01 04:40:00+05:30
1233	63	1995-09-01 04:40:00+05:30
1234	63	1995-10-01 04:40:00+05:30
1235	63	1995-11-01 04:40:00+05:30
1236	63	1995-12-01 04:40:00+05:30
1237	63	1996-01-01 04:40:00+05:30
1238	63	1996-02-01 04:40:00+05:30
1239	63	1996-03-01 04:40:00+05:30
1240	63	1996-04-01 04:40:00+05:30
1241	63	1996-05-01 04:40:00+05:30
1242	63	1996-06-01 04:40:00+05:30
1243	63	1996-07-01 04:40:00+05:30
1244	63	1996-08-01 04:40:00+05:30
1245	63	1996-09-01 04:40:00+05:30
1246	63	1996-10-01 04:40:00+05:30
1247	63	1996-11-01 04:40:00+05:30
1248	63	1996-12-01 04:40:00+05:30
1249	63	1997-01-01 04:40:00+05:30
1250	63	1997-02-01 04:40:00+05:30
1251	63	1997-03-01 04:40:00+05:30
1252	63	1997-04-01 04:40:00+05:30
1253	63	1997-05-01 04:40:00+05:30
1254	63	1997-06-01 04:40:00+05:30
1255	63	1997-07-01 04:40:00+05:30
1256	63	1997-08-01 04:40:00+05:30
1257	63	1997-09-01 04:40:00+05:30
1258	63	1997-10-01 04:40:00+05:30
1259	63	1997-11-01 04:40:00+05:30
1260	63	1997-12-01 04:40:00+05:30
1261	63	1998-01-01 04:40:00+05:30
1262	63	1998-02-01 04:40:00+05:30
1263	63	1998-03-01 04:40:00+05:30
1264	63	1998-04-01 04:40:00+05:30
1265	63	1998-05-01 04:40:00+05:30
1266	63	1998-06-01 04:40:00+05:30
1267	63	1998-07-01 04:40:00+05:30
1268	63	1998-08-01 04:40:00+05:30
1269	63	1998-09-01 04:40:00+05:30
1270	63	1998-10-01 04:40:00+05:30
1271	63	1998-11-01 04:40:00+05:30
1272	63	1998-12-01 04:40:00+05:30
1273	63	1999-01-01 04:40:00+05:30
1274	63	1999-02-01 04:40:00+05:30
1275	63	1999-03-01 04:40:00+05:30
1276	63	1999-04-01 04:40:00+05:30
1277	63	1999-05-01 04:40:00+05:30
1278	63	1999-06-01 04:40:00+05:30
1279	63	1999-07-01 04:40:00+05:30
1280	63	1999-08-01 04:40:00+05:30
1281	63	1999-09-01 04:40:00+05:30
1282	63	1999-10-01 04:40:00+05:30
1283	63	1999-11-01 04:40:00+05:30
1284	63	1999-12-01 04:40:00+05:30
1285	63	2000-01-01 04:40:00+05:30
1286	63	2000-02-01 04:40:00+05:30
1287	63	2000-03-01 04:40:00+05:30
1288	63	2000-04-01 04:40:00+05:30
1289	63	2000-05-01 04:40:00+05:30
1290	63	2000-06-01 04:40:00+05:30
1291	63	2000-07-01 04:40:00+05:30
1292	63	2000-08-01 04:40:00+05:30
1293	63	2000-09-01 04:40:00+05:30
1294	63	2000-10-01 04:40:00+05:30
1295	63	2000-11-01 04:40:00+05:30
1296	63	2000-12-01 04:40:00+05:30
1297	63	2001-01-01 04:40:00+05:30
1298	63	2001-02-01 04:40:00+05:30
1299	63	2001-03-01 04:40:00+05:30
1300	63	2001-04-01 04:40:00+05:30
1301	63	2001-05-01 04:40:00+05:30
1302	63	2001-06-01 04:40:00+05:30
1303	63	2001-07-01 04:40:00+05:30
1304	63	2001-08-01 04:40:00+05:30
1305	63	2001-09-01 04:40:00+05:30
1306	63	2001-10-01 04:40:00+05:30
1307	63	2001-11-01 04:40:00+05:30
1308	63	2001-12-01 04:40:00+05:30
1309	63	2002-01-01 04:40:00+05:30
1310	63	2002-02-01 04:40:00+05:30
1311	63	2002-03-01 04:40:00+05:30
1312	63	2002-04-01 04:40:00+05:30
1313	63	2002-05-01 04:40:00+05:30
1314	63	2002-06-01 04:40:00+05:30
1315	63	2002-07-01 04:40:00+05:30
1316	63	2002-08-01 04:40:00+05:30
1317	63	2002-09-01 04:40:00+05:30
1318	63	2002-10-01 04:40:00+05:30
1319	63	2002-11-01 04:40:00+05:30
1320	63	2002-12-01 04:40:00+05:30
1321	64	1992-01-02 04:40:00+05:30
1322	64	1992-02-01 04:40:00+05:30
1323	64	1992-03-01 04:40:00+05:30
1324	64	1992-04-01 04:40:00+05:30
1325	64	1992-05-01 04:40:00+05:30
1326	64	1992-06-01 04:40:00+05:30
1327	64	1992-07-01 04:40:00+05:30
1328	64	1992-08-01 04:40:00+05:30
1329	64	1992-09-01 04:40:00+05:30
1330	64	1992-10-01 04:40:00+05:30
1331	64	1992-11-01 04:40:00+05:30
1332	64	1992-12-01 04:40:00+05:30
1333	64	1993-01-01 04:40:00+05:30
1334	64	1993-02-01 04:40:00+05:30
1335	64	1993-03-01 04:40:00+05:30
1336	64	1993-04-01 04:40:00+05:30
1337	64	1993-05-01 04:40:00+05:30
1338	64	1993-06-01 04:40:00+05:30
1339	64	1993-07-01 04:40:00+05:30
1340	64	1993-08-01 04:40:00+05:30
1341	64	1993-09-01 04:40:00+05:30
1342	64	1993-10-01 04:40:00+05:30
1343	64	1993-11-01 04:40:00+05:30
1344	64	1993-12-01 04:40:00+05:30
1345	64	1994-01-01 04:40:00+05:30
1346	64	1994-02-01 04:40:00+05:30
1347	64	1994-03-01 04:40:00+05:30
1348	64	1994-04-01 04:40:00+05:30
1349	64	1994-05-01 04:40:00+05:30
1350	64	1994-06-01 04:40:00+05:30
1351	64	1994-07-01 04:40:00+05:30
1352	64	1994-08-01 04:40:00+05:30
1353	64	1994-09-01 04:40:00+05:30
1354	64	1994-10-01 04:40:00+05:30
1355	64	1994-11-01 04:40:00+05:30
1356	64	1994-12-01 04:40:00+05:30
1357	64	1995-01-01 04:40:00+05:30
1358	64	1995-02-01 04:40:00+05:30
1359	64	1995-03-01 04:40:00+05:30
1360	64	1995-04-01 04:40:00+05:30
1361	64	1995-05-01 04:40:00+05:30
1362	64	1995-06-01 04:40:00+05:30
1363	64	1995-07-01 04:40:00+05:30
1364	64	1995-08-01 04:40:00+05:30
1365	64	1995-09-01 04:40:00+05:30
1366	64	1995-10-01 04:40:00+05:30
1367	64	1995-11-01 04:40:00+05:30
1368	64	1995-12-01 04:40:00+05:30
1369	64	1996-01-01 04:40:00+05:30
1370	64	1996-02-01 04:40:00+05:30
1371	64	1996-03-01 04:40:00+05:30
1372	64	1996-04-01 04:40:00+05:30
1373	64	1996-05-01 04:40:00+05:30
1374	64	1996-06-01 04:40:00+05:30
1375	64	1996-07-01 04:40:00+05:30
1376	64	1996-08-01 04:40:00+05:30
1377	64	1996-09-01 04:40:00+05:30
1378	64	1996-10-01 04:40:00+05:30
1379	64	1996-11-01 04:40:00+05:30
1380	64	1996-12-01 04:40:00+05:30
1381	64	1997-01-01 04:40:00+05:30
1382	64	1997-02-01 04:40:00+05:30
1383	64	1997-03-01 04:40:00+05:30
1384	64	1997-04-01 04:40:00+05:30
1385	64	1997-05-01 04:40:00+05:30
1386	64	1997-06-01 04:40:00+05:30
1387	64	1997-07-01 04:40:00+05:30
1388	64	1997-08-01 04:40:00+05:30
1389	64	1997-09-01 04:40:00+05:30
1390	64	1997-10-01 04:40:00+05:30
1391	64	1997-11-01 04:40:00+05:30
1392	64	1997-12-01 04:40:00+05:30
1393	64	1998-01-01 04:40:00+05:30
1394	64	1998-02-01 04:40:00+05:30
1395	64	1998-03-01 04:40:00+05:30
1396	64	1998-04-01 04:40:00+05:30
1397	64	1998-05-01 04:40:00+05:30
1398	64	1998-06-01 04:40:00+05:30
1399	64	1998-07-01 04:40:00+05:30
1400	64	1998-08-01 04:40:00+05:30
1401	64	1998-09-01 04:40:00+05:30
1402	64	1998-10-01 04:40:00+05:30
1403	64	1998-11-01 04:40:00+05:30
1404	64	1998-12-01 04:40:00+05:30
1405	64	1999-01-01 04:40:00+05:30
1406	64	1999-02-01 04:40:00+05:30
1407	64	1999-03-01 04:40:00+05:30
1408	64	1999-04-01 04:40:00+05:30
1409	64	1999-05-01 04:40:00+05:30
1410	64	1999-06-01 04:40:00+05:30
1411	64	1999-07-01 04:40:00+05:30
1412	64	1999-08-01 04:40:00+05:30
1413	64	1999-09-01 04:40:00+05:30
1414	64	1999-10-01 04:40:00+05:30
1415	64	1999-11-01 04:40:00+05:30
1416	64	1999-12-01 04:40:00+05:30
1417	64	2000-01-01 04:40:00+05:30
1418	64	2000-02-01 04:40:00+05:30
1419	64	2000-03-01 04:40:00+05:30
1420	64	2000-04-01 04:40:00+05:30
1421	64	2000-05-01 04:40:00+05:30
1422	64	2000-06-01 04:40:00+05:30
1423	64	2000-07-01 04:40:00+05:30
1424	64	2000-08-01 04:40:00+05:30
1425	64	2000-09-01 04:40:00+05:30
1426	64	2000-10-01 04:40:00+05:30
1427	64	2000-11-01 04:40:00+05:30
1428	64	2000-12-01 04:40:00+05:30
1429	64	2001-01-01 04:40:00+05:30
1430	64	2001-02-01 04:40:00+05:30
1431	64	2001-03-01 04:40:00+05:30
1432	64	2001-04-01 04:40:00+05:30
1433	64	2001-05-01 04:40:00+05:30
1434	64	2001-06-01 04:40:00+05:30
1435	64	2001-07-01 04:40:00+05:30
1436	64	2001-08-01 04:40:00+05:30
1437	64	2001-09-01 04:40:00+05:30
1438	64	2001-10-01 04:40:00+05:30
1439	64	2001-11-01 04:40:00+05:30
1440	64	2001-12-01 04:40:00+05:30
1441	64	2002-01-01 04:40:00+05:30
1442	64	2002-02-01 04:40:00+05:30
1443	64	2002-03-01 04:40:00+05:30
1444	64	2002-04-01 04:40:00+05:30
1445	64	2002-05-01 04:40:00+05:30
1446	64	2002-06-01 04:40:00+05:30
1447	64	2002-07-01 04:40:00+05:30
1448	64	2002-08-01 04:40:00+05:30
1449	64	2002-09-01 04:40:00+05:30
1450	64	2002-10-01 04:40:00+05:30
1451	64	2002-11-01 04:40:00+05:30
1452	64	2002-12-01 04:40:00+05:30
1453	65	1992-01-02 04:40:00+05:30
1454	65	1992-02-01 04:40:00+05:30
1455	65	1992-03-01 04:40:00+05:30
1456	65	1992-04-01 04:40:00+05:30
1457	65	1992-05-01 04:40:00+05:30
1458	65	1992-06-01 04:40:00+05:30
1459	65	1992-07-01 04:40:00+05:30
1460	65	1992-08-01 04:40:00+05:30
1461	65	1992-09-01 04:40:00+05:30
1462	65	1992-10-01 04:40:00+05:30
1463	65	1992-11-01 04:40:00+05:30
1464	65	1992-12-01 04:40:00+05:30
1465	65	1993-01-01 04:40:00+05:30
1466	65	1993-02-01 04:40:00+05:30
1467	65	1993-03-01 04:40:00+05:30
1468	65	1993-04-01 04:40:00+05:30
1469	65	1993-05-01 04:40:00+05:30
1470	65	1993-06-01 04:40:00+05:30
1471	65	1993-07-01 04:40:00+05:30
1472	65	1993-08-01 04:40:00+05:30
1473	65	1993-09-01 04:40:00+05:30
1474	65	1993-10-01 04:40:00+05:30
1475	65	1993-11-01 04:40:00+05:30
1476	65	1993-12-01 04:40:00+05:30
1477	65	1994-01-01 04:40:00+05:30
1478	65	1994-02-01 04:40:00+05:30
1479	65	1994-03-01 04:40:00+05:30
1480	65	1994-04-01 04:40:00+05:30
1481	65	1994-05-01 04:40:00+05:30
1482	65	1994-06-01 04:40:00+05:30
1483	65	1994-07-01 04:40:00+05:30
1484	65	1994-08-01 04:40:00+05:30
1485	65	1994-09-01 04:40:00+05:30
1486	65	1994-10-01 04:40:00+05:30
1487	65	1994-11-01 04:40:00+05:30
1488	65	1994-12-01 04:40:00+05:30
1489	65	1995-01-01 04:40:00+05:30
1490	65	1995-02-01 04:40:00+05:30
1491	65	1995-03-01 04:40:00+05:30
1492	65	1995-04-01 04:40:00+05:30
1493	65	1995-05-01 04:40:00+05:30
1494	65	1995-06-01 04:40:00+05:30
1495	65	1995-07-01 04:40:00+05:30
1496	65	1995-08-01 04:40:00+05:30
1497	65	1995-09-01 04:40:00+05:30
1498	65	1995-10-01 04:40:00+05:30
1499	65	1995-11-01 04:40:00+05:30
1500	65	1995-12-01 04:40:00+05:30
1501	65	1996-01-01 04:40:00+05:30
1502	65	1996-02-01 04:40:00+05:30
1503	65	1996-03-01 04:40:00+05:30
1504	65	1996-04-01 04:40:00+05:30
1505	65	1996-05-01 04:40:00+05:30
1506	65	1996-06-01 04:40:00+05:30
1507	65	1996-07-01 04:40:00+05:30
1508	65	1996-08-01 04:40:00+05:30
1509	65	1996-09-01 04:40:00+05:30
1510	65	1996-10-01 04:40:00+05:30
1511	65	1996-11-01 04:40:00+05:30
1512	65	1996-12-01 04:40:00+05:30
1513	65	1997-01-01 04:40:00+05:30
1514	65	1997-02-01 04:40:00+05:30
1515	65	1997-03-01 04:40:00+05:30
1516	65	1997-04-01 04:40:00+05:30
1517	65	1997-05-01 04:40:00+05:30
1518	65	1997-06-01 04:40:00+05:30
1519	65	1997-07-01 04:40:00+05:30
1520	65	1997-08-01 04:40:00+05:30
1521	65	1997-09-01 04:40:00+05:30
1522	65	1997-10-01 04:40:00+05:30
1523	65	1997-11-01 04:40:00+05:30
1524	65	1997-12-01 04:40:00+05:30
1525	65	1998-01-01 04:40:00+05:30
1526	65	1998-02-01 04:40:00+05:30
1527	65	1998-03-01 04:40:00+05:30
1528	65	1998-04-01 04:40:00+05:30
1529	65	1998-05-01 04:40:00+05:30
1530	65	1998-06-01 04:40:00+05:30
1531	65	1998-07-01 04:40:00+05:30
1532	65	1998-08-01 04:40:00+05:30
1533	65	1998-09-01 04:40:00+05:30
1534	65	1998-10-01 04:40:00+05:30
1535	65	1998-11-01 04:40:00+05:30
1536	65	1998-12-01 04:40:00+05:30
1537	65	1999-01-01 04:40:00+05:30
1538	65	1999-02-01 04:40:00+05:30
1539	65	1999-03-01 04:40:00+05:30
1540	65	1999-04-01 04:40:00+05:30
1541	65	1999-05-01 04:40:00+05:30
1542	65	1999-06-01 04:40:00+05:30
1543	65	1999-07-01 04:40:00+05:30
1544	65	1999-08-01 04:40:00+05:30
1545	65	1999-09-01 04:40:00+05:30
1546	65	1999-10-01 04:40:00+05:30
1547	65	1999-11-01 04:40:00+05:30
1548	65	1999-12-01 04:40:00+05:30
1549	65	2000-01-01 04:40:00+05:30
1550	65	2000-02-01 04:40:00+05:30
1551	65	2000-03-01 04:40:00+05:30
1552	65	2000-04-01 04:40:00+05:30
1553	65	2000-05-01 04:40:00+05:30
1554	65	2000-06-01 04:40:00+05:30
1555	65	2000-07-01 04:40:00+05:30
1556	65	2000-08-01 04:40:00+05:30
1557	65	2000-09-01 04:40:00+05:30
1558	65	2000-10-01 04:40:00+05:30
1559	65	2000-11-01 04:40:00+05:30
1560	65	2000-12-01 04:40:00+05:30
1561	65	2001-01-01 04:40:00+05:30
1562	65	2001-02-01 04:40:00+05:30
1563	65	2001-03-01 04:40:00+05:30
1564	65	2001-04-01 04:40:00+05:30
1565	65	2001-05-01 04:40:00+05:30
1566	65	2001-06-01 04:40:00+05:30
1567	65	2001-07-01 04:40:00+05:30
1568	65	2001-08-01 04:40:00+05:30
1569	65	2001-09-01 04:40:00+05:30
1570	65	2001-10-01 04:40:00+05:30
1571	65	2001-11-01 04:40:00+05:30
1572	65	2001-12-01 04:40:00+05:30
1573	65	2002-01-01 04:40:00+05:30
1574	65	2002-02-01 04:40:00+05:30
1575	65	2002-03-01 04:40:00+05:30
1576	65	2002-04-01 04:40:00+05:30
1577	65	2002-05-01 04:40:00+05:30
1578	65	2002-06-01 04:40:00+05:30
1579	65	2002-07-01 04:40:00+05:30
1580	65	2002-08-01 04:40:00+05:30
1581	65	2002-09-01 04:40:00+05:30
1582	65	2002-10-01 04:40:00+05:30
1583	65	2002-11-01 04:40:00+05:30
1584	65	2002-12-01 04:40:00+05:30
1585	66	1992-01-02 04:40:00+05:30
1586	66	1992-02-01 04:40:00+05:30
1587	66	1992-03-01 04:40:00+05:30
1588	66	1992-04-01 04:40:00+05:30
1589	66	1992-05-01 04:40:00+05:30
1590	66	1992-06-01 04:40:00+05:30
1591	66	1992-07-01 04:40:00+05:30
1592	66	1992-08-01 04:40:00+05:30
1593	66	1992-09-01 04:40:00+05:30
1594	66	1992-10-01 04:40:00+05:30
1595	66	1992-11-01 04:40:00+05:30
1596	66	1992-12-01 04:40:00+05:30
1597	66	1993-01-01 04:40:00+05:30
1598	66	1993-02-01 04:40:00+05:30
1599	66	1993-03-01 04:40:00+05:30
1600	66	1993-04-01 04:40:00+05:30
1601	66	1993-05-01 04:40:00+05:30
1602	66	1993-06-01 04:40:00+05:30
1603	66	1993-07-01 04:40:00+05:30
1604	66	1993-08-01 04:40:00+05:30
1605	66	1993-09-01 04:40:00+05:30
1606	66	1993-10-01 04:40:00+05:30
1607	66	1993-11-01 04:40:00+05:30
1608	66	1993-12-01 04:40:00+05:30
1609	66	1994-01-01 04:40:00+05:30
1610	66	1994-02-01 04:40:00+05:30
1611	66	1994-03-01 04:40:00+05:30
1612	66	1994-04-01 04:40:00+05:30
1613	66	1994-05-01 04:40:00+05:30
1614	66	1994-06-01 04:40:00+05:30
1615	66	1994-07-01 04:40:00+05:30
1616	66	1994-08-01 04:40:00+05:30
1617	66	1994-09-01 04:40:00+05:30
1618	66	1994-10-01 04:40:00+05:30
1619	66	1994-11-01 04:40:00+05:30
1620	66	1994-12-01 04:40:00+05:30
1621	66	1995-01-01 04:40:00+05:30
1622	66	1995-02-01 04:40:00+05:30
1623	66	1995-03-01 04:40:00+05:30
1624	66	1995-04-01 04:40:00+05:30
1625	66	1995-05-01 04:40:00+05:30
1626	66	1995-06-01 04:40:00+05:30
1627	66	1995-07-01 04:40:00+05:30
1628	66	1995-08-01 04:40:00+05:30
1629	66	1995-09-01 04:40:00+05:30
1630	66	1995-10-01 04:40:00+05:30
1631	66	1995-11-01 04:40:00+05:30
1632	66	1995-12-01 04:40:00+05:30
1633	66	1996-01-01 04:40:00+05:30
1634	66	1996-02-01 04:40:00+05:30
1635	66	1996-03-01 04:40:00+05:30
1636	66	1996-04-01 04:40:00+05:30
1637	66	1996-05-01 04:40:00+05:30
1638	66	1996-06-01 04:40:00+05:30
1639	66	1996-07-01 04:40:00+05:30
1640	66	1996-08-01 04:40:00+05:30
1641	66	1996-09-01 04:40:00+05:30
1642	66	1996-10-01 04:40:00+05:30
1643	66	1996-11-01 04:40:00+05:30
1644	66	1996-12-01 04:40:00+05:30
1645	66	1997-01-01 04:40:00+05:30
1646	66	1997-02-01 04:40:00+05:30
1647	66	1997-03-01 04:40:00+05:30
1648	66	1997-04-01 04:40:00+05:30
1649	66	1997-05-01 04:40:00+05:30
1650	66	1997-06-01 04:40:00+05:30
1651	66	1997-07-01 04:40:00+05:30
1652	66	1997-08-01 04:40:00+05:30
1653	66	1997-09-01 04:40:00+05:30
1654	66	1997-10-01 04:40:00+05:30
1655	66	1997-11-01 04:40:00+05:30
1656	66	1997-12-01 04:40:00+05:30
1657	66	1998-01-01 04:40:00+05:30
1658	66	1998-02-01 04:40:00+05:30
1659	66	1998-03-01 04:40:00+05:30
1660	66	1998-04-01 04:40:00+05:30
1661	66	1998-05-01 04:40:00+05:30
1662	66	1998-06-01 04:40:00+05:30
1663	66	1998-07-01 04:40:00+05:30
1664	66	1998-08-01 04:40:00+05:30
1665	66	1998-09-01 04:40:00+05:30
1666	66	1998-10-01 04:40:00+05:30
1667	66	1998-11-01 04:40:00+05:30
1668	66	1998-12-01 04:40:00+05:30
1669	66	1999-01-01 04:40:00+05:30
1670	66	1999-02-01 04:40:00+05:30
1671	66	1999-03-01 04:40:00+05:30
1672	66	1999-04-01 04:40:00+05:30
1673	66	1999-05-01 04:40:00+05:30
1674	66	1999-06-01 04:40:00+05:30
1675	66	1999-07-01 04:40:00+05:30
1676	66	1999-08-01 04:40:00+05:30
1677	66	1999-09-01 04:40:00+05:30
1678	66	1999-10-01 04:40:00+05:30
1679	66	1999-11-01 04:40:00+05:30
1680	66	1999-12-01 04:40:00+05:30
1681	66	2000-01-01 04:40:00+05:30
1682	66	2000-02-01 04:40:00+05:30
1683	66	2000-03-01 04:40:00+05:30
1684	66	2000-04-01 04:40:00+05:30
1685	66	2000-05-01 04:40:00+05:30
1686	66	2000-06-01 04:40:00+05:30
1687	66	2000-07-01 04:40:00+05:30
1688	66	2000-08-01 04:40:00+05:30
1689	66	2000-09-01 04:40:00+05:30
1690	66	2000-10-01 04:40:00+05:30
1691	66	2000-11-01 04:40:00+05:30
1692	66	2000-12-01 04:40:00+05:30
1693	66	2001-01-01 04:40:00+05:30
1694	66	2001-02-01 04:40:00+05:30
1695	66	2001-03-01 04:40:00+05:30
1696	66	2001-04-01 04:40:00+05:30
1697	66	2001-05-01 04:40:00+05:30
1698	66	2001-06-01 04:40:00+05:30
1699	66	2001-07-01 04:40:00+05:30
1700	66	2001-08-01 04:40:00+05:30
1701	66	2001-09-01 04:40:00+05:30
1702	66	2001-10-01 04:40:00+05:30
1703	66	2001-11-01 04:40:00+05:30
1704	66	2001-12-01 04:40:00+05:30
1705	66	2002-01-01 04:40:00+05:30
1706	66	2002-02-01 04:40:00+05:30
1707	66	2002-03-01 04:40:00+05:30
1708	66	2002-04-01 04:40:00+05:30
1709	66	2002-05-01 04:40:00+05:30
1710	66	2002-06-01 04:40:00+05:30
1711	66	2002-07-01 04:40:00+05:30
1712	66	2002-08-01 04:40:00+05:30
1713	66	2002-09-01 04:40:00+05:30
1714	66	2002-10-01 04:40:00+05:30
1715	66	2002-11-01 04:40:00+05:30
1716	66	2002-12-01 04:40:00+05:30
1717	29	1992-01-02 04:40:00+05:30
1718	29	1992-02-01 04:40:00+05:30
1719	29	1992-03-01 04:40:00+05:30
1720	29	1992-04-01 04:40:00+05:30
1721	29	1992-05-01 04:40:00+05:30
1722	29	1992-06-01 04:40:00+05:30
1723	29	1992-07-01 04:40:00+05:30
1724	29	1992-08-01 04:40:00+05:30
1725	29	1992-09-01 04:40:00+05:30
1726	29	1992-10-01 04:40:00+05:30
1727	29	1992-11-01 04:40:00+05:30
1728	29	1992-12-01 04:40:00+05:30
1729	29	1993-01-01 04:40:00+05:30
1730	29	1993-02-01 04:40:00+05:30
1731	29	1993-03-01 04:40:00+05:30
1732	29	1993-04-01 04:40:00+05:30
1733	29	1993-05-01 04:40:00+05:30
1734	29	1993-06-01 04:40:00+05:30
1735	29	1993-07-01 04:40:00+05:30
1736	29	1993-08-01 04:40:00+05:30
1737	29	1993-09-01 04:40:00+05:30
1738	29	1993-10-01 04:40:00+05:30
1739	29	1993-11-01 04:40:00+05:30
1740	29	1993-12-01 04:40:00+05:30
1741	29	1994-01-01 04:40:00+05:30
1742	29	1994-02-01 04:40:00+05:30
1743	29	1994-03-01 04:40:00+05:30
1744	29	1994-04-01 04:40:00+05:30
1745	29	1994-05-01 04:40:00+05:30
1746	29	1994-06-01 04:40:00+05:30
1747	29	1994-07-01 04:40:00+05:30
1748	29	1994-08-01 04:40:00+05:30
1749	29	1994-09-01 04:40:00+05:30
1750	29	1994-10-01 04:40:00+05:30
1751	29	1994-11-01 04:40:00+05:30
1752	29	1994-12-01 04:40:00+05:30
1753	29	1995-01-01 04:40:00+05:30
1754	29	1995-02-01 04:40:00+05:30
1755	29	1995-03-01 04:40:00+05:30
1756	29	1995-04-01 04:40:00+05:30
1757	29	1995-05-01 04:40:00+05:30
1758	29	1995-06-01 04:40:00+05:30
1759	29	1995-07-01 04:40:00+05:30
1760	29	1995-08-01 04:40:00+05:30
1761	29	1995-09-01 04:40:00+05:30
1762	29	1995-10-01 04:40:00+05:30
1763	29	1995-11-01 04:40:00+05:30
1764	29	1995-12-01 04:40:00+05:30
1765	29	1996-01-01 04:40:00+05:30
1766	29	1996-02-01 04:40:00+05:30
1767	29	1996-03-01 04:40:00+05:30
1768	29	1996-04-01 04:40:00+05:30
1769	29	1996-05-01 04:40:00+05:30
1770	29	1996-06-01 04:40:00+05:30
1771	29	1996-07-01 04:40:00+05:30
1772	29	1996-08-01 04:40:00+05:30
1773	29	1996-09-01 04:40:00+05:30
1774	29	1996-10-01 04:40:00+05:30
1775	29	1996-11-01 04:40:00+05:30
1776	29	1996-12-01 04:40:00+05:30
1777	29	1997-01-01 04:40:00+05:30
1778	29	1997-02-01 04:40:00+05:30
1779	29	1997-03-01 04:40:00+05:30
1780	29	1997-04-01 04:40:00+05:30
1781	29	1997-05-01 04:40:00+05:30
1782	29	1997-06-01 04:40:00+05:30
1783	29	1997-07-01 04:40:00+05:30
1784	29	1997-08-01 04:40:00+05:30
1785	29	1997-09-01 04:40:00+05:30
1786	29	1997-10-01 04:40:00+05:30
1787	29	1997-11-01 04:40:00+05:30
1788	29	1997-12-01 04:40:00+05:30
1789	29	1998-01-01 04:40:00+05:30
1790	29	1998-02-01 04:40:00+05:30
1791	29	1998-03-01 04:40:00+05:30
1792	29	1998-04-01 04:40:00+05:30
1793	29	1998-05-01 04:40:00+05:30
1794	29	1998-06-01 04:40:00+05:30
1795	29	1998-07-01 04:40:00+05:30
1796	29	1998-08-01 04:40:00+05:30
1797	29	1998-09-01 04:40:00+05:30
1798	29	1998-10-01 04:40:00+05:30
1799	29	1998-11-01 04:40:00+05:30
1800	29	1998-12-01 04:40:00+05:30
1801	29	1999-01-01 04:40:00+05:30
1802	29	1999-02-01 04:40:00+05:30
1803	29	1999-03-01 04:40:00+05:30
1804	29	1999-04-01 04:40:00+05:30
1805	29	1999-05-01 04:40:00+05:30
1806	29	1999-06-01 04:40:00+05:30
1807	29	1999-07-01 04:40:00+05:30
1808	29	1999-08-01 04:40:00+05:30
1809	29	1999-09-01 04:40:00+05:30
1810	29	1999-10-01 04:40:00+05:30
1811	29	1999-11-01 04:40:00+05:30
1812	29	1999-12-01 04:40:00+05:30
1813	29	2000-01-01 04:40:00+05:30
1814	29	2000-02-01 04:40:00+05:30
1815	29	2000-03-01 04:40:00+05:30
1816	29	2000-04-01 04:40:00+05:30
1817	29	2000-05-01 04:40:00+05:30
1818	29	2000-06-01 04:40:00+05:30
1819	29	2000-07-01 04:40:00+05:30
1820	29	2000-08-01 04:40:00+05:30
1821	29	2000-09-01 04:40:00+05:30
1822	29	2000-10-01 04:40:00+05:30
1823	29	2000-11-01 04:40:00+05:30
1824	29	2000-12-01 04:40:00+05:30
1825	29	2001-01-01 04:40:00+05:30
1826	29	2001-02-01 04:40:00+05:30
1827	29	2001-03-01 04:40:00+05:30
1828	29	2001-04-01 04:40:00+05:30
1829	29	2001-05-01 04:40:00+05:30
1830	29	2001-06-01 04:40:00+05:30
1831	29	2001-07-01 04:40:00+05:30
1832	29	2001-08-01 04:40:00+05:30
1833	29	2001-09-01 04:40:00+05:30
1834	29	2001-10-01 04:40:00+05:30
1835	29	2001-11-01 04:40:00+05:30
1836	29	2001-12-01 04:40:00+05:30
1837	29	2002-01-01 04:40:00+05:30
1838	29	2002-02-01 04:40:00+05:30
1839	29	2002-03-01 04:40:00+05:30
1840	29	2002-04-01 04:40:00+05:30
1841	29	2002-05-01 04:40:00+05:30
1842	29	2002-06-01 04:40:00+05:30
1843	29	2002-07-01 04:40:00+05:30
1844	29	2002-08-01 04:40:00+05:30
1845	29	2002-09-01 04:40:00+05:30
1846	29	2002-10-01 04:40:00+05:30
1847	29	2002-11-01 04:40:00+05:30
1848	29	2002-12-01 04:40:00+05:30
1849	30	1992-01-02 04:40:00+05:30
1850	30	1992-02-01 04:40:00+05:30
1851	30	1992-03-01 04:40:00+05:30
1852	30	1992-04-01 04:40:00+05:30
1853	30	1992-05-01 04:40:00+05:30
1854	30	1992-06-01 04:40:00+05:30
1855	30	1992-07-01 04:40:00+05:30
1856	30	1992-08-01 04:40:00+05:30
1857	30	1992-09-01 04:40:00+05:30
1858	30	1992-10-01 04:40:00+05:30
1859	30	1992-11-01 04:40:00+05:30
1860	30	1992-12-01 04:40:00+05:30
1861	30	1993-01-01 04:40:00+05:30
1862	30	1993-02-01 04:40:00+05:30
1863	30	1993-03-01 04:40:00+05:30
1864	30	1993-04-01 04:40:00+05:30
1865	30	1993-05-01 04:40:00+05:30
1866	30	1993-06-01 04:40:00+05:30
1867	30	1993-07-01 04:40:00+05:30
1868	30	1993-08-01 04:40:00+05:30
1869	30	1993-09-01 04:40:00+05:30
1870	30	1993-10-01 04:40:00+05:30
1871	30	1993-11-01 04:40:00+05:30
1872	30	1993-12-01 04:40:00+05:30
1873	30	1994-01-01 04:40:00+05:30
1874	30	1994-02-01 04:40:00+05:30
1875	30	1994-03-01 04:40:00+05:30
1876	30	1994-04-01 04:40:00+05:30
1877	30	1994-05-01 04:40:00+05:30
1878	30	1994-06-01 04:40:00+05:30
1879	30	1994-07-01 04:40:00+05:30
1880	30	1994-08-01 04:40:00+05:30
1881	30	1994-09-01 04:40:00+05:30
1882	30	1994-10-01 04:40:00+05:30
1883	30	1994-11-01 04:40:00+05:30
1884	30	1994-12-01 04:40:00+05:30
1885	30	1995-01-01 04:40:00+05:30
1886	30	1995-02-01 04:40:00+05:30
1887	30	1995-03-01 04:40:00+05:30
1888	30	1995-04-01 04:40:00+05:30
1889	30	1995-05-01 04:40:00+05:30
1890	30	1995-06-01 04:40:00+05:30
1891	30	1995-07-01 04:40:00+05:30
1892	30	1995-08-01 04:40:00+05:30
1893	30	1995-09-01 04:40:00+05:30
1894	30	1995-10-01 04:40:00+05:30
1895	30	1995-11-01 04:40:00+05:30
1896	30	1995-12-01 04:40:00+05:30
1897	30	1996-01-01 04:40:00+05:30
1898	30	1996-02-01 04:40:00+05:30
1899	30	1996-03-01 04:40:00+05:30
1900	30	1996-04-01 04:40:00+05:30
1901	30	1996-05-01 04:40:00+05:30
1902	30	1996-06-01 04:40:00+05:30
1903	30	1996-07-01 04:40:00+05:30
1904	30	1996-08-01 04:40:00+05:30
1905	30	1996-09-01 04:40:00+05:30
1906	30	1996-10-01 04:40:00+05:30
1907	30	1996-11-01 04:40:00+05:30
1908	30	1996-12-01 04:40:00+05:30
1909	30	1997-01-01 04:40:00+05:30
1910	30	1997-02-01 04:40:00+05:30
1911	30	1997-03-01 04:40:00+05:30
1912	30	1997-04-01 04:40:00+05:30
1913	30	1997-05-01 04:40:00+05:30
1914	30	1997-06-01 04:40:00+05:30
1915	30	1997-07-01 04:40:00+05:30
1916	30	1997-08-01 04:40:00+05:30
1917	30	1997-09-01 04:40:00+05:30
1918	30	1997-10-01 04:40:00+05:30
1919	30	1997-11-01 04:40:00+05:30
1920	30	1997-12-01 04:40:00+05:30
1921	30	1998-01-01 04:40:00+05:30
1922	30	1998-02-01 04:40:00+05:30
1923	30	1998-03-01 04:40:00+05:30
1924	30	1998-04-01 04:40:00+05:30
1925	30	1998-05-01 04:40:00+05:30
1926	30	1998-06-01 04:40:00+05:30
1927	30	1998-07-01 04:40:00+05:30
1928	30	1998-08-01 04:40:00+05:30
1929	30	1998-09-01 04:40:00+05:30
1930	30	1998-10-01 04:40:00+05:30
1931	30	1998-11-01 04:40:00+05:30
1932	30	1998-12-01 04:40:00+05:30
1933	30	1999-01-01 04:40:00+05:30
1934	30	1999-02-01 04:40:00+05:30
1935	30	1999-03-01 04:40:00+05:30
1936	30	1999-04-01 04:40:00+05:30
1937	30	1999-05-01 04:40:00+05:30
1938	30	1999-06-01 04:40:00+05:30
1939	30	1999-07-01 04:40:00+05:30
1940	30	1999-08-01 04:40:00+05:30
1941	30	1999-09-01 04:40:00+05:30
1942	30	1999-10-01 04:40:00+05:30
1943	30	1999-11-01 04:40:00+05:30
1944	30	1999-12-01 04:40:00+05:30
1945	30	2000-01-01 04:40:00+05:30
1946	30	2000-02-01 04:40:00+05:30
1947	30	2000-03-01 04:40:00+05:30
1948	30	2000-04-01 04:40:00+05:30
1949	30	2000-05-01 04:40:00+05:30
1950	30	2000-06-01 04:40:00+05:30
1951	30	2000-07-01 04:40:00+05:30
1952	30	2000-08-01 04:40:00+05:30
1953	30	2000-09-01 04:40:00+05:30
1954	30	2000-10-01 04:40:00+05:30
1955	30	2000-11-01 04:40:00+05:30
1956	30	2000-12-01 04:40:00+05:30
1957	30	2001-01-01 04:40:00+05:30
1958	30	2001-02-01 04:40:00+05:30
1959	30	2001-03-01 04:40:00+05:30
1960	30	2001-04-01 04:40:00+05:30
1961	30	2001-05-01 04:40:00+05:30
1962	30	2001-06-01 04:40:00+05:30
1963	30	2001-07-01 04:40:00+05:30
1964	30	2001-08-01 04:40:00+05:30
1965	30	2001-09-01 04:40:00+05:30
1966	30	2001-10-01 04:40:00+05:30
1967	30	2001-11-01 04:40:00+05:30
1968	30	2001-12-01 04:40:00+05:30
1969	30	2002-01-01 04:40:00+05:30
1970	30	2002-02-01 04:40:00+05:30
1971	30	2002-03-01 04:40:00+05:30
1972	30	2002-04-01 04:40:00+05:30
1973	30	2002-05-01 04:40:00+05:30
1974	30	2002-06-01 04:40:00+05:30
1975	30	2002-07-01 04:40:00+05:30
1976	30	2002-08-01 04:40:00+05:30
1977	30	2002-09-01 04:40:00+05:30
1978	30	2002-10-01 04:40:00+05:30
1979	30	2002-11-01 04:40:00+05:30
1980	30	2002-12-01 04:40:00+05:30
1981	31	1992-01-02 04:40:00+05:30
1982	31	1992-02-01 04:40:00+05:30
1983	31	1992-03-01 04:40:00+05:30
1984	31	1992-04-01 04:40:00+05:30
1985	31	1992-05-01 04:40:00+05:30
1986	31	1992-06-01 04:40:00+05:30
1987	31	1992-07-01 04:40:00+05:30
1988	31	1992-08-01 04:40:00+05:30
1989	31	1992-09-01 04:40:00+05:30
1990	31	1992-10-01 04:40:00+05:30
1991	31	1992-11-01 04:40:00+05:30
1992	31	1992-12-01 04:40:00+05:30
1993	31	1993-01-01 04:40:00+05:30
1994	31	1993-02-01 04:40:00+05:30
1995	31	1993-03-01 04:40:00+05:30
1996	31	1993-04-01 04:40:00+05:30
1997	31	1993-05-01 04:40:00+05:30
1998	31	1993-06-01 04:40:00+05:30
1999	31	1993-07-01 04:40:00+05:30
2000	31	1993-08-01 04:40:00+05:30
2001	31	1993-09-01 04:40:00+05:30
2002	31	1993-10-01 04:40:00+05:30
2003	31	1993-11-01 04:40:00+05:30
2004	31	1993-12-01 04:40:00+05:30
2005	31	1994-01-01 04:40:00+05:30
2006	31	1994-02-01 04:40:00+05:30
2007	31	1994-03-01 04:40:00+05:30
2008	31	1994-04-01 04:40:00+05:30
2009	31	1994-05-01 04:40:00+05:30
2010	31	1994-06-01 04:40:00+05:30
2011	31	1994-07-01 04:40:00+05:30
2012	31	1994-08-01 04:40:00+05:30
2013	31	1994-09-01 04:40:00+05:30
2014	31	1994-10-01 04:40:00+05:30
2015	31	1994-11-01 04:40:00+05:30
2016	31	1994-12-01 04:40:00+05:30
2017	31	1995-01-01 04:40:00+05:30
2018	31	1995-02-01 04:40:00+05:30
2019	31	1995-03-01 04:40:00+05:30
2020	31	1995-04-01 04:40:00+05:30
2021	31	1995-05-01 04:40:00+05:30
2022	31	1995-06-01 04:40:00+05:30
2023	31	1995-07-01 04:40:00+05:30
2024	31	1995-08-01 04:40:00+05:30
2025	31	1995-09-01 04:40:00+05:30
2026	31	1995-10-01 04:40:00+05:30
2027	31	1995-11-01 04:40:00+05:30
2028	31	1995-12-01 04:40:00+05:30
2029	31	1996-01-01 04:40:00+05:30
2030	31	1996-02-01 04:40:00+05:30
2031	31	1996-03-01 04:40:00+05:30
2032	31	1996-04-01 04:40:00+05:30
2033	31	1996-05-01 04:40:00+05:30
2034	31	1996-06-01 04:40:00+05:30
2035	31	1996-07-01 04:40:00+05:30
2036	31	1996-08-01 04:40:00+05:30
2037	31	1996-09-01 04:40:00+05:30
2038	31	1996-10-01 04:40:00+05:30
2039	31	1996-11-01 04:40:00+05:30
2040	31	1996-12-01 04:40:00+05:30
2041	31	1997-01-01 04:40:00+05:30
2042	31	1997-02-01 04:40:00+05:30
2043	31	1997-03-01 04:40:00+05:30
2044	31	1997-04-01 04:40:00+05:30
2045	31	1997-05-01 04:40:00+05:30
2046	31	1997-06-01 04:40:00+05:30
2047	31	1997-07-01 04:40:00+05:30
2048	31	1997-08-01 04:40:00+05:30
2049	31	1997-09-01 04:40:00+05:30
2050	31	1997-10-01 04:40:00+05:30
2051	31	1997-11-01 04:40:00+05:30
2052	31	1997-12-01 04:40:00+05:30
2053	31	1998-01-01 04:40:00+05:30
2054	31	1998-02-01 04:40:00+05:30
2055	31	1998-03-01 04:40:00+05:30
2056	31	1998-04-01 04:40:00+05:30
2057	31	1998-05-01 04:40:00+05:30
2058	31	1998-06-01 04:40:00+05:30
2059	31	1998-07-01 04:40:00+05:30
2060	31	1998-08-01 04:40:00+05:30
2061	31	1998-09-01 04:40:00+05:30
2062	31	1998-10-01 04:40:00+05:30
2063	31	1998-11-01 04:40:00+05:30
2064	31	1998-12-01 04:40:00+05:30
2065	31	1999-01-01 04:40:00+05:30
2066	31	1999-02-01 04:40:00+05:30
2067	31	1999-03-01 04:40:00+05:30
2068	31	1999-04-01 04:40:00+05:30
2069	31	1999-05-01 04:40:00+05:30
2070	31	1999-06-01 04:40:00+05:30
2071	31	1999-07-01 04:40:00+05:30
2072	31	1999-08-01 04:40:00+05:30
2073	31	1999-09-01 04:40:00+05:30
2074	31	1999-10-01 04:40:00+05:30
2075	31	1999-11-01 04:40:00+05:30
2076	31	1999-12-01 04:40:00+05:30
2077	31	2000-01-01 04:40:00+05:30
2078	31	2000-02-01 04:40:00+05:30
2079	31	2000-03-01 04:40:00+05:30
2080	31	2000-04-01 04:40:00+05:30
2081	31	2000-05-01 04:40:00+05:30
2082	31	2000-06-01 04:40:00+05:30
2083	31	2000-07-01 04:40:00+05:30
2084	31	2000-08-01 04:40:00+05:30
2085	31	2000-09-01 04:40:00+05:30
2086	31	2000-10-01 04:40:00+05:30
2087	31	2000-11-01 04:40:00+05:30
2088	31	2000-12-01 04:40:00+05:30
2089	31	2001-01-01 04:40:00+05:30
2090	31	2001-02-01 04:40:00+05:30
2091	31	2001-03-01 04:40:00+05:30
2092	31	2001-04-01 04:40:00+05:30
2093	31	2001-05-01 04:40:00+05:30
2094	31	2001-06-01 04:40:00+05:30
2095	31	2001-07-01 04:40:00+05:30
2096	31	2001-08-01 04:40:00+05:30
2097	31	2001-09-01 04:40:00+05:30
2098	31	2001-10-01 04:40:00+05:30
2099	31	2001-11-01 04:40:00+05:30
2100	31	2001-12-01 04:40:00+05:30
2101	31	2002-01-01 04:40:00+05:30
2102	31	2002-02-01 04:40:00+05:30
2103	31	2002-03-01 04:40:00+05:30
2104	31	2002-04-01 04:40:00+05:30
2105	31	2002-05-01 04:40:00+05:30
2106	31	2002-06-01 04:40:00+05:30
2107	31	2002-07-01 04:40:00+05:30
2108	31	2002-08-01 04:40:00+05:30
2109	31	2002-09-01 04:40:00+05:30
2110	31	2002-10-01 04:40:00+05:30
2111	31	2002-11-01 04:40:00+05:30
2112	31	2002-12-01 04:40:00+05:30
2113	32	1992-01-02 04:40:00+05:30
2114	32	1992-02-01 04:40:00+05:30
2115	32	1992-03-01 04:40:00+05:30
2116	32	1992-04-01 04:40:00+05:30
2117	32	1992-05-01 04:40:00+05:30
2118	32	1992-06-01 04:40:00+05:30
2119	32	1992-07-01 04:40:00+05:30
2120	32	1992-08-01 04:40:00+05:30
2121	32	1992-09-01 04:40:00+05:30
2122	32	1992-10-01 04:40:00+05:30
2123	32	1992-11-01 04:40:00+05:30
2124	32	1992-12-01 04:40:00+05:30
2125	32	1993-01-01 04:40:00+05:30
2126	32	1993-02-01 04:40:00+05:30
2127	32	1993-03-01 04:40:00+05:30
2128	32	1993-04-01 04:40:00+05:30
2129	32	1993-05-01 04:40:00+05:30
2130	32	1993-06-01 04:40:00+05:30
2131	32	1993-07-01 04:40:00+05:30
2132	32	1993-08-01 04:40:00+05:30
2133	32	1993-09-01 04:40:00+05:30
2134	32	1993-10-01 04:40:00+05:30
2135	32	1993-11-01 04:40:00+05:30
2136	32	1993-12-01 04:40:00+05:30
2137	32	1994-01-01 04:40:00+05:30
2138	32	1994-02-01 04:40:00+05:30
2139	32	1994-03-01 04:40:00+05:30
2140	32	1994-04-01 04:40:00+05:30
2141	32	1994-05-01 04:40:00+05:30
2142	32	1994-06-01 04:40:00+05:30
2143	32	1994-07-01 04:40:00+05:30
2144	32	1994-08-01 04:40:00+05:30
2145	32	1994-09-01 04:40:00+05:30
2146	32	1994-10-01 04:40:00+05:30
2147	32	1994-11-01 04:40:00+05:30
2148	32	1994-12-01 04:40:00+05:30
2149	32	1995-01-01 04:40:00+05:30
2150	32	1995-02-01 04:40:00+05:30
2151	32	1995-03-01 04:40:00+05:30
2152	32	1995-04-01 04:40:00+05:30
2153	32	1995-05-01 04:40:00+05:30
2154	32	1995-06-01 04:40:00+05:30
2155	32	1995-07-01 04:40:00+05:30
2156	32	1995-08-01 04:40:00+05:30
2157	32	1995-09-01 04:40:00+05:30
2158	32	1995-10-01 04:40:00+05:30
2159	32	1995-11-01 04:40:00+05:30
2160	32	1995-12-01 04:40:00+05:30
2161	32	1996-01-01 04:40:00+05:30
2162	32	1996-02-01 04:40:00+05:30
2163	32	1996-03-01 04:40:00+05:30
2164	32	1996-04-01 04:40:00+05:30
2165	32	1996-05-01 04:40:00+05:30
2166	32	1996-06-01 04:40:00+05:30
2167	32	1996-07-01 04:40:00+05:30
2168	32	1996-08-01 04:40:00+05:30
2169	32	1996-09-01 04:40:00+05:30
2170	32	1996-10-01 04:40:00+05:30
2171	32	1996-11-01 04:40:00+05:30
2172	32	1996-12-01 04:40:00+05:30
2173	32	1997-01-01 04:40:00+05:30
2174	32	1997-02-01 04:40:00+05:30
2175	32	1997-03-01 04:40:00+05:30
2176	32	1997-04-01 04:40:00+05:30
2177	32	1997-05-01 04:40:00+05:30
2178	32	1997-06-01 04:40:00+05:30
2179	32	1997-07-01 04:40:00+05:30
2180	32	1997-08-01 04:40:00+05:30
2181	32	1997-09-01 04:40:00+05:30
2182	32	1997-10-01 04:40:00+05:30
2183	32	1997-11-01 04:40:00+05:30
2184	32	1997-12-01 04:40:00+05:30
2185	32	1998-01-01 04:40:00+05:30
2186	32	1998-02-01 04:40:00+05:30
2187	32	1998-03-01 04:40:00+05:30
2188	32	1998-04-01 04:40:00+05:30
2189	32	1998-05-01 04:40:00+05:30
2190	32	1998-06-01 04:40:00+05:30
2191	32	1998-07-01 04:40:00+05:30
2192	32	1998-08-01 04:40:00+05:30
2193	32	1998-09-01 04:40:00+05:30
2194	32	1998-10-01 04:40:00+05:30
2195	32	1998-11-01 04:40:00+05:30
2196	32	1998-12-01 04:40:00+05:30
2197	32	1999-01-01 04:40:00+05:30
2198	32	1999-02-01 04:40:00+05:30
2199	32	1999-03-01 04:40:00+05:30
2200	32	1999-04-01 04:40:00+05:30
2201	32	1999-05-01 04:40:00+05:30
2202	32	1999-06-01 04:40:00+05:30
2203	32	1999-07-01 04:40:00+05:30
2204	32	1999-08-01 04:40:00+05:30
2205	32	1999-09-01 04:40:00+05:30
2206	32	1999-10-01 04:40:00+05:30
2207	32	1999-11-01 04:40:00+05:30
2208	32	1999-12-01 04:40:00+05:30
2209	32	2000-01-01 04:40:00+05:30
2210	32	2000-02-01 04:40:00+05:30
2211	32	2000-03-01 04:40:00+05:30
2212	32	2000-04-01 04:40:00+05:30
2213	32	2000-05-01 04:40:00+05:30
2214	32	2000-06-01 04:40:00+05:30
2215	32	2000-07-01 04:40:00+05:30
2216	32	2000-08-01 04:40:00+05:30
2217	32	2000-09-01 04:40:00+05:30
2218	32	2000-10-01 04:40:00+05:30
2219	32	2000-11-01 04:40:00+05:30
2220	32	2000-12-01 04:40:00+05:30
2221	32	2001-01-01 04:40:00+05:30
2222	32	2001-02-01 04:40:00+05:30
2223	32	2001-03-01 04:40:00+05:30
2224	32	2001-04-01 04:40:00+05:30
2225	32	2001-05-01 04:40:00+05:30
2226	32	2001-06-01 04:40:00+05:30
2227	32	2001-07-01 04:40:00+05:30
2228	32	2001-08-01 04:40:00+05:30
2229	32	2001-09-01 04:40:00+05:30
2230	32	2001-10-01 04:40:00+05:30
2231	32	2001-11-01 04:40:00+05:30
2232	32	2001-12-01 04:40:00+05:30
2233	32	2002-01-01 04:40:00+05:30
2234	32	2002-02-01 04:40:00+05:30
2235	32	2002-03-01 04:40:00+05:30
2236	32	2002-04-01 04:40:00+05:30
2237	32	2002-05-01 04:40:00+05:30
2238	32	2002-06-01 04:40:00+05:30
2239	32	2002-07-01 04:40:00+05:30
2240	32	2002-08-01 04:40:00+05:30
2241	32	2002-09-01 04:40:00+05:30
2242	32	2002-10-01 04:40:00+05:30
2243	32	2002-11-01 04:40:00+05:30
2244	32	2002-12-01 04:40:00+05:30
2245	33	1992-01-02 04:40:00+05:30
2246	33	1992-02-01 04:40:00+05:30
2247	33	1992-03-01 04:40:00+05:30
2248	33	1992-04-01 04:40:00+05:30
2249	33	1992-05-01 04:40:00+05:30
2250	33	1992-06-01 04:40:00+05:30
2251	33	1992-07-01 04:40:00+05:30
2252	33	1992-08-01 04:40:00+05:30
2253	33	1992-09-01 04:40:00+05:30
2254	33	1992-10-01 04:40:00+05:30
2255	33	1992-11-01 04:40:00+05:30
2256	33	1992-12-01 04:40:00+05:30
2257	33	1993-01-01 04:40:00+05:30
2258	33	1993-02-01 04:40:00+05:30
2259	33	1993-03-01 04:40:00+05:30
2260	33	1993-04-01 04:40:00+05:30
2261	33	1993-05-01 04:40:00+05:30
2262	33	1993-06-01 04:40:00+05:30
2263	33	1993-07-01 04:40:00+05:30
2264	33	1993-08-01 04:40:00+05:30
2265	33	1993-09-01 04:40:00+05:30
2266	33	1993-10-01 04:40:00+05:30
2267	33	1993-11-01 04:40:00+05:30
2268	33	1993-12-01 04:40:00+05:30
2269	33	1994-01-01 04:40:00+05:30
2270	33	1994-02-01 04:40:00+05:30
2271	33	1994-03-01 04:40:00+05:30
2272	33	1994-04-01 04:40:00+05:30
2273	33	1994-05-01 04:40:00+05:30
2274	33	1994-06-01 04:40:00+05:30
2275	33	1994-07-01 04:40:00+05:30
2276	33	1994-08-01 04:40:00+05:30
2277	33	1994-09-01 04:40:00+05:30
2278	33	1994-10-01 04:40:00+05:30
2279	33	1994-11-01 04:40:00+05:30
2280	33	1994-12-01 04:40:00+05:30
2281	33	1995-01-01 04:40:00+05:30
2282	33	1995-02-01 04:40:00+05:30
2283	33	1995-03-01 04:40:00+05:30
2284	33	1995-04-01 04:40:00+05:30
2285	33	1995-05-01 04:40:00+05:30
2286	33	1995-06-01 04:40:00+05:30
2287	33	1995-07-01 04:40:00+05:30
2288	33	1995-08-01 04:40:00+05:30
2289	33	1995-09-01 04:40:00+05:30
2290	33	1995-10-01 04:40:00+05:30
2291	33	1995-11-01 04:40:00+05:30
2292	33	1995-12-01 04:40:00+05:30
2293	33	1996-01-01 04:40:00+05:30
2294	33	1996-02-01 04:40:00+05:30
2295	33	1996-03-01 04:40:00+05:30
2296	33	1996-04-01 04:40:00+05:30
2297	33	1996-05-01 04:40:00+05:30
2298	33	1996-06-01 04:40:00+05:30
2299	33	1996-07-01 04:40:00+05:30
2300	33	1996-08-01 04:40:00+05:30
2301	33	1996-09-01 04:40:00+05:30
2302	33	1996-10-01 04:40:00+05:30
2303	33	1996-11-01 04:40:00+05:30
2304	33	1996-12-01 04:40:00+05:30
2305	33	1997-01-01 04:40:00+05:30
2306	33	1997-02-01 04:40:00+05:30
2307	33	1997-03-01 04:40:00+05:30
2308	33	1997-04-01 04:40:00+05:30
2309	33	1997-05-01 04:40:00+05:30
2310	33	1997-06-01 04:40:00+05:30
2311	33	1997-07-01 04:40:00+05:30
2312	33	1997-08-01 04:40:00+05:30
2313	33	1997-09-01 04:40:00+05:30
2314	33	1997-10-01 04:40:00+05:30
2315	33	1997-11-01 04:40:00+05:30
2316	33	1997-12-01 04:40:00+05:30
2317	33	1998-01-01 04:40:00+05:30
2318	33	1998-02-01 04:40:00+05:30
2319	33	1998-03-01 04:40:00+05:30
2320	33	1998-04-01 04:40:00+05:30
2321	33	1998-05-01 04:40:00+05:30
2322	33	1998-06-01 04:40:00+05:30
2323	33	1998-07-01 04:40:00+05:30
2324	33	1998-08-01 04:40:00+05:30
2325	33	1998-09-01 04:40:00+05:30
2326	33	1998-10-01 04:40:00+05:30
2327	33	1998-11-01 04:40:00+05:30
2328	33	1998-12-01 04:40:00+05:30
2329	33	1999-01-01 04:40:00+05:30
2330	33	1999-02-01 04:40:00+05:30
2331	33	1999-03-01 04:40:00+05:30
2332	33	1999-04-01 04:40:00+05:30
2333	33	1999-05-01 04:40:00+05:30
2334	33	1999-06-01 04:40:00+05:30
2335	33	1999-07-01 04:40:00+05:30
2336	33	1999-08-01 04:40:00+05:30
2337	33	1999-09-01 04:40:00+05:30
2338	33	1999-10-01 04:40:00+05:30
2339	33	1999-11-01 04:40:00+05:30
2340	33	1999-12-01 04:40:00+05:30
2341	33	2000-01-01 04:40:00+05:30
2342	33	2000-02-01 04:40:00+05:30
2343	33	2000-03-01 04:40:00+05:30
2344	33	2000-04-01 04:40:00+05:30
2345	33	2000-05-01 04:40:00+05:30
2346	33	2000-06-01 04:40:00+05:30
2347	33	2000-07-01 04:40:00+05:30
2348	33	2000-08-01 04:40:00+05:30
2349	33	2000-09-01 04:40:00+05:30
2350	33	2000-10-01 04:40:00+05:30
2351	33	2000-11-01 04:40:00+05:30
2352	33	2000-12-01 04:40:00+05:30
2353	33	2001-01-01 04:40:00+05:30
2354	33	2001-02-01 04:40:00+05:30
2355	33	2001-03-01 04:40:00+05:30
2356	33	2001-04-01 04:40:00+05:30
2357	33	2001-05-01 04:40:00+05:30
2358	33	2001-06-01 04:40:00+05:30
2359	33	2001-07-01 04:40:00+05:30
2360	33	2001-08-01 04:40:00+05:30
2361	33	2001-09-01 04:40:00+05:30
2362	33	2001-10-01 04:40:00+05:30
2363	33	2001-11-01 04:40:00+05:30
2364	33	2001-12-01 04:40:00+05:30
2365	33	2002-01-01 04:40:00+05:30
2366	33	2002-02-01 04:40:00+05:30
2367	33	2002-03-01 04:40:00+05:30
2368	33	2002-04-01 04:40:00+05:30
2369	33	2002-05-01 04:40:00+05:30
2370	33	2002-06-01 04:40:00+05:30
2371	33	2002-07-01 04:40:00+05:30
2372	33	2002-08-01 04:40:00+05:30
2373	33	2002-09-01 04:40:00+05:30
2374	33	2002-10-01 04:40:00+05:30
2375	33	2002-11-01 04:40:00+05:30
2376	33	2002-12-01 04:40:00+05:30
2377	34	1992-01-02 04:40:00+05:30
2378	34	1992-02-01 04:40:00+05:30
2379	34	1992-03-01 04:40:00+05:30
2380	34	1992-04-01 04:40:00+05:30
2381	34	1992-05-01 04:40:00+05:30
2382	34	1992-06-01 04:40:00+05:30
2383	34	1992-07-01 04:40:00+05:30
2384	34	1992-08-01 04:40:00+05:30
2385	34	1992-09-01 04:40:00+05:30
2386	34	1992-10-01 04:40:00+05:30
2387	34	1992-11-01 04:40:00+05:30
2388	34	1992-12-01 04:40:00+05:30
2389	34	1993-01-01 04:40:00+05:30
2390	34	1993-02-01 04:40:00+05:30
2391	34	1993-03-01 04:40:00+05:30
2392	34	1993-04-01 04:40:00+05:30
2393	34	1993-05-01 04:40:00+05:30
2394	34	1993-06-01 04:40:00+05:30
2395	34	1993-07-01 04:40:00+05:30
2396	34	1993-08-01 04:40:00+05:30
2397	34	1993-09-01 04:40:00+05:30
2398	34	1993-10-01 04:40:00+05:30
2399	34	1993-11-01 04:40:00+05:30
2400	34	1993-12-01 04:40:00+05:30
2401	34	1994-01-01 04:40:00+05:30
2402	34	1994-02-01 04:40:00+05:30
2403	34	1994-03-01 04:40:00+05:30
2404	34	1994-04-01 04:40:00+05:30
2405	34	1994-05-01 04:40:00+05:30
2406	34	1994-06-01 04:40:00+05:30
2407	34	1994-07-01 04:40:00+05:30
2408	34	1994-08-01 04:40:00+05:30
2409	34	1994-09-01 04:40:00+05:30
2410	34	1994-10-01 04:40:00+05:30
2411	34	1994-11-01 04:40:00+05:30
2412	34	1994-12-01 04:40:00+05:30
2413	34	1995-01-01 04:40:00+05:30
2414	34	1995-02-01 04:40:00+05:30
2415	34	1995-03-01 04:40:00+05:30
2416	34	1995-04-01 04:40:00+05:30
2417	34	1995-05-01 04:40:00+05:30
2418	34	1995-06-01 04:40:00+05:30
2419	34	1995-07-01 04:40:00+05:30
2420	34	1995-08-01 04:40:00+05:30
2421	34	1995-09-01 04:40:00+05:30
2422	34	1995-10-01 04:40:00+05:30
2423	34	1995-11-01 04:40:00+05:30
2424	34	1995-12-01 04:40:00+05:30
2425	34	1996-01-01 04:40:00+05:30
2426	34	1996-02-01 04:40:00+05:30
2427	34	1996-03-01 04:40:00+05:30
2428	34	1996-04-01 04:40:00+05:30
2429	34	1996-05-01 04:40:00+05:30
2430	34	1996-06-01 04:40:00+05:30
2431	34	1996-07-01 04:40:00+05:30
2432	34	1996-08-01 04:40:00+05:30
2433	34	1996-09-01 04:40:00+05:30
2434	34	1996-10-01 04:40:00+05:30
2435	34	1996-11-01 04:40:00+05:30
2436	34	1996-12-01 04:40:00+05:30
2437	34	1997-01-01 04:40:00+05:30
2438	34	1997-02-01 04:40:00+05:30
2439	34	1997-03-01 04:40:00+05:30
2440	34	1997-04-01 04:40:00+05:30
2441	34	1997-05-01 04:40:00+05:30
2442	34	1997-06-01 04:40:00+05:30
2443	34	1997-07-01 04:40:00+05:30
2444	34	1997-08-01 04:40:00+05:30
2445	34	1997-09-01 04:40:00+05:30
2446	34	1997-10-01 04:40:00+05:30
2447	34	1997-11-01 04:40:00+05:30
2448	34	1997-12-01 04:40:00+05:30
2449	34	1998-01-01 04:40:00+05:30
2450	34	1998-02-01 04:40:00+05:30
2451	34	1998-03-01 04:40:00+05:30
2452	34	1998-04-01 04:40:00+05:30
2453	34	1998-05-01 04:40:00+05:30
2454	34	1998-06-01 04:40:00+05:30
2455	34	1998-07-01 04:40:00+05:30
2456	34	1998-08-01 04:40:00+05:30
2457	34	1998-09-01 04:40:00+05:30
2458	34	1998-10-01 04:40:00+05:30
2459	34	1998-11-01 04:40:00+05:30
2460	34	1998-12-01 04:40:00+05:30
2461	34	1999-01-01 04:40:00+05:30
2462	34	1999-02-01 04:40:00+05:30
2463	34	1999-03-01 04:40:00+05:30
2464	34	1999-04-01 04:40:00+05:30
2465	34	1999-05-01 04:40:00+05:30
2466	34	1999-06-01 04:40:00+05:30
2467	34	1999-07-01 04:40:00+05:30
2468	34	1999-08-01 04:40:00+05:30
2469	34	1999-09-01 04:40:00+05:30
2470	34	1999-10-01 04:40:00+05:30
2471	34	1999-11-01 04:40:00+05:30
2472	34	1999-12-01 04:40:00+05:30
2473	34	2000-01-01 04:40:00+05:30
2474	34	2000-02-01 04:40:00+05:30
2475	34	2000-03-01 04:40:00+05:30
2476	34	2000-04-01 04:40:00+05:30
2477	34	2000-05-01 04:40:00+05:30
2478	34	2000-06-01 04:40:00+05:30
2479	34	2000-07-01 04:40:00+05:30
2480	34	2000-08-01 04:40:00+05:30
2481	34	2000-09-01 04:40:00+05:30
2482	34	2000-10-01 04:40:00+05:30
2483	34	2000-11-01 04:40:00+05:30
2484	34	2000-12-01 04:40:00+05:30
2485	34	2001-01-01 04:40:00+05:30
2486	34	2001-02-01 04:40:00+05:30
2487	34	2001-03-01 04:40:00+05:30
2488	34	2001-04-01 04:40:00+05:30
2489	34	2001-05-01 04:40:00+05:30
2490	34	2001-06-01 04:40:00+05:30
2491	34	2001-07-01 04:40:00+05:30
2492	34	2001-08-01 04:40:00+05:30
2493	34	2001-09-01 04:40:00+05:30
2494	34	2001-10-01 04:40:00+05:30
2495	34	2001-11-01 04:40:00+05:30
2496	34	2001-12-01 04:40:00+05:30
2497	34	2002-01-01 04:40:00+05:30
2498	34	2002-02-01 04:40:00+05:30
2499	34	2002-03-01 04:40:00+05:30
2500	34	2002-04-01 04:40:00+05:30
2501	34	2002-05-01 04:40:00+05:30
2502	34	2002-06-01 04:40:00+05:30
2503	34	2002-07-01 04:40:00+05:30
2504	34	2002-08-01 04:40:00+05:30
2505	34	2002-09-01 04:40:00+05:30
2506	34	2002-10-01 04:40:00+05:30
2507	34	2002-11-01 04:40:00+05:30
2508	34	2002-12-01 04:40:00+05:30
2509	36	1992-01-02 04:40:00+05:30
2510	36	1992-02-01 04:40:00+05:30
2511	36	1992-03-01 04:40:00+05:30
2512	36	1992-04-01 04:40:00+05:30
2513	36	1992-05-01 04:40:00+05:30
2514	36	1992-06-01 04:40:00+05:30
2515	36	1992-07-01 04:40:00+05:30
2516	36	1992-08-01 04:40:00+05:30
2517	36	1992-09-01 04:40:00+05:30
2518	36	1992-10-01 04:40:00+05:30
2519	36	1992-11-01 04:40:00+05:30
2520	36	1992-12-01 04:40:00+05:30
2521	36	1993-01-01 04:40:00+05:30
2522	36	1993-02-01 04:40:00+05:30
2523	36	1993-03-01 04:40:00+05:30
2524	36	1993-04-01 04:40:00+05:30
2525	36	1993-05-01 04:40:00+05:30
2526	36	1993-06-01 04:40:00+05:30
2527	36	1993-07-01 04:40:00+05:30
2528	36	1993-08-01 04:40:00+05:30
2529	36	1993-09-01 04:40:00+05:30
2530	36	1993-10-01 04:40:00+05:30
2531	36	1993-11-01 04:40:00+05:30
2532	36	1993-12-01 04:40:00+05:30
2533	36	1994-01-01 04:40:00+05:30
2534	36	1994-02-01 04:40:00+05:30
2535	36	1994-03-01 04:40:00+05:30
2536	36	1994-04-01 04:40:00+05:30
2537	36	1994-05-01 04:40:00+05:30
2538	36	1994-06-01 04:40:00+05:30
2539	36	1994-07-01 04:40:00+05:30
2540	36	1994-08-01 04:40:00+05:30
2541	36	1994-09-01 04:40:00+05:30
2542	36	1994-10-01 04:40:00+05:30
2543	36	1994-11-01 04:40:00+05:30
2544	36	1994-12-01 04:40:00+05:30
2545	36	1995-01-01 04:40:00+05:30
2546	36	1995-02-01 04:40:00+05:30
2547	36	1995-03-01 04:40:00+05:30
2548	36	1995-04-01 04:40:00+05:30
2549	36	1995-05-01 04:40:00+05:30
2550	36	1995-06-01 04:40:00+05:30
2551	36	1995-07-01 04:40:00+05:30
2552	36	1995-08-01 04:40:00+05:30
2553	36	1995-09-01 04:40:00+05:30
2554	36	1995-10-01 04:40:00+05:30
2555	36	1995-11-01 04:40:00+05:30
2556	36	1995-12-01 04:40:00+05:30
2557	36	1996-01-01 04:40:00+05:30
2558	36	1996-02-01 04:40:00+05:30
2559	36	1996-03-01 04:40:00+05:30
2560	36	1996-04-01 04:40:00+05:30
2561	36	1996-05-01 04:40:00+05:30
2562	36	1996-06-01 04:40:00+05:30
2563	36	1996-07-01 04:40:00+05:30
2564	36	1996-08-01 04:40:00+05:30
2565	36	1996-09-01 04:40:00+05:30
2566	36	1996-10-01 04:40:00+05:30
2567	36	1996-11-01 04:40:00+05:30
2568	36	1996-12-01 04:40:00+05:30
2569	36	1997-01-01 04:40:00+05:30
2570	36	1997-02-01 04:40:00+05:30
2571	36	1997-03-01 04:40:00+05:30
2572	36	1997-04-01 04:40:00+05:30
2573	36	1997-05-01 04:40:00+05:30
2574	36	1997-06-01 04:40:00+05:30
2575	36	1997-07-01 04:40:00+05:30
2576	36	1997-08-01 04:40:00+05:30
2577	36	1997-09-01 04:40:00+05:30
2578	36	1997-10-01 04:40:00+05:30
2579	36	1997-11-01 04:40:00+05:30
2580	36	1997-12-01 04:40:00+05:30
2581	36	1998-01-01 04:40:00+05:30
2582	36	1998-02-01 04:40:00+05:30
2583	36	1998-03-01 04:40:00+05:30
2584	36	1998-04-01 04:40:00+05:30
2585	36	1998-05-01 04:40:00+05:30
2586	36	1998-06-01 04:40:00+05:30
2587	36	1998-07-01 04:40:00+05:30
2588	36	1998-08-01 04:40:00+05:30
2589	36	1998-09-01 04:40:00+05:30
2590	36	1998-10-01 04:40:00+05:30
2591	36	1998-11-01 04:40:00+05:30
2592	36	1998-12-01 04:40:00+05:30
2593	36	1999-01-01 04:40:00+05:30
2594	36	1999-02-01 04:40:00+05:30
2595	36	1999-03-01 04:40:00+05:30
2596	36	1999-04-01 04:40:00+05:30
2597	36	1999-05-01 04:40:00+05:30
2598	36	1999-06-01 04:40:00+05:30
2599	36	1999-07-01 04:40:00+05:30
2600	36	1999-08-01 04:40:00+05:30
2601	36	1999-09-01 04:40:00+05:30
2602	36	1999-10-01 04:40:00+05:30
2603	36	1999-11-01 04:40:00+05:30
2604	36	1999-12-01 04:40:00+05:30
2605	36	2000-01-01 04:40:00+05:30
2606	36	2000-02-01 04:40:00+05:30
2607	36	2000-03-01 04:40:00+05:30
2608	36	2000-04-01 04:40:00+05:30
2609	36	2000-05-01 04:40:00+05:30
2610	36	2000-06-01 04:40:00+05:30
2611	36	2000-07-01 04:40:00+05:30
2612	36	2000-08-01 04:40:00+05:30
2613	36	2000-09-01 04:40:00+05:30
2614	36	2000-10-01 04:40:00+05:30
2615	36	2000-11-01 04:40:00+05:30
2616	36	2000-12-01 04:40:00+05:30
2617	36	2001-01-01 04:40:00+05:30
2618	36	2001-02-01 04:40:00+05:30
2619	36	2001-03-01 04:40:00+05:30
2620	36	2001-04-01 04:40:00+05:30
2621	36	2001-05-01 04:40:00+05:30
2622	36	2001-06-01 04:40:00+05:30
2623	36	2001-07-01 04:40:00+05:30
2624	36	2001-08-01 04:40:00+05:30
2625	36	2001-09-01 04:40:00+05:30
2626	36	2001-10-01 04:40:00+05:30
2627	36	2001-11-01 04:40:00+05:30
2628	36	2001-12-01 04:40:00+05:30
2629	36	2002-01-01 04:40:00+05:30
2630	36	2002-02-01 04:40:00+05:30
2631	36	2002-03-01 04:40:00+05:30
2632	36	2002-04-01 04:40:00+05:30
2633	36	2002-05-01 04:40:00+05:30
2634	36	2002-06-01 04:40:00+05:30
2635	36	2002-07-01 04:40:00+05:30
2636	36	2002-08-01 04:40:00+05:30
2637	36	2002-09-01 04:40:00+05:30
2638	36	2002-10-01 04:40:00+05:30
2639	36	2002-11-01 04:40:00+05:30
2640	36	2002-12-01 04:40:00+05:30
2641	35	1992-01-02 04:40:00+05:30
2642	35	1992-02-01 04:40:00+05:30
2643	35	1992-03-01 04:40:00+05:30
2644	35	1992-04-01 04:40:00+05:30
2645	35	1992-05-01 04:40:00+05:30
2646	35	1992-06-01 04:40:00+05:30
2647	35	1992-07-01 04:40:00+05:30
2648	35	1992-08-01 04:40:00+05:30
2649	35	1992-09-01 04:40:00+05:30
2650	35	1992-10-01 04:40:00+05:30
2651	35	1992-11-01 04:40:00+05:30
2652	35	1992-12-01 04:40:00+05:30
2653	35	1993-01-01 04:40:00+05:30
2654	35	1993-02-01 04:40:00+05:30
2655	35	1993-03-01 04:40:00+05:30
2656	35	1993-04-01 04:40:00+05:30
2657	35	1993-05-01 04:40:00+05:30
2658	35	1993-06-01 04:40:00+05:30
2659	35	1993-07-01 04:40:00+05:30
2660	35	1993-08-01 04:40:00+05:30
2661	35	1993-09-01 04:40:00+05:30
2662	35	1993-10-01 04:40:00+05:30
2663	35	1993-11-01 04:40:00+05:30
2664	35	1993-12-01 04:40:00+05:30
2665	35	1994-01-01 04:40:00+05:30
2666	35	1994-02-01 04:40:00+05:30
2667	35	1994-03-01 04:40:00+05:30
2668	35	1994-04-01 04:40:00+05:30
2669	35	1994-05-01 04:40:00+05:30
2670	35	1994-06-01 04:40:00+05:30
2671	35	1994-07-01 04:40:00+05:30
2672	35	1994-08-01 04:40:00+05:30
2673	35	1994-09-01 04:40:00+05:30
2674	35	1994-10-01 04:40:00+05:30
2675	35	1994-11-01 04:40:00+05:30
2676	35	1994-12-01 04:40:00+05:30
2677	35	1995-01-01 04:40:00+05:30
2678	35	1995-02-01 04:40:00+05:30
2679	35	1995-03-01 04:40:00+05:30
2680	35	1995-04-01 04:40:00+05:30
2681	35	1995-05-01 04:40:00+05:30
2682	35	1995-06-01 04:40:00+05:30
2683	35	1995-07-01 04:40:00+05:30
2684	35	1995-08-01 04:40:00+05:30
2685	35	1995-09-01 04:40:00+05:30
2686	35	1995-10-01 04:40:00+05:30
2687	35	1995-11-01 04:40:00+05:30
2688	35	1995-12-01 04:40:00+05:30
2689	35	1996-01-01 04:40:00+05:30
2690	35	1996-02-01 04:40:00+05:30
2691	35	1996-03-01 04:40:00+05:30
2692	35	1996-04-01 04:40:00+05:30
2693	35	1996-05-01 04:40:00+05:30
2694	35	1996-06-01 04:40:00+05:30
2695	35	1996-07-01 04:40:00+05:30
2696	35	1996-08-01 04:40:00+05:30
2697	35	1996-09-01 04:40:00+05:30
2698	35	1996-10-01 04:40:00+05:30
2699	35	1996-11-01 04:40:00+05:30
2700	35	1996-12-01 04:40:00+05:30
2701	35	1997-01-01 04:40:00+05:30
2702	35	1997-02-01 04:40:00+05:30
2703	35	1997-03-01 04:40:00+05:30
2704	35	1997-04-01 04:40:00+05:30
2705	35	1997-05-01 04:40:00+05:30
2706	35	1997-06-01 04:40:00+05:30
2707	35	1997-07-01 04:40:00+05:30
2708	35	1997-08-01 04:40:00+05:30
2709	35	1997-09-01 04:40:00+05:30
2710	35	1997-10-01 04:40:00+05:30
2711	35	1997-11-01 04:40:00+05:30
2712	35	1997-12-01 04:40:00+05:30
2713	35	1998-01-01 04:40:00+05:30
2714	35	1998-02-01 04:40:00+05:30
2715	35	1998-03-01 04:40:00+05:30
2716	35	1998-04-01 04:40:00+05:30
2717	35	1998-05-01 04:40:00+05:30
2718	35	1998-06-01 04:40:00+05:30
2719	35	1998-07-01 04:40:00+05:30
2720	35	1998-08-01 04:40:00+05:30
2721	35	1998-09-01 04:40:00+05:30
2722	35	1998-10-01 04:40:00+05:30
2723	35	1998-11-01 04:40:00+05:30
2724	35	1998-12-01 04:40:00+05:30
2725	35	1999-01-01 04:40:00+05:30
2726	35	1999-02-01 04:40:00+05:30
2727	35	1999-03-01 04:40:00+05:30
2728	35	1999-04-01 04:40:00+05:30
2729	35	1999-05-01 04:40:00+05:30
2730	35	1999-06-01 04:40:00+05:30
2731	35	1999-07-01 04:40:00+05:30
2732	35	1999-08-01 04:40:00+05:30
2733	35	1999-09-01 04:40:00+05:30
2734	35	1999-10-01 04:40:00+05:30
2735	35	1999-11-01 04:40:00+05:30
2736	35	1999-12-01 04:40:00+05:30
2737	35	2000-01-01 04:40:00+05:30
2738	35	2000-02-01 04:40:00+05:30
2739	35	2000-03-01 04:40:00+05:30
2740	35	2000-04-01 04:40:00+05:30
2741	35	2000-05-01 04:40:00+05:30
2742	35	2000-06-01 04:40:00+05:30
2743	35	2000-07-01 04:40:00+05:30
2744	35	2000-08-01 04:40:00+05:30
2745	35	2000-09-01 04:40:00+05:30
2746	35	2000-10-01 04:40:00+05:30
2747	35	2000-11-01 04:40:00+05:30
2748	35	2000-12-01 04:40:00+05:30
2749	35	2001-01-01 04:40:00+05:30
2750	35	2001-02-01 04:40:00+05:30
2751	35	2001-03-01 04:40:00+05:30
2752	35	2001-04-01 04:40:00+05:30
2753	35	2001-05-01 04:40:00+05:30
2754	35	2001-06-01 04:40:00+05:30
2755	35	2001-07-01 04:40:00+05:30
2756	35	2001-08-01 04:40:00+05:30
2757	35	2001-09-01 04:40:00+05:30
2758	35	2001-10-01 04:40:00+05:30
2759	35	2001-11-01 04:40:00+05:30
2760	35	2001-12-01 04:40:00+05:30
2761	35	2002-01-01 04:40:00+05:30
2762	35	2002-02-01 04:40:00+05:30
2763	35	2002-03-01 04:40:00+05:30
2764	35	2002-04-01 04:40:00+05:30
2765	35	2002-05-01 04:40:00+05:30
2766	35	2002-06-01 04:40:00+05:30
2767	35	2002-07-01 04:40:00+05:30
2768	35	2002-08-01 04:40:00+05:30
2769	35	2002-09-01 04:40:00+05:30
2770	35	2002-10-01 04:40:00+05:30
2771	35	2002-11-01 04:40:00+05:30
2772	35	2002-12-01 04:40:00+05:30
2773	37	1992-01-02 04:40:00+05:30
2774	37	1992-02-01 04:40:00+05:30
2775	37	1992-03-01 04:40:00+05:30
2776	37	1992-04-01 04:40:00+05:30
2777	37	1992-05-01 04:40:00+05:30
2778	37	1992-06-01 04:40:00+05:30
2779	37	1992-07-01 04:40:00+05:30
2780	37	1992-08-01 04:40:00+05:30
2781	37	1992-09-01 04:40:00+05:30
2782	37	1992-10-01 04:40:00+05:30
2783	37	1992-11-01 04:40:00+05:30
2784	37	1992-12-01 04:40:00+05:30
2785	37	1993-01-01 04:40:00+05:30
2786	37	1993-02-01 04:40:00+05:30
2787	37	1993-03-01 04:40:00+05:30
2788	37	1993-04-01 04:40:00+05:30
2789	37	1993-05-01 04:40:00+05:30
2790	37	1993-06-01 04:40:00+05:30
2791	37	1993-07-01 04:40:00+05:30
2792	37	1993-08-01 04:40:00+05:30
2793	37	1993-09-01 04:40:00+05:30
2794	37	1993-10-01 04:40:00+05:30
2795	37	1993-11-01 04:40:00+05:30
2796	37	1993-12-01 04:40:00+05:30
2797	37	1994-01-01 04:40:00+05:30
2798	37	1994-02-01 04:40:00+05:30
2799	37	1994-03-01 04:40:00+05:30
2800	37	1994-04-01 04:40:00+05:30
2801	37	1994-05-01 04:40:00+05:30
2802	37	1994-06-01 04:40:00+05:30
2803	37	1994-07-01 04:40:00+05:30
2804	37	1994-08-01 04:40:00+05:30
2805	37	1994-09-01 04:40:00+05:30
2806	37	1994-10-01 04:40:00+05:30
2807	37	1994-11-01 04:40:00+05:30
2808	37	1994-12-01 04:40:00+05:30
2809	37	1995-01-01 04:40:00+05:30
2810	37	1995-02-01 04:40:00+05:30
2811	37	1995-03-01 04:40:00+05:30
2812	37	1995-04-01 04:40:00+05:30
2813	37	1995-05-01 04:40:00+05:30
2814	37	1995-06-01 04:40:00+05:30
2815	37	1995-07-01 04:40:00+05:30
2816	37	1995-08-01 04:40:00+05:30
2817	37	1995-09-01 04:40:00+05:30
2818	37	1995-10-01 04:40:00+05:30
2819	37	1995-11-01 04:40:00+05:30
2820	37	1995-12-01 04:40:00+05:30
2821	37	1996-01-01 04:40:00+05:30
2822	37	1996-02-01 04:40:00+05:30
2823	37	1996-03-01 04:40:00+05:30
2824	37	1996-04-01 04:40:00+05:30
2825	37	1996-05-01 04:40:00+05:30
2826	37	1996-06-01 04:40:00+05:30
2827	37	1996-07-01 04:40:00+05:30
2828	37	1996-08-01 04:40:00+05:30
2829	37	1996-09-01 04:40:00+05:30
2830	37	1996-10-01 04:40:00+05:30
2831	37	1996-11-01 04:40:00+05:30
2832	37	1996-12-01 04:40:00+05:30
2833	37	1997-01-01 04:40:00+05:30
2834	37	1997-02-01 04:40:00+05:30
2835	37	1997-03-01 04:40:00+05:30
2836	37	1997-04-01 04:40:00+05:30
2837	37	1997-05-01 04:40:00+05:30
2838	37	1997-06-01 04:40:00+05:30
2839	37	1997-07-01 04:40:00+05:30
2840	37	1997-08-01 04:40:00+05:30
2841	37	1997-09-01 04:40:00+05:30
2842	37	1997-10-01 04:40:00+05:30
2843	37	1997-11-01 04:40:00+05:30
2844	37	1997-12-01 04:40:00+05:30
2845	37	1998-01-01 04:40:00+05:30
2846	37	1998-02-01 04:40:00+05:30
2847	37	1998-03-01 04:40:00+05:30
2848	37	1998-04-01 04:40:00+05:30
2849	37	1998-05-01 04:40:00+05:30
2850	37	1998-06-01 04:40:00+05:30
2851	37	1998-07-01 04:40:00+05:30
2852	37	1998-08-01 04:40:00+05:30
2853	37	1998-09-01 04:40:00+05:30
2854	37	1998-10-01 04:40:00+05:30
2855	37	1998-11-01 04:40:00+05:30
2856	37	1998-12-01 04:40:00+05:30
2857	37	1999-01-01 04:40:00+05:30
2858	37	1999-02-01 04:40:00+05:30
2859	37	1999-03-01 04:40:00+05:30
2860	37	1999-04-01 04:40:00+05:30
2861	37	1999-05-01 04:40:00+05:30
2862	37	1999-06-01 04:40:00+05:30
2863	37	1999-07-01 04:40:00+05:30
2864	37	1999-08-01 04:40:00+05:30
2865	37	1999-09-01 04:40:00+05:30
2866	37	1999-10-01 04:40:00+05:30
2867	37	1999-11-01 04:40:00+05:30
2868	37	1999-12-01 04:40:00+05:30
2869	37	2000-01-01 04:40:00+05:30
2870	37	2000-02-01 04:40:00+05:30
2871	37	2000-03-01 04:40:00+05:30
2872	37	2000-04-01 04:40:00+05:30
2873	37	2000-05-01 04:40:00+05:30
2874	37	2000-06-01 04:40:00+05:30
2875	37	2000-07-01 04:40:00+05:30
2876	37	2000-08-01 04:40:00+05:30
2877	37	2000-09-01 04:40:00+05:30
2878	37	2000-10-01 04:40:00+05:30
2879	37	2000-11-01 04:40:00+05:30
2880	37	2000-12-01 04:40:00+05:30
2881	37	2001-01-01 04:40:00+05:30
2882	37	2001-02-01 04:40:00+05:30
2883	37	2001-03-01 04:40:00+05:30
2884	37	2001-04-01 04:40:00+05:30
2885	37	2001-05-01 04:40:00+05:30
2886	37	2001-06-01 04:40:00+05:30
2887	37	2001-07-01 04:40:00+05:30
2888	37	2001-08-01 04:40:00+05:30
2889	37	2001-09-01 04:40:00+05:30
2890	37	2001-10-01 04:40:00+05:30
2891	37	2001-11-01 04:40:00+05:30
2892	37	2001-12-01 04:40:00+05:30
2893	37	2002-01-01 04:40:00+05:30
2894	37	2002-02-01 04:40:00+05:30
2895	37	2002-03-01 04:40:00+05:30
2896	37	2002-04-01 04:40:00+05:30
2897	37	2002-05-01 04:40:00+05:30
2898	37	2002-06-01 04:40:00+05:30
2899	37	2002-07-01 04:40:00+05:30
2900	37	2002-08-01 04:40:00+05:30
2901	37	2002-09-01 04:40:00+05:30
2902	37	2002-10-01 04:40:00+05:30
2903	37	2002-11-01 04:40:00+05:30
2904	37	2002-12-01 04:40:00+05:30
2905	38	1992-01-02 04:40:00+05:30
2906	38	1992-02-01 04:40:00+05:30
2907	38	1992-03-01 04:40:00+05:30
2908	38	1992-04-01 04:40:00+05:30
2909	38	1992-05-01 04:40:00+05:30
2910	38	1992-06-01 04:40:00+05:30
2911	38	1992-07-01 04:40:00+05:30
2912	38	1992-08-01 04:40:00+05:30
2913	38	1992-09-01 04:40:00+05:30
2914	38	1992-10-01 04:40:00+05:30
2915	38	1992-11-01 04:40:00+05:30
2916	38	1992-12-01 04:40:00+05:30
2917	38	1993-01-01 04:40:00+05:30
2918	38	1993-02-01 04:40:00+05:30
2919	38	1993-03-01 04:40:00+05:30
2920	38	1993-04-01 04:40:00+05:30
2921	38	1993-05-01 04:40:00+05:30
2922	38	1993-06-01 04:40:00+05:30
2923	38	1993-07-01 04:40:00+05:30
2924	38	1993-08-01 04:40:00+05:30
2925	38	1993-09-01 04:40:00+05:30
2926	38	1993-10-01 04:40:00+05:30
2927	38	1993-11-01 04:40:00+05:30
2928	38	1993-12-01 04:40:00+05:30
2929	38	1994-01-01 04:40:00+05:30
2930	38	1994-02-01 04:40:00+05:30
2931	38	1994-03-01 04:40:00+05:30
2932	38	1994-04-01 04:40:00+05:30
2933	38	1994-05-01 04:40:00+05:30
2934	38	1994-06-01 04:40:00+05:30
2935	38	1994-07-01 04:40:00+05:30
2936	38	1994-08-01 04:40:00+05:30
2937	38	1994-09-01 04:40:00+05:30
2938	38	1994-10-01 04:40:00+05:30
2939	38	1994-11-01 04:40:00+05:30
2940	38	1994-12-01 04:40:00+05:30
2941	38	1995-01-01 04:40:00+05:30
2942	38	1995-02-01 04:40:00+05:30
2943	38	1995-03-01 04:40:00+05:30
2944	38	1995-04-01 04:40:00+05:30
2945	38	1995-05-01 04:40:00+05:30
2946	38	1995-06-01 04:40:00+05:30
2947	38	1995-07-01 04:40:00+05:30
2948	38	1995-08-01 04:40:00+05:30
2949	38	1995-09-01 04:40:00+05:30
2950	38	1995-10-01 04:40:00+05:30
2951	38	1995-11-01 04:40:00+05:30
2952	38	1995-12-01 04:40:00+05:30
2953	38	1996-01-01 04:40:00+05:30
2954	38	1996-02-01 04:40:00+05:30
2955	38	1996-03-01 04:40:00+05:30
2956	38	1996-04-01 04:40:00+05:30
2957	38	1996-05-01 04:40:00+05:30
2958	38	1996-06-01 04:40:00+05:30
2959	38	1996-07-01 04:40:00+05:30
2960	38	1996-08-01 04:40:00+05:30
2961	38	1996-09-01 04:40:00+05:30
2962	38	1996-10-01 04:40:00+05:30
2963	38	1996-11-01 04:40:00+05:30
2964	38	1996-12-01 04:40:00+05:30
2965	38	1997-01-01 04:40:00+05:30
2966	38	1997-02-01 04:40:00+05:30
2967	38	1997-03-01 04:40:00+05:30
2968	38	1997-04-01 04:40:00+05:30
2969	38	1997-05-01 04:40:00+05:30
2970	38	1997-06-01 04:40:00+05:30
2971	38	1997-07-01 04:40:00+05:30
2972	38	1997-08-01 04:40:00+05:30
2973	38	1997-09-01 04:40:00+05:30
2974	38	1997-10-01 04:40:00+05:30
2975	38	1997-11-01 04:40:00+05:30
2976	38	1997-12-01 04:40:00+05:30
2977	38	1998-01-01 04:40:00+05:30
2978	38	1998-02-01 04:40:00+05:30
2979	38	1998-03-01 04:40:00+05:30
2980	38	1998-04-01 04:40:00+05:30
2981	38	1998-05-01 04:40:00+05:30
2982	38	1998-06-01 04:40:00+05:30
2983	38	1998-07-01 04:40:00+05:30
2984	38	1998-08-01 04:40:00+05:30
2985	38	1998-09-01 04:40:00+05:30
2986	38	1998-10-01 04:40:00+05:30
2987	38	1998-11-01 04:40:00+05:30
2988	38	1998-12-01 04:40:00+05:30
2989	38	1999-01-01 04:40:00+05:30
2990	38	1999-02-01 04:40:00+05:30
2991	38	1999-03-01 04:40:00+05:30
2992	38	1999-04-01 04:40:00+05:30
2993	38	1999-05-01 04:40:00+05:30
2994	38	1999-06-01 04:40:00+05:30
2995	38	1999-07-01 04:40:00+05:30
2996	38	1999-08-01 04:40:00+05:30
2997	38	1999-09-01 04:40:00+05:30
2998	38	1999-10-01 04:40:00+05:30
2999	38	1999-11-01 04:40:00+05:30
3000	38	1999-12-01 04:40:00+05:30
3001	38	2000-01-01 04:40:00+05:30
3002	38	2000-02-01 04:40:00+05:30
3003	38	2000-03-01 04:40:00+05:30
3004	38	2000-04-01 04:40:00+05:30
3005	38	2000-05-01 04:40:00+05:30
3006	38	2000-06-01 04:40:00+05:30
3007	38	2000-07-01 04:40:00+05:30
3008	38	2000-08-01 04:40:00+05:30
3009	38	2000-09-01 04:40:00+05:30
3010	38	2000-10-01 04:40:00+05:30
3011	38	2000-11-01 04:40:00+05:30
3012	38	2000-12-01 04:40:00+05:30
3013	38	2001-01-01 04:40:00+05:30
3014	38	2001-02-01 04:40:00+05:30
3015	38	2001-03-01 04:40:00+05:30
3016	38	2001-04-01 04:40:00+05:30
3017	38	2001-05-01 04:40:00+05:30
3018	38	2001-06-01 04:40:00+05:30
3019	38	2001-07-01 04:40:00+05:30
3020	38	2001-08-01 04:40:00+05:30
3021	38	2001-09-01 04:40:00+05:30
3022	38	2001-10-01 04:40:00+05:30
3023	38	2001-11-01 04:40:00+05:30
3024	38	2001-12-01 04:40:00+05:30
3025	38	2002-01-01 04:40:00+05:30
3026	38	2002-02-01 04:40:00+05:30
3027	38	2002-03-01 04:40:00+05:30
3028	38	2002-04-01 04:40:00+05:30
3029	38	2002-05-01 04:40:00+05:30
3030	38	2002-06-01 04:40:00+05:30
3031	38	2002-07-01 04:40:00+05:30
3032	38	2002-08-01 04:40:00+05:30
3033	38	2002-09-01 04:40:00+05:30
3034	38	2002-10-01 04:40:00+05:30
3035	38	2002-11-01 04:40:00+05:30
3036	38	2002-12-01 04:40:00+05:30
3037	39	1992-01-02 04:40:00+05:30
3038	39	1992-02-01 04:40:00+05:30
3039	39	1992-03-01 04:40:00+05:30
3040	39	1992-04-01 04:40:00+05:30
3041	39	1992-05-01 04:40:00+05:30
3042	39	1992-06-01 04:40:00+05:30
3043	39	1992-07-01 04:40:00+05:30
3044	39	1992-08-01 04:40:00+05:30
3045	39	1992-09-01 04:40:00+05:30
3046	39	1992-10-01 04:40:00+05:30
3047	39	1992-11-01 04:40:00+05:30
3048	39	1992-12-01 04:40:00+05:30
3049	39	1993-01-01 04:40:00+05:30
3050	39	1993-02-01 04:40:00+05:30
3051	39	1993-03-01 04:40:00+05:30
3052	39	1993-04-01 04:40:00+05:30
3053	39	1993-05-01 04:40:00+05:30
3054	39	1993-06-01 04:40:00+05:30
3055	39	1993-07-01 04:40:00+05:30
3056	39	1993-08-01 04:40:00+05:30
3057	39	1993-09-01 04:40:00+05:30
3058	39	1993-10-01 04:40:00+05:30
3059	39	1993-11-01 04:40:00+05:30
3060	39	1993-12-01 04:40:00+05:30
3061	39	1994-01-01 04:40:00+05:30
3062	39	1994-02-01 04:40:00+05:30
3063	39	1994-03-01 04:40:00+05:30
3064	39	1994-04-01 04:40:00+05:30
3065	39	1994-05-01 04:40:00+05:30
3066	39	1994-06-01 04:40:00+05:30
3067	39	1994-07-01 04:40:00+05:30
3068	39	1994-08-01 04:40:00+05:30
3069	39	1994-09-01 04:40:00+05:30
3070	39	1994-10-01 04:40:00+05:30
3071	39	1994-11-01 04:40:00+05:30
3072	39	1994-12-01 04:40:00+05:30
3073	39	1995-01-01 04:40:00+05:30
3074	39	1995-02-01 04:40:00+05:30
3075	39	1995-03-01 04:40:00+05:30
3076	39	1995-04-01 04:40:00+05:30
3077	39	1995-05-01 04:40:00+05:30
3078	39	1995-06-01 04:40:00+05:30
3079	39	1995-07-01 04:40:00+05:30
3080	39	1995-08-01 04:40:00+05:30
3081	39	1995-09-01 04:40:00+05:30
3082	39	1995-10-01 04:40:00+05:30
3083	39	1995-11-01 04:40:00+05:30
3084	39	1995-12-01 04:40:00+05:30
3085	39	1996-01-01 04:40:00+05:30
3086	39	1996-02-01 04:40:00+05:30
3087	39	1996-03-01 04:40:00+05:30
3088	39	1996-04-01 04:40:00+05:30
3089	39	1996-05-01 04:40:00+05:30
3090	39	1996-06-01 04:40:00+05:30
3091	39	1996-07-01 04:40:00+05:30
3092	39	1996-08-01 04:40:00+05:30
3093	39	1996-09-01 04:40:00+05:30
3094	39	1996-10-01 04:40:00+05:30
3095	39	1996-11-01 04:40:00+05:30
3096	39	1996-12-01 04:40:00+05:30
3097	39	1997-01-01 04:40:00+05:30
3098	39	1997-02-01 04:40:00+05:30
3099	39	1997-03-01 04:40:00+05:30
3100	39	1997-04-01 04:40:00+05:30
3101	39	1997-05-01 04:40:00+05:30
3102	39	1997-06-01 04:40:00+05:30
3103	39	1997-07-01 04:40:00+05:30
3104	39	1997-08-01 04:40:00+05:30
3105	39	1997-09-01 04:40:00+05:30
3106	39	1997-10-01 04:40:00+05:30
3107	39	1997-11-01 04:40:00+05:30
3108	39	1997-12-01 04:40:00+05:30
3109	39	1998-01-01 04:40:00+05:30
3110	39	1998-02-01 04:40:00+05:30
3111	39	1998-03-01 04:40:00+05:30
3112	39	1998-04-01 04:40:00+05:30
3113	39	1998-05-01 04:40:00+05:30
3114	39	1998-06-01 04:40:00+05:30
3115	39	1998-07-01 04:40:00+05:30
3116	39	1998-08-01 04:40:00+05:30
3117	39	1998-09-01 04:40:00+05:30
3118	39	1998-10-01 04:40:00+05:30
3119	39	1998-11-01 04:40:00+05:30
3120	39	1998-12-01 04:40:00+05:30
3121	39	1999-01-01 04:40:00+05:30
3122	39	1999-02-01 04:40:00+05:30
3123	39	1999-03-01 04:40:00+05:30
3124	39	1999-04-01 04:40:00+05:30
3125	39	1999-05-01 04:40:00+05:30
3126	39	1999-06-01 04:40:00+05:30
3127	39	1999-07-01 04:40:00+05:30
3128	39	1999-08-01 04:40:00+05:30
3129	39	1999-09-01 04:40:00+05:30
3130	39	1999-10-01 04:40:00+05:30
3131	39	1999-11-01 04:40:00+05:30
3132	39	1999-12-01 04:40:00+05:30
3133	39	2000-01-01 04:40:00+05:30
3134	39	2000-02-01 04:40:00+05:30
3135	39	2000-03-01 04:40:00+05:30
3136	39	2000-04-01 04:40:00+05:30
3137	39	2000-05-01 04:40:00+05:30
3138	39	2000-06-01 04:40:00+05:30
3139	39	2000-07-01 04:40:00+05:30
3140	39	2000-08-01 04:40:00+05:30
3141	39	2000-09-01 04:40:00+05:30
3142	39	2000-10-01 04:40:00+05:30
3143	39	2000-11-01 04:40:00+05:30
3144	39	2000-12-01 04:40:00+05:30
3145	39	2001-01-01 04:40:00+05:30
3146	39	2001-02-01 04:40:00+05:30
3147	39	2001-03-01 04:40:00+05:30
3148	39	2001-04-01 04:40:00+05:30
3149	39	2001-05-01 04:40:00+05:30
3150	39	2001-06-01 04:40:00+05:30
3151	39	2001-07-01 04:40:00+05:30
3152	39	2001-08-01 04:40:00+05:30
3153	39	2001-09-01 04:40:00+05:30
3154	39	2001-10-01 04:40:00+05:30
3155	39	2001-11-01 04:40:00+05:30
3156	39	2001-12-01 04:40:00+05:30
3157	39	2002-01-01 04:40:00+05:30
3158	39	2002-02-01 04:40:00+05:30
3159	39	2002-03-01 04:40:00+05:30
3160	39	2002-04-01 04:40:00+05:30
3161	39	2002-05-01 04:40:00+05:30
3162	39	2002-06-01 04:40:00+05:30
3163	39	2002-07-01 04:40:00+05:30
3164	39	2002-08-01 04:40:00+05:30
3165	39	2002-09-01 04:40:00+05:30
3166	39	2002-10-01 04:40:00+05:30
3167	39	2002-11-01 04:40:00+05:30
3168	39	2002-12-01 04:40:00+05:30
3169	40	1992-01-02 04:40:00+05:30
3170	40	1992-02-01 04:40:00+05:30
3171	40	1992-03-01 04:40:00+05:30
3172	40	1992-04-01 04:40:00+05:30
3173	40	1992-05-01 04:40:00+05:30
3174	40	1992-06-01 04:40:00+05:30
3175	40	1992-07-01 04:40:00+05:30
3176	40	1992-08-01 04:40:00+05:30
3177	40	1992-09-01 04:40:00+05:30
3178	40	1992-10-01 04:40:00+05:30
3179	40	1992-11-01 04:40:00+05:30
3180	40	1992-12-01 04:40:00+05:30
3181	40	1993-01-01 04:40:00+05:30
3182	40	1993-02-01 04:40:00+05:30
3183	40	1993-03-01 04:40:00+05:30
3184	40	1993-04-01 04:40:00+05:30
3185	40	1993-05-01 04:40:00+05:30
3186	40	1993-06-01 04:40:00+05:30
3187	40	1993-07-01 04:40:00+05:30
3188	40	1993-08-01 04:40:00+05:30
3189	40	1993-09-01 04:40:00+05:30
3190	40	1993-10-01 04:40:00+05:30
3191	40	1993-11-01 04:40:00+05:30
3192	40	1993-12-01 04:40:00+05:30
3193	40	1994-01-01 04:40:00+05:30
3194	40	1994-02-01 04:40:00+05:30
3195	40	1994-03-01 04:40:00+05:30
3196	40	1994-04-01 04:40:00+05:30
3197	40	1994-05-01 04:40:00+05:30
3198	40	1994-06-01 04:40:00+05:30
3199	40	1994-07-01 04:40:00+05:30
3200	40	1994-08-01 04:40:00+05:30
3201	40	1994-09-01 04:40:00+05:30
3202	40	1994-10-01 04:40:00+05:30
3203	40	1994-11-01 04:40:00+05:30
3204	40	1994-12-01 04:40:00+05:30
3205	40	1995-01-01 04:40:00+05:30
3206	40	1995-02-01 04:40:00+05:30
3207	40	1995-03-01 04:40:00+05:30
3208	40	1995-04-01 04:40:00+05:30
3209	40	1995-05-01 04:40:00+05:30
3210	40	1995-06-01 04:40:00+05:30
3211	40	1995-07-01 04:40:00+05:30
3212	40	1995-08-01 04:40:00+05:30
3213	40	1995-09-01 04:40:00+05:30
3214	40	1995-10-01 04:40:00+05:30
3215	40	1995-11-01 04:40:00+05:30
3216	40	1995-12-01 04:40:00+05:30
3217	40	1996-01-01 04:40:00+05:30
3218	40	1996-02-01 04:40:00+05:30
3219	40	1996-03-01 04:40:00+05:30
3220	40	1996-04-01 04:40:00+05:30
3221	40	1996-05-01 04:40:00+05:30
3222	40	1996-06-01 04:40:00+05:30
3223	40	1996-07-01 04:40:00+05:30
3224	40	1996-08-01 04:40:00+05:30
3225	40	1996-09-01 04:40:00+05:30
3226	40	1996-10-01 04:40:00+05:30
3227	40	1996-11-01 04:40:00+05:30
3228	40	1996-12-01 04:40:00+05:30
3229	40	1997-01-01 04:40:00+05:30
3230	40	1997-02-01 04:40:00+05:30
3231	40	1997-03-01 04:40:00+05:30
3232	40	1997-04-01 04:40:00+05:30
3233	40	1997-05-01 04:40:00+05:30
3234	40	1997-06-01 04:40:00+05:30
3235	40	1997-07-01 04:40:00+05:30
3236	40	1997-08-01 04:40:00+05:30
3237	40	1997-09-01 04:40:00+05:30
3238	40	1997-10-01 04:40:00+05:30
3239	40	1997-11-01 04:40:00+05:30
3240	40	1997-12-01 04:40:00+05:30
3241	40	1998-01-01 04:40:00+05:30
3242	40	1998-02-01 04:40:00+05:30
3243	40	1998-03-01 04:40:00+05:30
3244	40	1998-04-01 04:40:00+05:30
3245	40	1998-05-01 04:40:00+05:30
3246	40	1998-06-01 04:40:00+05:30
3247	40	1998-07-01 04:40:00+05:30
3248	40	1998-08-01 04:40:00+05:30
3249	40	1998-09-01 04:40:00+05:30
3250	40	1998-10-01 04:40:00+05:30
3251	40	1998-11-01 04:40:00+05:30
3252	40	1998-12-01 04:40:00+05:30
3253	40	1999-01-01 04:40:00+05:30
3254	40	1999-02-01 04:40:00+05:30
3255	40	1999-03-01 04:40:00+05:30
3256	40	1999-04-01 04:40:00+05:30
3257	40	1999-05-01 04:40:00+05:30
3258	40	1999-06-01 04:40:00+05:30
3259	40	1999-07-01 04:40:00+05:30
3260	40	1999-08-01 04:40:00+05:30
3261	40	1999-09-01 04:40:00+05:30
3262	40	1999-10-01 04:40:00+05:30
3263	40	1999-11-01 04:40:00+05:30
3264	40	1999-12-01 04:40:00+05:30
3265	40	2000-01-01 04:40:00+05:30
3266	40	2000-02-01 04:40:00+05:30
3267	40	2000-03-01 04:40:00+05:30
3268	40	2000-04-01 04:40:00+05:30
3269	40	2000-05-01 04:40:00+05:30
3270	40	2000-06-01 04:40:00+05:30
3271	40	2000-07-01 04:40:00+05:30
3272	40	2000-08-01 04:40:00+05:30
3273	40	2000-09-01 04:40:00+05:30
3274	40	2000-10-01 04:40:00+05:30
3275	40	2000-11-01 04:40:00+05:30
3276	40	2000-12-01 04:40:00+05:30
3277	40	2001-01-01 04:40:00+05:30
3278	40	2001-02-01 04:40:00+05:30
3279	40	2001-03-01 04:40:00+05:30
3280	40	2001-04-01 04:40:00+05:30
3281	40	2001-05-01 04:40:00+05:30
3282	40	2001-06-01 04:40:00+05:30
3283	40	2001-07-01 04:40:00+05:30
3284	40	2001-08-01 04:40:00+05:30
3285	40	2001-09-01 04:40:00+05:30
3286	40	2001-10-01 04:40:00+05:30
3287	40	2001-11-01 04:40:00+05:30
3288	40	2001-12-01 04:40:00+05:30
3289	40	2002-01-01 04:40:00+05:30
3290	40	2002-02-01 04:40:00+05:30
3291	40	2002-03-01 04:40:00+05:30
3292	40	2002-04-01 04:40:00+05:30
3293	40	2002-05-01 04:40:00+05:30
3294	40	2002-06-01 04:40:00+05:30
3295	40	2002-07-01 04:40:00+05:30
3296	40	2002-08-01 04:40:00+05:30
3297	40	2002-09-01 04:40:00+05:30
3298	40	2002-10-01 04:40:00+05:30
3299	40	2002-11-01 04:40:00+05:30
3300	40	2002-12-01 04:40:00+05:30
3301	28	1992-01-02 04:40:00+05:30
3302	28	1992-02-01 04:40:00+05:30
3303	28	1992-03-01 04:40:00+05:30
3304	28	1992-04-01 04:40:00+05:30
3305	28	1992-05-01 04:40:00+05:30
3306	28	1992-06-01 04:40:00+05:30
3307	28	1992-07-01 04:40:00+05:30
3308	28	1992-08-01 04:40:00+05:30
3309	28	1992-09-01 04:40:00+05:30
3310	28	1992-10-01 04:40:00+05:30
3311	28	1992-11-01 04:40:00+05:30
3312	28	1992-12-01 04:40:00+05:30
3313	28	1993-01-01 04:40:00+05:30
3314	28	1993-02-01 04:40:00+05:30
3315	28	1993-03-01 04:40:00+05:30
3316	28	1993-04-01 04:40:00+05:30
3317	28	1993-05-01 04:40:00+05:30
3318	28	1993-06-01 04:40:00+05:30
3319	28	1993-07-01 04:40:00+05:30
3320	28	1993-08-01 04:40:00+05:30
3321	28	1993-09-01 04:40:00+05:30
3322	28	1993-10-01 04:40:00+05:30
3323	28	1993-11-01 04:40:00+05:30
3324	28	1993-12-01 04:40:00+05:30
3325	28	1994-01-01 04:40:00+05:30
3326	28	1994-02-01 04:40:00+05:30
3327	28	1994-03-01 04:40:00+05:30
3328	28	1994-04-01 04:40:00+05:30
3329	28	1994-05-01 04:40:00+05:30
3330	28	1994-06-01 04:40:00+05:30
3331	28	1994-07-01 04:40:00+05:30
3332	28	1994-08-01 04:40:00+05:30
3333	28	1994-09-01 04:40:00+05:30
3334	28	1994-10-01 04:40:00+05:30
3335	28	1994-11-01 04:40:00+05:30
3336	28	1994-12-01 04:40:00+05:30
3337	28	1995-01-01 04:40:00+05:30
3338	28	1995-02-01 04:40:00+05:30
3339	28	1995-03-01 04:40:00+05:30
3340	28	1995-04-01 04:40:00+05:30
3341	28	1995-05-01 04:40:00+05:30
3342	28	1995-06-01 04:40:00+05:30
3343	28	1995-07-01 04:40:00+05:30
3344	28	1995-08-01 04:40:00+05:30
3345	28	1995-09-01 04:40:00+05:30
3346	28	1995-10-01 04:40:00+05:30
3347	28	1995-11-01 04:40:00+05:30
3348	28	1995-12-01 04:40:00+05:30
3349	28	1996-01-01 04:40:00+05:30
3350	28	1996-02-01 04:40:00+05:30
3351	28	1996-03-01 04:40:00+05:30
3352	28	1996-04-01 04:40:00+05:30
3353	28	1996-05-01 04:40:00+05:30
3354	28	1996-06-01 04:40:00+05:30
3355	28	1996-07-01 04:40:00+05:30
3356	28	1996-08-01 04:40:00+05:30
3357	28	1996-09-01 04:40:00+05:30
3358	28	1996-10-01 04:40:00+05:30
3359	28	1996-11-01 04:40:00+05:30
3360	28	1996-12-01 04:40:00+05:30
3361	28	1997-01-01 04:40:00+05:30
3362	28	1997-02-01 04:40:00+05:30
3363	28	1997-03-01 04:40:00+05:30
3364	28	1997-04-01 04:40:00+05:30
3365	28	1997-05-01 04:40:00+05:30
3366	28	1997-06-01 04:40:00+05:30
3367	28	1997-07-01 04:40:00+05:30
3368	28	1997-08-01 04:40:00+05:30
3369	28	1997-09-01 04:40:00+05:30
3370	28	1997-10-01 04:40:00+05:30
3371	28	1997-11-01 04:40:00+05:30
3372	28	1997-12-01 04:40:00+05:30
3373	28	1998-01-01 04:40:00+05:30
3374	28	1998-02-01 04:40:00+05:30
3375	28	1998-03-01 04:40:00+05:30
3376	28	1998-04-01 04:40:00+05:30
3377	28	1998-05-01 04:40:00+05:30
3378	28	1998-06-01 04:40:00+05:30
3379	28	1998-07-01 04:40:00+05:30
3380	28	1998-08-01 04:40:00+05:30
3381	28	1998-09-01 04:40:00+05:30
3382	28	1998-10-01 04:40:00+05:30
3383	28	1998-11-01 04:40:00+05:30
3384	28	1998-12-01 04:40:00+05:30
3385	28	1999-01-01 04:40:00+05:30
3386	28	1999-02-01 04:40:00+05:30
3387	28	1999-03-01 04:40:00+05:30
3388	28	1999-04-01 04:40:00+05:30
3389	28	1999-05-01 04:40:00+05:30
3390	28	1999-06-01 04:40:00+05:30
3391	28	1999-07-01 04:40:00+05:30
3392	28	1999-08-01 04:40:00+05:30
3393	28	1999-09-01 04:40:00+05:30
3394	28	1999-10-01 04:40:00+05:30
3395	28	1999-11-01 04:40:00+05:30
3396	28	1999-12-01 04:40:00+05:30
3397	28	2000-01-01 04:40:00+05:30
3398	28	2000-02-01 04:40:00+05:30
3399	28	2000-03-01 04:40:00+05:30
3400	28	2000-04-01 04:40:00+05:30
3401	28	2000-05-01 04:40:00+05:30
3402	28	2000-06-01 04:40:00+05:30
3403	28	2000-07-01 04:40:00+05:30
3404	28	2000-08-01 04:40:00+05:30
3405	28	2000-09-01 04:40:00+05:30
3406	28	2000-10-01 04:40:00+05:30
3407	28	2000-11-01 04:40:00+05:30
3408	28	2000-12-01 04:40:00+05:30
3409	28	2001-01-01 04:40:00+05:30
3410	28	2001-02-01 04:40:00+05:30
3411	28	2001-03-01 04:40:00+05:30
3412	28	2001-04-01 04:40:00+05:30
3413	28	2001-05-01 04:40:00+05:30
3414	28	2001-06-01 04:40:00+05:30
3415	28	2001-07-01 04:40:00+05:30
3416	28	2001-08-01 04:40:00+05:30
3417	28	2001-09-01 04:40:00+05:30
3418	28	2001-10-01 04:40:00+05:30
3419	28	2001-11-01 04:40:00+05:30
3420	28	2001-12-01 04:40:00+05:30
3421	28	2002-01-01 04:40:00+05:30
3422	28	2002-02-01 04:40:00+05:30
3423	28	2002-03-01 04:40:00+05:30
3424	28	2002-04-01 04:40:00+05:30
3425	28	2002-05-01 04:40:00+05:30
3426	28	2002-06-01 04:40:00+05:30
3427	28	2002-07-01 04:40:00+05:30
3428	28	2002-08-01 04:40:00+05:30
3429	28	2002-09-01 04:40:00+05:30
3430	28	2002-10-01 04:40:00+05:30
3431	28	2002-11-01 04:40:00+05:30
3432	28	2002-12-01 04:40:00+05:30
3433	41	1992-01-02 04:40:00+05:30
3434	41	1992-02-01 04:40:00+05:30
3435	41	1992-03-01 04:40:00+05:30
3436	41	1992-04-01 04:40:00+05:30
3437	41	1992-05-01 04:40:00+05:30
3438	41	1992-06-01 04:40:00+05:30
3439	41	1992-07-01 04:40:00+05:30
3440	41	1992-08-01 04:40:00+05:30
3441	41	1992-09-01 04:40:00+05:30
3442	41	1992-10-01 04:40:00+05:30
3443	41	1992-11-01 04:40:00+05:30
3444	41	1992-12-01 04:40:00+05:30
3445	41	1993-01-01 04:40:00+05:30
3446	41	1993-02-01 04:40:00+05:30
3447	41	1993-03-01 04:40:00+05:30
3448	41	1993-04-01 04:40:00+05:30
3449	41	1993-05-01 04:40:00+05:30
3450	41	1993-06-01 04:40:00+05:30
3451	41	1993-07-01 04:40:00+05:30
3452	41	1993-08-01 04:40:00+05:30
3453	41	1993-09-01 04:40:00+05:30
3454	41	1993-10-01 04:40:00+05:30
3455	41	1993-11-01 04:40:00+05:30
3456	41	1993-12-01 04:40:00+05:30
3457	41	1994-01-01 04:40:00+05:30
3458	41	1994-02-01 04:40:00+05:30
3459	41	1994-03-01 04:40:00+05:30
3460	41	1994-04-01 04:40:00+05:30
3461	41	1994-05-01 04:40:00+05:30
3462	41	1994-06-01 04:40:00+05:30
3463	41	1994-07-01 04:40:00+05:30
3464	41	1994-08-01 04:40:00+05:30
3465	41	1994-09-01 04:40:00+05:30
3466	41	1994-10-01 04:40:00+05:30
3467	41	1994-11-01 04:40:00+05:30
3468	41	1994-12-01 04:40:00+05:30
3469	41	1995-01-01 04:40:00+05:30
3470	41	1995-02-01 04:40:00+05:30
3471	41	1995-03-01 04:40:00+05:30
3472	41	1995-04-01 04:40:00+05:30
3473	41	1995-05-01 04:40:00+05:30
3474	41	1995-06-01 04:40:00+05:30
3475	41	1995-07-01 04:40:00+05:30
3476	41	1995-08-01 04:40:00+05:30
3477	41	1995-09-01 04:40:00+05:30
3478	41	1995-10-01 04:40:00+05:30
3479	41	1995-11-01 04:40:00+05:30
3480	41	1995-12-01 04:40:00+05:30
3481	41	1996-01-01 04:40:00+05:30
3482	41	1996-02-01 04:40:00+05:30
3483	41	1996-03-01 04:40:00+05:30
3484	41	1996-04-01 04:40:00+05:30
3485	41	1996-05-01 04:40:00+05:30
3486	41	1996-06-01 04:40:00+05:30
3487	41	1996-07-01 04:40:00+05:30
3488	41	1996-08-01 04:40:00+05:30
3489	41	1996-09-01 04:40:00+05:30
3490	41	1996-10-01 04:40:00+05:30
3491	41	1996-11-01 04:40:00+05:30
3492	41	1996-12-01 04:40:00+05:30
3493	41	1997-01-01 04:40:00+05:30
3494	41	1997-02-01 04:40:00+05:30
3495	41	1997-03-01 04:40:00+05:30
3496	41	1997-04-01 04:40:00+05:30
3497	41	1997-05-01 04:40:00+05:30
3498	41	1997-06-01 04:40:00+05:30
3499	41	1997-07-01 04:40:00+05:30
3500	41	1997-08-01 04:40:00+05:30
3501	41	1997-09-01 04:40:00+05:30
3502	41	1997-10-01 04:40:00+05:30
3503	41	1997-11-01 04:40:00+05:30
3504	41	1997-12-01 04:40:00+05:30
3505	41	1998-01-01 04:40:00+05:30
3506	41	1998-02-01 04:40:00+05:30
3507	41	1998-03-01 04:40:00+05:30
3508	41	1998-04-01 04:40:00+05:30
3509	41	1998-05-01 04:40:00+05:30
3510	41	1998-06-01 04:40:00+05:30
3511	41	1998-07-01 04:40:00+05:30
3512	41	1998-08-01 04:40:00+05:30
3513	41	1998-09-01 04:40:00+05:30
3514	41	1998-10-01 04:40:00+05:30
3515	41	1998-11-01 04:40:00+05:30
3516	41	1998-12-01 04:40:00+05:30
3517	41	1999-01-01 04:40:00+05:30
3518	41	1999-02-01 04:40:00+05:30
3519	41	1999-03-01 04:40:00+05:30
3520	41	1999-04-01 04:40:00+05:30
3521	41	1999-05-01 04:40:00+05:30
3522	41	1999-06-01 04:40:00+05:30
3523	41	1999-07-01 04:40:00+05:30
3524	41	1999-08-01 04:40:00+05:30
3525	41	1999-09-01 04:40:00+05:30
3526	41	1999-10-01 04:40:00+05:30
3527	41	1999-11-01 04:40:00+05:30
3528	41	1999-12-01 04:40:00+05:30
3529	41	2000-01-01 04:40:00+05:30
3530	41	2000-02-01 04:40:00+05:30
3531	41	2000-03-01 04:40:00+05:30
3532	41	2000-04-01 04:40:00+05:30
3533	41	2000-05-01 04:40:00+05:30
3534	41	2000-06-01 04:40:00+05:30
3535	41	2000-07-01 04:40:00+05:30
3536	41	2000-08-01 04:40:00+05:30
3537	41	2000-09-01 04:40:00+05:30
3538	41	2000-10-01 04:40:00+05:30
3539	41	2000-11-01 04:40:00+05:30
3540	41	2000-12-01 04:40:00+05:30
3541	41	2001-01-01 04:40:00+05:30
3542	41	2001-02-01 04:40:00+05:30
3543	41	2001-03-01 04:40:00+05:30
3544	41	2001-04-01 04:40:00+05:30
3545	41	2001-05-01 04:40:00+05:30
3546	41	2001-06-01 04:40:00+05:30
3547	41	2001-07-01 04:40:00+05:30
3548	41	2001-08-01 04:40:00+05:30
3549	41	2001-09-01 04:40:00+05:30
3550	41	2001-10-01 04:40:00+05:30
3551	41	2001-11-01 04:40:00+05:30
3552	41	2001-12-01 04:40:00+05:30
3553	41	2002-01-01 04:40:00+05:30
3554	41	2002-02-01 04:40:00+05:30
3555	41	2002-03-01 04:40:00+05:30
3556	41	2002-04-01 04:40:00+05:30
3557	41	2002-05-01 04:40:00+05:30
3558	41	2002-06-01 04:40:00+05:30
3559	41	2002-07-01 04:40:00+05:30
3560	41	2002-08-01 04:40:00+05:30
3561	41	2002-09-01 04:40:00+05:30
3562	41	2002-10-01 04:40:00+05:30
3563	41	2002-11-01 04:40:00+05:30
3564	41	2002-12-01 04:40:00+05:30
3565	42	1992-01-02 04:40:00+05:30
3566	42	1992-02-01 04:40:00+05:30
3567	42	1992-03-01 04:40:00+05:30
3568	42	1992-04-01 04:40:00+05:30
3569	42	1992-05-01 04:40:00+05:30
3570	42	1992-06-01 04:40:00+05:30
3571	42	1992-07-01 04:40:00+05:30
3572	42	1992-08-01 04:40:00+05:30
3573	42	1992-09-01 04:40:00+05:30
3574	42	1992-10-01 04:40:00+05:30
3575	42	1992-11-01 04:40:00+05:30
3576	42	1992-12-01 04:40:00+05:30
3577	42	1993-01-01 04:40:00+05:30
3578	42	1993-02-01 04:40:00+05:30
3579	42	1993-03-01 04:40:00+05:30
3580	42	1993-04-01 04:40:00+05:30
3581	42	1993-05-01 04:40:00+05:30
3582	42	1993-06-01 04:40:00+05:30
3583	42	1993-07-01 04:40:00+05:30
3584	42	1993-08-01 04:40:00+05:30
3585	42	1993-09-01 04:40:00+05:30
3586	42	1993-10-01 04:40:00+05:30
3587	42	1993-11-01 04:40:00+05:30
3588	42	1993-12-01 04:40:00+05:30
3589	42	1994-01-01 04:40:00+05:30
3590	42	1994-02-01 04:40:00+05:30
3591	42	1994-03-01 04:40:00+05:30
3592	42	1994-04-01 04:40:00+05:30
3593	42	1994-05-01 04:40:00+05:30
3594	42	1994-06-01 04:40:00+05:30
3595	42	1994-07-01 04:40:00+05:30
3596	42	1994-08-01 04:40:00+05:30
3597	42	1994-09-01 04:40:00+05:30
3598	42	1994-10-01 04:40:00+05:30
3599	42	1994-11-01 04:40:00+05:30
3600	42	1994-12-01 04:40:00+05:30
3601	42	1995-01-01 04:40:00+05:30
3602	42	1995-02-01 04:40:00+05:30
3603	42	1995-03-01 04:40:00+05:30
3604	42	1995-04-01 04:40:00+05:30
3605	42	1995-05-01 04:40:00+05:30
3606	42	1995-06-01 04:40:00+05:30
3607	42	1995-07-01 04:40:00+05:30
3608	42	1995-08-01 04:40:00+05:30
3609	42	1995-09-01 04:40:00+05:30
3610	42	1995-10-01 04:40:00+05:30
3611	42	1995-11-01 04:40:00+05:30
3612	42	1995-12-01 04:40:00+05:30
3613	42	1996-01-01 04:40:00+05:30
3614	42	1996-02-01 04:40:00+05:30
3615	42	1996-03-01 04:40:00+05:30
3616	42	1996-04-01 04:40:00+05:30
3617	42	1996-05-01 04:40:00+05:30
3618	42	1996-06-01 04:40:00+05:30
3619	42	1996-07-01 04:40:00+05:30
3620	42	1996-08-01 04:40:00+05:30
3621	42	1996-09-01 04:40:00+05:30
3622	42	1996-10-01 04:40:00+05:30
3623	42	1996-11-01 04:40:00+05:30
3624	42	1996-12-01 04:40:00+05:30
3625	42	1997-01-01 04:40:00+05:30
3626	42	1997-02-01 04:40:00+05:30
3627	42	1997-03-01 04:40:00+05:30
3628	42	1997-04-01 04:40:00+05:30
3629	42	1997-05-01 04:40:00+05:30
3630	42	1997-06-01 04:40:00+05:30
3631	42	1997-07-01 04:40:00+05:30
3632	42	1997-08-01 04:40:00+05:30
3633	42	1997-09-01 04:40:00+05:30
3634	42	1997-10-01 04:40:00+05:30
3635	42	1997-11-01 04:40:00+05:30
3636	42	1997-12-01 04:40:00+05:30
3637	42	1998-01-01 04:40:00+05:30
3638	42	1998-02-01 04:40:00+05:30
3639	42	1998-03-01 04:40:00+05:30
3640	42	1998-04-01 04:40:00+05:30
3641	42	1998-05-01 04:40:00+05:30
3642	42	1998-06-01 04:40:00+05:30
3643	42	1998-07-01 04:40:00+05:30
3644	42	1998-08-01 04:40:00+05:30
3645	42	1998-09-01 04:40:00+05:30
3646	42	1998-10-01 04:40:00+05:30
3647	42	1998-11-01 04:40:00+05:30
3648	42	1998-12-01 04:40:00+05:30
3649	42	1999-01-01 04:40:00+05:30
3650	42	1999-02-01 04:40:00+05:30
3651	42	1999-03-01 04:40:00+05:30
3652	42	1999-04-01 04:40:00+05:30
3653	42	1999-05-01 04:40:00+05:30
3654	42	1999-06-01 04:40:00+05:30
3655	42	1999-07-01 04:40:00+05:30
3656	42	1999-08-01 04:40:00+05:30
3657	42	1999-09-01 04:40:00+05:30
3658	42	1999-10-01 04:40:00+05:30
3659	42	1999-11-01 04:40:00+05:30
3660	42	1999-12-01 04:40:00+05:30
3661	42	2000-01-01 04:40:00+05:30
3662	42	2000-02-01 04:40:00+05:30
3663	42	2000-03-01 04:40:00+05:30
3664	42	2000-04-01 04:40:00+05:30
3665	42	2000-05-01 04:40:00+05:30
3666	42	2000-06-01 04:40:00+05:30
3667	42	2000-07-01 04:40:00+05:30
3668	42	2000-08-01 04:40:00+05:30
3669	42	2000-09-01 04:40:00+05:30
3670	42	2000-10-01 04:40:00+05:30
3671	42	2000-11-01 04:40:00+05:30
3672	42	2000-12-01 04:40:00+05:30
3673	42	2001-01-01 04:40:00+05:30
3674	42	2001-02-01 04:40:00+05:30
3675	42	2001-03-01 04:40:00+05:30
3676	42	2001-04-01 04:40:00+05:30
3677	42	2001-05-01 04:40:00+05:30
3678	42	2001-06-01 04:40:00+05:30
3679	42	2001-07-01 04:40:00+05:30
3680	42	2001-08-01 04:40:00+05:30
3681	42	2001-09-01 04:40:00+05:30
3682	42	2001-10-01 04:40:00+05:30
3683	42	2001-11-01 04:40:00+05:30
3684	42	2001-12-01 04:40:00+05:30
3685	42	2002-01-01 04:40:00+05:30
3686	42	2002-02-01 04:40:00+05:30
3687	42	2002-03-01 04:40:00+05:30
3688	42	2002-04-01 04:40:00+05:30
3689	42	2002-05-01 04:40:00+05:30
3690	42	2002-06-01 04:40:00+05:30
3691	42	2002-07-01 04:40:00+05:30
3692	42	2002-08-01 04:40:00+05:30
3693	42	2002-09-01 04:40:00+05:30
3694	42	2002-10-01 04:40:00+05:30
3695	42	2002-11-01 04:40:00+05:30
3696	42	2002-12-01 04:40:00+05:30
3697	43	1992-01-02 04:40:00+05:30
3698	43	1992-02-01 04:40:00+05:30
3699	43	1992-03-01 04:40:00+05:30
3700	43	1992-04-01 04:40:00+05:30
3701	43	1992-05-01 04:40:00+05:30
3702	43	1992-06-01 04:40:00+05:30
3703	43	1992-07-01 04:40:00+05:30
3704	43	1992-08-01 04:40:00+05:30
3705	43	1992-09-01 04:40:00+05:30
3706	43	1992-10-01 04:40:00+05:30
3707	43	1992-11-01 04:40:00+05:30
3708	43	1992-12-01 04:40:00+05:30
3709	43	1993-01-01 04:40:00+05:30
3710	43	1993-02-01 04:40:00+05:30
3711	43	1993-03-01 04:40:00+05:30
3712	43	1993-04-01 04:40:00+05:30
3713	43	1993-05-01 04:40:00+05:30
3714	43	1993-06-01 04:40:00+05:30
3715	43	1993-07-01 04:40:00+05:30
3716	43	1993-08-01 04:40:00+05:30
3717	43	1993-09-01 04:40:00+05:30
3718	43	1993-10-01 04:40:00+05:30
3719	43	1993-11-01 04:40:00+05:30
3720	43	1993-12-01 04:40:00+05:30
3721	43	1994-01-01 04:40:00+05:30
3722	43	1994-02-01 04:40:00+05:30
3723	43	1994-03-01 04:40:00+05:30
3724	43	1994-04-01 04:40:00+05:30
3725	43	1994-05-01 04:40:00+05:30
3726	43	1994-06-01 04:40:00+05:30
3727	43	1994-07-01 04:40:00+05:30
3728	43	1994-08-01 04:40:00+05:30
3729	43	1994-09-01 04:40:00+05:30
3730	43	1994-10-01 04:40:00+05:30
3731	43	1994-11-01 04:40:00+05:30
3732	43	1994-12-01 04:40:00+05:30
3733	43	1995-01-01 04:40:00+05:30
3734	43	1995-02-01 04:40:00+05:30
3735	43	1995-03-01 04:40:00+05:30
3736	43	1995-04-01 04:40:00+05:30
3737	43	1995-05-01 04:40:00+05:30
3738	43	1995-06-01 04:40:00+05:30
3739	43	1995-07-01 04:40:00+05:30
3740	43	1995-08-01 04:40:00+05:30
3741	43	1995-09-01 04:40:00+05:30
3742	43	1995-10-01 04:40:00+05:30
3743	43	1995-11-01 04:40:00+05:30
3744	43	1995-12-01 04:40:00+05:30
3745	43	1996-01-01 04:40:00+05:30
3746	43	1996-02-01 04:40:00+05:30
3747	43	1996-03-01 04:40:00+05:30
3748	43	1996-04-01 04:40:00+05:30
3749	43	1996-05-01 04:40:00+05:30
3750	43	1996-06-01 04:40:00+05:30
3751	43	1996-07-01 04:40:00+05:30
3752	43	1996-08-01 04:40:00+05:30
3753	43	1996-09-01 04:40:00+05:30
3754	43	1996-10-01 04:40:00+05:30
3755	43	1996-11-01 04:40:00+05:30
3756	43	1996-12-01 04:40:00+05:30
3757	43	1997-01-01 04:40:00+05:30
3758	43	1997-02-01 04:40:00+05:30
3759	43	1997-03-01 04:40:00+05:30
3760	43	1997-04-01 04:40:00+05:30
3761	43	1997-05-01 04:40:00+05:30
3762	43	1997-06-01 04:40:00+05:30
3763	43	1997-07-01 04:40:00+05:30
3764	43	1997-08-01 04:40:00+05:30
3765	43	1997-09-01 04:40:00+05:30
3766	43	1997-10-01 04:40:00+05:30
3767	43	1997-11-01 04:40:00+05:30
3768	43	1997-12-01 04:40:00+05:30
3769	43	1998-01-01 04:40:00+05:30
3770	43	1998-02-01 04:40:00+05:30
3771	43	1998-03-01 04:40:00+05:30
3772	43	1998-04-01 04:40:00+05:30
3773	43	1998-05-01 04:40:00+05:30
3774	43	1998-06-01 04:40:00+05:30
3775	43	1998-07-01 04:40:00+05:30
3776	43	1998-08-01 04:40:00+05:30
3777	43	1998-09-01 04:40:00+05:30
3778	43	1998-10-01 04:40:00+05:30
3779	43	1998-11-01 04:40:00+05:30
3780	43	1998-12-01 04:40:00+05:30
3781	43	1999-01-01 04:40:00+05:30
3782	43	1999-02-01 04:40:00+05:30
3783	43	1999-03-01 04:40:00+05:30
3784	43	1999-04-01 04:40:00+05:30
3785	43	1999-05-01 04:40:00+05:30
3786	43	1999-06-01 04:40:00+05:30
3787	43	1999-07-01 04:40:00+05:30
3788	43	1999-08-01 04:40:00+05:30
3789	43	1999-09-01 04:40:00+05:30
3790	43	1999-10-01 04:40:00+05:30
3791	43	1999-11-01 04:40:00+05:30
3792	43	1999-12-01 04:40:00+05:30
3793	43	2000-01-01 04:40:00+05:30
3794	43	2000-02-01 04:40:00+05:30
3795	43	2000-03-01 04:40:00+05:30
3796	43	2000-04-01 04:40:00+05:30
3797	43	2000-05-01 04:40:00+05:30
3798	43	2000-06-01 04:40:00+05:30
3799	43	2000-07-01 04:40:00+05:30
3800	43	2000-08-01 04:40:00+05:30
3801	43	2000-09-01 04:40:00+05:30
3802	43	2000-10-01 04:40:00+05:30
3803	43	2000-11-01 04:40:00+05:30
3804	43	2000-12-01 04:40:00+05:30
3805	43	2001-01-01 04:40:00+05:30
3806	43	2001-02-01 04:40:00+05:30
3807	43	2001-03-01 04:40:00+05:30
3808	43	2001-04-01 04:40:00+05:30
3809	43	2001-05-01 04:40:00+05:30
3810	43	2001-06-01 04:40:00+05:30
3811	43	2001-07-01 04:40:00+05:30
3812	43	2001-08-01 04:40:00+05:30
3813	43	2001-09-01 04:40:00+05:30
3814	43	2001-10-01 04:40:00+05:30
3815	43	2001-11-01 04:40:00+05:30
3816	43	2001-12-01 04:40:00+05:30
3817	43	2002-01-01 04:40:00+05:30
3818	43	2002-02-01 04:40:00+05:30
3819	43	2002-03-01 04:40:00+05:30
3820	43	2002-04-01 04:40:00+05:30
3821	43	2002-05-01 04:40:00+05:30
3822	43	2002-06-01 04:40:00+05:30
3823	43	2002-07-01 04:40:00+05:30
3824	43	2002-08-01 04:40:00+05:30
3825	43	2002-09-01 04:40:00+05:30
3826	43	2002-10-01 04:40:00+05:30
3827	43	2002-11-01 04:40:00+05:30
3828	43	2002-12-01 04:40:00+05:30
3829	44	1992-01-02 04:40:00+05:30
3830	44	1992-02-01 04:40:00+05:30
3831	44	1992-03-01 04:40:00+05:30
3832	44	1992-04-01 04:40:00+05:30
3833	44	1992-05-01 04:40:00+05:30
3834	44	1992-06-01 04:40:00+05:30
3835	44	1992-07-01 04:40:00+05:30
3836	44	1992-08-01 04:40:00+05:30
3837	44	1992-09-01 04:40:00+05:30
3838	44	1992-10-01 04:40:00+05:30
3839	44	1992-11-01 04:40:00+05:30
3840	44	1992-12-01 04:40:00+05:30
3841	44	1993-01-01 04:40:00+05:30
3842	44	1993-02-01 04:40:00+05:30
3843	44	1993-03-01 04:40:00+05:30
3844	44	1993-04-01 04:40:00+05:30
3845	44	1993-05-01 04:40:00+05:30
3846	44	1993-06-01 04:40:00+05:30
3847	44	1993-07-01 04:40:00+05:30
3848	44	1993-08-01 04:40:00+05:30
3849	44	1993-09-01 04:40:00+05:30
3850	44	1993-10-01 04:40:00+05:30
3851	44	1993-11-01 04:40:00+05:30
3852	44	1993-12-01 04:40:00+05:30
3853	44	1994-01-01 04:40:00+05:30
3854	44	1994-02-01 04:40:00+05:30
3855	44	1994-03-01 04:40:00+05:30
3856	44	1994-04-01 04:40:00+05:30
3857	44	1994-05-01 04:40:00+05:30
3858	44	1994-06-01 04:40:00+05:30
3859	44	1994-07-01 04:40:00+05:30
3860	44	1994-08-01 04:40:00+05:30
3861	44	1994-09-01 04:40:00+05:30
3862	44	1994-10-01 04:40:00+05:30
3863	44	1994-11-01 04:40:00+05:30
3864	44	1994-12-01 04:40:00+05:30
3865	44	1995-01-01 04:40:00+05:30
3866	44	1995-02-01 04:40:00+05:30
3867	44	1995-03-01 04:40:00+05:30
3868	44	1995-04-01 04:40:00+05:30
3869	44	1995-05-01 04:40:00+05:30
3870	44	1995-06-01 04:40:00+05:30
3871	44	1995-07-01 04:40:00+05:30
3872	44	1995-08-01 04:40:00+05:30
3873	44	1995-09-01 04:40:00+05:30
3874	44	1995-10-01 04:40:00+05:30
3875	44	1995-11-01 04:40:00+05:30
3876	44	1995-12-01 04:40:00+05:30
3877	44	1996-01-01 04:40:00+05:30
3878	44	1996-02-01 04:40:00+05:30
3879	44	1996-03-01 04:40:00+05:30
3880	44	1996-04-01 04:40:00+05:30
3881	44	1996-05-01 04:40:00+05:30
3882	44	1996-06-01 04:40:00+05:30
3883	44	1996-07-01 04:40:00+05:30
3884	44	1996-08-01 04:40:00+05:30
3885	44	1996-09-01 04:40:00+05:30
3886	44	1996-10-01 04:40:00+05:30
3887	44	1996-11-01 04:40:00+05:30
3888	44	1996-12-01 04:40:00+05:30
3889	44	1997-01-01 04:40:00+05:30
3890	44	1997-02-01 04:40:00+05:30
3891	44	1997-03-01 04:40:00+05:30
3892	44	1997-04-01 04:40:00+05:30
3893	44	1997-05-01 04:40:00+05:30
3894	44	1997-06-01 04:40:00+05:30
3895	44	1997-07-01 04:40:00+05:30
3896	44	1997-08-01 04:40:00+05:30
3897	44	1997-09-01 04:40:00+05:30
3898	44	1997-10-01 04:40:00+05:30
3899	44	1997-11-01 04:40:00+05:30
3900	44	1997-12-01 04:40:00+05:30
3901	44	1998-01-01 04:40:00+05:30
3902	44	1998-02-01 04:40:00+05:30
3903	44	1998-03-01 04:40:00+05:30
3904	44	1998-04-01 04:40:00+05:30
3905	44	1998-05-01 04:40:00+05:30
3906	44	1998-06-01 04:40:00+05:30
3907	44	1998-07-01 04:40:00+05:30
3908	44	1998-08-01 04:40:00+05:30
3909	44	1998-09-01 04:40:00+05:30
3910	44	1998-10-01 04:40:00+05:30
3911	44	1998-11-01 04:40:00+05:30
3912	44	1998-12-01 04:40:00+05:30
3913	44	1999-01-01 04:40:00+05:30
3914	44	1999-02-01 04:40:00+05:30
3915	44	1999-03-01 04:40:00+05:30
3916	44	1999-04-01 04:40:00+05:30
3917	44	1999-05-01 04:40:00+05:30
3918	44	1999-06-01 04:40:00+05:30
3919	44	1999-07-01 04:40:00+05:30
3920	44	1999-08-01 04:40:00+05:30
3921	44	1999-09-01 04:40:00+05:30
3922	44	1999-10-01 04:40:00+05:30
3923	44	1999-11-01 04:40:00+05:30
3924	44	1999-12-01 04:40:00+05:30
3925	44	2000-01-01 04:40:00+05:30
3926	44	2000-02-01 04:40:00+05:30
3927	44	2000-03-01 04:40:00+05:30
3928	44	2000-04-01 04:40:00+05:30
3929	44	2000-05-01 04:40:00+05:30
3930	44	2000-06-01 04:40:00+05:30
3931	44	2000-07-01 04:40:00+05:30
3932	44	2000-08-01 04:40:00+05:30
3933	44	2000-09-01 04:40:00+05:30
3934	44	2000-10-01 04:40:00+05:30
3935	44	2000-11-01 04:40:00+05:30
3936	44	2000-12-01 04:40:00+05:30
3937	44	2001-01-01 04:40:00+05:30
3938	44	2001-02-01 04:40:00+05:30
3939	44	2001-03-01 04:40:00+05:30
3940	44	2001-04-01 04:40:00+05:30
3941	44	2001-05-01 04:40:00+05:30
3942	44	2001-06-01 04:40:00+05:30
3943	44	2001-07-01 04:40:00+05:30
3944	44	2001-08-01 04:40:00+05:30
3945	44	2001-09-01 04:40:00+05:30
3946	44	2001-10-01 04:40:00+05:30
3947	44	2001-11-01 04:40:00+05:30
3948	44	2001-12-01 04:40:00+05:30
3949	44	2002-01-01 04:40:00+05:30
3950	44	2002-02-01 04:40:00+05:30
3951	44	2002-03-01 04:40:00+05:30
3952	44	2002-04-01 04:40:00+05:30
3953	44	2002-05-01 04:40:00+05:30
3954	44	2002-06-01 04:40:00+05:30
3955	44	2002-07-01 04:40:00+05:30
3956	44	2002-08-01 04:40:00+05:30
3957	44	2002-09-01 04:40:00+05:30
3958	44	2002-10-01 04:40:00+05:30
3959	44	2002-11-01 04:40:00+05:30
3960	44	2002-12-01 04:40:00+05:30
3961	45	1992-01-02 04:40:00+05:30
3962	45	1992-02-01 04:40:00+05:30
3963	45	1992-03-01 04:40:00+05:30
3964	45	1992-04-01 04:40:00+05:30
3965	45	1992-05-01 04:40:00+05:30
3966	45	1992-06-01 04:40:00+05:30
3967	45	1992-07-01 04:40:00+05:30
3968	45	1992-08-01 04:40:00+05:30
3969	45	1992-09-01 04:40:00+05:30
3970	45	1992-10-01 04:40:00+05:30
3971	45	1992-11-01 04:40:00+05:30
3972	45	1992-12-01 04:40:00+05:30
3973	45	1993-01-01 04:40:00+05:30
3974	45	1993-02-01 04:40:00+05:30
3975	45	1993-03-01 04:40:00+05:30
3976	45	1993-04-01 04:40:00+05:30
3977	45	1993-05-01 04:40:00+05:30
3978	45	1993-06-01 04:40:00+05:30
3979	45	1993-07-01 04:40:00+05:30
3980	45	1993-08-01 04:40:00+05:30
3981	45	1993-09-01 04:40:00+05:30
3982	45	1993-10-01 04:40:00+05:30
3983	45	1993-11-01 04:40:00+05:30
3984	45	1993-12-01 04:40:00+05:30
3985	45	1994-01-01 04:40:00+05:30
3986	45	1994-02-01 04:40:00+05:30
3987	45	1994-03-01 04:40:00+05:30
3988	45	1994-04-01 04:40:00+05:30
3989	45	1994-05-01 04:40:00+05:30
3990	45	1994-06-01 04:40:00+05:30
3991	45	1994-07-01 04:40:00+05:30
3992	45	1994-08-01 04:40:00+05:30
3993	45	1994-09-01 04:40:00+05:30
3994	45	1994-10-01 04:40:00+05:30
3995	45	1994-11-01 04:40:00+05:30
3996	45	1994-12-01 04:40:00+05:30
3997	45	1995-01-01 04:40:00+05:30
3998	45	1995-02-01 04:40:00+05:30
3999	45	1995-03-01 04:40:00+05:30
4000	45	1995-04-01 04:40:00+05:30
4001	45	1995-05-01 04:40:00+05:30
4002	45	1995-06-01 04:40:00+05:30
4003	45	1995-07-01 04:40:00+05:30
4004	45	1995-08-01 04:40:00+05:30
4005	45	1995-09-01 04:40:00+05:30
4006	45	1995-10-01 04:40:00+05:30
4007	45	1995-11-01 04:40:00+05:30
4008	45	1995-12-01 04:40:00+05:30
4009	45	1996-01-01 04:40:00+05:30
4010	45	1996-02-01 04:40:00+05:30
4011	45	1996-03-01 04:40:00+05:30
4012	45	1996-04-01 04:40:00+05:30
4013	45	1996-05-01 04:40:00+05:30
4014	45	1996-06-01 04:40:00+05:30
4015	45	1996-07-01 04:40:00+05:30
4016	45	1996-08-01 04:40:00+05:30
4017	45	1996-09-01 04:40:00+05:30
4018	45	1996-10-01 04:40:00+05:30
4019	45	1996-11-01 04:40:00+05:30
4020	45	1996-12-01 04:40:00+05:30
4021	45	1997-01-01 04:40:00+05:30
4022	45	1997-02-01 04:40:00+05:30
4023	45	1997-03-01 04:40:00+05:30
4024	45	1997-04-01 04:40:00+05:30
4025	45	1997-05-01 04:40:00+05:30
4026	45	1997-06-01 04:40:00+05:30
4027	45	1997-07-01 04:40:00+05:30
4028	45	1997-08-01 04:40:00+05:30
4029	45	1997-09-01 04:40:00+05:30
4030	45	1997-10-01 04:40:00+05:30
4031	45	1997-11-01 04:40:00+05:30
4032	45	1997-12-01 04:40:00+05:30
4033	45	1998-01-01 04:40:00+05:30
4034	45	1998-02-01 04:40:00+05:30
4035	45	1998-03-01 04:40:00+05:30
4036	45	1998-04-01 04:40:00+05:30
4037	45	1998-05-01 04:40:00+05:30
4038	45	1998-06-01 04:40:00+05:30
4039	45	1998-07-01 04:40:00+05:30
4040	45	1998-08-01 04:40:00+05:30
4041	45	1998-09-01 04:40:00+05:30
4042	45	1998-10-01 04:40:00+05:30
4043	45	1998-11-01 04:40:00+05:30
4044	45	1998-12-01 04:40:00+05:30
4045	45	1999-01-01 04:40:00+05:30
4046	45	1999-02-01 04:40:00+05:30
4047	45	1999-03-01 04:40:00+05:30
4048	45	1999-04-01 04:40:00+05:30
4049	45	1999-05-01 04:40:00+05:30
4050	45	1999-06-01 04:40:00+05:30
4051	45	1999-07-01 04:40:00+05:30
4052	45	1999-08-01 04:40:00+05:30
4053	45	1999-09-01 04:40:00+05:30
4054	45	1999-10-01 04:40:00+05:30
4055	45	1999-11-01 04:40:00+05:30
4056	45	1999-12-01 04:40:00+05:30
4057	45	2000-01-01 04:40:00+05:30
4058	45	2000-02-01 04:40:00+05:30
4059	45	2000-03-01 04:40:00+05:30
4060	45	2000-04-01 04:40:00+05:30
4061	45	2000-05-01 04:40:00+05:30
4062	45	2000-06-01 04:40:00+05:30
4063	45	2000-07-01 04:40:00+05:30
4064	45	2000-08-01 04:40:00+05:30
4065	45	2000-09-01 04:40:00+05:30
4066	45	2000-10-01 04:40:00+05:30
4067	45	2000-11-01 04:40:00+05:30
4068	45	2000-12-01 04:40:00+05:30
4069	45	2001-01-01 04:40:00+05:30
4070	45	2001-02-01 04:40:00+05:30
4071	45	2001-03-01 04:40:00+05:30
4072	45	2001-04-01 04:40:00+05:30
4073	45	2001-05-01 04:40:00+05:30
4074	45	2001-06-01 04:40:00+05:30
4075	45	2001-07-01 04:40:00+05:30
4076	45	2001-08-01 04:40:00+05:30
4077	45	2001-09-01 04:40:00+05:30
4078	45	2001-10-01 04:40:00+05:30
4079	45	2001-11-01 04:40:00+05:30
4080	45	2001-12-01 04:40:00+05:30
4081	45	2002-01-01 04:40:00+05:30
4082	45	2002-02-01 04:40:00+05:30
4083	45	2002-03-01 04:40:00+05:30
4084	45	2002-04-01 04:40:00+05:30
4085	45	2002-05-01 04:40:00+05:30
4086	45	2002-06-01 04:40:00+05:30
4087	45	2002-07-01 04:40:00+05:30
4088	45	2002-08-01 04:40:00+05:30
4089	45	2002-09-01 04:40:00+05:30
4090	45	2002-10-01 04:40:00+05:30
4091	45	2002-11-01 04:40:00+05:30
4092	45	2002-12-01 04:40:00+05:30
4093	46	1992-01-02 04:40:00+05:30
4094	46	1992-02-01 04:40:00+05:30
4095	46	1992-03-01 04:40:00+05:30
4096	46	1992-04-01 04:40:00+05:30
4097	46	1992-05-01 04:40:00+05:30
4098	46	1992-06-01 04:40:00+05:30
4099	46	1992-07-01 04:40:00+05:30
4100	46	1992-08-01 04:40:00+05:30
4101	46	1992-09-01 04:40:00+05:30
4102	46	1992-10-01 04:40:00+05:30
4103	46	1992-11-01 04:40:00+05:30
4104	46	1992-12-01 04:40:00+05:30
4105	46	1993-01-01 04:40:00+05:30
4106	46	1993-02-01 04:40:00+05:30
4107	46	1993-03-01 04:40:00+05:30
4108	46	1993-04-01 04:40:00+05:30
4109	46	1993-05-01 04:40:00+05:30
4110	46	1993-06-01 04:40:00+05:30
4111	46	1993-07-01 04:40:00+05:30
4112	46	1993-08-01 04:40:00+05:30
4113	46	1993-09-01 04:40:00+05:30
4114	46	1993-10-01 04:40:00+05:30
4115	46	1993-11-01 04:40:00+05:30
4116	46	1993-12-01 04:40:00+05:30
4117	46	1994-01-01 04:40:00+05:30
4118	46	1994-02-01 04:40:00+05:30
4119	46	1994-03-01 04:40:00+05:30
4120	46	1994-04-01 04:40:00+05:30
4121	46	1994-05-01 04:40:00+05:30
4122	46	1994-06-01 04:40:00+05:30
4123	46	1994-07-01 04:40:00+05:30
4124	46	1994-08-01 04:40:00+05:30
4125	46	1994-09-01 04:40:00+05:30
4126	46	1994-10-01 04:40:00+05:30
4127	46	1994-11-01 04:40:00+05:30
4128	46	1994-12-01 04:40:00+05:30
4129	46	1995-01-01 04:40:00+05:30
4130	46	1995-02-01 04:40:00+05:30
4131	46	1995-03-01 04:40:00+05:30
4132	46	1995-04-01 04:40:00+05:30
4133	46	1995-05-01 04:40:00+05:30
4134	46	1995-06-01 04:40:00+05:30
4135	46	1995-07-01 04:40:00+05:30
4136	46	1995-08-01 04:40:00+05:30
4137	46	1995-09-01 04:40:00+05:30
4138	46	1995-10-01 04:40:00+05:30
4139	46	1995-11-01 04:40:00+05:30
4140	46	1995-12-01 04:40:00+05:30
4141	46	1996-01-01 04:40:00+05:30
4142	46	1996-02-01 04:40:00+05:30
4143	46	1996-03-01 04:40:00+05:30
4144	46	1996-04-01 04:40:00+05:30
4145	46	1996-05-01 04:40:00+05:30
4146	46	1996-06-01 04:40:00+05:30
4147	46	1996-07-01 04:40:00+05:30
4148	46	1996-08-01 04:40:00+05:30
4149	46	1996-09-01 04:40:00+05:30
4150	46	1996-10-01 04:40:00+05:30
4151	46	1996-11-01 04:40:00+05:30
4152	46	1996-12-01 04:40:00+05:30
4153	46	1997-01-01 04:40:00+05:30
4154	46	1997-02-01 04:40:00+05:30
4155	46	1997-03-01 04:40:00+05:30
4156	46	1997-04-01 04:40:00+05:30
4157	46	1997-05-01 04:40:00+05:30
4158	46	1997-06-01 04:40:00+05:30
4159	46	1997-07-01 04:40:00+05:30
4160	46	1997-08-01 04:40:00+05:30
4161	46	1997-09-01 04:40:00+05:30
4162	46	1997-10-01 04:40:00+05:30
4163	46	1997-11-01 04:40:00+05:30
4164	46	1997-12-01 04:40:00+05:30
4165	46	1998-01-01 04:40:00+05:30
4166	46	1998-02-01 04:40:00+05:30
4167	46	1998-03-01 04:40:00+05:30
4168	46	1998-04-01 04:40:00+05:30
4169	46	1998-05-01 04:40:00+05:30
4170	46	1998-06-01 04:40:00+05:30
4171	46	1998-07-01 04:40:00+05:30
4172	46	1998-08-01 04:40:00+05:30
4173	46	1998-09-01 04:40:00+05:30
4174	46	1998-10-01 04:40:00+05:30
4175	46	1998-11-01 04:40:00+05:30
4176	46	1998-12-01 04:40:00+05:30
4177	46	1999-01-01 04:40:00+05:30
4178	46	1999-02-01 04:40:00+05:30
4179	46	1999-03-01 04:40:00+05:30
4180	46	1999-04-01 04:40:00+05:30
4181	46	1999-05-01 04:40:00+05:30
4182	46	1999-06-01 04:40:00+05:30
4183	46	1999-07-01 04:40:00+05:30
4184	46	1999-08-01 04:40:00+05:30
4185	46	1999-09-01 04:40:00+05:30
4186	46	1999-10-01 04:40:00+05:30
4187	46	1999-11-01 04:40:00+05:30
4188	46	1999-12-01 04:40:00+05:30
4189	46	2000-01-01 04:40:00+05:30
4190	46	2000-02-01 04:40:00+05:30
4191	46	2000-03-01 04:40:00+05:30
4192	46	2000-04-01 04:40:00+05:30
4193	46	2000-05-01 04:40:00+05:30
4194	46	2000-06-01 04:40:00+05:30
4195	46	2000-07-01 04:40:00+05:30
4196	46	2000-08-01 04:40:00+05:30
4197	46	2000-09-01 04:40:00+05:30
4198	46	2000-10-01 04:40:00+05:30
4199	46	2000-11-01 04:40:00+05:30
4200	46	2000-12-01 04:40:00+05:30
4201	46	2001-01-01 04:40:00+05:30
4202	46	2001-02-01 04:40:00+05:30
4203	46	2001-03-01 04:40:00+05:30
4204	46	2001-04-01 04:40:00+05:30
4205	46	2001-05-01 04:40:00+05:30
4206	46	2001-06-01 04:40:00+05:30
4207	46	2001-07-01 04:40:00+05:30
4208	46	2001-08-01 04:40:00+05:30
4209	46	2001-09-01 04:40:00+05:30
4210	46	2001-10-01 04:40:00+05:30
4211	46	2001-11-01 04:40:00+05:30
4212	46	2001-12-01 04:40:00+05:30
4213	46	2002-01-01 04:40:00+05:30
4214	46	2002-02-01 04:40:00+05:30
4215	46	2002-03-01 04:40:00+05:30
4216	46	2002-04-01 04:40:00+05:30
4217	46	2002-05-01 04:40:00+05:30
4218	46	2002-06-01 04:40:00+05:30
4219	46	2002-07-01 04:40:00+05:30
4220	46	2002-08-01 04:40:00+05:30
4221	46	2002-09-01 04:40:00+05:30
4222	46	2002-10-01 04:40:00+05:30
4223	46	2002-11-01 04:40:00+05:30
4224	46	2002-12-01 04:40:00+05:30
4225	50	1992-01-02 04:40:00+05:30
4226	50	1992-02-01 04:40:00+05:30
4227	50	1992-03-01 04:40:00+05:30
4228	50	1992-04-01 04:40:00+05:30
4229	50	1992-05-01 04:40:00+05:30
4230	50	1992-06-01 04:40:00+05:30
4231	50	1992-07-01 04:40:00+05:30
4232	50	1992-08-01 04:40:00+05:30
4233	50	1992-09-01 04:40:00+05:30
4234	50	1992-10-01 04:40:00+05:30
4235	50	1992-11-01 04:40:00+05:30
4236	50	1992-12-01 04:40:00+05:30
4237	50	1993-01-01 04:40:00+05:30
4238	50	1993-02-01 04:40:00+05:30
4239	50	1993-03-01 04:40:00+05:30
4240	50	1993-04-01 04:40:00+05:30
4241	50	1993-05-01 04:40:00+05:30
4242	50	1993-06-01 04:40:00+05:30
4243	50	1993-07-01 04:40:00+05:30
4244	50	1993-08-01 04:40:00+05:30
4245	50	1993-09-01 04:40:00+05:30
4246	50	1993-10-01 04:40:00+05:30
4247	50	1993-11-01 04:40:00+05:30
4248	50	1993-12-01 04:40:00+05:30
4249	50	1994-01-01 04:40:00+05:30
4250	50	1994-02-01 04:40:00+05:30
4251	50	1994-03-01 04:40:00+05:30
4252	50	1994-04-01 04:40:00+05:30
4253	50	1994-05-01 04:40:00+05:30
4254	50	1994-06-01 04:40:00+05:30
4255	50	1994-07-01 04:40:00+05:30
4256	50	1994-08-01 04:40:00+05:30
4257	50	1994-09-01 04:40:00+05:30
4258	50	1994-10-01 04:40:00+05:30
4259	50	1994-11-01 04:40:00+05:30
4260	50	1994-12-01 04:40:00+05:30
4261	50	1995-01-01 04:40:00+05:30
4262	50	1995-02-01 04:40:00+05:30
4263	50	1995-03-01 04:40:00+05:30
4264	50	1995-04-01 04:40:00+05:30
4265	50	1995-05-01 04:40:00+05:30
4266	50	1995-06-01 04:40:00+05:30
4267	50	1995-07-01 04:40:00+05:30
4268	50	1995-08-01 04:40:00+05:30
4269	50	1995-09-01 04:40:00+05:30
4270	50	1995-10-01 04:40:00+05:30
4271	50	1995-11-01 04:40:00+05:30
4272	50	1995-12-01 04:40:00+05:30
4273	50	1996-01-01 04:40:00+05:30
4274	50	1996-02-01 04:40:00+05:30
4275	50	1996-03-01 04:40:00+05:30
4276	50	1996-04-01 04:40:00+05:30
4277	50	1996-05-01 04:40:00+05:30
4278	50	1996-06-01 04:40:00+05:30
4279	50	1996-07-01 04:40:00+05:30
4280	50	1996-08-01 04:40:00+05:30
4281	50	1996-09-01 04:40:00+05:30
4282	50	1996-10-01 04:40:00+05:30
4283	50	1996-11-01 04:40:00+05:30
4284	50	1996-12-01 04:40:00+05:30
4285	50	1997-01-01 04:40:00+05:30
4286	50	1997-02-01 04:40:00+05:30
4287	50	1997-03-01 04:40:00+05:30
4288	50	1997-04-01 04:40:00+05:30
4289	50	1997-05-01 04:40:00+05:30
4290	50	1997-06-01 04:40:00+05:30
4291	50	1997-07-01 04:40:00+05:30
4292	50	1997-08-01 04:40:00+05:30
4293	50	1997-09-01 04:40:00+05:30
4294	50	1997-10-01 04:40:00+05:30
4295	50	1997-11-01 04:40:00+05:30
4296	50	1997-12-01 04:40:00+05:30
4297	50	1998-01-01 04:40:00+05:30
4298	50	1998-02-01 04:40:00+05:30
4299	50	1998-03-01 04:40:00+05:30
4300	50	1998-04-01 04:40:00+05:30
4301	50	1998-05-01 04:40:00+05:30
4302	50	1998-06-01 04:40:00+05:30
4303	50	1998-07-01 04:40:00+05:30
4304	50	1998-08-01 04:40:00+05:30
4305	50	1998-09-01 04:40:00+05:30
4306	50	1998-10-01 04:40:00+05:30
4307	50	1998-11-01 04:40:00+05:30
4308	50	1998-12-01 04:40:00+05:30
4309	50	1999-01-01 04:40:00+05:30
4310	50	1999-02-01 04:40:00+05:30
4311	50	1999-03-01 04:40:00+05:30
4312	50	1999-04-01 04:40:00+05:30
4313	50	1999-05-01 04:40:00+05:30
4314	50	1999-06-01 04:40:00+05:30
4315	50	1999-07-01 04:40:00+05:30
4316	50	1999-08-01 04:40:00+05:30
4317	50	1999-09-01 04:40:00+05:30
4318	50	1999-10-01 04:40:00+05:30
4319	50	1999-11-01 04:40:00+05:30
4320	50	1999-12-01 04:40:00+05:30
4321	50	2000-01-01 04:40:00+05:30
4322	50	2000-02-01 04:40:00+05:30
4323	50	2000-03-01 04:40:00+05:30
4324	50	2000-04-01 04:40:00+05:30
4325	50	2000-05-01 04:40:00+05:30
4326	50	2000-06-01 04:40:00+05:30
4327	50	2000-07-01 04:40:00+05:30
4328	50	2000-08-01 04:40:00+05:30
4329	50	2000-09-01 04:40:00+05:30
4330	50	2000-10-01 04:40:00+05:30
4331	50	2000-11-01 04:40:00+05:30
4332	50	2000-12-01 04:40:00+05:30
4333	50	2001-01-01 04:40:00+05:30
4334	50	2001-02-01 04:40:00+05:30
4335	50	2001-03-01 04:40:00+05:30
4336	50	2001-04-01 04:40:00+05:30
4337	50	2001-05-01 04:40:00+05:30
4338	50	2001-06-01 04:40:00+05:30
4339	50	2001-07-01 04:40:00+05:30
4340	50	2001-08-01 04:40:00+05:30
4341	50	2001-09-01 04:40:00+05:30
4342	50	2001-10-01 04:40:00+05:30
4343	50	2001-11-01 04:40:00+05:30
4344	50	2001-12-01 04:40:00+05:30
4345	50	2002-01-01 04:40:00+05:30
4346	50	2002-02-01 04:40:00+05:30
4347	50	2002-03-01 04:40:00+05:30
4348	50	2002-04-01 04:40:00+05:30
4349	50	2002-05-01 04:40:00+05:30
4350	50	2002-06-01 04:40:00+05:30
4351	50	2002-07-01 04:40:00+05:30
4352	50	2002-08-01 04:40:00+05:30
4353	50	2002-09-01 04:40:00+05:30
4354	50	2002-10-01 04:40:00+05:30
4355	50	2002-11-01 04:40:00+05:30
4356	50	2002-12-01 04:40:00+05:30
4357	47	1992-01-02 04:40:00+05:30
4358	47	1992-02-01 04:40:00+05:30
4359	47	1992-03-01 04:40:00+05:30
4360	47	1992-04-01 04:40:00+05:30
4361	47	1992-05-01 04:40:00+05:30
4362	47	1992-06-01 04:40:00+05:30
4363	47	1992-07-01 04:40:00+05:30
4364	47	1992-08-01 04:40:00+05:30
4365	47	1992-09-01 04:40:00+05:30
4366	47	1992-10-01 04:40:00+05:30
4367	47	1992-11-01 04:40:00+05:30
4368	47	1992-12-01 04:40:00+05:30
4369	47	1993-01-01 04:40:00+05:30
4370	47	1993-02-01 04:40:00+05:30
4371	47	1993-03-01 04:40:00+05:30
4372	47	1993-04-01 04:40:00+05:30
4373	47	1993-05-01 04:40:00+05:30
4374	47	1993-06-01 04:40:00+05:30
4375	47	1993-07-01 04:40:00+05:30
4376	47	1993-08-01 04:40:00+05:30
4377	47	1993-09-01 04:40:00+05:30
4378	47	1993-10-01 04:40:00+05:30
4379	47	1993-11-01 04:40:00+05:30
4380	47	1993-12-01 04:40:00+05:30
4381	47	1994-01-01 04:40:00+05:30
4382	47	1994-02-01 04:40:00+05:30
4383	47	1994-03-01 04:40:00+05:30
4384	47	1994-04-01 04:40:00+05:30
4385	47	1994-05-01 04:40:00+05:30
4386	47	1994-06-01 04:40:00+05:30
4387	47	1994-07-01 04:40:00+05:30
4388	47	1994-08-01 04:40:00+05:30
4389	47	1994-09-01 04:40:00+05:30
4390	47	1994-10-01 04:40:00+05:30
4391	47	1994-11-01 04:40:00+05:30
4392	47	1994-12-01 04:40:00+05:30
4393	47	1995-01-01 04:40:00+05:30
4394	47	1995-02-01 04:40:00+05:30
4395	47	1995-03-01 04:40:00+05:30
4396	47	1995-04-01 04:40:00+05:30
4397	47	1995-05-01 04:40:00+05:30
4398	47	1995-06-01 04:40:00+05:30
4399	47	1995-07-01 04:40:00+05:30
4400	47	1995-08-01 04:40:00+05:30
4401	47	1995-09-01 04:40:00+05:30
4402	47	1995-10-01 04:40:00+05:30
4403	47	1995-11-01 04:40:00+05:30
4404	47	1995-12-01 04:40:00+05:30
4405	47	1996-01-01 04:40:00+05:30
4406	47	1996-02-01 04:40:00+05:30
4407	47	1996-03-01 04:40:00+05:30
4408	47	1996-04-01 04:40:00+05:30
4409	47	1996-05-01 04:40:00+05:30
4410	47	1996-06-01 04:40:00+05:30
4411	47	1996-07-01 04:40:00+05:30
4412	47	1996-08-01 04:40:00+05:30
4413	47	1996-09-01 04:40:00+05:30
4414	47	1996-10-01 04:40:00+05:30
4415	47	1996-11-01 04:40:00+05:30
4416	47	1996-12-01 04:40:00+05:30
4417	47	1997-01-01 04:40:00+05:30
4418	47	1997-02-01 04:40:00+05:30
4419	47	1997-03-01 04:40:00+05:30
4420	47	1997-04-01 04:40:00+05:30
4421	47	1997-05-01 04:40:00+05:30
4422	47	1997-06-01 04:40:00+05:30
4423	47	1997-07-01 04:40:00+05:30
4424	47	1997-08-01 04:40:00+05:30
4425	47	1997-09-01 04:40:00+05:30
4426	47	1997-10-01 04:40:00+05:30
4427	47	1997-11-01 04:40:00+05:30
4428	47	1997-12-01 04:40:00+05:30
4429	47	1998-01-01 04:40:00+05:30
4430	47	1998-02-01 04:40:00+05:30
4431	47	1998-03-01 04:40:00+05:30
4432	47	1998-04-01 04:40:00+05:30
4433	47	1998-05-01 04:40:00+05:30
4434	47	1998-06-01 04:40:00+05:30
4435	47	1998-07-01 04:40:00+05:30
4436	47	1998-08-01 04:40:00+05:30
4437	47	1998-09-01 04:40:00+05:30
4438	47	1998-10-01 04:40:00+05:30
4439	47	1998-11-01 04:40:00+05:30
4440	47	1998-12-01 04:40:00+05:30
4441	47	1999-01-01 04:40:00+05:30
4442	47	1999-02-01 04:40:00+05:30
4443	47	1999-03-01 04:40:00+05:30
4444	47	1999-04-01 04:40:00+05:30
4445	47	1999-05-01 04:40:00+05:30
4446	47	1999-06-01 04:40:00+05:30
4447	47	1999-07-01 04:40:00+05:30
4448	47	1999-08-01 04:40:00+05:30
4449	47	1999-09-01 04:40:00+05:30
4450	47	1999-10-01 04:40:00+05:30
4451	47	1999-11-01 04:40:00+05:30
4452	47	1999-12-01 04:40:00+05:30
4453	47	2000-01-01 04:40:00+05:30
4454	47	2000-02-01 04:40:00+05:30
4455	47	2000-03-01 04:40:00+05:30
4456	47	2000-04-01 04:40:00+05:30
4457	47	2000-05-01 04:40:00+05:30
4458	47	2000-06-01 04:40:00+05:30
4459	47	2000-07-01 04:40:00+05:30
4460	47	2000-08-01 04:40:00+05:30
4461	47	2000-09-01 04:40:00+05:30
4462	47	2000-10-01 04:40:00+05:30
4463	47	2000-11-01 04:40:00+05:30
4464	47	2000-12-01 04:40:00+05:30
4465	47	2001-01-01 04:40:00+05:30
4466	47	2001-02-01 04:40:00+05:30
4467	47	2001-03-01 04:40:00+05:30
4468	47	2001-04-01 04:40:00+05:30
4469	47	2001-05-01 04:40:00+05:30
4470	47	2001-06-01 04:40:00+05:30
4471	47	2001-07-01 04:40:00+05:30
4472	47	2001-08-01 04:40:00+05:30
4473	47	2001-09-01 04:40:00+05:30
4474	47	2001-10-01 04:40:00+05:30
4475	47	2001-11-01 04:40:00+05:30
4476	47	2001-12-01 04:40:00+05:30
4477	47	2002-01-01 04:40:00+05:30
4478	47	2002-02-01 04:40:00+05:30
4479	47	2002-03-01 04:40:00+05:30
4480	47	2002-04-01 04:40:00+05:30
4481	47	2002-05-01 04:40:00+05:30
4482	47	2002-06-01 04:40:00+05:30
4483	47	2002-07-01 04:40:00+05:30
4484	47	2002-08-01 04:40:00+05:30
4485	47	2002-09-01 04:40:00+05:30
4486	47	2002-10-01 04:40:00+05:30
4487	47	2002-11-01 04:40:00+05:30
4488	47	2002-12-01 04:40:00+05:30
4489	48	1992-01-02 04:40:00+05:30
4490	48	1992-02-01 04:40:00+05:30
4491	48	1992-03-01 04:40:00+05:30
4492	48	1992-04-01 04:40:00+05:30
4493	48	1992-05-01 04:40:00+05:30
4494	48	1992-06-01 04:40:00+05:30
4495	48	1992-07-01 04:40:00+05:30
4496	48	1992-08-01 04:40:00+05:30
4497	48	1992-09-01 04:40:00+05:30
4498	48	1992-10-01 04:40:00+05:30
4499	48	1992-11-01 04:40:00+05:30
4500	48	1992-12-01 04:40:00+05:30
4501	48	1993-01-01 04:40:00+05:30
4502	48	1993-02-01 04:40:00+05:30
4503	48	1993-03-01 04:40:00+05:30
4504	48	1993-04-01 04:40:00+05:30
4505	48	1993-05-01 04:40:00+05:30
4506	48	1993-06-01 04:40:00+05:30
4507	48	1993-07-01 04:40:00+05:30
4508	48	1993-08-01 04:40:00+05:30
4509	48	1993-09-01 04:40:00+05:30
4510	48	1993-10-01 04:40:00+05:30
4511	48	1993-11-01 04:40:00+05:30
4512	48	1993-12-01 04:40:00+05:30
4513	48	1994-01-01 04:40:00+05:30
4514	48	1994-02-01 04:40:00+05:30
4515	48	1994-03-01 04:40:00+05:30
4516	48	1994-04-01 04:40:00+05:30
4517	48	1994-05-01 04:40:00+05:30
4518	48	1994-06-01 04:40:00+05:30
4519	48	1994-07-01 04:40:00+05:30
4520	48	1994-08-01 04:40:00+05:30
4521	48	1994-09-01 04:40:00+05:30
4522	48	1994-10-01 04:40:00+05:30
4523	48	1994-11-01 04:40:00+05:30
4524	48	1994-12-01 04:40:00+05:30
4525	48	1995-01-01 04:40:00+05:30
4526	48	1995-02-01 04:40:00+05:30
4527	48	1995-03-01 04:40:00+05:30
4528	48	1995-04-01 04:40:00+05:30
4529	48	1995-05-01 04:40:00+05:30
4530	48	1995-06-01 04:40:00+05:30
4531	48	1995-07-01 04:40:00+05:30
4532	48	1995-08-01 04:40:00+05:30
4533	48	1995-09-01 04:40:00+05:30
4534	48	1995-10-01 04:40:00+05:30
4535	48	1995-11-01 04:40:00+05:30
4536	48	1995-12-01 04:40:00+05:30
4537	48	1996-01-01 04:40:00+05:30
4538	48	1996-02-01 04:40:00+05:30
4539	48	1996-03-01 04:40:00+05:30
4540	48	1996-04-01 04:40:00+05:30
4541	48	1996-05-01 04:40:00+05:30
4542	48	1996-06-01 04:40:00+05:30
4543	48	1996-07-01 04:40:00+05:30
4544	48	1996-08-01 04:40:00+05:30
4545	48	1996-09-01 04:40:00+05:30
4546	48	1996-10-01 04:40:00+05:30
4547	48	1996-11-01 04:40:00+05:30
4548	48	1996-12-01 04:40:00+05:30
4549	48	1997-01-01 04:40:00+05:30
4550	48	1997-02-01 04:40:00+05:30
4551	48	1997-03-01 04:40:00+05:30
4552	48	1997-04-01 04:40:00+05:30
4553	48	1997-05-01 04:40:00+05:30
4554	48	1997-06-01 04:40:00+05:30
4555	48	1997-07-01 04:40:00+05:30
4556	48	1997-08-01 04:40:00+05:30
4557	48	1997-09-01 04:40:00+05:30
4558	48	1997-10-01 04:40:00+05:30
4559	48	1997-11-01 04:40:00+05:30
4560	48	1997-12-01 04:40:00+05:30
4561	48	1998-01-01 04:40:00+05:30
4562	48	1998-02-01 04:40:00+05:30
4563	48	1998-03-01 04:40:00+05:30
4564	48	1998-04-01 04:40:00+05:30
4565	48	1998-05-01 04:40:00+05:30
4566	48	1998-06-01 04:40:00+05:30
4567	48	1998-07-01 04:40:00+05:30
4568	48	1998-08-01 04:40:00+05:30
4569	48	1998-09-01 04:40:00+05:30
4570	48	1998-10-01 04:40:00+05:30
4571	48	1998-11-01 04:40:00+05:30
4572	48	1998-12-01 04:40:00+05:30
4573	48	1999-01-01 04:40:00+05:30
4574	48	1999-02-01 04:40:00+05:30
4575	48	1999-03-01 04:40:00+05:30
4576	48	1999-04-01 04:40:00+05:30
4577	48	1999-05-01 04:40:00+05:30
4578	48	1999-06-01 04:40:00+05:30
4579	48	1999-07-01 04:40:00+05:30
4580	48	1999-08-01 04:40:00+05:30
4581	48	1999-09-01 04:40:00+05:30
4582	48	1999-10-01 04:40:00+05:30
4583	48	1999-11-01 04:40:00+05:30
4584	48	1999-12-01 04:40:00+05:30
4585	48	2000-01-01 04:40:00+05:30
4586	48	2000-02-01 04:40:00+05:30
4587	48	2000-03-01 04:40:00+05:30
4588	48	2000-04-01 04:40:00+05:30
4589	48	2000-05-01 04:40:00+05:30
4590	48	2000-06-01 04:40:00+05:30
4591	48	2000-07-01 04:40:00+05:30
4592	48	2000-08-01 04:40:00+05:30
4593	48	2000-09-01 04:40:00+05:30
4594	48	2000-10-01 04:40:00+05:30
4595	48	2000-11-01 04:40:00+05:30
4596	48	2000-12-01 04:40:00+05:30
4597	48	2001-01-01 04:40:00+05:30
4598	48	2001-02-01 04:40:00+05:30
4599	48	2001-03-01 04:40:00+05:30
4600	48	2001-04-01 04:40:00+05:30
4601	48	2001-05-01 04:40:00+05:30
4602	48	2001-06-01 04:40:00+05:30
4603	48	2001-07-01 04:40:00+05:30
4604	48	2001-08-01 04:40:00+05:30
4605	48	2001-09-01 04:40:00+05:30
4606	48	2001-10-01 04:40:00+05:30
4607	48	2001-11-01 04:40:00+05:30
4608	48	2001-12-01 04:40:00+05:30
4609	48	2002-01-01 04:40:00+05:30
4610	48	2002-02-01 04:40:00+05:30
4611	48	2002-03-01 04:40:00+05:30
4612	48	2002-04-01 04:40:00+05:30
4613	48	2002-05-01 04:40:00+05:30
4614	48	2002-06-01 04:40:00+05:30
4615	48	2002-07-01 04:40:00+05:30
4616	48	2002-08-01 04:40:00+05:30
4617	48	2002-09-01 04:40:00+05:30
4618	48	2002-10-01 04:40:00+05:30
4619	48	2002-11-01 04:40:00+05:30
4620	48	2002-12-01 04:40:00+05:30
4621	49	1992-01-02 04:40:00+05:30
4622	49	1992-02-01 04:40:00+05:30
4623	49	1992-03-01 04:40:00+05:30
4624	49	1992-04-01 04:40:00+05:30
4625	49	1992-05-01 04:40:00+05:30
4626	49	1992-06-01 04:40:00+05:30
4627	49	1992-07-01 04:40:00+05:30
4628	49	1992-08-01 04:40:00+05:30
4629	49	1992-09-01 04:40:00+05:30
4630	49	1992-10-01 04:40:00+05:30
4631	49	1992-11-01 04:40:00+05:30
4632	49	1992-12-01 04:40:00+05:30
4633	49	1993-01-01 04:40:00+05:30
4634	49	1993-02-01 04:40:00+05:30
4635	49	1993-03-01 04:40:00+05:30
4636	49	1993-04-01 04:40:00+05:30
4637	49	1993-05-01 04:40:00+05:30
4638	49	1993-06-01 04:40:00+05:30
4639	49	1993-07-01 04:40:00+05:30
4640	49	1993-08-01 04:40:00+05:30
4641	49	1993-09-01 04:40:00+05:30
4642	49	1993-10-01 04:40:00+05:30
4643	49	1993-11-01 04:40:00+05:30
4644	49	1993-12-01 04:40:00+05:30
4645	49	1994-01-01 04:40:00+05:30
4646	49	1994-02-01 04:40:00+05:30
4647	49	1994-03-01 04:40:00+05:30
4648	49	1994-04-01 04:40:00+05:30
4649	49	1994-05-01 04:40:00+05:30
4650	49	1994-06-01 04:40:00+05:30
4651	49	1994-07-01 04:40:00+05:30
4652	49	1994-08-01 04:40:00+05:30
4653	49	1994-09-01 04:40:00+05:30
4654	49	1994-10-01 04:40:00+05:30
4655	49	1994-11-01 04:40:00+05:30
4656	49	1994-12-01 04:40:00+05:30
4657	49	1995-01-01 04:40:00+05:30
4658	49	1995-02-01 04:40:00+05:30
4659	49	1995-03-01 04:40:00+05:30
4660	49	1995-04-01 04:40:00+05:30
4661	49	1995-05-01 04:40:00+05:30
4662	49	1995-06-01 04:40:00+05:30
4663	49	1995-07-01 04:40:00+05:30
4664	49	1995-08-01 04:40:00+05:30
4665	49	1995-09-01 04:40:00+05:30
4666	49	1995-10-01 04:40:00+05:30
4667	49	1995-11-01 04:40:00+05:30
4668	49	1995-12-01 04:40:00+05:30
4669	49	1996-01-01 04:40:00+05:30
4670	49	1996-02-01 04:40:00+05:30
4671	49	1996-03-01 04:40:00+05:30
4672	49	1996-04-01 04:40:00+05:30
4673	49	1996-05-01 04:40:00+05:30
4674	49	1996-06-01 04:40:00+05:30
4675	49	1996-07-01 04:40:00+05:30
4676	49	1996-08-01 04:40:00+05:30
4677	49	1996-09-01 04:40:00+05:30
4678	49	1996-10-01 04:40:00+05:30
4679	49	1996-11-01 04:40:00+05:30
4680	49	1996-12-01 04:40:00+05:30
4681	49	1997-01-01 04:40:00+05:30
4682	49	1997-02-01 04:40:00+05:30
4683	49	1997-03-01 04:40:00+05:30
4684	49	1997-04-01 04:40:00+05:30
4685	49	1997-05-01 04:40:00+05:30
4686	49	1997-06-01 04:40:00+05:30
4687	49	1997-07-01 04:40:00+05:30
4688	49	1997-08-01 04:40:00+05:30
4689	49	1997-09-01 04:40:00+05:30
4690	49	1997-10-01 04:40:00+05:30
4691	49	1997-11-01 04:40:00+05:30
4692	49	1997-12-01 04:40:00+05:30
4693	49	1998-01-01 04:40:00+05:30
4694	49	1998-02-01 04:40:00+05:30
4695	49	1998-03-01 04:40:00+05:30
4696	49	1998-04-01 04:40:00+05:30
4697	49	1998-05-01 04:40:00+05:30
4698	49	1998-06-01 04:40:00+05:30
4699	49	1998-07-01 04:40:00+05:30
4700	49	1998-08-01 04:40:00+05:30
4701	49	1998-09-01 04:40:00+05:30
4702	49	1998-10-01 04:40:00+05:30
4703	49	1998-11-01 04:40:00+05:30
4704	49	1998-12-01 04:40:00+05:30
4705	49	1999-01-01 04:40:00+05:30
4706	49	1999-02-01 04:40:00+05:30
4707	49	1999-03-01 04:40:00+05:30
4708	49	1999-04-01 04:40:00+05:30
4709	49	1999-05-01 04:40:00+05:30
4710	49	1999-06-01 04:40:00+05:30
4711	49	1999-07-01 04:40:00+05:30
4712	49	1999-08-01 04:40:00+05:30
4713	49	1999-09-01 04:40:00+05:30
4714	49	1999-10-01 04:40:00+05:30
4715	49	1999-11-01 04:40:00+05:30
4716	49	1999-12-01 04:40:00+05:30
4717	49	2000-01-01 04:40:00+05:30
4718	49	2000-02-01 04:40:00+05:30
4719	49	2000-03-01 04:40:00+05:30
4720	49	2000-04-01 04:40:00+05:30
4721	49	2000-05-01 04:40:00+05:30
4722	49	2000-06-01 04:40:00+05:30
4723	49	2000-07-01 04:40:00+05:30
4724	49	2000-08-01 04:40:00+05:30
4725	49	2000-09-01 04:40:00+05:30
4726	49	2000-10-01 04:40:00+05:30
4727	49	2000-11-01 04:40:00+05:30
4728	49	2000-12-01 04:40:00+05:30
4729	49	2001-01-01 04:40:00+05:30
4730	49	2001-02-01 04:40:00+05:30
4731	49	2001-03-01 04:40:00+05:30
4732	49	2001-04-01 04:40:00+05:30
4733	49	2001-05-01 04:40:00+05:30
4734	49	2001-06-01 04:40:00+05:30
4735	49	2001-07-01 04:40:00+05:30
4736	49	2001-08-01 04:40:00+05:30
4737	49	2001-09-01 04:40:00+05:30
4738	49	2001-10-01 04:40:00+05:30
4739	49	2001-11-01 04:40:00+05:30
4740	49	2001-12-01 04:40:00+05:30
4741	49	2002-01-01 04:40:00+05:30
4742	49	2002-02-01 04:40:00+05:30
4743	49	2002-03-01 04:40:00+05:30
4744	49	2002-04-01 04:40:00+05:30
4745	49	2002-05-01 04:40:00+05:30
4746	49	2002-06-01 04:40:00+05:30
4747	49	2002-07-01 04:40:00+05:30
4748	49	2002-08-01 04:40:00+05:30
4749	49	2002-09-01 04:40:00+05:30
4750	49	2002-10-01 04:40:00+05:30
4751	49	2002-11-01 04:40:00+05:30
4752	49	2002-12-01 04:40:00+05:30
4753	51	1992-01-02 04:40:00+05:30
4754	51	1992-02-01 04:40:00+05:30
4755	51	1992-03-01 04:40:00+05:30
4756	51	1992-04-01 04:40:00+05:30
4757	51	1992-05-01 04:40:00+05:30
4758	51	1992-06-01 04:40:00+05:30
4759	51	1992-07-01 04:40:00+05:30
4760	51	1992-08-01 04:40:00+05:30
4761	51	1992-09-01 04:40:00+05:30
4762	51	1992-10-01 04:40:00+05:30
4763	51	1992-11-01 04:40:00+05:30
4764	51	1992-12-01 04:40:00+05:30
4765	51	1993-01-01 04:40:00+05:30
4766	51	1993-02-01 04:40:00+05:30
4767	51	1993-03-01 04:40:00+05:30
4768	51	1993-04-01 04:40:00+05:30
4769	51	1993-05-01 04:40:00+05:30
4770	51	1993-06-01 04:40:00+05:30
4771	51	1993-07-01 04:40:00+05:30
4772	51	1993-08-01 04:40:00+05:30
4773	51	1993-09-01 04:40:00+05:30
4774	51	1993-10-01 04:40:00+05:30
4775	51	1993-11-01 04:40:00+05:30
4776	51	1993-12-01 04:40:00+05:30
4777	51	1994-01-01 04:40:00+05:30
4778	51	1994-02-01 04:40:00+05:30
4779	51	1994-03-01 04:40:00+05:30
4780	51	1994-04-01 04:40:00+05:30
4781	51	1994-05-01 04:40:00+05:30
4782	51	1994-06-01 04:40:00+05:30
4783	51	1994-07-01 04:40:00+05:30
4784	51	1994-08-01 04:40:00+05:30
4785	51	1994-09-01 04:40:00+05:30
4786	51	1994-10-01 04:40:00+05:30
4787	51	1994-11-01 04:40:00+05:30
4788	51	1994-12-01 04:40:00+05:30
4789	51	1995-01-01 04:40:00+05:30
4790	51	1995-02-01 04:40:00+05:30
4791	51	1995-03-01 04:40:00+05:30
4792	51	1995-04-01 04:40:00+05:30
4793	51	1995-05-01 04:40:00+05:30
4794	51	1995-06-01 04:40:00+05:30
4795	51	1995-07-01 04:40:00+05:30
4796	51	1995-08-01 04:40:00+05:30
4797	51	1995-09-01 04:40:00+05:30
4798	51	1995-10-01 04:40:00+05:30
4799	51	1995-11-01 04:40:00+05:30
4800	51	1995-12-01 04:40:00+05:30
4801	51	1996-01-01 04:40:00+05:30
4802	51	1996-02-01 04:40:00+05:30
4803	51	1996-03-01 04:40:00+05:30
4804	51	1996-04-01 04:40:00+05:30
4805	51	1996-05-01 04:40:00+05:30
4806	51	1996-06-01 04:40:00+05:30
4807	51	1996-07-01 04:40:00+05:30
4808	51	1996-08-01 04:40:00+05:30
4809	51	1996-09-01 04:40:00+05:30
4810	51	1996-10-01 04:40:00+05:30
4811	51	1996-11-01 04:40:00+05:30
4812	51	1996-12-01 04:40:00+05:30
4813	51	1997-01-01 04:40:00+05:30
4814	51	1997-02-01 04:40:00+05:30
4815	51	1997-03-01 04:40:00+05:30
4816	51	1997-04-01 04:40:00+05:30
4817	51	1997-05-01 04:40:00+05:30
4818	51	1997-06-01 04:40:00+05:30
4819	51	1997-07-01 04:40:00+05:30
4820	51	1997-08-01 04:40:00+05:30
4821	51	1997-09-01 04:40:00+05:30
4822	51	1997-10-01 04:40:00+05:30
4823	51	1997-11-01 04:40:00+05:30
4824	51	1997-12-01 04:40:00+05:30
4825	51	1998-01-01 04:40:00+05:30
4826	51	1998-02-01 04:40:00+05:30
4827	51	1998-03-01 04:40:00+05:30
4828	51	1998-04-01 04:40:00+05:30
4829	51	1998-05-01 04:40:00+05:30
4830	51	1998-06-01 04:40:00+05:30
4831	51	1998-07-01 04:40:00+05:30
4832	51	1998-08-01 04:40:00+05:30
4833	51	1998-09-01 04:40:00+05:30
4834	51	1998-10-01 04:40:00+05:30
4835	51	1998-11-01 04:40:00+05:30
4836	51	1998-12-01 04:40:00+05:30
4837	51	1999-01-01 04:40:00+05:30
4838	51	1999-02-01 04:40:00+05:30
4839	51	1999-03-01 04:40:00+05:30
4840	51	1999-04-01 04:40:00+05:30
4841	51	1999-05-01 04:40:00+05:30
4842	51	1999-06-01 04:40:00+05:30
4843	51	1999-07-01 04:40:00+05:30
4844	51	1999-08-01 04:40:00+05:30
4845	51	1999-09-01 04:40:00+05:30
4846	51	1999-10-01 04:40:00+05:30
4847	51	1999-11-01 04:40:00+05:30
4848	51	1999-12-01 04:40:00+05:30
4849	51	2000-01-01 04:40:00+05:30
4850	51	2000-02-01 04:40:00+05:30
4851	51	2000-03-01 04:40:00+05:30
4852	51	2000-04-01 04:40:00+05:30
4853	51	2000-05-01 04:40:00+05:30
4854	51	2000-06-01 04:40:00+05:30
4855	51	2000-07-01 04:40:00+05:30
4856	51	2000-08-01 04:40:00+05:30
4857	51	2000-09-01 04:40:00+05:30
4858	51	2000-10-01 04:40:00+05:30
4859	51	2000-11-01 04:40:00+05:30
4860	51	2000-12-01 04:40:00+05:30
4861	51	2001-01-01 04:40:00+05:30
4862	51	2001-02-01 04:40:00+05:30
4863	51	2001-03-01 04:40:00+05:30
4864	51	2001-04-01 04:40:00+05:30
4865	51	2001-05-01 04:40:00+05:30
4866	51	2001-06-01 04:40:00+05:30
4867	51	2001-07-01 04:40:00+05:30
4868	51	2001-08-01 04:40:00+05:30
4869	51	2001-09-01 04:40:00+05:30
4870	51	2001-10-01 04:40:00+05:30
4871	51	2001-11-01 04:40:00+05:30
4872	51	2001-12-01 04:40:00+05:30
4873	51	2002-01-01 04:40:00+05:30
4874	51	2002-02-01 04:40:00+05:30
4875	51	2002-03-01 04:40:00+05:30
4876	51	2002-04-01 04:40:00+05:30
4877	51	2002-05-01 04:40:00+05:30
4878	51	2002-06-01 04:40:00+05:30
4879	51	2002-07-01 04:40:00+05:30
4880	51	2002-08-01 04:40:00+05:30
4881	51	2002-09-01 04:40:00+05:30
4882	51	2002-10-01 04:40:00+05:30
4883	51	2002-11-01 04:40:00+05:30
4884	51	2002-12-01 04:40:00+05:30
4885	52	1992-01-02 04:40:00+05:30
4886	52	1992-02-01 04:40:00+05:30
4887	52	1992-03-01 04:40:00+05:30
4888	52	1992-04-01 04:40:00+05:30
4889	52	1992-05-01 04:40:00+05:30
4890	52	1992-06-01 04:40:00+05:30
4891	52	1992-07-01 04:40:00+05:30
4892	52	1992-08-01 04:40:00+05:30
4893	52	1992-09-01 04:40:00+05:30
4894	52	1992-10-01 04:40:00+05:30
4895	52	1992-11-01 04:40:00+05:30
4896	52	1992-12-01 04:40:00+05:30
4897	52	1993-01-01 04:40:00+05:30
4898	52	1993-02-01 04:40:00+05:30
4899	52	1993-03-01 04:40:00+05:30
4900	52	1993-04-01 04:40:00+05:30
4901	52	1993-05-01 04:40:00+05:30
4902	52	1993-06-01 04:40:00+05:30
4903	52	1993-07-01 04:40:00+05:30
4904	52	1993-08-01 04:40:00+05:30
4905	52	1993-09-01 04:40:00+05:30
4906	52	1993-10-01 04:40:00+05:30
4907	52	1993-11-01 04:40:00+05:30
4908	52	1993-12-01 04:40:00+05:30
4909	52	1994-01-01 04:40:00+05:30
4910	52	1994-02-01 04:40:00+05:30
4911	52	1994-03-01 04:40:00+05:30
4912	52	1994-04-01 04:40:00+05:30
4913	52	1994-05-01 04:40:00+05:30
4914	52	1994-06-01 04:40:00+05:30
4915	52	1994-07-01 04:40:00+05:30
4916	52	1994-08-01 04:40:00+05:30
4917	52	1994-09-01 04:40:00+05:30
4918	52	1994-10-01 04:40:00+05:30
4919	52	1994-11-01 04:40:00+05:30
4920	52	1994-12-01 04:40:00+05:30
4921	52	1995-01-01 04:40:00+05:30
4922	52	1995-02-01 04:40:00+05:30
4923	52	1995-03-01 04:40:00+05:30
4924	52	1995-04-01 04:40:00+05:30
4925	52	1995-05-01 04:40:00+05:30
4926	52	1995-06-01 04:40:00+05:30
4927	52	1995-07-01 04:40:00+05:30
4928	52	1995-08-01 04:40:00+05:30
4929	52	1995-09-01 04:40:00+05:30
4930	52	1995-10-01 04:40:00+05:30
4931	52	1995-11-01 04:40:00+05:30
4932	52	1995-12-01 04:40:00+05:30
4933	52	1996-01-01 04:40:00+05:30
4934	52	1996-02-01 04:40:00+05:30
4935	52	1996-03-01 04:40:00+05:30
4936	52	1996-04-01 04:40:00+05:30
4937	52	1996-05-01 04:40:00+05:30
4938	52	1996-06-01 04:40:00+05:30
4939	52	1996-07-01 04:40:00+05:30
4940	52	1996-08-01 04:40:00+05:30
4941	52	1996-09-01 04:40:00+05:30
4942	52	1996-10-01 04:40:00+05:30
4943	52	1996-11-01 04:40:00+05:30
4944	52	1996-12-01 04:40:00+05:30
4945	52	1997-01-01 04:40:00+05:30
4946	52	1997-02-01 04:40:00+05:30
4947	52	1997-03-01 04:40:00+05:30
4948	52	1997-04-01 04:40:00+05:30
4949	52	1997-05-01 04:40:00+05:30
4950	52	1997-06-01 04:40:00+05:30
4951	52	1997-07-01 04:40:00+05:30
4952	52	1997-08-01 04:40:00+05:30
4953	52	1997-09-01 04:40:00+05:30
4954	52	1997-10-01 04:40:00+05:30
4955	52	1997-11-01 04:40:00+05:30
4956	52	1997-12-01 04:40:00+05:30
4957	52	1998-01-01 04:40:00+05:30
4958	52	1998-02-01 04:40:00+05:30
4959	52	1998-03-01 04:40:00+05:30
4960	52	1998-04-01 04:40:00+05:30
4961	52	1998-05-01 04:40:00+05:30
4962	52	1998-06-01 04:40:00+05:30
4963	52	1998-07-01 04:40:00+05:30
4964	52	1998-08-01 04:40:00+05:30
4965	52	1998-09-01 04:40:00+05:30
4966	52	1998-10-01 04:40:00+05:30
4967	52	1998-11-01 04:40:00+05:30
4968	52	1998-12-01 04:40:00+05:30
4969	52	1999-01-01 04:40:00+05:30
4970	52	1999-02-01 04:40:00+05:30
4971	52	1999-03-01 04:40:00+05:30
4972	52	1999-04-01 04:40:00+05:30
4973	52	1999-05-01 04:40:00+05:30
4974	52	1999-06-01 04:40:00+05:30
4975	52	1999-07-01 04:40:00+05:30
4976	52	1999-08-01 04:40:00+05:30
4977	52	1999-09-01 04:40:00+05:30
4978	52	1999-10-01 04:40:00+05:30
4979	52	1999-11-01 04:40:00+05:30
4980	52	1999-12-01 04:40:00+05:30
4981	52	2000-01-01 04:40:00+05:30
4982	52	2000-02-01 04:40:00+05:30
4983	52	2000-03-01 04:40:00+05:30
4984	52	2000-04-01 04:40:00+05:30
4985	52	2000-05-01 04:40:00+05:30
4986	52	2000-06-01 04:40:00+05:30
4987	52	2000-07-01 04:40:00+05:30
4988	52	2000-08-01 04:40:00+05:30
4989	52	2000-09-01 04:40:00+05:30
4990	52	2000-10-01 04:40:00+05:30
4991	52	2000-11-01 04:40:00+05:30
4992	52	2000-12-01 04:40:00+05:30
4993	52	2001-01-01 04:40:00+05:30
4994	52	2001-02-01 04:40:00+05:30
4995	52	2001-03-01 04:40:00+05:30
4996	52	2001-04-01 04:40:00+05:30
4997	52	2001-05-01 04:40:00+05:30
4998	52	2001-06-01 04:40:00+05:30
4999	52	2001-07-01 04:40:00+05:30
5000	52	2001-08-01 04:40:00+05:30
5001	52	2001-09-01 04:40:00+05:30
5002	52	2001-10-01 04:40:00+05:30
5003	52	2001-11-01 04:40:00+05:30
5004	52	2001-12-01 04:40:00+05:30
5005	52	2002-01-01 04:40:00+05:30
5006	52	2002-02-01 04:40:00+05:30
5007	52	2002-03-01 04:40:00+05:30
5008	52	2002-04-01 04:40:00+05:30
5009	52	2002-05-01 04:40:00+05:30
5010	52	2002-06-01 04:40:00+05:30
5011	52	2002-07-01 04:40:00+05:30
5012	52	2002-08-01 04:40:00+05:30
5013	52	2002-09-01 04:40:00+05:30
5014	52	2002-10-01 04:40:00+05:30
5015	52	2002-11-01 04:40:00+05:30
5016	52	2002-12-01 04:40:00+05:30
5017	53	1992-01-02 04:40:00+05:30
5018	53	1992-02-01 04:40:00+05:30
5019	53	1992-03-01 04:40:00+05:30
5020	53	1992-04-01 04:40:00+05:30
5021	53	1992-05-01 04:40:00+05:30
5022	53	1992-06-01 04:40:00+05:30
5023	53	1992-07-01 04:40:00+05:30
5024	53	1992-08-01 04:40:00+05:30
5025	53	1992-09-01 04:40:00+05:30
5026	53	1992-10-01 04:40:00+05:30
5027	53	1992-11-01 04:40:00+05:30
5028	53	1992-12-01 04:40:00+05:30
5029	53	1993-01-01 04:40:00+05:30
5030	53	1993-02-01 04:40:00+05:30
5031	53	1993-03-01 04:40:00+05:30
5032	53	1993-04-01 04:40:00+05:30
5033	53	1993-05-01 04:40:00+05:30
5034	53	1993-06-01 04:40:00+05:30
5035	53	1993-07-01 04:40:00+05:30
5036	53	1993-08-01 04:40:00+05:30
5037	53	1993-09-01 04:40:00+05:30
5038	53	1993-10-01 04:40:00+05:30
5039	53	1993-11-01 04:40:00+05:30
5040	53	1993-12-01 04:40:00+05:30
5041	53	1994-01-01 04:40:00+05:30
5042	53	1994-02-01 04:40:00+05:30
5043	53	1994-03-01 04:40:00+05:30
5044	53	1994-04-01 04:40:00+05:30
5045	53	1994-05-01 04:40:00+05:30
5046	53	1994-06-01 04:40:00+05:30
5047	53	1994-07-01 04:40:00+05:30
5048	53	1994-08-01 04:40:00+05:30
5049	53	1994-09-01 04:40:00+05:30
5050	53	1994-10-01 04:40:00+05:30
5051	53	1994-11-01 04:40:00+05:30
5052	53	1994-12-01 04:40:00+05:30
5053	53	1995-01-01 04:40:00+05:30
5054	53	1995-02-01 04:40:00+05:30
5055	53	1995-03-01 04:40:00+05:30
5056	53	1995-04-01 04:40:00+05:30
5057	53	1995-05-01 04:40:00+05:30
5058	53	1995-06-01 04:40:00+05:30
5059	53	1995-07-01 04:40:00+05:30
5060	53	1995-08-01 04:40:00+05:30
5061	53	1995-09-01 04:40:00+05:30
5062	53	1995-10-01 04:40:00+05:30
5063	53	1995-11-01 04:40:00+05:30
5064	53	1995-12-01 04:40:00+05:30
5065	53	1996-01-01 04:40:00+05:30
5066	53	1996-02-01 04:40:00+05:30
5067	53	1996-03-01 04:40:00+05:30
5068	53	1996-04-01 04:40:00+05:30
5069	53	1996-05-01 04:40:00+05:30
5070	53	1996-06-01 04:40:00+05:30
5071	53	1996-07-01 04:40:00+05:30
5072	53	1996-08-01 04:40:00+05:30
5073	53	1996-09-01 04:40:00+05:30
5074	53	1996-10-01 04:40:00+05:30
5075	53	1996-11-01 04:40:00+05:30
5076	53	1996-12-01 04:40:00+05:30
5077	53	1997-01-01 04:40:00+05:30
5078	53	1997-02-01 04:40:00+05:30
5079	53	1997-03-01 04:40:00+05:30
5080	53	1997-04-01 04:40:00+05:30
5081	53	1997-05-01 04:40:00+05:30
5082	53	1997-06-01 04:40:00+05:30
5083	53	1997-07-01 04:40:00+05:30
5084	53	1997-08-01 04:40:00+05:30
5085	53	1997-09-01 04:40:00+05:30
5086	53	1997-10-01 04:40:00+05:30
5087	53	1997-11-01 04:40:00+05:30
5088	53	1997-12-01 04:40:00+05:30
5089	53	1998-01-01 04:40:00+05:30
5090	53	1998-02-01 04:40:00+05:30
5091	53	1998-03-01 04:40:00+05:30
5092	53	1998-04-01 04:40:00+05:30
5093	53	1998-05-01 04:40:00+05:30
5094	53	1998-06-01 04:40:00+05:30
5095	53	1998-07-01 04:40:00+05:30
5096	53	1998-08-01 04:40:00+05:30
5097	53	1998-09-01 04:40:00+05:30
5098	53	1998-10-01 04:40:00+05:30
5099	53	1998-11-01 04:40:00+05:30
5100	53	1998-12-01 04:40:00+05:30
5101	53	1999-01-01 04:40:00+05:30
5102	53	1999-02-01 04:40:00+05:30
5103	53	1999-03-01 04:40:00+05:30
5104	53	1999-04-01 04:40:00+05:30
5105	53	1999-05-01 04:40:00+05:30
5106	53	1999-06-01 04:40:00+05:30
5107	53	1999-07-01 04:40:00+05:30
5108	53	1999-08-01 04:40:00+05:30
5109	53	1999-09-01 04:40:00+05:30
5110	53	1999-10-01 04:40:00+05:30
5111	53	1999-11-01 04:40:00+05:30
5112	53	1999-12-01 04:40:00+05:30
5113	53	2000-01-01 04:40:00+05:30
5114	53	2000-02-01 04:40:00+05:30
5115	53	2000-03-01 04:40:00+05:30
5116	53	2000-04-01 04:40:00+05:30
5117	53	2000-05-01 04:40:00+05:30
5118	53	2000-06-01 04:40:00+05:30
5119	53	2000-07-01 04:40:00+05:30
5120	53	2000-08-01 04:40:00+05:30
5121	53	2000-09-01 04:40:00+05:30
5122	53	2000-10-01 04:40:00+05:30
5123	53	2000-11-01 04:40:00+05:30
5124	53	2000-12-01 04:40:00+05:30
5125	53	2001-01-01 04:40:00+05:30
5126	53	2001-02-01 04:40:00+05:30
5127	53	2001-03-01 04:40:00+05:30
5128	53	2001-04-01 04:40:00+05:30
5129	53	2001-05-01 04:40:00+05:30
5130	53	2001-06-01 04:40:00+05:30
5131	53	2001-07-01 04:40:00+05:30
5132	53	2001-08-01 04:40:00+05:30
5133	53	2001-09-01 04:40:00+05:30
5134	53	2001-10-01 04:40:00+05:30
5135	53	2001-11-01 04:40:00+05:30
5136	53	2001-12-01 04:40:00+05:30
5137	53	2002-01-01 04:40:00+05:30
5138	53	2002-02-01 04:40:00+05:30
5139	53	2002-03-01 04:40:00+05:30
5140	53	2002-04-01 04:40:00+05:30
5141	53	2002-05-01 04:40:00+05:30
5142	53	2002-06-01 04:40:00+05:30
5143	53	2002-07-01 04:40:00+05:30
5144	53	2002-08-01 04:40:00+05:30
5145	53	2002-09-01 04:40:00+05:30
5146	53	2002-10-01 04:40:00+05:30
5147	53	2002-11-01 04:40:00+05:30
5148	53	2002-12-01 04:40:00+05:30
5149	2	1992-01-02 04:40:00+05:30
5150	2	1992-02-01 04:40:00+05:30
5151	2	1992-03-01 04:40:00+05:30
5152	2	1992-04-01 04:40:00+05:30
5153	2	1992-05-01 04:40:00+05:30
5154	2	1992-06-01 04:40:00+05:30
5155	2	1992-07-01 04:40:00+05:30
5156	2	1992-08-01 04:40:00+05:30
5157	2	1992-09-01 04:40:00+05:30
5158	2	1992-10-01 04:40:00+05:30
5159	2	1992-11-01 04:40:00+05:30
5160	2	1992-12-01 04:40:00+05:30
5161	2	1993-01-01 04:40:00+05:30
5162	2	1993-02-01 04:40:00+05:30
5163	2	1993-03-01 04:40:00+05:30
5164	2	1993-04-01 04:40:00+05:30
5165	2	1993-05-01 04:40:00+05:30
5166	2	1993-06-01 04:40:00+05:30
5167	2	1993-07-01 04:40:00+05:30
5168	2	1993-08-01 04:40:00+05:30
5169	2	1993-09-01 04:40:00+05:30
5170	2	1993-10-01 04:40:00+05:30
5171	2	1993-11-01 04:40:00+05:30
5172	2	1993-12-01 04:40:00+05:30
5173	2	1994-01-01 04:40:00+05:30
5174	2	1994-02-01 04:40:00+05:30
5175	2	1994-03-01 04:40:00+05:30
5176	2	1994-04-01 04:40:00+05:30
5177	2	1994-05-01 04:40:00+05:30
5178	2	1994-06-01 04:40:00+05:30
5179	2	1994-07-01 04:40:00+05:30
5180	2	1994-08-01 04:40:00+05:30
5181	2	1994-09-01 04:40:00+05:30
5182	2	1994-10-01 04:40:00+05:30
5183	2	1994-11-01 04:40:00+05:30
5184	2	1994-12-01 04:40:00+05:30
5185	2	1995-01-01 04:40:00+05:30
5186	2	1995-02-01 04:40:00+05:30
5187	2	1995-03-01 04:40:00+05:30
5188	2	1995-04-01 04:40:00+05:30
5189	2	1995-05-01 04:40:00+05:30
5190	2	1995-06-01 04:40:00+05:30
5191	2	1995-07-01 04:40:00+05:30
5192	2	1995-08-01 04:40:00+05:30
5193	2	1995-09-01 04:40:00+05:30
5194	2	1995-10-01 04:40:00+05:30
5195	2	1995-11-01 04:40:00+05:30
5196	2	1995-12-01 04:40:00+05:30
5197	2	1996-01-01 04:40:00+05:30
5198	2	1996-02-01 04:40:00+05:30
5199	2	1996-03-01 04:40:00+05:30
5200	2	1996-04-01 04:40:00+05:30
5201	2	1996-05-01 04:40:00+05:30
5202	2	1996-06-01 04:40:00+05:30
5203	2	1996-07-01 04:40:00+05:30
5204	2	1996-08-01 04:40:00+05:30
5205	2	1996-09-01 04:40:00+05:30
5206	2	1996-10-01 04:40:00+05:30
5207	2	1996-11-01 04:40:00+05:30
5208	2	1996-12-01 04:40:00+05:30
5209	2	1997-01-01 04:40:00+05:30
5210	2	1997-02-01 04:40:00+05:30
5211	2	1997-03-01 04:40:00+05:30
5212	2	1997-04-01 04:40:00+05:30
5213	2	1997-05-01 04:40:00+05:30
5214	2	1997-06-01 04:40:00+05:30
5215	2	1997-07-01 04:40:00+05:30
5216	2	1997-08-01 04:40:00+05:30
5217	2	1997-09-01 04:40:00+05:30
5218	2	1997-10-01 04:40:00+05:30
5219	2	1997-11-01 04:40:00+05:30
5220	2	1997-12-01 04:40:00+05:30
5221	2	1998-01-01 04:40:00+05:30
5222	2	1998-02-01 04:40:00+05:30
5223	2	1998-03-01 04:40:00+05:30
5224	2	1998-04-01 04:40:00+05:30
5225	2	1998-05-01 04:40:00+05:30
5226	2	1998-06-01 04:40:00+05:30
5227	2	1998-07-01 04:40:00+05:30
5228	2	1998-08-01 04:40:00+05:30
5229	2	1998-09-01 04:40:00+05:30
5230	2	1998-10-01 04:40:00+05:30
5231	2	1998-11-01 04:40:00+05:30
5232	2	1998-12-01 04:40:00+05:30
5233	2	1999-01-01 04:40:00+05:30
5234	2	1999-02-01 04:40:00+05:30
5235	2	1999-03-01 04:40:00+05:30
5236	2	1999-04-01 04:40:00+05:30
5237	2	1999-05-01 04:40:00+05:30
5238	2	1999-06-01 04:40:00+05:30
5239	2	1999-07-01 04:40:00+05:30
5240	2	1999-08-01 04:40:00+05:30
5241	2	1999-09-01 04:40:00+05:30
5242	2	1999-10-01 04:40:00+05:30
5243	2	1999-11-01 04:40:00+05:30
5244	2	1999-12-01 04:40:00+05:30
5245	2	2000-01-01 04:40:00+05:30
5246	2	2000-02-01 04:40:00+05:30
5247	2	2000-03-01 04:40:00+05:30
5248	2	2000-04-01 04:40:00+05:30
5249	2	2000-05-01 04:40:00+05:30
5250	2	2000-06-01 04:40:00+05:30
5251	2	2000-07-01 04:40:00+05:30
5252	2	2000-08-01 04:40:00+05:30
5253	2	2000-09-01 04:40:00+05:30
5254	2	2000-10-01 04:40:00+05:30
5255	2	2000-11-01 04:40:00+05:30
5256	2	2000-12-01 04:40:00+05:30
5257	2	2001-01-01 04:40:00+05:30
5258	2	2001-02-01 04:40:00+05:30
5259	2	2001-03-01 04:40:00+05:30
5260	2	2001-04-01 04:40:00+05:30
5261	2	2001-05-01 04:40:00+05:30
5262	2	2001-06-01 04:40:00+05:30
5263	2	2001-07-01 04:40:00+05:30
5264	2	2001-08-01 04:40:00+05:30
5265	2	2001-09-01 04:40:00+05:30
5266	2	2001-10-01 04:40:00+05:30
5267	2	2001-11-01 04:40:00+05:30
5268	2	2001-12-01 04:40:00+05:30
5269	2	2002-01-01 04:40:00+05:30
5270	2	2002-02-01 04:40:00+05:30
5271	2	2002-03-01 04:40:00+05:30
5272	2	2002-04-01 04:40:00+05:30
5273	2	2002-05-01 04:40:00+05:30
5274	2	2002-06-01 04:40:00+05:30
5275	2	2002-07-01 04:40:00+05:30
5276	2	2002-08-01 04:40:00+05:30
5277	2	2002-09-01 04:40:00+05:30
5278	2	2002-10-01 04:40:00+05:30
5279	2	2002-11-01 04:40:00+05:30
5280	2	2002-12-01 04:40:00+05:30
5281	3	1992-01-02 04:40:00+05:30
5282	3	1992-02-01 04:40:00+05:30
5283	3	1992-03-01 04:40:00+05:30
5284	3	1992-04-01 04:40:00+05:30
5285	3	1992-05-01 04:40:00+05:30
5286	3	1992-06-01 04:40:00+05:30
5287	3	1992-07-01 04:40:00+05:30
5288	3	1992-08-01 04:40:00+05:30
5289	3	1992-09-01 04:40:00+05:30
5290	3	1992-10-01 04:40:00+05:30
5291	3	1992-11-01 04:40:00+05:30
5292	3	1992-12-01 04:40:00+05:30
5293	3	1993-01-01 04:40:00+05:30
5294	3	1993-02-01 04:40:00+05:30
5295	3	1993-03-01 04:40:00+05:30
5296	3	1993-04-01 04:40:00+05:30
5297	3	1993-05-01 04:40:00+05:30
5298	3	1993-06-01 04:40:00+05:30
5299	3	1993-07-01 04:40:00+05:30
5300	3	1993-08-01 04:40:00+05:30
5301	3	1993-09-01 04:40:00+05:30
5302	3	1993-10-01 04:40:00+05:30
5303	3	1993-11-01 04:40:00+05:30
5304	3	1993-12-01 04:40:00+05:30
5305	3	1994-01-01 04:40:00+05:30
5306	3	1994-02-01 04:40:00+05:30
5307	3	1994-03-01 04:40:00+05:30
5308	3	1994-04-01 04:40:00+05:30
5309	3	1994-05-01 04:40:00+05:30
5310	3	1994-06-01 04:40:00+05:30
5311	3	1994-07-01 04:40:00+05:30
5312	3	1994-08-01 04:40:00+05:30
5313	3	1994-09-01 04:40:00+05:30
5314	3	1994-10-01 04:40:00+05:30
5315	3	1994-11-01 04:40:00+05:30
5316	3	1994-12-01 04:40:00+05:30
5317	3	1995-01-01 04:40:00+05:30
5318	3	1995-02-01 04:40:00+05:30
5319	3	1995-03-01 04:40:00+05:30
5320	3	1995-04-01 04:40:00+05:30
5321	3	1995-05-01 04:40:00+05:30
5322	3	1995-06-01 04:40:00+05:30
5323	3	1995-07-01 04:40:00+05:30
5324	3	1995-08-01 04:40:00+05:30
5325	3	1995-09-01 04:40:00+05:30
5326	3	1995-10-01 04:40:00+05:30
5327	3	1995-11-01 04:40:00+05:30
5328	3	1995-12-01 04:40:00+05:30
5329	3	1996-01-01 04:40:00+05:30
5330	3	1996-02-01 04:40:00+05:30
5331	3	1996-03-01 04:40:00+05:30
5332	3	1996-04-01 04:40:00+05:30
5333	3	1996-05-01 04:40:00+05:30
5334	3	1996-06-01 04:40:00+05:30
5335	3	1996-07-01 04:40:00+05:30
5336	3	1996-08-01 04:40:00+05:30
5337	3	1996-09-01 04:40:00+05:30
5338	3	1996-10-01 04:40:00+05:30
5339	3	1996-11-01 04:40:00+05:30
5340	3	1996-12-01 04:40:00+05:30
5341	3	1997-01-01 04:40:00+05:30
5342	3	1997-02-01 04:40:00+05:30
5343	3	1997-03-01 04:40:00+05:30
5344	3	1997-04-01 04:40:00+05:30
5345	3	1997-05-01 04:40:00+05:30
5346	3	1997-06-01 04:40:00+05:30
5347	3	1997-07-01 04:40:00+05:30
5348	3	1997-08-01 04:40:00+05:30
5349	3	1997-09-01 04:40:00+05:30
5350	3	1997-10-01 04:40:00+05:30
5351	3	1997-11-01 04:40:00+05:30
5352	3	1997-12-01 04:40:00+05:30
5353	3	1998-01-01 04:40:00+05:30
5354	3	1998-02-01 04:40:00+05:30
5355	3	1998-03-01 04:40:00+05:30
5356	3	1998-04-01 04:40:00+05:30
5357	3	1998-05-01 04:40:00+05:30
5358	3	1998-06-01 04:40:00+05:30
5359	3	1998-07-01 04:40:00+05:30
5360	3	1998-08-01 04:40:00+05:30
5361	3	1998-09-01 04:40:00+05:30
5362	3	1998-10-01 04:40:00+05:30
5363	3	1998-11-01 04:40:00+05:30
5364	3	1998-12-01 04:40:00+05:30
5365	3	1999-01-01 04:40:00+05:30
5366	3	1999-02-01 04:40:00+05:30
5367	3	1999-03-01 04:40:00+05:30
5368	3	1999-04-01 04:40:00+05:30
5369	3	1999-05-01 04:40:00+05:30
5370	3	1999-06-01 04:40:00+05:30
5371	3	1999-07-01 04:40:00+05:30
5372	3	1999-08-01 04:40:00+05:30
5373	3	1999-09-01 04:40:00+05:30
5374	3	1999-10-01 04:40:00+05:30
5375	3	1999-11-01 04:40:00+05:30
5376	3	1999-12-01 04:40:00+05:30
5377	3	2000-01-01 04:40:00+05:30
5378	3	2000-02-01 04:40:00+05:30
5379	3	2000-03-01 04:40:00+05:30
5380	3	2000-04-01 04:40:00+05:30
5381	3	2000-05-01 04:40:00+05:30
5382	3	2000-06-01 04:40:00+05:30
5383	3	2000-07-01 04:40:00+05:30
5384	3	2000-08-01 04:40:00+05:30
5385	3	2000-09-01 04:40:00+05:30
5386	3	2000-10-01 04:40:00+05:30
5387	3	2000-11-01 04:40:00+05:30
5388	3	2000-12-01 04:40:00+05:30
5389	3	2001-01-01 04:40:00+05:30
5390	3	2001-02-01 04:40:00+05:30
5391	3	2001-03-01 04:40:00+05:30
5392	3	2001-04-01 04:40:00+05:30
5393	3	2001-05-01 04:40:00+05:30
5394	3	2001-06-01 04:40:00+05:30
5395	3	2001-07-01 04:40:00+05:30
5396	3	2001-08-01 04:40:00+05:30
5397	3	2001-09-01 04:40:00+05:30
5398	3	2001-10-01 04:40:00+05:30
5399	3	2001-11-01 04:40:00+05:30
5400	3	2001-12-01 04:40:00+05:30
5401	3	2002-01-01 04:40:00+05:30
5402	3	2002-02-01 04:40:00+05:30
5403	3	2002-03-01 04:40:00+05:30
5404	3	2002-04-01 04:40:00+05:30
5405	3	2002-05-01 04:40:00+05:30
5406	3	2002-06-01 04:40:00+05:30
5407	3	2002-07-01 04:40:00+05:30
5408	3	2002-08-01 04:40:00+05:30
5409	3	2002-09-01 04:40:00+05:30
5410	3	2002-10-01 04:40:00+05:30
5411	3	2002-11-01 04:40:00+05:30
5412	3	2002-12-01 04:40:00+05:30
5677	5	1992-01-02 04:40:00+05:30
5678	5	1992-02-01 04:40:00+05:30
5679	5	1992-03-01 04:40:00+05:30
5680	5	1992-04-01 04:40:00+05:30
5681	5	1992-05-01 04:40:00+05:30
5682	5	1992-06-01 04:40:00+05:30
5683	5	1992-07-01 04:40:00+05:30
5684	5	1992-08-01 04:40:00+05:30
5685	5	1992-09-01 04:40:00+05:30
5686	5	1992-10-01 04:40:00+05:30
5687	5	1992-11-01 04:40:00+05:30
5688	5	1992-12-01 04:40:00+05:30
5689	5	1993-01-01 04:40:00+05:30
5690	5	1993-02-01 04:40:00+05:30
5691	5	1993-03-01 04:40:00+05:30
5692	5	1993-04-01 04:40:00+05:30
5693	5	1993-05-01 04:40:00+05:30
5694	5	1993-06-01 04:40:00+05:30
5695	5	1993-07-01 04:40:00+05:30
5696	5	1993-08-01 04:40:00+05:30
5697	5	1993-09-01 04:40:00+05:30
5698	5	1993-10-01 04:40:00+05:30
5699	5	1993-11-01 04:40:00+05:30
5700	5	1993-12-01 04:40:00+05:30
5701	5	1994-01-01 04:40:00+05:30
5702	5	1994-02-01 04:40:00+05:30
5703	5	1994-03-01 04:40:00+05:30
5704	5	1994-04-01 04:40:00+05:30
5705	5	1994-05-01 04:40:00+05:30
5706	5	1994-06-01 04:40:00+05:30
5707	5	1994-07-01 04:40:00+05:30
5708	5	1994-08-01 04:40:00+05:30
5709	5	1994-09-01 04:40:00+05:30
5710	5	1994-10-01 04:40:00+05:30
5711	5	1994-11-01 04:40:00+05:30
5712	5	1994-12-01 04:40:00+05:30
5713	5	1995-01-01 04:40:00+05:30
5714	5	1995-02-01 04:40:00+05:30
5715	5	1995-03-01 04:40:00+05:30
5716	5	1995-04-01 04:40:00+05:30
5717	5	1995-05-01 04:40:00+05:30
5718	5	1995-06-01 04:40:00+05:30
5719	5	1995-07-01 04:40:00+05:30
5720	5	1995-08-01 04:40:00+05:30
5721	5	1995-09-01 04:40:00+05:30
5722	5	1995-10-01 04:40:00+05:30
5723	5	1995-11-01 04:40:00+05:30
5724	5	1995-12-01 04:40:00+05:30
5725	5	1996-01-01 04:40:00+05:30
5726	5	1996-02-01 04:40:00+05:30
5727	5	1996-03-01 04:40:00+05:30
5728	5	1996-04-01 04:40:00+05:30
5729	5	1996-05-01 04:40:00+05:30
5730	5	1996-06-01 04:40:00+05:30
5731	5	1996-07-01 04:40:00+05:30
5732	5	1996-08-01 04:40:00+05:30
5733	5	1996-09-01 04:40:00+05:30
5734	5	1996-10-01 04:40:00+05:30
5735	5	1996-11-01 04:40:00+05:30
5736	5	1996-12-01 04:40:00+05:30
5737	5	1997-01-01 04:40:00+05:30
5738	5	1997-02-01 04:40:00+05:30
5739	5	1997-03-01 04:40:00+05:30
5740	5	1997-04-01 04:40:00+05:30
5741	5	1997-05-01 04:40:00+05:30
5742	5	1997-06-01 04:40:00+05:30
5743	5	1997-07-01 04:40:00+05:30
5744	5	1997-08-01 04:40:00+05:30
5745	5	1997-09-01 04:40:00+05:30
5746	5	1997-10-01 04:40:00+05:30
5747	5	1997-11-01 04:40:00+05:30
5748	5	1997-12-01 04:40:00+05:30
5749	5	1998-01-01 04:40:00+05:30
5750	5	1998-02-01 04:40:00+05:30
5751	5	1998-03-01 04:40:00+05:30
5752	5	1998-04-01 04:40:00+05:30
5753	5	1998-05-01 04:40:00+05:30
5754	5	1998-06-01 04:40:00+05:30
5755	5	1998-07-01 04:40:00+05:30
5756	5	1998-08-01 04:40:00+05:30
5757	5	1998-09-01 04:40:00+05:30
5758	5	1998-10-01 04:40:00+05:30
5759	5	1998-11-01 04:40:00+05:30
5760	5	1998-12-01 04:40:00+05:30
5761	5	1999-01-01 04:40:00+05:30
5762	5	1999-02-01 04:40:00+05:30
5763	5	1999-03-01 04:40:00+05:30
5764	5	1999-04-01 04:40:00+05:30
5765	5	1999-05-01 04:40:00+05:30
5766	5	1999-06-01 04:40:00+05:30
5767	5	1999-07-01 04:40:00+05:30
5768	5	1999-08-01 04:40:00+05:30
5769	5	1999-09-01 04:40:00+05:30
5770	5	1999-10-01 04:40:00+05:30
5771	5	1999-11-01 04:40:00+05:30
5772	5	1999-12-01 04:40:00+05:30
5773	5	2000-01-01 04:40:00+05:30
5774	5	2000-02-01 04:40:00+05:30
5775	5	2000-03-01 04:40:00+05:30
5776	5	2000-04-01 04:40:00+05:30
5777	5	2000-05-01 04:40:00+05:30
5778	5	2000-06-01 04:40:00+05:30
5779	5	2000-07-01 04:40:00+05:30
5780	5	2000-08-01 04:40:00+05:30
5781	5	2000-09-01 04:40:00+05:30
5782	5	2000-10-01 04:40:00+05:30
5783	5	2000-11-01 04:40:00+05:30
5784	5	2000-12-01 04:40:00+05:30
5785	5	2001-01-01 04:40:00+05:30
5786	5	2001-02-01 04:40:00+05:30
5787	5	2001-03-01 04:40:00+05:30
5788	5	2001-04-01 04:40:00+05:30
5789	5	2001-05-01 04:40:00+05:30
5790	5	2001-06-01 04:40:00+05:30
5791	5	2001-07-01 04:40:00+05:30
5792	5	2001-08-01 04:40:00+05:30
5793	5	2001-09-01 04:40:00+05:30
5794	5	2001-10-01 04:40:00+05:30
5795	5	2001-11-01 04:40:00+05:30
5796	5	2001-12-01 04:40:00+05:30
5797	5	2002-01-01 04:40:00+05:30
5798	5	2002-02-01 04:40:00+05:30
5799	5	2002-03-01 04:40:00+05:30
5800	5	2002-04-01 04:40:00+05:30
5801	5	2002-05-01 04:40:00+05:30
5802	5	2002-06-01 04:40:00+05:30
5803	5	2002-07-01 04:40:00+05:30
5804	5	2002-08-01 04:40:00+05:30
5805	5	2002-09-01 04:40:00+05:30
5806	5	2002-10-01 04:40:00+05:30
5807	5	2002-11-01 04:40:00+05:30
5808	5	2002-12-01 04:40:00+05:30
5809	6	1992-01-02 04:40:00+05:30
5810	6	1992-02-01 04:40:00+05:30
5811	6	1992-03-01 04:40:00+05:30
5812	6	1992-04-01 04:40:00+05:30
5813	6	1992-05-01 04:40:00+05:30
5814	6	1992-06-01 04:40:00+05:30
5815	6	1992-07-01 04:40:00+05:30
5816	6	1992-08-01 04:40:00+05:30
5817	6	1992-09-01 04:40:00+05:30
5818	6	1992-10-01 04:40:00+05:30
5819	6	1992-11-01 04:40:00+05:30
5820	6	1992-12-01 04:40:00+05:30
5821	6	1993-01-01 04:40:00+05:30
5822	6	1993-02-01 04:40:00+05:30
5823	6	1993-03-01 04:40:00+05:30
5824	6	1993-04-01 04:40:00+05:30
5825	6	1993-05-01 04:40:00+05:30
5826	6	1993-06-01 04:40:00+05:30
5827	6	1993-07-01 04:40:00+05:30
5828	6	1993-08-01 04:40:00+05:30
5829	6	1993-09-01 04:40:00+05:30
5830	6	1993-10-01 04:40:00+05:30
5831	6	1993-11-01 04:40:00+05:30
5832	6	1993-12-01 04:40:00+05:30
5833	6	1994-01-01 04:40:00+05:30
5834	6	1994-02-01 04:40:00+05:30
5835	6	1994-03-01 04:40:00+05:30
5836	6	1994-04-01 04:40:00+05:30
5837	6	1994-05-01 04:40:00+05:30
5838	6	1994-06-01 04:40:00+05:30
5839	6	1994-07-01 04:40:00+05:30
5840	6	1994-08-01 04:40:00+05:30
5841	6	1994-09-01 04:40:00+05:30
5842	6	1994-10-01 04:40:00+05:30
5843	6	1994-11-01 04:40:00+05:30
5844	6	1994-12-01 04:40:00+05:30
5845	6	1995-01-01 04:40:00+05:30
5846	6	1995-02-01 04:40:00+05:30
5847	6	1995-03-01 04:40:00+05:30
5848	6	1995-04-01 04:40:00+05:30
5849	6	1995-05-01 04:40:00+05:30
5850	6	1995-06-01 04:40:00+05:30
5851	6	1995-07-01 04:40:00+05:30
5852	6	1995-08-01 04:40:00+05:30
5853	6	1995-09-01 04:40:00+05:30
5854	6	1995-10-01 04:40:00+05:30
5855	6	1995-11-01 04:40:00+05:30
5856	6	1995-12-01 04:40:00+05:30
5857	6	1996-01-01 04:40:00+05:30
5858	6	1996-02-01 04:40:00+05:30
5859	6	1996-03-01 04:40:00+05:30
5860	6	1996-04-01 04:40:00+05:30
5861	6	1996-05-01 04:40:00+05:30
5862	6	1996-06-01 04:40:00+05:30
5863	6	1996-07-01 04:40:00+05:30
5864	6	1996-08-01 04:40:00+05:30
5865	6	1996-09-01 04:40:00+05:30
5866	6	1996-10-01 04:40:00+05:30
5867	6	1996-11-01 04:40:00+05:30
5868	6	1996-12-01 04:40:00+05:30
5869	6	1997-01-01 04:40:00+05:30
5870	6	1997-02-01 04:40:00+05:30
5871	6	1997-03-01 04:40:00+05:30
5872	6	1997-04-01 04:40:00+05:30
5873	6	1997-05-01 04:40:00+05:30
5874	6	1997-06-01 04:40:00+05:30
5875	6	1997-07-01 04:40:00+05:30
5876	6	1997-08-01 04:40:00+05:30
5877	6	1997-09-01 04:40:00+05:30
5878	6	1997-10-01 04:40:00+05:30
5879	6	1997-11-01 04:40:00+05:30
5880	6	1997-12-01 04:40:00+05:30
5881	6	1998-01-01 04:40:00+05:30
5882	6	1998-02-01 04:40:00+05:30
5883	6	1998-03-01 04:40:00+05:30
5884	6	1998-04-01 04:40:00+05:30
5885	6	1998-05-01 04:40:00+05:30
5886	6	1998-06-01 04:40:00+05:30
5887	6	1998-07-01 04:40:00+05:30
5888	6	1998-08-01 04:40:00+05:30
5889	6	1998-09-01 04:40:00+05:30
5890	6	1998-10-01 04:40:00+05:30
5891	6	1998-11-01 04:40:00+05:30
5892	6	1998-12-01 04:40:00+05:30
5893	6	1999-01-01 04:40:00+05:30
5894	6	1999-02-01 04:40:00+05:30
5895	6	1999-03-01 04:40:00+05:30
5896	6	1999-04-01 04:40:00+05:30
5897	6	1999-05-01 04:40:00+05:30
5898	6	1999-06-01 04:40:00+05:30
5899	6	1999-07-01 04:40:00+05:30
5900	6	1999-08-01 04:40:00+05:30
5901	6	1999-09-01 04:40:00+05:30
5902	6	1999-10-01 04:40:00+05:30
5903	6	1999-11-01 04:40:00+05:30
5904	6	1999-12-01 04:40:00+05:30
5905	6	2000-01-01 04:40:00+05:30
5906	6	2000-02-01 04:40:00+05:30
5907	6	2000-03-01 04:40:00+05:30
5908	6	2000-04-01 04:40:00+05:30
5909	6	2000-05-01 04:40:00+05:30
5910	6	2000-06-01 04:40:00+05:30
5911	6	2000-07-01 04:40:00+05:30
5912	6	2000-08-01 04:40:00+05:30
5913	6	2000-09-01 04:40:00+05:30
5914	6	2000-10-01 04:40:00+05:30
5915	6	2000-11-01 04:40:00+05:30
5916	6	2000-12-01 04:40:00+05:30
5917	6	2001-01-01 04:40:00+05:30
5918	6	2001-02-01 04:40:00+05:30
5919	6	2001-03-01 04:40:00+05:30
5920	6	2001-04-01 04:40:00+05:30
5921	6	2001-05-01 04:40:00+05:30
5922	6	2001-06-01 04:40:00+05:30
5923	6	2001-07-01 04:40:00+05:30
5924	6	2001-08-01 04:40:00+05:30
5925	6	2001-09-01 04:40:00+05:30
5926	6	2001-10-01 04:40:00+05:30
5927	6	2001-11-01 04:40:00+05:30
5928	6	2001-12-01 04:40:00+05:30
5929	6	2002-01-01 04:40:00+05:30
5930	6	2002-02-01 04:40:00+05:30
5931	6	2002-03-01 04:40:00+05:30
5932	6	2002-04-01 04:40:00+05:30
5933	6	2002-05-01 04:40:00+05:30
5934	6	2002-06-01 04:40:00+05:30
5935	6	2002-07-01 04:40:00+05:30
5936	6	2002-08-01 04:40:00+05:30
5937	6	2002-09-01 04:40:00+05:30
5938	6	2002-10-01 04:40:00+05:30
5939	6	2002-11-01 04:40:00+05:30
5940	6	2002-12-01 04:40:00+05:30
5941	7	1992-01-02 04:40:00+05:30
5942	7	1992-02-01 04:40:00+05:30
5943	7	1992-03-01 04:40:00+05:30
5944	7	1992-04-01 04:40:00+05:30
5945	7	1992-05-01 04:40:00+05:30
5946	7	1992-06-01 04:40:00+05:30
5947	7	1992-07-01 04:40:00+05:30
5948	7	1992-08-01 04:40:00+05:30
5949	7	1992-09-01 04:40:00+05:30
5950	7	1992-10-01 04:40:00+05:30
5951	7	1992-11-01 04:40:00+05:30
5952	7	1992-12-01 04:40:00+05:30
5953	7	1993-01-01 04:40:00+05:30
5954	7	1993-02-01 04:40:00+05:30
5955	7	1993-03-01 04:40:00+05:30
5956	7	1993-04-01 04:40:00+05:30
5957	7	1993-05-01 04:40:00+05:30
5958	7	1993-06-01 04:40:00+05:30
5959	7	1993-07-01 04:40:00+05:30
5960	7	1993-08-01 04:40:00+05:30
5961	7	1993-09-01 04:40:00+05:30
5962	7	1993-10-01 04:40:00+05:30
5963	7	1993-11-01 04:40:00+05:30
5964	7	1993-12-01 04:40:00+05:30
5965	7	1994-01-01 04:40:00+05:30
5966	7	1994-02-01 04:40:00+05:30
5967	7	1994-03-01 04:40:00+05:30
5968	7	1994-04-01 04:40:00+05:30
5969	7	1994-05-01 04:40:00+05:30
5970	7	1994-06-01 04:40:00+05:30
5971	7	1994-07-01 04:40:00+05:30
5972	7	1994-08-01 04:40:00+05:30
5973	7	1994-09-01 04:40:00+05:30
5974	7	1994-10-01 04:40:00+05:30
5975	7	1994-11-01 04:40:00+05:30
5976	7	1994-12-01 04:40:00+05:30
5977	7	1995-01-01 04:40:00+05:30
5978	7	1995-02-01 04:40:00+05:30
5979	7	1995-03-01 04:40:00+05:30
5980	7	1995-04-01 04:40:00+05:30
5981	7	1995-05-01 04:40:00+05:30
5982	7	1995-06-01 04:40:00+05:30
5983	7	1995-07-01 04:40:00+05:30
5984	7	1995-08-01 04:40:00+05:30
5985	7	1995-09-01 04:40:00+05:30
5986	7	1995-10-01 04:40:00+05:30
5987	7	1995-11-01 04:40:00+05:30
5988	7	1995-12-01 04:40:00+05:30
5989	7	1996-01-01 04:40:00+05:30
5990	7	1996-02-01 04:40:00+05:30
5991	7	1996-03-01 04:40:00+05:30
5992	7	1996-04-01 04:40:00+05:30
5993	7	1996-05-01 04:40:00+05:30
5994	7	1996-06-01 04:40:00+05:30
5995	7	1996-07-01 04:40:00+05:30
5996	7	1996-08-01 04:40:00+05:30
5997	7	1996-09-01 04:40:00+05:30
5998	7	1996-10-01 04:40:00+05:30
5999	7	1996-11-01 04:40:00+05:30
6000	7	1996-12-01 04:40:00+05:30
6001	7	1997-01-01 04:40:00+05:30
6002	7	1997-02-01 04:40:00+05:30
6003	7	1997-03-01 04:40:00+05:30
6004	7	1997-04-01 04:40:00+05:30
6005	7	1997-05-01 04:40:00+05:30
6006	7	1997-06-01 04:40:00+05:30
6007	7	1997-07-01 04:40:00+05:30
6008	7	1997-08-01 04:40:00+05:30
6009	7	1997-09-01 04:40:00+05:30
6010	7	1997-10-01 04:40:00+05:30
6011	7	1997-11-01 04:40:00+05:30
6012	7	1997-12-01 04:40:00+05:30
6013	7	1998-01-01 04:40:00+05:30
6014	7	1998-02-01 04:40:00+05:30
6015	7	1998-03-01 04:40:00+05:30
6016	7	1998-04-01 04:40:00+05:30
6017	7	1998-05-01 04:40:00+05:30
6018	7	1998-06-01 04:40:00+05:30
6019	7	1998-07-01 04:40:00+05:30
6020	7	1998-08-01 04:40:00+05:30
6021	7	1998-09-01 04:40:00+05:30
6022	7	1998-10-01 04:40:00+05:30
6023	7	1998-11-01 04:40:00+05:30
6024	7	1998-12-01 04:40:00+05:30
6025	7	1999-01-01 04:40:00+05:30
6026	7	1999-02-01 04:40:00+05:30
6027	7	1999-03-01 04:40:00+05:30
6028	7	1999-04-01 04:40:00+05:30
6029	7	1999-05-01 04:40:00+05:30
6030	7	1999-06-01 04:40:00+05:30
6031	7	1999-07-01 04:40:00+05:30
6032	7	1999-08-01 04:40:00+05:30
6033	7	1999-09-01 04:40:00+05:30
6034	7	1999-10-01 04:40:00+05:30
6035	7	1999-11-01 04:40:00+05:30
6036	7	1999-12-01 04:40:00+05:30
6037	7	2000-01-01 04:40:00+05:30
6038	7	2000-02-01 04:40:00+05:30
6039	7	2000-03-01 04:40:00+05:30
6040	7	2000-04-01 04:40:00+05:30
6041	7	2000-05-01 04:40:00+05:30
6042	7	2000-06-01 04:40:00+05:30
6043	7	2000-07-01 04:40:00+05:30
6044	7	2000-08-01 04:40:00+05:30
6045	7	2000-09-01 04:40:00+05:30
6046	7	2000-10-01 04:40:00+05:30
6047	7	2000-11-01 04:40:00+05:30
6048	7	2000-12-01 04:40:00+05:30
6049	7	2001-01-01 04:40:00+05:30
6050	7	2001-02-01 04:40:00+05:30
6051	7	2001-03-01 04:40:00+05:30
6052	7	2001-04-01 04:40:00+05:30
6053	7	2001-05-01 04:40:00+05:30
6054	7	2001-06-01 04:40:00+05:30
6055	7	2001-07-01 04:40:00+05:30
6056	7	2001-08-01 04:40:00+05:30
6057	7	2001-09-01 04:40:00+05:30
6058	7	2001-10-01 04:40:00+05:30
6059	7	2001-11-01 04:40:00+05:30
6060	7	2001-12-01 04:40:00+05:30
6061	7	2002-01-01 04:40:00+05:30
6062	7	2002-02-01 04:40:00+05:30
6063	7	2002-03-01 04:40:00+05:30
6064	7	2002-04-01 04:40:00+05:30
6065	7	2002-05-01 04:40:00+05:30
6066	7	2002-06-01 04:40:00+05:30
6067	7	2002-07-01 04:40:00+05:30
6068	7	2002-08-01 04:40:00+05:30
6069	7	2002-09-01 04:40:00+05:30
6070	7	2002-10-01 04:40:00+05:30
6071	7	2002-11-01 04:40:00+05:30
6072	7	2002-12-01 04:40:00+05:30
6073	8	1992-01-02 04:40:00+05:30
6074	8	1992-02-01 04:40:00+05:30
6075	8	1992-03-01 04:40:00+05:30
6076	8	1992-04-01 04:40:00+05:30
6077	8	1992-05-01 04:40:00+05:30
6078	8	1992-06-01 04:40:00+05:30
6079	8	1992-07-01 04:40:00+05:30
6080	8	1992-08-01 04:40:00+05:30
6081	8	1992-09-01 04:40:00+05:30
6082	8	1992-10-01 04:40:00+05:30
6083	8	1992-11-01 04:40:00+05:30
6084	8	1992-12-01 04:40:00+05:30
6085	8	1993-01-01 04:40:00+05:30
6086	8	1993-02-01 04:40:00+05:30
6087	8	1993-03-01 04:40:00+05:30
6088	8	1993-04-01 04:40:00+05:30
6089	8	1993-05-01 04:40:00+05:30
6090	8	1993-06-01 04:40:00+05:30
6091	8	1993-07-01 04:40:00+05:30
6092	8	1993-08-01 04:40:00+05:30
6093	8	1993-09-01 04:40:00+05:30
6094	8	1993-10-01 04:40:00+05:30
6095	8	1993-11-01 04:40:00+05:30
6096	8	1993-12-01 04:40:00+05:30
6097	8	1994-01-01 04:40:00+05:30
6098	8	1994-02-01 04:40:00+05:30
6099	8	1994-03-01 04:40:00+05:30
6100	8	1994-04-01 04:40:00+05:30
6101	8	1994-05-01 04:40:00+05:30
6102	8	1994-06-01 04:40:00+05:30
6103	8	1994-07-01 04:40:00+05:30
6104	8	1994-08-01 04:40:00+05:30
6105	8	1994-09-01 04:40:00+05:30
6106	8	1994-10-01 04:40:00+05:30
6107	8	1994-11-01 04:40:00+05:30
6108	8	1994-12-01 04:40:00+05:30
6109	8	1995-01-01 04:40:00+05:30
6110	8	1995-02-01 04:40:00+05:30
6111	8	1995-03-01 04:40:00+05:30
6112	8	1995-04-01 04:40:00+05:30
6113	8	1995-05-01 04:40:00+05:30
6114	8	1995-06-01 04:40:00+05:30
6115	8	1995-07-01 04:40:00+05:30
6116	8	1995-08-01 04:40:00+05:30
6117	8	1995-09-01 04:40:00+05:30
6118	8	1995-10-01 04:40:00+05:30
6119	8	1995-11-01 04:40:00+05:30
6120	8	1995-12-01 04:40:00+05:30
6121	8	1996-01-01 04:40:00+05:30
6122	8	1996-02-01 04:40:00+05:30
6123	8	1996-03-01 04:40:00+05:30
6124	8	1996-04-01 04:40:00+05:30
6125	8	1996-05-01 04:40:00+05:30
6126	8	1996-06-01 04:40:00+05:30
6127	8	1996-07-01 04:40:00+05:30
6128	8	1996-08-01 04:40:00+05:30
6129	8	1996-09-01 04:40:00+05:30
6130	8	1996-10-01 04:40:00+05:30
6131	8	1996-11-01 04:40:00+05:30
6132	8	1996-12-01 04:40:00+05:30
6133	8	1997-01-01 04:40:00+05:30
6134	8	1997-02-01 04:40:00+05:30
6135	8	1997-03-01 04:40:00+05:30
6136	8	1997-04-01 04:40:00+05:30
6137	8	1997-05-01 04:40:00+05:30
6138	8	1997-06-01 04:40:00+05:30
6139	8	1997-07-01 04:40:00+05:30
6140	8	1997-08-01 04:40:00+05:30
6141	8	1997-09-01 04:40:00+05:30
6142	8	1997-10-01 04:40:00+05:30
6143	8	1997-11-01 04:40:00+05:30
6144	8	1997-12-01 04:40:00+05:30
6145	8	1998-01-01 04:40:00+05:30
6146	8	1998-02-01 04:40:00+05:30
6147	8	1998-03-01 04:40:00+05:30
6148	8	1998-04-01 04:40:00+05:30
6149	8	1998-05-01 04:40:00+05:30
6150	8	1998-06-01 04:40:00+05:30
6151	8	1998-07-01 04:40:00+05:30
6152	8	1998-08-01 04:40:00+05:30
6153	8	1998-09-01 04:40:00+05:30
6154	8	1998-10-01 04:40:00+05:30
6155	8	1998-11-01 04:40:00+05:30
6156	8	1998-12-01 04:40:00+05:30
6157	8	1999-01-01 04:40:00+05:30
6158	8	1999-02-01 04:40:00+05:30
6159	8	1999-03-01 04:40:00+05:30
6160	8	1999-04-01 04:40:00+05:30
6161	8	1999-05-01 04:40:00+05:30
6162	8	1999-06-01 04:40:00+05:30
6163	8	1999-07-01 04:40:00+05:30
6164	8	1999-08-01 04:40:00+05:30
6165	8	1999-09-01 04:40:00+05:30
6166	8	1999-10-01 04:40:00+05:30
6167	8	1999-11-01 04:40:00+05:30
6168	8	1999-12-01 04:40:00+05:30
6169	8	2000-01-01 04:40:00+05:30
6170	8	2000-02-01 04:40:00+05:30
6171	8	2000-03-01 04:40:00+05:30
6172	8	2000-04-01 04:40:00+05:30
6173	8	2000-05-01 04:40:00+05:30
6174	8	2000-06-01 04:40:00+05:30
6175	8	2000-07-01 04:40:00+05:30
6176	8	2000-08-01 04:40:00+05:30
6177	8	2000-09-01 04:40:00+05:30
6178	8	2000-10-01 04:40:00+05:30
6179	8	2000-11-01 04:40:00+05:30
6180	8	2000-12-01 04:40:00+05:30
6181	8	2001-01-01 04:40:00+05:30
6182	8	2001-02-01 04:40:00+05:30
6183	8	2001-03-01 04:40:00+05:30
6184	8	2001-04-01 04:40:00+05:30
6185	8	2001-05-01 04:40:00+05:30
6186	8	2001-06-01 04:40:00+05:30
6187	8	2001-07-01 04:40:00+05:30
6188	8	2001-08-01 04:40:00+05:30
6189	8	2001-09-01 04:40:00+05:30
6190	8	2001-10-01 04:40:00+05:30
6191	8	2001-11-01 04:40:00+05:30
6192	8	2001-12-01 04:40:00+05:30
6193	8	2002-01-01 04:40:00+05:30
6194	8	2002-02-01 04:40:00+05:30
6195	8	2002-03-01 04:40:00+05:30
6196	8	2002-04-01 04:40:00+05:30
6197	8	2002-05-01 04:40:00+05:30
6198	8	2002-06-01 04:40:00+05:30
6199	8	2002-07-01 04:40:00+05:30
6200	8	2002-08-01 04:40:00+05:30
6201	8	2002-09-01 04:40:00+05:30
6202	8	2002-10-01 04:40:00+05:30
6203	8	2002-11-01 04:40:00+05:30
6204	8	2002-12-01 04:40:00+05:30
6205	9	1992-01-02 04:40:00+05:30
6206	9	1992-02-01 04:40:00+05:30
6207	9	1992-03-01 04:40:00+05:30
6208	9	1992-04-01 04:40:00+05:30
6209	9	1992-05-01 04:40:00+05:30
6210	9	1992-06-01 04:40:00+05:30
6211	9	1992-07-01 04:40:00+05:30
6212	9	1992-08-01 04:40:00+05:30
6213	9	1992-09-01 04:40:00+05:30
6214	9	1992-10-01 04:40:00+05:30
6215	9	1992-11-01 04:40:00+05:30
6216	9	1992-12-01 04:40:00+05:30
6217	9	1993-01-01 04:40:00+05:30
6218	9	1993-02-01 04:40:00+05:30
6219	9	1993-03-01 04:40:00+05:30
6220	9	1993-04-01 04:40:00+05:30
6221	9	1993-05-01 04:40:00+05:30
6222	9	1993-06-01 04:40:00+05:30
6223	9	1993-07-01 04:40:00+05:30
6224	9	1993-08-01 04:40:00+05:30
6225	9	1993-09-01 04:40:00+05:30
6226	9	1993-10-01 04:40:00+05:30
6227	9	1993-11-01 04:40:00+05:30
6228	9	1993-12-01 04:40:00+05:30
6229	9	1994-01-01 04:40:00+05:30
6230	9	1994-02-01 04:40:00+05:30
6231	9	1994-03-01 04:40:00+05:30
6232	9	1994-04-01 04:40:00+05:30
6233	9	1994-05-01 04:40:00+05:30
6234	9	1994-06-01 04:40:00+05:30
6235	9	1994-07-01 04:40:00+05:30
6236	9	1994-08-01 04:40:00+05:30
6237	9	1994-09-01 04:40:00+05:30
6238	9	1994-10-01 04:40:00+05:30
6239	9	1994-11-01 04:40:00+05:30
6240	9	1994-12-01 04:40:00+05:30
6241	9	1995-01-01 04:40:00+05:30
6242	9	1995-02-01 04:40:00+05:30
6243	9	1995-03-01 04:40:00+05:30
6244	9	1995-04-01 04:40:00+05:30
6245	9	1995-05-01 04:40:00+05:30
6246	9	1995-06-01 04:40:00+05:30
6247	9	1995-07-01 04:40:00+05:30
6248	9	1995-08-01 04:40:00+05:30
6249	9	1995-09-01 04:40:00+05:30
6250	9	1995-10-01 04:40:00+05:30
6251	9	1995-11-01 04:40:00+05:30
6252	9	1995-12-01 04:40:00+05:30
6253	9	1996-01-01 04:40:00+05:30
6254	9	1996-02-01 04:40:00+05:30
6255	9	1996-03-01 04:40:00+05:30
6256	9	1996-04-01 04:40:00+05:30
6257	9	1996-05-01 04:40:00+05:30
6258	9	1996-06-01 04:40:00+05:30
6259	9	1996-07-01 04:40:00+05:30
6260	9	1996-08-01 04:40:00+05:30
6261	9	1996-09-01 04:40:00+05:30
6262	9	1996-10-01 04:40:00+05:30
6263	9	1996-11-01 04:40:00+05:30
6264	9	1996-12-01 04:40:00+05:30
6265	9	1997-01-01 04:40:00+05:30
6266	9	1997-02-01 04:40:00+05:30
6267	9	1997-03-01 04:40:00+05:30
6268	9	1997-04-01 04:40:00+05:30
6269	9	1997-05-01 04:40:00+05:30
6270	9	1997-06-01 04:40:00+05:30
6271	9	1997-07-01 04:40:00+05:30
6272	9	1997-08-01 04:40:00+05:30
6273	9	1997-09-01 04:40:00+05:30
6274	9	1997-10-01 04:40:00+05:30
6275	9	1997-11-01 04:40:00+05:30
6276	9	1997-12-01 04:40:00+05:30
6277	9	1998-01-01 04:40:00+05:30
6278	9	1998-02-01 04:40:00+05:30
6279	9	1998-03-01 04:40:00+05:30
6280	9	1998-04-01 04:40:00+05:30
6281	9	1998-05-01 04:40:00+05:30
6282	9	1998-06-01 04:40:00+05:30
6283	9	1998-07-01 04:40:00+05:30
6284	9	1998-08-01 04:40:00+05:30
6285	9	1998-09-01 04:40:00+05:30
6286	9	1998-10-01 04:40:00+05:30
6287	9	1998-11-01 04:40:00+05:30
6288	9	1998-12-01 04:40:00+05:30
6289	9	1999-01-01 04:40:00+05:30
6290	9	1999-02-01 04:40:00+05:30
6291	9	1999-03-01 04:40:00+05:30
6292	9	1999-04-01 04:40:00+05:30
6293	9	1999-05-01 04:40:00+05:30
6294	9	1999-06-01 04:40:00+05:30
6295	9	1999-07-01 04:40:00+05:30
6296	9	1999-08-01 04:40:00+05:30
6297	9	1999-09-01 04:40:00+05:30
6298	9	1999-10-01 04:40:00+05:30
6299	9	1999-11-01 04:40:00+05:30
6300	9	1999-12-01 04:40:00+05:30
6301	9	2000-01-01 04:40:00+05:30
6302	9	2000-02-01 04:40:00+05:30
6303	9	2000-03-01 04:40:00+05:30
6304	9	2000-04-01 04:40:00+05:30
6305	9	2000-05-01 04:40:00+05:30
6306	9	2000-06-01 04:40:00+05:30
6307	9	2000-07-01 04:40:00+05:30
6308	9	2000-08-01 04:40:00+05:30
6309	9	2000-09-01 04:40:00+05:30
6310	9	2000-10-01 04:40:00+05:30
6311	9	2000-11-01 04:40:00+05:30
6312	9	2000-12-01 04:40:00+05:30
6313	9	2001-01-01 04:40:00+05:30
6314	9	2001-02-01 04:40:00+05:30
6315	9	2001-03-01 04:40:00+05:30
6316	9	2001-04-01 04:40:00+05:30
6317	9	2001-05-01 04:40:00+05:30
6318	9	2001-06-01 04:40:00+05:30
6319	9	2001-07-01 04:40:00+05:30
6320	9	2001-08-01 04:40:00+05:30
6321	9	2001-09-01 04:40:00+05:30
6322	9	2001-10-01 04:40:00+05:30
6323	9	2001-11-01 04:40:00+05:30
6324	9	2001-12-01 04:40:00+05:30
6325	9	2002-01-01 04:40:00+05:30
6326	9	2002-02-01 04:40:00+05:30
6327	9	2002-03-01 04:40:00+05:30
6328	9	2002-04-01 04:40:00+05:30
6329	9	2002-05-01 04:40:00+05:30
6330	9	2002-06-01 04:40:00+05:30
6331	9	2002-07-01 04:40:00+05:30
6332	9	2002-08-01 04:40:00+05:30
6333	9	2002-09-01 04:40:00+05:30
6334	9	2002-10-01 04:40:00+05:30
6335	9	2002-11-01 04:40:00+05:30
6336	9	2002-12-01 04:40:00+05:30
6337	10	1992-01-02 04:40:00+05:30
6338	10	1992-02-01 04:40:00+05:30
6339	10	1992-03-01 04:40:00+05:30
6340	10	1992-04-01 04:40:00+05:30
6341	10	1992-05-01 04:40:00+05:30
6342	10	1992-06-01 04:40:00+05:30
6343	10	1992-07-01 04:40:00+05:30
6344	10	1992-08-01 04:40:00+05:30
6345	10	1992-09-01 04:40:00+05:30
6346	10	1992-10-01 04:40:00+05:30
6347	10	1992-11-01 04:40:00+05:30
6348	10	1992-12-01 04:40:00+05:30
6349	10	1993-01-01 04:40:00+05:30
6350	10	1993-02-01 04:40:00+05:30
6351	10	1993-03-01 04:40:00+05:30
6352	10	1993-04-01 04:40:00+05:30
6353	10	1993-05-01 04:40:00+05:30
6354	10	1993-06-01 04:40:00+05:30
6355	10	1993-07-01 04:40:00+05:30
6356	10	1993-08-01 04:40:00+05:30
6357	10	1993-09-01 04:40:00+05:30
6358	10	1993-10-01 04:40:00+05:30
6359	10	1993-11-01 04:40:00+05:30
6360	10	1993-12-01 04:40:00+05:30
6361	10	1994-01-01 04:40:00+05:30
6362	10	1994-02-01 04:40:00+05:30
6363	10	1994-03-01 04:40:00+05:30
6364	10	1994-04-01 04:40:00+05:30
6365	10	1994-05-01 04:40:00+05:30
6366	10	1994-06-01 04:40:00+05:30
6367	10	1994-07-01 04:40:00+05:30
6368	10	1994-08-01 04:40:00+05:30
6369	10	1994-09-01 04:40:00+05:30
6370	10	1994-10-01 04:40:00+05:30
6371	10	1994-11-01 04:40:00+05:30
6372	10	1994-12-01 04:40:00+05:30
6373	10	1995-01-01 04:40:00+05:30
6374	10	1995-02-01 04:40:00+05:30
6375	10	1995-03-01 04:40:00+05:30
6376	10	1995-04-01 04:40:00+05:30
6377	10	1995-05-01 04:40:00+05:30
6378	10	1995-06-01 04:40:00+05:30
6379	10	1995-07-01 04:40:00+05:30
6380	10	1995-08-01 04:40:00+05:30
6381	10	1995-09-01 04:40:00+05:30
6382	10	1995-10-01 04:40:00+05:30
6383	10	1995-11-01 04:40:00+05:30
6384	10	1995-12-01 04:40:00+05:30
6385	10	1996-01-01 04:40:00+05:30
6386	10	1996-02-01 04:40:00+05:30
6387	10	1996-03-01 04:40:00+05:30
6388	10	1996-04-01 04:40:00+05:30
6389	10	1996-05-01 04:40:00+05:30
6390	10	1996-06-01 04:40:00+05:30
6391	10	1996-07-01 04:40:00+05:30
6392	10	1996-08-01 04:40:00+05:30
6393	10	1996-09-01 04:40:00+05:30
6394	10	1996-10-01 04:40:00+05:30
6395	10	1996-11-01 04:40:00+05:30
6396	10	1996-12-01 04:40:00+05:30
6397	10	1997-01-01 04:40:00+05:30
6398	10	1997-02-01 04:40:00+05:30
6399	10	1997-03-01 04:40:00+05:30
6400	10	1997-04-01 04:40:00+05:30
6401	10	1997-05-01 04:40:00+05:30
6402	10	1997-06-01 04:40:00+05:30
6403	10	1997-07-01 04:40:00+05:30
6404	10	1997-08-01 04:40:00+05:30
6405	10	1997-09-01 04:40:00+05:30
6406	10	1997-10-01 04:40:00+05:30
6407	10	1997-11-01 04:40:00+05:30
6408	10	1997-12-01 04:40:00+05:30
6409	10	1998-01-01 04:40:00+05:30
6410	10	1998-02-01 04:40:00+05:30
6411	10	1998-03-01 04:40:00+05:30
6412	10	1998-04-01 04:40:00+05:30
6413	10	1998-05-01 04:40:00+05:30
6414	10	1998-06-01 04:40:00+05:30
6415	10	1998-07-01 04:40:00+05:30
6416	10	1998-08-01 04:40:00+05:30
6417	10	1998-09-01 04:40:00+05:30
6418	10	1998-10-01 04:40:00+05:30
6419	10	1998-11-01 04:40:00+05:30
6420	10	1998-12-01 04:40:00+05:30
6421	10	1999-01-01 04:40:00+05:30
6422	10	1999-02-01 04:40:00+05:30
6423	10	1999-03-01 04:40:00+05:30
6424	10	1999-04-01 04:40:00+05:30
6425	10	1999-05-01 04:40:00+05:30
6426	10	1999-06-01 04:40:00+05:30
6427	10	1999-07-01 04:40:00+05:30
6428	10	1999-08-01 04:40:00+05:30
6429	10	1999-09-01 04:40:00+05:30
6430	10	1999-10-01 04:40:00+05:30
6431	10	1999-11-01 04:40:00+05:30
6432	10	1999-12-01 04:40:00+05:30
6433	10	2000-01-01 04:40:00+05:30
6434	10	2000-02-01 04:40:00+05:30
6435	10	2000-03-01 04:40:00+05:30
6436	10	2000-04-01 04:40:00+05:30
6437	10	2000-05-01 04:40:00+05:30
6438	10	2000-06-01 04:40:00+05:30
6439	10	2000-07-01 04:40:00+05:30
6440	10	2000-08-01 04:40:00+05:30
6441	10	2000-09-01 04:40:00+05:30
6442	10	2000-10-01 04:40:00+05:30
6443	10	2000-11-01 04:40:00+05:30
6444	10	2000-12-01 04:40:00+05:30
6445	10	2001-01-01 04:40:00+05:30
6446	10	2001-02-01 04:40:00+05:30
6447	10	2001-03-01 04:40:00+05:30
6448	10	2001-04-01 04:40:00+05:30
6449	10	2001-05-01 04:40:00+05:30
6450	10	2001-06-01 04:40:00+05:30
6451	10	2001-07-01 04:40:00+05:30
6452	10	2001-08-01 04:40:00+05:30
6453	10	2001-09-01 04:40:00+05:30
6454	10	2001-10-01 04:40:00+05:30
6455	10	2001-11-01 04:40:00+05:30
6456	10	2001-12-01 04:40:00+05:30
6457	10	2002-01-01 04:40:00+05:30
6458	10	2002-02-01 04:40:00+05:30
6459	10	2002-03-01 04:40:00+05:30
6460	10	2002-04-01 04:40:00+05:30
6461	10	2002-05-01 04:40:00+05:30
6462	10	2002-06-01 04:40:00+05:30
6463	10	2002-07-01 04:40:00+05:30
6464	10	2002-08-01 04:40:00+05:30
6465	10	2002-09-01 04:40:00+05:30
6466	10	2002-10-01 04:40:00+05:30
6467	10	2002-11-01 04:40:00+05:30
6468	10	2002-12-01 04:40:00+05:30
6469	11	1992-01-02 04:40:00+05:30
6470	11	1992-02-01 04:40:00+05:30
6471	11	1992-03-01 04:40:00+05:30
6472	11	1992-04-01 04:40:00+05:30
6473	11	1992-05-01 04:40:00+05:30
6474	11	1992-06-01 04:40:00+05:30
6475	11	1992-07-01 04:40:00+05:30
6476	11	1992-08-01 04:40:00+05:30
6477	11	1992-09-01 04:40:00+05:30
6478	11	1992-10-01 04:40:00+05:30
6479	11	1992-11-01 04:40:00+05:30
6480	11	1992-12-01 04:40:00+05:30
6481	11	1993-01-01 04:40:00+05:30
6482	11	1993-02-01 04:40:00+05:30
6483	11	1993-03-01 04:40:00+05:30
6484	11	1993-04-01 04:40:00+05:30
6485	11	1993-05-01 04:40:00+05:30
6486	11	1993-06-01 04:40:00+05:30
6487	11	1993-07-01 04:40:00+05:30
6488	11	1993-08-01 04:40:00+05:30
6489	11	1993-09-01 04:40:00+05:30
6490	11	1993-10-01 04:40:00+05:30
6491	11	1993-11-01 04:40:00+05:30
6492	11	1993-12-01 04:40:00+05:30
6493	11	1994-01-01 04:40:00+05:30
6494	11	1994-02-01 04:40:00+05:30
6495	11	1994-03-01 04:40:00+05:30
6496	11	1994-04-01 04:40:00+05:30
6497	11	1994-05-01 04:40:00+05:30
6498	11	1994-06-01 04:40:00+05:30
6499	11	1994-07-01 04:40:00+05:30
6500	11	1994-08-01 04:40:00+05:30
6501	11	1994-09-01 04:40:00+05:30
6502	11	1994-10-01 04:40:00+05:30
6503	11	1994-11-01 04:40:00+05:30
6504	11	1994-12-01 04:40:00+05:30
6505	11	1995-01-01 04:40:00+05:30
6506	11	1995-02-01 04:40:00+05:30
6507	11	1995-03-01 04:40:00+05:30
6508	11	1995-04-01 04:40:00+05:30
6509	11	1995-05-01 04:40:00+05:30
6510	11	1995-06-01 04:40:00+05:30
6511	11	1995-07-01 04:40:00+05:30
6512	11	1995-08-01 04:40:00+05:30
6513	11	1995-09-01 04:40:00+05:30
6514	11	1995-10-01 04:40:00+05:30
6515	11	1995-11-01 04:40:00+05:30
6516	11	1995-12-01 04:40:00+05:30
6517	11	1996-01-01 04:40:00+05:30
6518	11	1996-02-01 04:40:00+05:30
6519	11	1996-03-01 04:40:00+05:30
6520	11	1996-04-01 04:40:00+05:30
6521	11	1996-05-01 04:40:00+05:30
6522	11	1996-06-01 04:40:00+05:30
6523	11	1996-07-01 04:40:00+05:30
6524	11	1996-08-01 04:40:00+05:30
6525	11	1996-09-01 04:40:00+05:30
6526	11	1996-10-01 04:40:00+05:30
6527	11	1996-11-01 04:40:00+05:30
6528	11	1996-12-01 04:40:00+05:30
6529	11	1997-01-01 04:40:00+05:30
6530	11	1997-02-01 04:40:00+05:30
6531	11	1997-03-01 04:40:00+05:30
6532	11	1997-04-01 04:40:00+05:30
6533	11	1997-05-01 04:40:00+05:30
6534	11	1997-06-01 04:40:00+05:30
6535	11	1997-07-01 04:40:00+05:30
6536	11	1997-08-01 04:40:00+05:30
6537	11	1997-09-01 04:40:00+05:30
6538	11	1997-10-01 04:40:00+05:30
6539	11	1997-11-01 04:40:00+05:30
6540	11	1997-12-01 04:40:00+05:30
6541	11	1998-01-01 04:40:00+05:30
6542	11	1998-02-01 04:40:00+05:30
6543	11	1998-03-01 04:40:00+05:30
6544	11	1998-04-01 04:40:00+05:30
6545	11	1998-05-01 04:40:00+05:30
6546	11	1998-06-01 04:40:00+05:30
6547	11	1998-07-01 04:40:00+05:30
6548	11	1998-08-01 04:40:00+05:30
6549	11	1998-09-01 04:40:00+05:30
6550	11	1998-10-01 04:40:00+05:30
6551	11	1998-11-01 04:40:00+05:30
6552	11	1998-12-01 04:40:00+05:30
6553	11	1999-01-01 04:40:00+05:30
6554	11	1999-02-01 04:40:00+05:30
6555	11	1999-03-01 04:40:00+05:30
6556	11	1999-04-01 04:40:00+05:30
6557	11	1999-05-01 04:40:00+05:30
6558	11	1999-06-01 04:40:00+05:30
6559	11	1999-07-01 04:40:00+05:30
6560	11	1999-08-01 04:40:00+05:30
6561	11	1999-09-01 04:40:00+05:30
6562	11	1999-10-01 04:40:00+05:30
6563	11	1999-11-01 04:40:00+05:30
6564	11	1999-12-01 04:40:00+05:30
6565	11	2000-01-01 04:40:00+05:30
6566	11	2000-02-01 04:40:00+05:30
6567	11	2000-03-01 04:40:00+05:30
6568	11	2000-04-01 04:40:00+05:30
6569	11	2000-05-01 04:40:00+05:30
6570	11	2000-06-01 04:40:00+05:30
6571	11	2000-07-01 04:40:00+05:30
6572	11	2000-08-01 04:40:00+05:30
6573	11	2000-09-01 04:40:00+05:30
6574	11	2000-10-01 04:40:00+05:30
6575	11	2000-11-01 04:40:00+05:30
6576	11	2000-12-01 04:40:00+05:30
6577	11	2001-01-01 04:40:00+05:30
6578	11	2001-02-01 04:40:00+05:30
6579	11	2001-03-01 04:40:00+05:30
6580	11	2001-04-01 04:40:00+05:30
6581	11	2001-05-01 04:40:00+05:30
6582	11	2001-06-01 04:40:00+05:30
6583	11	2001-07-01 04:40:00+05:30
6584	11	2001-08-01 04:40:00+05:30
6585	11	2001-09-01 04:40:00+05:30
6586	11	2001-10-01 04:40:00+05:30
6587	11	2001-11-01 04:40:00+05:30
6588	11	2001-12-01 04:40:00+05:30
6589	11	2002-01-01 04:40:00+05:30
6590	11	2002-02-01 04:40:00+05:30
6591	11	2002-03-01 04:40:00+05:30
6592	11	2002-04-01 04:40:00+05:30
6593	11	2002-05-01 04:40:00+05:30
6594	11	2002-06-01 04:40:00+05:30
6595	11	2002-07-01 04:40:00+05:30
6596	11	2002-08-01 04:40:00+05:30
6597	11	2002-09-01 04:40:00+05:30
6598	11	2002-10-01 04:40:00+05:30
6599	11	2002-11-01 04:40:00+05:30
6600	11	2002-12-01 04:40:00+05:30
6601	12	1992-01-02 04:40:00+05:30
6602	12	1992-02-01 04:40:00+05:30
6603	12	1992-03-01 04:40:00+05:30
6604	12	1992-04-01 04:40:00+05:30
6605	12	1992-05-01 04:40:00+05:30
6606	12	1992-06-01 04:40:00+05:30
6607	12	1992-07-01 04:40:00+05:30
6608	12	1992-08-01 04:40:00+05:30
6609	12	1992-09-01 04:40:00+05:30
6610	12	1992-10-01 04:40:00+05:30
6611	12	1992-11-01 04:40:00+05:30
6612	12	1992-12-01 04:40:00+05:30
6613	12	1993-01-01 04:40:00+05:30
6614	12	1993-02-01 04:40:00+05:30
6615	12	1993-03-01 04:40:00+05:30
6616	12	1993-04-01 04:40:00+05:30
6617	12	1993-05-01 04:40:00+05:30
6618	12	1993-06-01 04:40:00+05:30
6619	12	1993-07-01 04:40:00+05:30
6620	12	1993-08-01 04:40:00+05:30
6621	12	1993-09-01 04:40:00+05:30
6622	12	1993-10-01 04:40:00+05:30
6623	12	1993-11-01 04:40:00+05:30
6624	12	1993-12-01 04:40:00+05:30
6625	12	1994-01-01 04:40:00+05:30
6626	12	1994-02-01 04:40:00+05:30
6627	12	1994-03-01 04:40:00+05:30
6628	12	1994-04-01 04:40:00+05:30
6629	12	1994-05-01 04:40:00+05:30
6630	12	1994-06-01 04:40:00+05:30
6631	12	1994-07-01 04:40:00+05:30
6632	12	1994-08-01 04:40:00+05:30
6633	12	1994-09-01 04:40:00+05:30
6634	12	1994-10-01 04:40:00+05:30
6635	12	1994-11-01 04:40:00+05:30
6636	12	1994-12-01 04:40:00+05:30
6637	12	1995-01-01 04:40:00+05:30
6638	12	1995-02-01 04:40:00+05:30
6639	12	1995-03-01 04:40:00+05:30
6640	12	1995-04-01 04:40:00+05:30
6641	12	1995-05-01 04:40:00+05:30
6642	12	1995-06-01 04:40:00+05:30
6643	12	1995-07-01 04:40:00+05:30
6644	12	1995-08-01 04:40:00+05:30
6645	12	1995-09-01 04:40:00+05:30
6646	12	1995-10-01 04:40:00+05:30
6647	12	1995-11-01 04:40:00+05:30
6648	12	1995-12-01 04:40:00+05:30
6649	12	1996-01-01 04:40:00+05:30
6650	12	1996-02-01 04:40:00+05:30
6651	12	1996-03-01 04:40:00+05:30
6652	12	1996-04-01 04:40:00+05:30
6653	12	1996-05-01 04:40:00+05:30
6654	12	1996-06-01 04:40:00+05:30
6655	12	1996-07-01 04:40:00+05:30
6656	12	1996-08-01 04:40:00+05:30
6657	12	1996-09-01 04:40:00+05:30
6658	12	1996-10-01 04:40:00+05:30
6659	12	1996-11-01 04:40:00+05:30
6660	12	1996-12-01 04:40:00+05:30
6661	12	1997-01-01 04:40:00+05:30
6662	12	1997-02-01 04:40:00+05:30
6663	12	1997-03-01 04:40:00+05:30
6664	12	1997-04-01 04:40:00+05:30
6665	12	1997-05-01 04:40:00+05:30
6666	12	1997-06-01 04:40:00+05:30
6667	12	1997-07-01 04:40:00+05:30
6668	12	1997-08-01 04:40:00+05:30
6669	12	1997-09-01 04:40:00+05:30
6670	12	1997-10-01 04:40:00+05:30
6671	12	1997-11-01 04:40:00+05:30
6672	12	1997-12-01 04:40:00+05:30
6673	12	1998-01-01 04:40:00+05:30
6674	12	1998-02-01 04:40:00+05:30
6675	12	1998-03-01 04:40:00+05:30
6676	12	1998-04-01 04:40:00+05:30
6677	12	1998-05-01 04:40:00+05:30
6678	12	1998-06-01 04:40:00+05:30
6679	12	1998-07-01 04:40:00+05:30
6680	12	1998-08-01 04:40:00+05:30
6681	12	1998-09-01 04:40:00+05:30
6682	12	1998-10-01 04:40:00+05:30
6683	12	1998-11-01 04:40:00+05:30
6684	12	1998-12-01 04:40:00+05:30
6685	12	1999-01-01 04:40:00+05:30
6686	12	1999-02-01 04:40:00+05:30
6687	12	1999-03-01 04:40:00+05:30
6688	12	1999-04-01 04:40:00+05:30
6689	12	1999-05-01 04:40:00+05:30
6690	12	1999-06-01 04:40:00+05:30
6691	12	1999-07-01 04:40:00+05:30
6692	12	1999-08-01 04:40:00+05:30
6693	12	1999-09-01 04:40:00+05:30
6694	12	1999-10-01 04:40:00+05:30
6695	12	1999-11-01 04:40:00+05:30
6696	12	1999-12-01 04:40:00+05:30
6697	12	2000-01-01 04:40:00+05:30
6698	12	2000-02-01 04:40:00+05:30
6699	12	2000-03-01 04:40:00+05:30
6700	12	2000-04-01 04:40:00+05:30
6701	12	2000-05-01 04:40:00+05:30
6702	12	2000-06-01 04:40:00+05:30
6703	12	2000-07-01 04:40:00+05:30
6704	12	2000-08-01 04:40:00+05:30
6705	12	2000-09-01 04:40:00+05:30
6706	12	2000-10-01 04:40:00+05:30
6707	12	2000-11-01 04:40:00+05:30
6708	12	2000-12-01 04:40:00+05:30
6709	12	2001-01-01 04:40:00+05:30
6710	12	2001-02-01 04:40:00+05:30
6711	12	2001-03-01 04:40:00+05:30
6712	12	2001-04-01 04:40:00+05:30
6713	12	2001-05-01 04:40:00+05:30
6714	12	2001-06-01 04:40:00+05:30
6715	12	2001-07-01 04:40:00+05:30
6716	12	2001-08-01 04:40:00+05:30
6717	12	2001-09-01 04:40:00+05:30
6718	12	2001-10-01 04:40:00+05:30
6719	12	2001-11-01 04:40:00+05:30
6720	12	2001-12-01 04:40:00+05:30
6721	12	2002-01-01 04:40:00+05:30
6722	12	2002-02-01 04:40:00+05:30
6723	12	2002-03-01 04:40:00+05:30
6724	12	2002-04-01 04:40:00+05:30
6725	12	2002-05-01 04:40:00+05:30
6726	12	2002-06-01 04:40:00+05:30
6727	12	2002-07-01 04:40:00+05:30
6728	12	2002-08-01 04:40:00+05:30
6729	12	2002-09-01 04:40:00+05:30
6730	12	2002-10-01 04:40:00+05:30
6731	12	2002-11-01 04:40:00+05:30
6732	12	2002-12-01 04:40:00+05:30
6733	14	1992-01-02 04:40:00+05:30
6734	14	1992-02-01 04:40:00+05:30
6735	14	1992-03-01 04:40:00+05:30
6736	14	1992-04-01 04:40:00+05:30
6737	14	1992-05-01 04:40:00+05:30
6738	14	1992-06-01 04:40:00+05:30
6739	14	1992-07-01 04:40:00+05:30
6740	14	1992-08-01 04:40:00+05:30
6741	14	1992-09-01 04:40:00+05:30
6742	14	1992-10-01 04:40:00+05:30
6743	14	1992-11-01 04:40:00+05:30
6744	14	1992-12-01 04:40:00+05:30
6745	14	1993-01-01 04:40:00+05:30
6746	14	1993-02-01 04:40:00+05:30
6747	14	1993-03-01 04:40:00+05:30
6748	14	1993-04-01 04:40:00+05:30
6749	14	1993-05-01 04:40:00+05:30
6750	14	1993-06-01 04:40:00+05:30
6751	14	1993-07-01 04:40:00+05:30
6752	14	1993-08-01 04:40:00+05:30
6753	14	1993-09-01 04:40:00+05:30
6754	14	1993-10-01 04:40:00+05:30
6755	14	1993-11-01 04:40:00+05:30
6756	14	1993-12-01 04:40:00+05:30
6757	14	1994-01-01 04:40:00+05:30
6758	14	1994-02-01 04:40:00+05:30
6759	14	1994-03-01 04:40:00+05:30
6760	14	1994-04-01 04:40:00+05:30
6761	14	1994-05-01 04:40:00+05:30
6762	14	1994-06-01 04:40:00+05:30
6763	14	1994-07-01 04:40:00+05:30
6764	14	1994-08-01 04:40:00+05:30
6765	14	1994-09-01 04:40:00+05:30
6766	14	1994-10-01 04:40:00+05:30
6767	14	1994-11-01 04:40:00+05:30
6768	14	1994-12-01 04:40:00+05:30
6769	14	1995-01-01 04:40:00+05:30
6770	14	1995-02-01 04:40:00+05:30
6771	14	1995-03-01 04:40:00+05:30
6772	14	1995-04-01 04:40:00+05:30
6773	14	1995-05-01 04:40:00+05:30
6774	14	1995-06-01 04:40:00+05:30
6775	14	1995-07-01 04:40:00+05:30
6776	14	1995-08-01 04:40:00+05:30
6777	14	1995-09-01 04:40:00+05:30
6778	14	1995-10-01 04:40:00+05:30
6779	14	1995-11-01 04:40:00+05:30
6780	14	1995-12-01 04:40:00+05:30
6781	14	1996-01-01 04:40:00+05:30
6782	14	1996-02-01 04:40:00+05:30
6783	14	1996-03-01 04:40:00+05:30
6784	14	1996-04-01 04:40:00+05:30
6785	14	1996-05-01 04:40:00+05:30
6786	14	1996-06-01 04:40:00+05:30
6787	14	1996-07-01 04:40:00+05:30
6788	14	1996-08-01 04:40:00+05:30
6789	14	1996-09-01 04:40:00+05:30
6790	14	1996-10-01 04:40:00+05:30
6791	14	1996-11-01 04:40:00+05:30
6792	14	1996-12-01 04:40:00+05:30
6793	14	1997-01-01 04:40:00+05:30
6794	14	1997-02-01 04:40:00+05:30
6795	14	1997-03-01 04:40:00+05:30
6796	14	1997-04-01 04:40:00+05:30
6797	14	1997-05-01 04:40:00+05:30
6798	14	1997-06-01 04:40:00+05:30
6799	14	1997-07-01 04:40:00+05:30
6800	14	1997-08-01 04:40:00+05:30
6801	14	1997-09-01 04:40:00+05:30
6802	14	1997-10-01 04:40:00+05:30
6803	14	1997-11-01 04:40:00+05:30
6804	14	1997-12-01 04:40:00+05:30
6805	14	1998-01-01 04:40:00+05:30
6806	14	1998-02-01 04:40:00+05:30
6807	14	1998-03-01 04:40:00+05:30
6808	14	1998-04-01 04:40:00+05:30
6809	14	1998-05-01 04:40:00+05:30
6810	14	1998-06-01 04:40:00+05:30
6811	14	1998-07-01 04:40:00+05:30
6812	14	1998-08-01 04:40:00+05:30
6813	14	1998-09-01 04:40:00+05:30
6814	14	1998-10-01 04:40:00+05:30
6815	14	1998-11-01 04:40:00+05:30
6816	14	1998-12-01 04:40:00+05:30
6817	14	1999-01-01 04:40:00+05:30
6818	14	1999-02-01 04:40:00+05:30
6819	14	1999-03-01 04:40:00+05:30
6820	14	1999-04-01 04:40:00+05:30
6821	14	1999-05-01 04:40:00+05:30
6822	14	1999-06-01 04:40:00+05:30
6823	14	1999-07-01 04:40:00+05:30
6824	14	1999-08-01 04:40:00+05:30
6825	14	1999-09-01 04:40:00+05:30
6826	14	1999-10-01 04:40:00+05:30
6827	14	1999-11-01 04:40:00+05:30
6828	14	1999-12-01 04:40:00+05:30
6829	14	2000-01-01 04:40:00+05:30
6830	14	2000-02-01 04:40:00+05:30
6831	14	2000-03-01 04:40:00+05:30
6832	14	2000-04-01 04:40:00+05:30
6833	14	2000-05-01 04:40:00+05:30
6834	14	2000-06-01 04:40:00+05:30
6835	14	2000-07-01 04:40:00+05:30
6836	14	2000-08-01 04:40:00+05:30
6837	14	2000-09-01 04:40:00+05:30
6838	14	2000-10-01 04:40:00+05:30
6839	14	2000-11-01 04:40:00+05:30
6840	14	2000-12-01 04:40:00+05:30
6841	14	2001-01-01 04:40:00+05:30
6842	14	2001-02-01 04:40:00+05:30
6843	14	2001-03-01 04:40:00+05:30
6844	14	2001-04-01 04:40:00+05:30
6845	14	2001-05-01 04:40:00+05:30
6846	14	2001-06-01 04:40:00+05:30
6847	14	2001-07-01 04:40:00+05:30
6848	14	2001-08-01 04:40:00+05:30
6849	14	2001-09-01 04:40:00+05:30
6850	14	2001-10-01 04:40:00+05:30
6851	14	2001-11-01 04:40:00+05:30
6852	14	2001-12-01 04:40:00+05:30
6853	14	2002-01-01 04:40:00+05:30
6854	14	2002-02-01 04:40:00+05:30
6855	14	2002-03-01 04:40:00+05:30
6856	14	2002-04-01 04:40:00+05:30
6857	14	2002-05-01 04:40:00+05:30
6858	14	2002-06-01 04:40:00+05:30
6859	14	2002-07-01 04:40:00+05:30
6860	14	2002-08-01 04:40:00+05:30
6861	14	2002-09-01 04:40:00+05:30
6862	14	2002-10-01 04:40:00+05:30
6863	14	2002-11-01 04:40:00+05:30
6864	14	2002-12-01 04:40:00+05:30
6865	21	1992-01-02 04:40:00+05:30
6866	21	1992-02-01 04:40:00+05:30
6867	21	1992-03-01 04:40:00+05:30
6868	21	1992-04-01 04:40:00+05:30
6869	21	1992-05-01 04:40:00+05:30
6870	21	1992-06-01 04:40:00+05:30
6871	21	1992-07-01 04:40:00+05:30
6872	21	1992-08-01 04:40:00+05:30
6873	21	1992-09-01 04:40:00+05:30
6874	21	1992-10-01 04:40:00+05:30
6875	21	1992-11-01 04:40:00+05:30
6876	21	1992-12-01 04:40:00+05:30
6877	21	1993-01-01 04:40:00+05:30
6878	21	1993-02-01 04:40:00+05:30
6879	21	1993-03-01 04:40:00+05:30
6880	21	1993-04-01 04:40:00+05:30
6881	21	1993-05-01 04:40:00+05:30
6882	21	1993-06-01 04:40:00+05:30
6883	21	1993-07-01 04:40:00+05:30
6884	21	1993-08-01 04:40:00+05:30
6885	21	1993-09-01 04:40:00+05:30
6886	21	1993-10-01 04:40:00+05:30
6887	21	1993-11-01 04:40:00+05:30
6888	21	1993-12-01 04:40:00+05:30
6889	21	1994-01-01 04:40:00+05:30
6890	21	1994-02-01 04:40:00+05:30
6891	21	1994-03-01 04:40:00+05:30
6892	21	1994-04-01 04:40:00+05:30
6893	21	1994-05-01 04:40:00+05:30
6894	21	1994-06-01 04:40:00+05:30
6895	21	1994-07-01 04:40:00+05:30
6896	21	1994-08-01 04:40:00+05:30
6897	21	1994-09-01 04:40:00+05:30
6898	21	1994-10-01 04:40:00+05:30
6899	21	1994-11-01 04:40:00+05:30
6900	21	1994-12-01 04:40:00+05:30
6901	21	1995-01-01 04:40:00+05:30
6902	21	1995-02-01 04:40:00+05:30
6903	21	1995-03-01 04:40:00+05:30
6904	21	1995-04-01 04:40:00+05:30
6905	21	1995-05-01 04:40:00+05:30
6906	21	1995-06-01 04:40:00+05:30
6907	21	1995-07-01 04:40:00+05:30
6908	21	1995-08-01 04:40:00+05:30
6909	21	1995-09-01 04:40:00+05:30
6910	21	1995-10-01 04:40:00+05:30
6911	21	1995-11-01 04:40:00+05:30
6912	21	1995-12-01 04:40:00+05:30
6913	21	1996-01-01 04:40:00+05:30
6914	21	1996-02-01 04:40:00+05:30
6915	21	1996-03-01 04:40:00+05:30
6916	21	1996-04-01 04:40:00+05:30
6917	21	1996-05-01 04:40:00+05:30
6918	21	1996-06-01 04:40:00+05:30
6919	21	1996-07-01 04:40:00+05:30
6920	21	1996-08-01 04:40:00+05:30
6921	21	1996-09-01 04:40:00+05:30
6922	21	1996-10-01 04:40:00+05:30
6923	21	1996-11-01 04:40:00+05:30
6924	21	1996-12-01 04:40:00+05:30
6925	21	1997-01-01 04:40:00+05:30
6926	21	1997-02-01 04:40:00+05:30
6927	21	1997-03-01 04:40:00+05:30
6928	21	1997-04-01 04:40:00+05:30
6929	21	1997-05-01 04:40:00+05:30
6930	21	1997-06-01 04:40:00+05:30
6931	21	1997-07-01 04:40:00+05:30
6932	21	1997-08-01 04:40:00+05:30
6933	21	1997-09-01 04:40:00+05:30
6934	21	1997-10-01 04:40:00+05:30
6935	21	1997-11-01 04:40:00+05:30
6936	21	1997-12-01 04:40:00+05:30
6937	21	1998-01-01 04:40:00+05:30
6938	21	1998-02-01 04:40:00+05:30
6939	21	1998-03-01 04:40:00+05:30
6940	21	1998-04-01 04:40:00+05:30
6941	21	1998-05-01 04:40:00+05:30
6942	21	1998-06-01 04:40:00+05:30
6943	21	1998-07-01 04:40:00+05:30
6944	21	1998-08-01 04:40:00+05:30
6945	21	1998-09-01 04:40:00+05:30
6946	21	1998-10-01 04:40:00+05:30
6947	21	1998-11-01 04:40:00+05:30
6948	21	1998-12-01 04:40:00+05:30
6949	21	1999-01-01 04:40:00+05:30
6950	21	1999-02-01 04:40:00+05:30
6951	21	1999-03-01 04:40:00+05:30
6952	21	1999-04-01 04:40:00+05:30
6953	21	1999-05-01 04:40:00+05:30
6954	21	1999-06-01 04:40:00+05:30
6955	21	1999-07-01 04:40:00+05:30
6956	21	1999-08-01 04:40:00+05:30
6957	21	1999-09-01 04:40:00+05:30
6958	21	1999-10-01 04:40:00+05:30
6959	21	1999-11-01 04:40:00+05:30
6960	21	1999-12-01 04:40:00+05:30
6961	21	2000-01-01 04:40:00+05:30
6962	21	2000-02-01 04:40:00+05:30
6963	21	2000-03-01 04:40:00+05:30
6964	21	2000-04-01 04:40:00+05:30
6965	21	2000-05-01 04:40:00+05:30
6966	21	2000-06-01 04:40:00+05:30
6967	21	2000-07-01 04:40:00+05:30
6968	21	2000-08-01 04:40:00+05:30
6969	21	2000-09-01 04:40:00+05:30
6970	21	2000-10-01 04:40:00+05:30
6971	21	2000-11-01 04:40:00+05:30
6972	21	2000-12-01 04:40:00+05:30
6973	21	2001-01-01 04:40:00+05:30
6974	21	2001-02-01 04:40:00+05:30
6975	21	2001-03-01 04:40:00+05:30
6976	21	2001-04-01 04:40:00+05:30
6977	21	2001-05-01 04:40:00+05:30
6978	21	2001-06-01 04:40:00+05:30
6979	21	2001-07-01 04:40:00+05:30
6980	21	2001-08-01 04:40:00+05:30
6981	21	2001-09-01 04:40:00+05:30
6982	21	2001-10-01 04:40:00+05:30
6983	21	2001-11-01 04:40:00+05:30
6984	21	2001-12-01 04:40:00+05:30
6985	21	2002-01-01 04:40:00+05:30
6986	21	2002-02-01 04:40:00+05:30
6987	21	2002-03-01 04:40:00+05:30
6988	21	2002-04-01 04:40:00+05:30
6989	21	2002-05-01 04:40:00+05:30
6990	21	2002-06-01 04:40:00+05:30
6991	21	2002-07-01 04:40:00+05:30
6992	21	2002-08-01 04:40:00+05:30
6993	21	2002-09-01 04:40:00+05:30
6994	21	2002-10-01 04:40:00+05:30
6995	21	2002-11-01 04:40:00+05:30
6996	21	2002-12-01 04:40:00+05:30
6997	4	1992-01-02 04:40:00+05:30
6998	4	1992-02-01 04:40:00+05:30
6999	4	1992-03-01 04:40:00+05:30
7000	4	1992-04-01 04:40:00+05:30
7001	4	1992-05-01 04:40:00+05:30
7002	4	1992-06-01 04:40:00+05:30
7003	4	1992-07-01 04:40:00+05:30
7004	4	1992-08-01 04:40:00+05:30
7005	4	1992-09-01 04:40:00+05:30
7006	4	1992-10-01 04:40:00+05:30
7007	4	1992-11-01 04:40:00+05:30
7008	4	1992-12-01 04:40:00+05:30
7009	4	1993-01-01 04:40:00+05:30
7010	4	1993-02-01 04:40:00+05:30
7011	4	1993-03-01 04:40:00+05:30
7012	4	1993-04-01 04:40:00+05:30
7013	4	1993-05-01 04:40:00+05:30
7014	4	1993-06-01 04:40:00+05:30
7015	4	1993-07-01 04:40:00+05:30
7016	4	1993-08-01 04:40:00+05:30
7017	4	1993-09-01 04:40:00+05:30
7018	4	1993-10-01 04:40:00+05:30
7019	4	1993-11-01 04:40:00+05:30
7020	4	1993-12-01 04:40:00+05:30
7021	4	1994-01-01 04:40:00+05:30
7022	4	1994-02-01 04:40:00+05:30
7023	4	1994-03-01 04:40:00+05:30
7024	4	1994-04-01 04:40:00+05:30
7025	4	1994-05-01 04:40:00+05:30
7026	4	1994-06-01 04:40:00+05:30
7027	4	1994-07-01 04:40:00+05:30
7028	4	1994-08-01 04:40:00+05:30
7029	4	1994-09-01 04:40:00+05:30
7030	4	1994-10-01 04:40:00+05:30
7031	4	1994-11-01 04:40:00+05:30
7032	4	1994-12-01 04:40:00+05:30
7033	4	1995-01-01 04:40:00+05:30
7034	4	1995-02-01 04:40:00+05:30
7035	4	1995-03-01 04:40:00+05:30
7036	4	1995-04-01 04:40:00+05:30
7037	4	1995-05-01 04:40:00+05:30
7038	4	1995-06-01 04:40:00+05:30
7039	4	1995-07-01 04:40:00+05:30
7040	4	1995-08-01 04:40:00+05:30
7041	4	1995-09-01 04:40:00+05:30
7042	4	1995-10-01 04:40:00+05:30
7043	4	1995-11-01 04:40:00+05:30
7044	4	1995-12-01 04:40:00+05:30
7045	4	1996-01-01 04:40:00+05:30
7046	4	1996-02-01 04:40:00+05:30
7047	4	1996-03-01 04:40:00+05:30
7048	4	1996-04-01 04:40:00+05:30
7049	4	1996-05-01 04:40:00+05:30
7050	4	1996-06-01 04:40:00+05:30
7051	4	1996-07-01 04:40:00+05:30
7052	4	1996-08-01 04:40:00+05:30
7053	4	1996-09-01 04:40:00+05:30
7054	4	1996-10-01 04:40:00+05:30
7055	4	1996-11-01 04:40:00+05:30
7056	4	1996-12-01 04:40:00+05:30
7057	4	1997-01-01 04:40:00+05:30
7058	4	1997-02-01 04:40:00+05:30
7059	4	1997-03-01 04:40:00+05:30
7060	4	1997-04-01 04:40:00+05:30
7061	4	1997-05-01 04:40:00+05:30
7062	4	1997-06-01 04:40:00+05:30
7063	4	1997-07-01 04:40:00+05:30
7064	4	1997-08-01 04:40:00+05:30
7065	4	1997-09-01 04:40:00+05:30
7066	4	1997-10-01 04:40:00+05:30
7067	4	1997-11-01 04:40:00+05:30
7068	4	1997-12-01 04:40:00+05:30
7069	4	1998-01-01 04:40:00+05:30
7070	4	1998-02-01 04:40:00+05:30
7071	4	1998-03-01 04:40:00+05:30
7072	4	1998-04-01 04:40:00+05:30
7073	4	1998-05-01 04:40:00+05:30
7074	4	1998-06-01 04:40:00+05:30
7075	4	1998-07-01 04:40:00+05:30
7076	4	1998-08-01 04:40:00+05:30
7077	4	1998-09-01 04:40:00+05:30
7078	4	1998-10-01 04:40:00+05:30
7079	4	1998-11-01 04:40:00+05:30
7080	4	1998-12-01 04:40:00+05:30
7081	4	1999-01-01 04:40:00+05:30
7082	4	1999-02-01 04:40:00+05:30
7083	4	1999-03-01 04:40:00+05:30
7084	4	1999-04-01 04:40:00+05:30
7085	4	1999-05-01 04:40:00+05:30
7086	4	1999-06-01 04:40:00+05:30
7087	4	1999-07-01 04:40:00+05:30
7088	4	1999-08-01 04:40:00+05:30
7089	4	1999-09-01 04:40:00+05:30
7090	4	1999-10-01 04:40:00+05:30
7091	4	1999-11-01 04:40:00+05:30
7092	4	1999-12-01 04:40:00+05:30
7093	4	2000-01-01 04:40:00+05:30
7094	4	2000-02-01 04:40:00+05:30
7095	4	2000-03-01 04:40:00+05:30
7096	4	2000-04-01 04:40:00+05:30
7097	4	2000-05-01 04:40:00+05:30
7098	4	2000-06-01 04:40:00+05:30
7099	4	2000-07-01 04:40:00+05:30
7100	4	2000-08-01 04:40:00+05:30
7101	4	2000-09-01 04:40:00+05:30
7102	4	2000-10-01 04:40:00+05:30
7103	4	2000-11-01 04:40:00+05:30
7104	4	2000-12-01 04:40:00+05:30
7105	4	2001-01-01 04:40:00+05:30
7106	4	2001-02-01 04:40:00+05:30
7107	4	2001-03-01 04:40:00+05:30
7108	4	2001-04-01 04:40:00+05:30
7109	4	2001-05-01 04:40:00+05:30
7110	4	2001-06-01 04:40:00+05:30
7111	4	2001-07-01 04:40:00+05:30
7112	4	2001-08-01 04:40:00+05:30
7113	4	2001-09-01 04:40:00+05:30
7114	4	2001-10-01 04:40:00+05:30
7115	4	2001-11-01 04:40:00+05:30
7116	4	2001-12-01 04:40:00+05:30
7117	4	2002-01-01 04:40:00+05:30
7118	4	2002-02-01 04:40:00+05:30
7119	4	2002-03-01 04:40:00+05:30
7120	4	2002-04-01 04:40:00+05:30
7121	4	2002-05-01 04:40:00+05:30
7122	4	2002-06-01 04:40:00+05:30
7123	4	2002-07-01 04:40:00+05:30
7124	4	2002-08-01 04:40:00+05:30
7125	4	2002-09-01 04:40:00+05:30
7126	4	2002-10-01 04:40:00+05:30
7127	4	2002-11-01 04:40:00+05:30
7128	4	2002-12-01 04:40:00+05:30
\.


--
-- Name: event_time_id_eti_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('event_time_id_eti_seq', 7128, true);


--
-- Data for Name: feature_type; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY feature_type (name_fty, id_fty) FROM stdin;
Point	1
\.


--
-- Name: feature_type_id_fty_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('feature_type_id_fty_seq', 1, true);


--
-- Data for Name: foi; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY foi (desc_foi, id_fty_fk, id_foi, name_foi, geom_foi) FROM stdin;
NULL	1	3	AizwalCity	01010000A0E610000004E78C28ED2D5740EEEBC03923BA37400000000000000000
NULL	1	4	AurangabadCity	01010000A0E61000003108AC1C5A18554090A0F831E6BE38400000000000000000
NULL	1	5	BathindaCity	01010000A0E61000008D976E1283BC5240BC74931804363E400000000000000000
NULL	1	7	BikanerCity	01010000A0E6100000D5E76A2BF653524012143FC6DC053C400000000000000000
NULL	1	8	BokaroCity	01010000A0E61000003D9B559FAB8955407A36AB3E57AB37400000000000000000
NULL	1	9	ChandigarhCity	01010000A0E610000027A089B0E131534024287E8CB9BB3E400000000000000000
NULL	1	11	DadraandNagarHaveliCity	01010000A0E61000005BD3BCE314415240AED85F764F2E34400000000000000000
NULL	1	12	DarjeelingCity	01010000A0E6100000302AA913D0105640F0A7C64B37093B400000000000000000
NULL	1	13	DarrangCity	01010000A0E610000092CB7F48BF01574016FBCBEEC9733A400000000000000000
NULL	1	14	GhaziabadCity	01010000A0E610000030BB270F0B5D5340B37BF2B050AB3C400000000000000000
NULL	1	15	IdukkiCity	01010000A0E6100000C3F5285C8F465340BC96900F7AD623400000000000000000
NULL	1	16	JaintiaHillsCity	01010000A0E610000027A089B0E1155740545227A0898039400000000000000000
NULL	1	17	KargilCity	01010000A0E6100000BF0E9C33A208534090A0F831E64641400000000000000000
NULL	1	18	KohimaCity	01010000A0E61000003411363CBD865740462575029AA839400000000000000000
NULL	1	19	MuzaffarpurCity	01010000A0E61000007A36AB3E575755401E166A4DF31E3A400000000000000000
NULL	1	20	NewDelhiCity	01010000A0E61000004C378941604D5340B003E78C289D3C400000000000000000
NULL	1	21	PondicherryCity	01010000A0E6100000E3A59BC420F45340F9A067B3EAD327400000000000000000
NULL	1	22	PuriCity	01010000A0E6100000F0A7C64B3775554000917EFB3AD033400000000000000000
NULL	1	23	RaigarhCity	01010000A0E6100000933A014D84D55440A7E8482EFF0136400000000000000000
NULL	1	24	ShimlaCity	01010000A0E6100000174850FC184B5340ED9E3C2CD41A3F400000000000000000
NULL	1	25	VijayawadaCity	01010000A0E6100000B6F3FDD478295440363CBD52968130400000000000000000
NULL	1	26	WestKamengCity	01010000A0E6100000DE9387855A135740B29DEFA7C64B27400000000000000000
NULL	1	28	VijaywadaCity	01010000A0E6100000B6F3FDD478295440363CBD52968130400000000000000000
NULL	1	6	BengaluruCity	01010000A0E6100000E78C28ED0D6653405396218E75F129400000000000000000
NULL	1	29	DadraNagarCity	01010000A0E61000005BD3BCE314415240AED85F764F2E34400000000000000000
NULL	1	30	MuzaffapurCity	01010000A0E61000007A36AB3E575755401E166A4DF31E3A400000000000000000
NULL	1	10	ChennaiCity	01010000A0E6100000BEC117265311544027C286A7572A2A400000000000000000
NULL	1	1	YavatmalCity	01010000A0E61000006519E25817875340CBA145B6F31D34400000000000000000
NULL	1	2	AhmedabadCity	01010000A0E6100000CD3B4ED191245240F6285C8FC20537400000000000000000
NULL	1	27	DelhiCity	01010000A0E61000004C378941604D5340B003E78C289D3C400000000000000000
\.


--
-- Name: foi_id_foi_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('foi_id_foi_seq', 30, true);


--
-- Data for Name: measures; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY measures (id_msr, id_eti_fk, id_qi_fk, id_pro_fk, val_msr) FROM stdin;
1	1	100	160	72.571400
2	2	100	160	72.571400
3	3	100	160	72.571400
4	4	100	160	72.571400
5	5	100	160	72.571400
6	6	100	160	72.571400
7	7	100	160	72.571400
8	8	100	160	72.571400
9	9	100	160	72.571400
10	10	100	160	72.571400
11	11	100	160	72.571400
12	12	100	160	72.571400
13	13	100	160	72.571400
14	14	100	160	72.571400
15	15	100	160	72.571400
16	16	100	160	72.571400
17	17	100	160	72.571400
18	18	100	160	72.571400
19	19	100	160	72.571400
20	20	100	160	72.571400
21	21	100	160	72.571400
22	22	100	160	72.571400
23	23	100	160	72.571400
24	24	100	160	72.571400
25	25	100	160	72.571400
26	26	100	160	72.571400
27	27	100	160	72.571400
28	28	100	160	72.571400
29	29	100	160	72.571400
30	30	100	160	72.571400
31	31	100	160	72.571400
32	32	100	160	72.571400
33	33	100	160	72.571400
34	34	100	160	72.571400
35	35	100	160	72.571400
36	36	100	160	72.571400
37	37	100	160	72.571400
38	38	100	160	72.571400
39	39	100	160	72.571400
40	40	100	160	72.571400
41	41	100	160	72.571400
42	42	100	160	72.571400
43	43	100	160	72.571400
44	44	100	160	72.571400
45	45	100	160	72.571400
46	46	100	160	72.571400
47	47	100	160	72.571400
48	48	100	160	72.571400
49	49	100	160	72.571400
50	50	100	160	72.571400
51	51	100	160	72.571400
52	52	100	160	72.571400
53	53	100	160	72.571400
54	54	100	160	72.571400
55	55	100	160	72.571400
56	56	100	160	72.571400
57	57	100	160	72.571400
58	58	100	160	72.571400
59	59	100	160	72.571400
60	60	100	160	72.571400
61	61	100	160	72.571400
62	62	100	160	72.571400
63	63	100	160	72.571400
64	64	100	160	72.571400
65	65	100	160	72.571400
66	66	100	160	72.571400
67	67	100	160	72.571400
68	68	100	160	72.571400
69	69	100	160	72.571400
70	70	100	160	72.571400
71	71	100	160	72.571400
72	72	100	160	72.571400
73	73	100	160	72.571400
74	74	100	160	72.571400
75	75	100	160	72.571400
76	76	100	160	72.571400
77	77	100	160	72.571400
78	78	100	160	72.571400
79	79	100	160	72.571400
80	80	100	160	72.571400
81	81	100	160	72.571400
82	82	100	160	72.571400
83	83	100	160	72.571400
84	84	100	160	72.571400
85	85	100	160	72.571400
86	86	100	160	72.571400
87	87	100	160	72.571400
88	88	100	160	72.571400
89	89	100	160	72.571400
90	90	100	160	72.571400
91	91	100	160	72.571400
92	92	100	160	72.571400
93	93	100	160	72.571400
94	94	100	160	72.571400
95	95	100	160	72.571400
96	96	100	160	72.571400
97	97	100	160	72.571400
98	98	100	160	72.571400
99	99	100	160	72.571400
100	100	100	160	72.571400
101	101	100	160	72.571400
102	102	100	160	72.571400
103	103	100	160	72.571400
104	104	100	160	72.571400
105	105	100	160	72.571400
106	106	100	160	72.571400
107	107	100	160	72.571400
108	108	100	160	72.571400
109	109	100	160	72.571400
110	110	100	160	72.571400
111	111	100	160	72.571400
112	112	100	160	72.571400
113	113	100	160	72.571400
114	114	100	160	72.571400
115	115	100	160	72.571400
116	116	100	160	72.571400
117	117	100	160	72.571400
118	118	100	160	72.571400
119	119	100	160	72.571400
120	120	100	160	72.571400
121	121	100	160	72.571400
122	122	100	160	72.571400
123	123	100	160	72.571400
124	124	100	160	72.571400
125	125	100	160	72.571400
126	126	100	160	72.571400
127	127	100	160	72.571400
128	128	100	160	72.571400
129	129	100	160	72.571400
130	130	100	160	72.571400
131	131	100	160	72.571400
132	132	100	160	72.571400
133	1	200	162	5.950000
134	2	200	162	6.500000
135	3	200	162	7.550000
136	4	200	162	8.370000
137	5	200	162	8.710000
138	6	200	162	7.530000
139	7	200	162	5.950000
140	8	200	162	5.440000
141	9	200	162	6.040000
142	10	200	162	6.930000
143	11	200	162	6.380000
144	12	200	162	5.870000
145	13	200	162	5.930000
146	14	200	162	6.710000
147	15	200	162	7.590000
148	16	200	162	8.410000
149	17	200	162	8.760000
150	18	200	162	7.550000
151	19	200	162	5.890000
152	20	200	162	5.430000
153	21	200	162	6.090000
154	22	200	162	6.980000
155	23	200	162	6.470000
156	24	200	162	5.890000
157	25	200	162	6.000000
158	26	200	162	6.560000
159	27	200	162	7.650000
160	28	200	162	8.470000
161	29	200	162	8.810000
162	30	200	162	7.530000
163	31	200	162	5.800000
164	32	200	162	5.380000
165	33	200	162	6.070000
166	34	200	162	6.930000
167	35	200	162	6.440000
168	36	200	162	5.830000
169	37	200	162	5.810000
170	38	200	162	6.630000
171	39	200	162	7.540000
172	40	200	162	8.380000
173	41	200	162	8.740000
174	42	200	162	7.560000
175	43	200	162	5.960000
176	44	200	162	5.430000
177	45	200	162	6.060000
178	46	200	162	7.030000
179	47	200	162	6.490000
180	48	200	162	5.830000
181	49	200	162	5.900000
182	50	200	162	6.640000
183	51	200	162	7.620000
184	52	200	162	8.510000
185	53	200	162	8.890000
186	54	200	162	7.500000
187	55	200	162	5.960000
188	56	200	162	5.300000
189	57	200	162	5.640000
190	58	200	162	6.850000
191	59	200	162	6.420000
192	60	200	162	5.960000
193	61	200	162	5.890000
194	62	200	162	6.560000
195	63	200	162	7.560000
196	64	200	162	8.290000
197	65	200	162	8.810000
198	66	200	162	7.360000
199	67	200	162	6.020000
200	68	200	162	5.430000
201	69	200	162	6.160000
202	70	200	162	7.040000
203	71	200	162	6.380000
204	72	200	162	5.760000
205	73	200	162	5.880000
206	74	200	162	6.560000
207	75	200	162	7.550000
208	76	200	162	8.440000
209	77	200	162	8.890000
210	78	200	162	7.610000
211	79	200	162	5.980000
212	80	200	162	5.440000
213	81	200	162	5.980000
214	82	200	162	6.970000
215	83	200	162	6.380000
216	84	200	162	5.840000
217	85	200	162	5.860000
218	86	200	162	6.550000
219	87	200	162	7.620000
220	88	200	162	8.560000
221	89	200	162	8.630000
222	90	200	162	7.360000
223	91	200	162	5.850000
224	92	200	162	5.430000
225	93	200	162	6.180000
226	94	200	162	6.970000
227	95	200	162	6.380000
228	96	200	162	5.830000
229	97	200	162	6.000000
230	98	200	162	6.520000
231	99	200	162	7.500000
232	100	200	162	8.570000
233	101	200	162	8.790000
234	102	200	162	7.540000
235	103	200	162	5.880000
236	104	200	162	5.480000
237	105	200	162	6.150000
238	106	200	162	7.040000
239	107	200	162	6.410000
240	108	200	162	5.960000
241	109	200	162	5.930000
242	110	200	162	6.500000
243	111	200	162	7.480000
244	112	200	162	8.500000
245	113	200	162	8.850000
246	114	200	162	7.270000
247	115	200	162	5.620000
248	116	200	162	5.350000
249	117	200	162	6.270000
250	118	200	162	6.890000
251	119	200	162	6.420000
252	120	200	162	5.920000
253	121	200	162	5.860000
254	122	200	162	6.520000
255	123	200	162	7.440000
256	124	200	162	8.330000
257	125	200	162	8.610000
258	126	200	162	7.480000
259	127	200	162	6.030000
260	128	200	162	5.210000
261	129	200	162	6.230000
262	130	200	162	7.030000
263	131	200	162	6.320000
264	132	200	162	5.800000
265	1	100	161	23.022500
266	2	100	161	23.022500
267	3	100	161	23.022500
268	4	100	161	23.022500
269	5	100	161	23.022500
270	6	100	161	23.022500
271	7	100	161	23.022500
272	8	100	161	23.022500
273	9	100	161	23.022500
274	10	100	161	23.022500
275	11	100	161	23.022500
276	12	100	161	23.022500
277	13	100	161	23.022500
278	14	100	161	23.022500
279	15	100	161	23.022500
280	16	100	161	23.022500
281	17	100	161	23.022500
282	18	100	161	23.022500
283	19	100	161	23.022500
284	20	100	161	23.022500
285	21	100	161	23.022500
286	22	100	161	23.022500
287	23	100	161	23.022500
288	24	100	161	23.022500
289	25	100	161	23.022500
290	26	100	161	23.022500
291	27	100	161	23.022500
292	28	100	161	23.022500
293	29	100	161	23.022500
294	30	100	161	23.022500
295	31	100	161	23.022500
296	32	100	161	23.022500
297	33	100	161	23.022500
298	34	100	161	23.022500
299	35	100	161	23.022500
300	36	100	161	23.022500
301	37	100	161	23.022500
302	38	100	161	23.022500
303	39	100	161	23.022500
304	40	100	161	23.022500
305	41	100	161	23.022500
306	42	100	161	23.022500
307	43	100	161	23.022500
308	44	100	161	23.022500
309	45	100	161	23.022500
310	46	100	161	23.022500
311	47	100	161	23.022500
312	48	100	161	23.022500
313	49	100	161	23.022500
314	50	100	161	23.022500
315	51	100	161	23.022500
316	52	100	161	23.022500
317	53	100	161	23.022500
318	54	100	161	23.022500
319	55	100	161	23.022500
320	56	100	161	23.022500
321	57	100	161	23.022500
322	58	100	161	23.022500
323	59	100	161	23.022500
324	60	100	161	23.022500
325	61	100	161	23.022500
326	62	100	161	23.022500
327	63	100	161	23.022500
328	64	100	161	23.022500
329	65	100	161	23.022500
330	66	100	161	23.022500
331	67	100	161	23.022500
332	68	100	161	23.022500
333	69	100	161	23.022500
334	70	100	161	23.022500
335	71	100	161	23.022500
336	72	100	161	23.022500
337	73	100	161	23.022500
338	74	100	161	23.022500
339	75	100	161	23.022500
340	76	100	161	23.022500
341	77	100	161	23.022500
342	78	100	161	23.022500
343	79	100	161	23.022500
344	80	100	161	23.022500
345	81	100	161	23.022500
346	82	100	161	23.022500
347	83	100	161	23.022500
348	84	100	161	23.022500
349	85	100	161	23.022500
350	86	100	161	23.022500
351	87	100	161	23.022500
352	88	100	161	23.022500
353	89	100	161	23.022500
354	90	100	161	23.022500
355	91	100	161	23.022500
356	92	100	161	23.022500
357	93	100	161	23.022500
358	94	100	161	23.022500
359	95	100	161	23.022500
360	96	100	161	23.022500
361	97	100	161	23.022500
362	98	100	161	23.022500
363	99	100	161	23.022500
364	100	100	161	23.022500
365	101	100	161	23.022500
366	102	100	161	23.022500
367	103	100	161	23.022500
368	104	100	161	23.022500
369	105	100	161	23.022500
370	106	100	161	23.022500
371	107	100	161	23.022500
372	108	100	161	23.022500
373	109	100	161	23.022500
374	110	100	161	23.022500
375	111	100	161	23.022500
376	112	100	161	23.022500
377	113	100	161	23.022500
378	114	100	161	23.022500
379	115	100	161	23.022500
380	116	100	161	23.022500
381	117	100	161	23.022500
382	118	100	161	23.022500
383	119	100	161	23.022500
384	120	100	161	23.022500
385	121	100	161	23.022500
386	122	100	161	23.022500
387	123	100	161	23.022500
388	124	100	161	23.022500
389	125	100	161	23.022500
390	126	100	161	23.022500
391	127	100	161	23.022500
392	128	100	161	23.022500
393	129	100	161	23.022500
394	130	100	161	23.022500
395	131	100	161	23.022500
396	132	100	161	23.022500
397	133	100	164	23.727100
398	134	100	164	23.727100
399	135	100	164	23.727100
400	136	100	164	23.727100
401	137	100	164	23.727100
402	138	100	164	23.727100
403	139	100	164	23.727100
404	140	100	164	23.727100
405	141	100	164	23.727100
406	142	100	164	23.727100
407	143	100	164	23.727100
408	144	100	164	23.727100
409	145	100	164	23.727100
410	146	100	164	23.727100
411	147	100	164	23.727100
412	148	100	164	23.727100
413	149	100	164	23.727100
414	150	100	164	23.727100
415	151	100	164	23.727100
416	152	100	164	23.727100
417	153	100	164	23.727100
418	154	100	164	23.727100
419	155	100	164	23.727100
420	156	100	164	23.727100
421	157	100	164	23.727100
422	158	100	164	23.727100
423	159	100	164	23.727100
424	160	100	164	23.727100
425	161	100	164	23.727100
426	162	100	164	23.727100
427	163	100	164	23.727100
428	164	100	164	23.727100
429	165	100	164	23.727100
430	166	100	164	23.727100
431	167	100	164	23.727100
432	168	100	164	23.727100
433	169	100	164	23.727100
434	170	100	164	23.727100
435	171	100	164	23.727100
436	172	100	164	23.727100
437	173	100	164	23.727100
438	174	100	164	23.727100
439	175	100	164	23.727100
440	176	100	164	23.727100
441	177	100	164	23.727100
442	178	100	164	23.727100
443	179	100	164	23.727100
444	180	100	164	23.727100
445	181	100	164	23.727100
446	182	100	164	23.727100
447	183	100	164	23.727100
448	184	100	164	23.727100
449	185	100	164	23.727100
450	186	100	164	23.727100
451	187	100	164	23.727100
452	188	100	164	23.727100
453	189	100	164	23.727100
454	190	100	164	23.727100
455	191	100	164	23.727100
456	192	100	164	23.727100
457	193	100	164	23.727100
458	194	100	164	23.727100
459	195	100	164	23.727100
460	196	100	164	23.727100
461	197	100	164	23.727100
462	198	100	164	23.727100
463	199	100	164	23.727100
464	200	100	164	23.727100
465	201	100	164	23.727100
466	202	100	164	23.727100
467	203	100	164	23.727100
468	204	100	164	23.727100
469	205	100	164	23.727100
470	206	100	164	23.727100
471	207	100	164	23.727100
472	208	100	164	23.727100
473	209	100	164	23.727100
474	210	100	164	23.727100
475	211	100	164	23.727100
476	212	100	164	23.727100
477	213	100	164	23.727100
478	214	100	164	23.727100
479	215	100	164	23.727100
480	216	100	164	23.727100
481	217	100	164	23.727100
482	218	100	164	23.727100
483	219	100	164	23.727100
484	220	100	164	23.727100
485	221	100	164	23.727100
486	222	100	164	23.727100
487	223	100	164	23.727100
488	224	100	164	23.727100
489	225	100	164	23.727100
490	226	100	164	23.727100
491	227	100	164	23.727100
492	228	100	164	23.727100
493	229	100	164	23.727100
494	230	100	164	23.727100
495	231	100	164	23.727100
496	232	100	164	23.727100
497	233	100	164	23.727100
498	234	100	164	23.727100
499	235	100	164	23.727100
500	236	100	164	23.727100
501	237	100	164	23.727100
502	238	100	164	23.727100
503	239	100	164	23.727100
504	240	100	164	23.727100
505	241	100	164	23.727100
506	242	100	164	23.727100
507	243	100	164	23.727100
508	244	100	164	23.727100
509	245	100	164	23.727100
510	246	100	164	23.727100
511	247	100	164	23.727100
512	248	100	164	23.727100
513	249	100	164	23.727100
514	250	100	164	23.727100
515	251	100	164	23.727100
516	252	100	164	23.727100
517	253	100	164	23.727100
518	254	100	164	23.727100
519	255	100	164	23.727100
520	256	100	164	23.727100
521	257	100	164	23.727100
522	258	100	164	23.727100
523	259	100	164	23.727100
524	260	100	164	23.727100
525	261	100	164	23.727100
526	262	100	164	23.727100
527	263	100	164	23.727100
528	264	100	164	23.727100
529	133	100	165	92.717600
530	134	100	165	92.717600
531	135	100	165	92.717600
532	136	100	165	92.717600
533	137	100	165	92.717600
534	138	100	165	92.717600
535	139	100	165	92.717600
536	140	100	165	92.717600
537	141	100	165	92.717600
538	142	100	165	92.717600
539	143	100	165	92.717600
540	144	100	165	92.717600
541	145	100	165	92.717600
542	146	100	165	92.717600
543	147	100	165	92.717600
544	148	100	165	92.717600
545	149	100	165	92.717600
546	150	100	165	92.717600
547	151	100	165	92.717600
548	152	100	165	92.717600
549	153	100	165	92.717600
550	154	100	165	92.717600
551	155	100	165	92.717600
552	156	100	165	92.717600
553	157	100	165	92.717600
554	158	100	165	92.717600
555	159	100	165	92.717600
556	160	100	165	92.717600
557	161	100	165	92.717600
558	162	100	165	92.717600
559	163	100	165	92.717600
560	164	100	165	92.717600
561	165	100	165	92.717600
562	166	100	165	92.717600
563	167	100	165	92.717600
564	168	100	165	92.717600
565	169	100	165	92.717600
566	170	100	165	92.717600
567	171	100	165	92.717600
568	172	100	165	92.717600
569	173	100	165	92.717600
570	174	100	165	92.717600
571	175	100	165	92.717600
572	176	100	165	92.717600
573	177	100	165	92.717600
574	178	100	165	92.717600
575	179	100	165	92.717600
576	180	100	165	92.717600
577	181	100	165	92.717600
578	182	100	165	92.717600
579	183	100	165	92.717600
580	184	100	165	92.717600
581	185	100	165	92.717600
582	186	100	165	92.717600
583	187	100	165	92.717600
584	188	100	165	92.717600
585	189	100	165	92.717600
586	190	100	165	92.717600
587	191	100	165	92.717600
588	192	100	165	92.717600
589	193	100	165	92.717600
590	194	100	165	92.717600
591	195	100	165	92.717600
592	196	100	165	92.717600
593	197	100	165	92.717600
594	198	100	165	92.717600
595	199	100	165	92.717600
596	200	100	165	92.717600
597	201	100	165	92.717600
598	202	100	165	92.717600
599	203	100	165	92.717600
600	204	100	165	92.717600
601	205	100	165	92.717600
602	206	100	165	92.717600
603	207	100	165	92.717600
604	208	100	165	92.717600
605	209	100	165	92.717600
606	210	100	165	92.717600
607	211	100	165	92.717600
608	212	100	165	92.717600
609	213	100	165	92.717600
610	214	100	165	92.717600
611	215	100	165	92.717600
612	216	100	165	92.717600
613	217	100	165	92.717600
614	218	100	165	92.717600
615	219	100	165	92.717600
616	220	100	165	92.717600
617	221	100	165	92.717600
618	222	100	165	92.717600
619	223	100	165	92.717600
620	224	100	165	92.717600
621	225	100	165	92.717600
622	226	100	165	92.717600
623	227	100	165	92.717600
624	228	100	165	92.717600
625	229	100	165	92.717600
626	230	100	165	92.717600
627	231	100	165	92.717600
628	232	100	165	92.717600
629	233	100	165	92.717600
630	234	100	165	92.717600
631	235	100	165	92.717600
632	236	100	165	92.717600
633	237	100	165	92.717600
634	238	100	165	92.717600
635	239	100	165	92.717600
636	240	100	165	92.717600
637	241	100	165	92.717600
638	242	100	165	92.717600
639	243	100	165	92.717600
640	244	100	165	92.717600
641	245	100	165	92.717600
642	246	100	165	92.717600
643	247	100	165	92.717600
644	248	100	165	92.717600
645	249	100	165	92.717600
646	250	100	165	92.717600
647	251	100	165	92.717600
648	252	100	165	92.717600
649	253	100	165	92.717600
650	254	100	165	92.717600
651	255	100	165	92.717600
652	256	100	165	92.717600
653	257	100	165	92.717600
654	258	100	165	92.717600
655	259	100	165	92.717600
656	260	100	165	92.717600
657	261	100	165	92.717600
658	262	100	165	92.717600
659	263	100	165	92.717600
660	264	100	165	92.717600
661	133	200	163	4.920000
662	134	200	163	4.900000
663	135	200	163	5.050000
664	136	200	163	5.000000
665	137	200	163	4.890000
666	138	200	163	4.950000
667	139	200	163	4.700000
668	140	200	163	5.000000
669	141	200	163	4.810000
670	142	200	163	5.040000
671	143	200	163	4.840000
672	144	200	163	5.350000
673	145	200	163	5.580000
674	146	200	163	5.590000
675	147	200	163	5.570000
676	148	200	163	5.560000
677	149	200	163	5.530000
678	150	200	163	5.230000
679	151	200	163	5.970000
680	152	200	163	4.830000
681	153	200	163	5.630000
682	154	200	163	5.730000
683	155	200	163	6.360000
684	156	200	163	6.330000
685	157	200	163	6.380000
686	158	200	163	6.280000
687	159	200	163	6.280000
688	160	200	163	5.940000
689	161	200	163	5.850000
690	162	200	163	6.790000
691	163	200	163	5.790000
692	164	200	163	6.180000
693	165	200	163	6.480000
694	166	200	163	6.670000
695	167	200	163	6.450000
696	168	200	163	6.510000
697	169	200	163	6.520000
698	170	200	163	6.250000
699	171	200	163	6.400000
700	172	200	163	6.170000
701	173	200	163	6.570000
702	174	200	163	6.310000
703	175	200	163	6.590000
704	176	200	163	6.570000
705	177	200	163	6.450000
706	178	200	163	6.050000
707	179	200	163	6.150000
708	180	200	163	6.110000
709	181	200	163	6.210000
710	182	200	163	6.350000
711	183	200	163	5.900000
712	184	200	163	6.100000
713	185	200	163	5.860000
714	186	200	163	5.970000
715	187	200	163	6.130000
716	188	200	163	5.320000
717	189	200	163	5.020000
718	190	200	163	5.060000
719	191	200	163	5.020000
720	192	200	163	5.120000
721	193	200	163	5.180000
722	194	200	163	5.130000
723	195	200	163	5.110000
724	196	200	163	4.740000
725	197	200	163	4.740000
726	198	200	163	5.010000
727	199	200	163	4.700000
728	200	200	163	4.670000
729	201	200	163	4.700000
730	202	200	163	4.620000
731	203	200	163	4.470000
732	204	200	163	4.610000
733	205	200	163	4.360000
734	206	200	163	4.740000
735	207	200	163	4.530000
736	208	200	163	4.430000
737	209	200	163	4.730000
738	210	200	163	4.730000
739	211	200	163	4.620000
740	212	200	163	4.640000
741	213	200	163	4.600000
742	214	200	163	4.380000
743	215	200	163	4.760000
744	216	200	163	4.500000
745	217	200	163	4.410000
746	218	200	163	4.540000
747	219	200	163	4.900000
748	220	200	163	4.720000
749	221	200	163	4.610000
750	222	200	163	4.560000
751	223	200	163	4.670000
752	224	200	163	4.400000
753	225	200	163	4.690000
754	226	200	163	4.360000
755	227	200	163	4.790000
756	228	200	163	4.350000
757	229	200	163	4.210000
758	230	200	163	4.590000
759	231	200	163	4.540000
760	232	200	163	4.770000
761	233	200	163	4.810000
762	234	200	163	4.840000
763	235	200	163	4.820000
764	236	200	163	4.870000
765	237	200	163	5.070000
766	238	200	163	4.640000
767	239	200	163	4.490000
768	240	200	163	4.810000
769	241	200	163	4.310000
770	242	200	163	4.870000
771	243	200	163	4.920000
772	244	200	163	4.920000
773	245	200	163	4.890000
774	246	200	163	4.400000
775	247	200	163	5.280000
776	248	200	163	4.720000
777	249	200	163	4.610000
778	250	200	163	4.860000
779	251	200	163	4.930000
780	252	200	163	4.370000
781	253	200	163	4.840000
782	254	200	163	4.730000
783	255	200	163	4.810000
784	256	200	163	4.770000
785	257	200	163	4.770000
786	258	200	163	4.890000
787	259	200	163	4.020000
788	260	200	163	4.760000
789	261	200	163	4.410000
790	262	200	163	4.920000
791	263	200	163	4.600000
792	264	200	163	4.560000
793	265	100	167	24.745700
794	266	100	167	24.745700
795	267	100	167	24.745700
796	268	100	167	24.745700
797	269	100	167	24.745700
798	270	100	167	24.745700
799	271	100	167	24.745700
800	272	100	167	24.745700
801	273	100	167	24.745700
802	274	100	167	24.745700
803	275	100	167	24.745700
804	276	100	167	24.745700
805	277	100	167	24.745700
806	278	100	167	24.745700
807	279	100	167	24.745700
808	280	100	167	24.745700
809	281	100	167	24.745700
810	282	100	167	24.745700
811	283	100	167	24.745700
812	284	100	167	24.745700
813	285	100	167	24.745700
814	286	100	167	24.745700
815	287	100	167	24.745700
816	288	100	167	24.745700
817	289	100	167	24.745700
818	290	100	167	24.745700
819	291	100	167	24.745700
820	292	100	167	24.745700
821	293	100	167	24.745700
822	294	100	167	24.745700
823	295	100	167	24.745700
824	296	100	167	24.745700
825	297	100	167	24.745700
826	298	100	167	24.745700
827	299	100	167	24.745700
828	300	100	167	24.745700
829	301	100	167	24.745700
830	302	100	167	24.745700
831	303	100	167	24.745700
832	304	100	167	24.745700
833	305	100	167	24.745700
834	306	100	167	24.745700
835	307	100	167	24.745700
836	308	100	167	24.745700
837	309	100	167	24.745700
838	310	100	167	24.745700
839	311	100	167	24.745700
840	312	100	167	24.745700
841	313	100	167	24.745700
842	314	100	167	24.745700
843	315	100	167	24.745700
844	316	100	167	24.745700
845	317	100	167	24.745700
846	318	100	167	24.745700
847	319	100	167	24.745700
848	320	100	167	24.745700
849	321	100	167	24.745700
850	322	100	167	24.745700
851	323	100	167	24.745700
852	324	100	167	24.745700
853	325	100	167	24.745700
854	326	100	167	24.745700
855	327	100	167	24.745700
856	328	100	167	24.745700
857	329	100	167	24.745700
858	330	100	167	24.745700
859	331	100	167	24.745700
860	332	100	167	24.745700
861	333	100	167	24.745700
862	334	100	167	24.745700
863	335	100	167	24.745700
864	336	100	167	24.745700
865	337	100	167	24.745700
866	338	100	167	24.745700
867	339	100	167	24.745700
868	340	100	167	24.745700
869	341	100	167	24.745700
870	342	100	167	24.745700
871	343	100	167	24.745700
872	344	100	167	24.745700
873	345	100	167	24.745700
874	346	100	167	24.745700
875	347	100	167	24.745700
876	348	100	167	24.745700
877	349	100	167	24.745700
878	350	100	167	24.745700
879	351	100	167	24.745700
880	352	100	167	24.745700
881	353	100	167	24.745700
882	354	100	167	24.745700
883	355	100	167	24.745700
884	356	100	167	24.745700
885	357	100	167	24.745700
886	358	100	167	24.745700
887	359	100	167	24.745700
888	360	100	167	24.745700
889	361	100	167	24.745700
890	362	100	167	24.745700
891	363	100	167	24.745700
892	364	100	167	24.745700
893	365	100	167	24.745700
894	366	100	167	24.745700
895	367	100	167	24.745700
896	368	100	167	24.745700
897	369	100	167	24.745700
898	370	100	167	24.745700
899	371	100	167	24.745700
900	372	100	167	24.745700
901	373	100	167	24.745700
902	374	100	167	24.745700
903	375	100	167	24.745700
904	376	100	167	24.745700
905	377	100	167	24.745700
906	378	100	167	24.745700
907	379	100	167	24.745700
908	380	100	167	24.745700
909	381	100	167	24.745700
910	382	100	167	24.745700
911	383	100	167	24.745700
912	384	100	167	24.745700
913	385	100	167	24.745700
914	386	100	167	24.745700
915	387	100	167	24.745700
916	388	100	167	24.745700
917	389	100	167	24.745700
918	390	100	167	24.745700
919	391	100	167	24.745700
920	392	100	167	24.745700
921	393	100	167	24.745700
922	394	100	167	24.745700
923	395	100	167	24.745700
924	396	100	167	24.745700
925	265	100	168	84.380500
926	266	100	168	84.380500
927	267	100	168	84.380500
928	268	100	168	84.380500
929	269	100	168	84.380500
930	270	100	168	84.380500
931	271	100	168	84.380500
932	272	100	168	84.380500
933	273	100	168	84.380500
934	274	100	168	84.380500
935	275	100	168	84.380500
936	276	100	168	84.380500
937	277	100	168	84.380500
938	278	100	168	84.380500
939	279	100	168	84.380500
940	280	100	168	84.380500
941	281	100	168	84.380500
942	282	100	168	84.380500
943	283	100	168	84.380500
944	284	100	168	84.380500
945	285	100	168	84.380500
946	286	100	168	84.380500
947	287	100	168	84.380500
948	288	100	168	84.380500
949	289	100	168	84.380500
950	290	100	168	84.380500
951	291	100	168	84.380500
952	292	100	168	84.380500
953	293	100	168	84.380500
954	294	100	168	84.380500
955	295	100	168	84.380500
956	296	100	168	84.380500
957	297	100	168	84.380500
958	298	100	168	84.380500
959	299	100	168	84.380500
960	300	100	168	84.380500
961	301	100	168	84.380500
962	302	100	168	84.380500
963	303	100	168	84.380500
964	304	100	168	84.380500
965	305	100	168	84.380500
966	306	100	168	84.380500
967	307	100	168	84.380500
968	308	100	168	84.380500
969	309	100	168	84.380500
970	310	100	168	84.380500
971	311	100	168	84.380500
972	312	100	168	84.380500
973	313	100	168	84.380500
974	314	100	168	84.380500
975	315	100	168	84.380500
976	316	100	168	84.380500
977	317	100	168	84.380500
978	318	100	168	84.380500
979	319	100	168	84.380500
980	320	100	168	84.380500
981	321	100	168	84.380500
982	322	100	168	84.380500
983	323	100	168	84.380500
984	324	100	168	84.380500
985	325	100	168	84.380500
986	326	100	168	84.380500
987	327	100	168	84.380500
988	328	100	168	84.380500
989	329	100	168	84.380500
990	330	100	168	84.380500
991	331	100	168	84.380500
992	332	100	168	84.380500
993	333	100	168	84.380500
994	334	100	168	84.380500
995	335	100	168	84.380500
996	336	100	168	84.380500
997	337	100	168	84.380500
998	338	100	168	84.380500
999	339	100	168	84.380500
1000	340	100	168	84.380500
1001	341	100	168	84.380500
1002	342	100	168	84.380500
1003	343	100	168	84.380500
1004	344	100	168	84.380500
1005	345	100	168	84.380500
1006	346	100	168	84.380500
1007	347	100	168	84.380500
1008	348	100	168	84.380500
1009	349	100	168	84.380500
1010	350	100	168	84.380500
1011	351	100	168	84.380500
1012	352	100	168	84.380500
1013	353	100	168	84.380500
1014	354	100	168	84.380500
1015	355	100	168	84.380500
1016	356	100	168	84.380500
1017	357	100	168	84.380500
1018	358	100	168	84.380500
1019	359	100	168	84.380500
1020	360	100	168	84.380500
1021	361	100	168	84.380500
1022	362	100	168	84.380500
1023	363	100	168	84.380500
1024	364	100	168	84.380500
1025	365	100	168	84.380500
1026	366	100	168	84.380500
1027	367	100	168	84.380500
1028	368	100	168	84.380500
1029	369	100	168	84.380500
1030	370	100	168	84.380500
1031	371	100	168	84.380500
1032	372	100	168	84.380500
1033	373	100	168	84.380500
1034	374	100	168	84.380500
1035	375	100	168	84.380500
1036	376	100	168	84.380500
1037	377	100	168	84.380500
1038	378	100	168	84.380500
1039	379	100	168	84.380500
1040	380	100	168	84.380500
1041	381	100	168	84.380500
1042	382	100	168	84.380500
1043	383	100	168	84.380500
1044	384	100	168	84.380500
1045	385	100	168	84.380500
1046	386	100	168	84.380500
1047	387	100	168	84.380500
1048	388	100	168	84.380500
1049	389	100	168	84.380500
1050	390	100	168	84.380500
1051	391	100	168	84.380500
1052	392	100	168	84.380500
1053	393	100	168	84.380500
1054	394	100	168	84.380500
1055	395	100	168	84.380500
1056	396	100	168	84.380500
1057	265	200	166	5.030000
1058	266	200	166	5.090000
1059	267	200	166	5.150000
1060	268	200	166	4.970000
1061	269	200	166	5.200000
1062	270	200	166	5.010000
1063	271	200	166	5.030000
1064	272	200	166	5.050000
1065	273	200	166	5.200000
1066	274	200	166	5.110000
1067	275	200	166	5.080000
1068	276	200	166	5.700000
1069	277	200	166	6.050000
1070	278	200	166	5.880000
1071	279	200	166	5.900000
1072	280	200	166	5.810000
1073	281	200	166	5.860000
1074	282	200	166	5.800000
1075	283	200	166	5.870000
1076	284	200	166	5.480000
1077	285	200	166	5.830000
1078	286	200	166	5.870000
1079	287	200	166	7.200000
1080	288	200	166	7.250000
1081	289	200	166	7.310000
1082	290	200	166	7.130000
1083	291	200	166	6.550000
1084	292	200	166	7.120000
1085	293	200	166	7.020000
1086	294	200	166	7.280000
1087	295	200	166	7.120000
1088	296	200	166	7.120000
1089	297	200	166	7.370000
1090	298	200	166	8.590000
1091	299	200	166	8.470000
1092	300	200	166	8.490000
1093	301	200	166	8.540000
1094	302	200	166	8.560000
1095	303	200	166	8.380000
1096	304	200	166	7.860000
1097	305	200	166	8.840000
1098	306	200	166	8.760000
1099	307	200	166	8.550000
1100	308	200	166	8.610000
1101	309	200	166	8.910000
1102	310	200	166	8.940000
1103	311	200	166	8.950000
1104	312	200	166	8.900000
1105	313	200	166	8.890000
1106	314	200	166	8.840000
1107	315	200	166	8.640000
1108	316	200	166	8.960000
1109	317	200	166	8.960000
1110	318	200	166	8.990000
1111	319	200	166	9.080000
1112	320	200	166	7.660000
1113	321	200	166	7.820000
1114	322	200	166	7.800000
1115	323	200	166	7.820000
1116	324	200	166	7.750000
1117	325	200	166	8.070000
1118	326	200	166	7.960000
1119	327	200	166	7.780000
1120	328	200	166	7.550000
1121	329	200	166	7.310000
1122	330	200	166	7.890000
1123	331	200	166	6.150000
1124	332	200	166	6.190000
1125	333	200	166	6.090000
1126	334	200	166	6.130000
1127	335	200	166	6.010000
1128	336	200	166	5.970000
1129	337	200	166	5.960000
1130	338	200	166	6.050000
1131	339	200	166	5.950000
1132	340	200	166	5.650000
1133	341	200	166	6.310000
1134	342	200	166	5.570000
1135	343	200	166	5.580000
1136	344	200	166	5.500000
1137	345	200	166	5.350000
1138	346	200	166	5.420000
1139	347	200	166	5.660000
1140	348	200	166	5.220000
1141	349	200	166	5.180000
1142	350	200	166	5.680000
1143	351	200	166	5.560000
1144	352	200	166	5.500000
1145	353	200	166	5.650000
1146	354	200	166	5.660000
1147	355	200	166	5.640000
1148	356	200	166	5.360000
1149	357	200	166	5.600000
1150	358	200	166	5.550000
1151	359	200	166	5.370000
1152	360	200	166	5.140000
1153	361	200	166	5.450000
1154	362	200	166	5.650000
1155	363	200	166	5.680000
1156	364	200	166	6.080000
1157	365	200	166	6.150000
1158	366	200	166	6.090000
1159	367	200	166	6.040000
1160	368	200	166	6.120000
1161	369	200	166	6.210000
1162	370	200	166	6.040000
1163	371	200	166	5.870000
1164	372	200	166	6.200000
1165	373	200	166	5.870000
1166	374	200	166	6.190000
1167	375	200	166	5.900000
1168	376	200	166	5.790000
1169	377	200	166	5.860000
1170	378	200	166	5.720000
1171	379	200	166	6.180000
1172	380	200	166	5.880000
1173	381	200	166	5.690000
1174	382	200	166	5.550000
1175	383	200	166	6.030000
1176	384	200	166	5.990000
1177	385	200	166	5.970000
1178	386	200	166	5.090000
1179	387	200	166	5.010000
1180	388	200	166	5.150000
1181	389	200	166	5.070000
1182	390	200	166	5.050000
1183	391	200	166	4.750000
1184	392	200	166	5.100000
1185	393	200	166	4.930000
1186	394	200	166	5.240000
1187	395	200	166	5.100000
1188	396	200	166	4.930000
1189	397	100	170	30.211000
1190	398	100	170	30.211000
1191	399	100	170	30.211000
1192	400	100	170	30.211000
1193	401	100	170	30.211000
1194	402	100	170	30.211000
1195	403	100	170	30.211000
1196	404	100	170	30.211000
1197	405	100	170	30.211000
1198	406	100	170	30.211000
1199	407	100	170	30.211000
1200	408	100	170	30.211000
1201	409	100	170	30.211000
1202	410	100	170	30.211000
1203	411	100	170	30.211000
1204	412	100	170	30.211000
1205	413	100	170	30.211000
1206	414	100	170	30.211000
1207	415	100	170	30.211000
1208	416	100	170	30.211000
1209	417	100	170	30.211000
1210	418	100	170	30.211000
1211	419	100	170	30.211000
1212	420	100	170	30.211000
1213	421	100	170	30.211000
1214	422	100	170	30.211000
1215	423	100	170	30.211000
1216	424	100	170	30.211000
1217	425	100	170	30.211000
1218	426	100	170	30.211000
1219	427	100	170	30.211000
1220	428	100	170	30.211000
1221	429	100	170	30.211000
1222	430	100	170	30.211000
1223	431	100	170	30.211000
1224	432	100	170	30.211000
1225	433	100	170	30.211000
1226	434	100	170	30.211000
1227	435	100	170	30.211000
1228	436	100	170	30.211000
1229	437	100	170	30.211000
1230	438	100	170	30.211000
1231	439	100	170	30.211000
1232	440	100	170	30.211000
1233	441	100	170	30.211000
1234	442	100	170	30.211000
1235	443	100	170	30.211000
1236	444	100	170	30.211000
1237	445	100	170	30.211000
1238	446	100	170	30.211000
1239	447	100	170	30.211000
1240	448	100	170	30.211000
1241	449	100	170	30.211000
1242	450	100	170	30.211000
1243	451	100	170	30.211000
1244	452	100	170	30.211000
1245	453	100	170	30.211000
1246	454	100	170	30.211000
1247	455	100	170	30.211000
1248	456	100	170	30.211000
1249	457	100	170	30.211000
1250	458	100	170	30.211000
1251	459	100	170	30.211000
1252	460	100	170	30.211000
1253	461	100	170	30.211000
1254	462	100	170	30.211000
1255	463	100	170	30.211000
1256	464	100	170	30.211000
1257	465	100	170	30.211000
1258	466	100	170	30.211000
1259	467	100	170	30.211000
1260	468	100	170	30.211000
1261	469	100	170	30.211000
1262	470	100	170	30.211000
1263	471	100	170	30.211000
1264	472	100	170	30.211000
1265	473	100	170	30.211000
1266	474	100	170	30.211000
1267	475	100	170	30.211000
1268	476	100	170	30.211000
1269	477	100	170	30.211000
1270	478	100	170	30.211000
1271	479	100	170	30.211000
1272	480	100	170	30.211000
1273	481	100	170	30.211000
1274	482	100	170	30.211000
1275	483	100	170	30.211000
1276	484	100	170	30.211000
1277	485	100	170	30.211000
1278	486	100	170	30.211000
1279	487	100	170	30.211000
1280	488	100	170	30.211000
1281	489	100	170	30.211000
1282	490	100	170	30.211000
1283	491	100	170	30.211000
1284	492	100	170	30.211000
1285	493	100	170	30.211000
1286	494	100	170	30.211000
1287	495	100	170	30.211000
1288	496	100	170	30.211000
1289	497	100	170	30.211000
1290	498	100	170	30.211000
1291	499	100	170	30.211000
1292	500	100	170	30.211000
1293	501	100	170	30.211000
1294	502	100	170	30.211000
1295	503	100	170	30.211000
1296	504	100	170	30.211000
1297	505	100	170	30.211000
1298	506	100	170	30.211000
1299	507	100	170	30.211000
1300	508	100	170	30.211000
1301	509	100	170	30.211000
1302	510	100	170	30.211000
1303	511	100	170	30.211000
1304	512	100	170	30.211000
1305	513	100	170	30.211000
1306	514	100	170	30.211000
1307	515	100	170	30.211000
1308	516	100	170	30.211000
1309	517	100	170	30.211000
1310	518	100	170	30.211000
1311	519	100	170	30.211000
1312	520	100	170	30.211000
1313	521	100	170	30.211000
1314	522	100	170	30.211000
1315	523	100	170	30.211000
1316	524	100	170	30.211000
1317	525	100	170	30.211000
1318	526	100	170	30.211000
1319	527	100	170	30.211000
1320	528	100	170	30.211000
1321	397	100	171	74.945500
1322	398	100	171	74.945500
1323	399	100	171	74.945500
1324	400	100	171	74.945500
1325	401	100	171	74.945500
1326	402	100	171	74.945500
1327	403	100	171	74.945500
1328	404	100	171	74.945500
1329	405	100	171	74.945500
1330	406	100	171	74.945500
1331	407	100	171	74.945500
1332	408	100	171	74.945500
1333	409	100	171	74.945500
1334	410	100	171	74.945500
1335	411	100	171	74.945500
1336	412	100	171	74.945500
1337	413	100	171	74.945500
1338	414	100	171	74.945500
1339	415	100	171	74.945500
1340	416	100	171	74.945500
1341	417	100	171	74.945500
1342	418	100	171	74.945500
1343	419	100	171	74.945500
1344	420	100	171	74.945500
1345	421	100	171	74.945500
1346	422	100	171	74.945500
1347	423	100	171	74.945500
1348	424	100	171	74.945500
1349	425	100	171	74.945500
1350	426	100	171	74.945500
1351	427	100	171	74.945500
1352	428	100	171	74.945500
1353	429	100	171	74.945500
1354	430	100	171	74.945500
1355	431	100	171	74.945500
1356	432	100	171	74.945500
1357	433	100	171	74.945500
1358	434	100	171	74.945500
1359	435	100	171	74.945500
1360	436	100	171	74.945500
1361	437	100	171	74.945500
1362	438	100	171	74.945500
1363	439	100	171	74.945500
1364	440	100	171	74.945500
1365	441	100	171	74.945500
1366	442	100	171	74.945500
1367	443	100	171	74.945500
1368	444	100	171	74.945500
1369	445	100	171	74.945500
1370	446	100	171	74.945500
1371	447	100	171	74.945500
1372	448	100	171	74.945500
1373	449	100	171	74.945500
1374	450	100	171	74.945500
1375	451	100	171	74.945500
1376	452	100	171	74.945500
1377	453	100	171	74.945500
1378	454	100	171	74.945500
1379	455	100	171	74.945500
1380	456	100	171	74.945500
1381	457	100	171	74.945500
1382	458	100	171	74.945500
1383	459	100	171	74.945500
1384	460	100	171	74.945500
1385	461	100	171	74.945500
1386	462	100	171	74.945500
1387	463	100	171	74.945500
1388	464	100	171	74.945500
1389	465	100	171	74.945500
1390	466	100	171	74.945500
1391	467	100	171	74.945500
1392	468	100	171	74.945500
1393	469	100	171	74.945500
1394	470	100	171	74.945500
1395	471	100	171	74.945500
1396	472	100	171	74.945500
1397	473	100	171	74.945500
1398	474	100	171	74.945500
1399	475	100	171	74.945500
1400	476	100	171	74.945500
1401	477	100	171	74.945500
1402	478	100	171	74.945500
1403	479	100	171	74.945500
1404	480	100	171	74.945500
1405	481	100	171	74.945500
1406	482	100	171	74.945500
1407	483	100	171	74.945500
1408	484	100	171	74.945500
1409	485	100	171	74.945500
1410	486	100	171	74.945500
1411	487	100	171	74.945500
1412	488	100	171	74.945500
1413	489	100	171	74.945500
1414	490	100	171	74.945500
1415	491	100	171	74.945500
1416	492	100	171	74.945500
1417	493	100	171	74.945500
1418	494	100	171	74.945500
1419	495	100	171	74.945500
1420	496	100	171	74.945500
1421	497	100	171	74.945500
1422	498	100	171	74.945500
1423	499	100	171	74.945500
1424	500	100	171	74.945500
1425	501	100	171	74.945500
1426	502	100	171	74.945500
1427	503	100	171	74.945500
1428	504	100	171	74.945500
1429	505	100	171	74.945500
1430	506	100	171	74.945500
1431	507	100	171	74.945500
1432	508	100	171	74.945500
1433	509	100	171	74.945500
1434	510	100	171	74.945500
1435	511	100	171	74.945500
1436	512	100	171	74.945500
1437	513	100	171	74.945500
1438	514	100	171	74.945500
1439	515	100	171	74.945500
1440	516	100	171	74.945500
1441	517	100	171	74.945500
1442	518	100	171	74.945500
1443	519	100	171	74.945500
1444	520	100	171	74.945500
1445	521	100	171	74.945500
1446	522	100	171	74.945500
1447	523	100	171	74.945500
1448	524	100	171	74.945500
1449	525	100	171	74.945500
1450	526	100	171	74.945500
1451	527	100	171	74.945500
1452	528	100	171	74.945500
1453	397	200	169	4.460000
1454	398	200	169	5.030000
1455	399	200	169	6.210000
1456	400	200	169	7.930000
1457	401	200	169	8.950000
1458	402	200	169	8.840000
1459	403	200	169	7.220000
1460	404	200	169	6.460000
1461	405	200	169	6.790000
1462	406	200	169	6.860000
1463	407	200	169	5.720000
1464	408	200	169	4.720000
1465	409	200	169	4.360000
1466	410	200	169	5.200000
1467	411	200	169	6.190000
1468	412	200	169	7.890000
1469	413	200	169	9.090000
1470	414	200	169	8.890000
1471	415	200	169	7.150000
1472	416	200	169	6.540000
1473	417	200	169	6.840000
1474	418	200	169	6.840000
1475	419	200	169	5.810000
1476	420	200	169	4.630000
1477	421	200	169	4.470000
1478	422	200	169	5.020000
1479	423	200	169	6.370000
1480	424	200	169	7.900000
1481	425	200	169	9.020000
1482	426	200	169	8.890000
1483	427	200	169	7.230000
1484	428	200	169	6.460000
1485	429	200	169	6.780000
1486	430	200	169	6.830000
1487	431	200	169	5.750000
1488	432	200	169	4.680000
1489	433	200	169	4.380000
1490	434	200	169	5.070000
1491	435	200	169	6.150000
1492	436	200	169	7.750000
1493	437	200	169	8.980000
1494	438	200	169	8.750000
1495	439	200	169	7.310000
1496	440	200	169	6.450000
1497	441	200	169	6.700000
1498	442	200	169	6.740000
1499	443	200	169	5.770000
1500	444	200	169	4.530000
1501	445	200	169	4.540000
1502	446	200	169	5.160000
1503	447	200	169	6.270000
1504	448	200	169	8.040000
1505	449	200	169	9.090000
1506	450	200	169	8.600000
1507	451	200	169	7.320000
1508	452	200	169	6.440000
1509	453	200	169	6.790000
1510	454	200	169	6.910000
1511	455	200	169	5.900000
1512	456	200	169	4.930000
1513	457	200	169	4.460000
1514	458	200	169	5.230000
1515	459	200	169	6.140000
1516	460	200	169	7.870000
1517	461	200	169	9.000000
1518	462	200	169	8.680000
1519	463	200	169	7.210000
1520	464	200	169	6.600000
1521	465	200	169	6.880000
1522	466	200	169	6.610000
1523	467	200	169	5.690000
1524	468	200	169	4.200000
1525	469	200	169	4.460000
1526	470	200	169	5.140000
1527	471	200	169	6.170000
1528	472	200	169	7.910000
1529	473	200	169	9.170000
1530	474	200	169	8.860000
1531	475	200	169	7.290000
1532	476	200	169	6.600000
1533	477	200	169	6.660000
1534	478	200	169	6.800000
1535	479	200	169	5.930000
1536	480	200	169	4.500000
1537	481	200	169	4.260000
1538	482	200	169	5.090000
1539	483	200	169	6.410000
1540	484	200	169	8.070000
1541	485	200	169	9.120000
1542	486	200	169	8.910000
1543	487	200	169	7.250000
1544	488	200	169	6.710000
1545	489	200	169	6.720000
1546	490	200	169	6.930000
1547	491	200	169	5.940000
1548	492	200	169	4.920000
1549	493	200	169	4.340000
1550	494	200	169	5.010000
1551	495	200	169	6.350000
1552	496	200	169	7.990000
1553	497	200	169	9.240000
1554	498	200	169	8.810000
1555	499	200	169	7.140000
1556	500	200	169	6.660000
1557	501	200	169	6.880000
1558	502	200	169	6.870000
1559	503	200	169	5.600000
1560	504	200	169	4.920000
1561	505	200	169	4.260000
1562	506	200	169	5.290000
1563	507	200	169	6.470000
1564	508	200	169	7.910000
1565	509	200	169	9.140000
1566	510	200	169	8.680000
1567	511	200	169	7.080000
1568	512	200	169	6.700000
1569	513	200	169	6.820000
1570	514	200	169	6.760000
1571	515	200	169	5.820000
1572	516	200	169	4.630000
1573	517	200	169	4.490000
1574	518	200	169	5.090000
1575	519	200	169	6.220000
1576	520	200	169	7.870000
1577	521	200	169	9.110000
1578	522	200	169	8.890000
1579	523	200	169	7.400000
1580	524	200	169	6.580000
1581	525	200	169	6.890000
1582	526	200	169	6.820000
1583	527	200	169	5.830000
1584	528	200	169	4.560000
1585	529	100	173	12.971600
1586	530	100	173	12.971600
1587	531	100	173	12.971600
1588	532	100	173	12.971600
1589	533	100	173	12.971600
1590	534	100	173	12.971600
1591	535	100	173	12.971600
1592	536	100	173	12.971600
1593	537	100	173	12.971600
1594	538	100	173	12.971600
1595	539	100	173	12.971600
1596	540	100	173	12.971600
1597	541	100	173	12.971600
1598	542	100	173	12.971600
1599	543	100	173	12.971600
1600	544	100	173	12.971600
1601	545	100	173	12.971600
1602	546	100	173	12.971600
1603	547	100	173	12.971600
1604	548	100	173	12.971600
1605	549	100	173	12.971600
1606	550	100	173	12.971600
1607	551	100	173	12.971600
1608	552	100	173	12.971600
1609	553	100	173	12.971600
1610	554	100	173	12.971600
1611	555	100	173	12.971600
1612	556	100	173	12.971600
1613	557	100	173	12.971600
1614	558	100	173	12.971600
1615	559	100	173	12.971600
1616	560	100	173	12.971600
1617	561	100	173	12.971600
1618	562	100	173	12.971600
1619	563	100	173	12.971600
1620	564	100	173	12.971600
1621	565	100	173	12.971600
1622	566	100	173	12.971600
1623	567	100	173	12.971600
1624	568	100	173	12.971600
1625	569	100	173	12.971600
1626	570	100	173	12.971600
1627	571	100	173	12.971600
1628	572	100	173	12.971600
1629	573	100	173	12.971600
1630	574	100	173	12.971600
1631	575	100	173	12.971600
1632	576	100	173	12.971600
1633	577	100	173	12.971600
1634	578	100	173	12.971600
1635	579	100	173	12.971600
1636	580	100	173	12.971600
1637	581	100	173	12.971600
1638	582	100	173	12.971600
1639	583	100	173	12.971600
1640	584	100	173	12.971600
1641	585	100	173	12.971600
1642	586	100	173	12.971600
1643	587	100	173	12.971600
1644	588	100	173	12.971600
1645	589	100	173	12.971600
1646	590	100	173	12.971600
1647	591	100	173	12.971600
1648	592	100	173	12.971600
1649	593	100	173	12.971600
1650	594	100	173	12.971600
1651	595	100	173	12.971600
1652	596	100	173	12.971600
1653	597	100	173	12.971600
1654	598	100	173	12.971600
1655	599	100	173	12.971600
1656	600	100	173	12.971600
1657	601	100	173	12.971600
1658	602	100	173	12.971600
1659	603	100	173	12.971600
1660	604	100	173	12.971600
1661	605	100	173	12.971600
1662	606	100	173	12.971600
1663	607	100	173	12.971600
1664	608	100	173	12.971600
1665	609	100	173	12.971600
1666	610	100	173	12.971600
1667	611	100	173	12.971600
1668	612	100	173	12.971600
1669	613	100	173	12.971600
1670	614	100	173	12.971600
1671	615	100	173	12.971600
1672	616	100	173	12.971600
1673	617	100	173	12.971600
1674	618	100	173	12.971600
1675	619	100	173	12.971600
1676	620	100	173	12.971600
1677	621	100	173	12.971600
1678	622	100	173	12.971600
1679	623	100	173	12.971600
1680	624	100	173	12.971600
1681	625	100	173	12.971600
1682	626	100	173	12.971600
1683	627	100	173	12.971600
1684	628	100	173	12.971600
1685	629	100	173	12.971600
1686	630	100	173	12.971600
1687	631	100	173	12.971600
1688	632	100	173	12.971600
1689	633	100	173	12.971600
1690	634	100	173	12.971600
1691	635	100	173	12.971600
1692	636	100	173	12.971600
1693	637	100	173	12.971600
1694	638	100	173	12.971600
1695	639	100	173	12.971600
1696	640	100	173	12.971600
1697	641	100	173	12.971600
1698	642	100	173	12.971600
1699	643	100	173	12.971600
1700	644	100	173	12.971600
1701	645	100	173	12.971600
1702	646	100	173	12.971600
1703	647	100	173	12.971600
1704	648	100	173	12.971600
1705	649	100	173	12.971600
1706	650	100	173	12.971600
1707	651	100	173	12.971600
1708	652	100	173	12.971600
1709	653	100	173	12.971600
1710	654	100	173	12.971600
1711	655	100	173	12.971600
1712	656	100	173	12.971600
1713	657	100	173	12.971600
1714	658	100	173	12.971600
1715	659	100	173	12.971600
1716	660	100	173	12.971600
1717	529	100	174	77.594600
1718	530	100	174	77.594600
1719	531	100	174	77.594600
1720	532	100	174	77.594600
1721	533	100	174	77.594600
1722	534	100	174	77.594600
1723	535	100	174	77.594600
1724	536	100	174	77.594600
1725	537	100	174	77.594600
1726	538	100	174	77.594600
1727	539	100	174	77.594600
1728	540	100	174	77.594600
1729	541	100	174	77.594600
1730	542	100	174	77.594600
1731	543	100	174	77.594600
1732	544	100	174	77.594600
1733	545	100	174	77.594600
1734	546	100	174	77.594600
1735	547	100	174	77.594600
1736	548	100	174	77.594600
1737	549	100	174	77.594600
1738	550	100	174	77.594600
1739	551	100	174	77.594600
1740	552	100	174	77.594600
1741	553	100	174	77.594600
1742	554	100	174	77.594600
1743	555	100	174	77.594600
1744	556	100	174	77.594600
1745	557	100	174	77.594600
1746	558	100	174	77.594600
1747	559	100	174	77.594600
1748	560	100	174	77.594600
1749	561	100	174	77.594600
1750	562	100	174	77.594600
1751	563	100	174	77.594600
1752	564	100	174	77.594600
1753	565	100	174	77.594600
1754	566	100	174	77.594600
1755	567	100	174	77.594600
1756	568	100	174	77.594600
1757	569	100	174	77.594600
1758	570	100	174	77.594600
1759	571	100	174	77.594600
1760	572	100	174	77.594600
1761	573	100	174	77.594600
1762	574	100	174	77.594600
1763	575	100	174	77.594600
1764	576	100	174	77.594600
1765	577	100	174	77.594600
1766	578	100	174	77.594600
1767	579	100	174	77.594600
1768	580	100	174	77.594600
1769	581	100	174	77.594600
1770	582	100	174	77.594600
1771	583	100	174	77.594600
1772	584	100	174	77.594600
1773	585	100	174	77.594600
1774	586	100	174	77.594600
1775	587	100	174	77.594600
1776	588	100	174	77.594600
1777	589	100	174	77.594600
1778	590	100	174	77.594600
1779	591	100	174	77.594600
1780	592	100	174	77.594600
1781	593	100	174	77.594600
1782	594	100	174	77.594600
1783	595	100	174	77.594600
1784	596	100	174	77.594600
1785	597	100	174	77.594600
1786	598	100	174	77.594600
1787	599	100	174	77.594600
1788	600	100	174	77.594600
1789	601	100	174	77.594600
1790	602	100	174	77.594600
1791	603	100	174	77.594600
1792	604	100	174	77.594600
1793	605	100	174	77.594600
1794	606	100	174	77.594600
1795	607	100	174	77.594600
1796	608	100	174	77.594600
1797	609	100	174	77.594600
1798	610	100	174	77.594600
1799	611	100	174	77.594600
1800	612	100	174	77.594600
1801	613	100	174	77.594600
1802	614	100	174	77.594600
1803	615	100	174	77.594600
1804	616	100	174	77.594600
1805	617	100	174	77.594600
1806	618	100	174	77.594600
1807	619	100	174	77.594600
1808	620	100	174	77.594600
1809	621	100	174	77.594600
1810	622	100	174	77.594600
1811	623	100	174	77.594600
1812	624	100	174	77.594600
1813	625	100	174	77.594600
1814	626	100	174	77.594600
1815	627	100	174	77.594600
1816	628	100	174	77.594600
1817	629	100	174	77.594600
1818	630	100	174	77.594600
1819	631	100	174	77.594600
1820	632	100	174	77.594600
1821	633	100	174	77.594600
1822	634	100	174	77.594600
1823	635	100	174	77.594600
1824	636	100	174	77.594600
1825	637	100	174	77.594600
1826	638	100	174	77.594600
1827	639	100	174	77.594600
1828	640	100	174	77.594600
1829	641	100	174	77.594600
1830	642	100	174	77.594600
1831	643	100	174	77.594600
1832	644	100	174	77.594600
1833	645	100	174	77.594600
1834	646	100	174	77.594600
1835	647	100	174	77.594600
1836	648	100	174	77.594600
1837	649	100	174	77.594600
1838	650	100	174	77.594600
1839	651	100	174	77.594600
1840	652	100	174	77.594600
1841	653	100	174	77.594600
1842	654	100	174	77.594600
1843	655	100	174	77.594600
1844	656	100	174	77.594600
1845	657	100	174	77.594600
1846	658	100	174	77.594600
1847	659	100	174	77.594600
1848	660	100	174	77.594600
1849	529	200	172	5.790000
1850	530	200	172	6.670000
1851	531	200	172	7.450000
1852	532	200	172	7.580000
1853	533	200	172	7.210000
1854	534	200	172	5.880000
1855	535	200	172	5.340000
1856	536	200	172	5.460000
1857	537	200	172	5.760000
1858	538	200	172	5.430000
1859	539	200	172	5.330000
1860	540	200	172	5.280000
1861	541	200	172	5.850000
1862	542	200	172	6.630000
1863	543	200	172	7.430000
1864	544	200	172	7.580000
1865	545	200	172	7.270000
1866	546	200	172	5.920000
1867	547	200	172	5.350000
1868	548	200	172	5.490000
1869	549	200	172	5.750000
1870	550	200	172	5.420000
1871	551	200	172	5.300000
1872	552	200	172	5.280000
1873	553	200	172	5.860000
1874	554	200	172	6.670000
1875	555	200	172	7.470000
1876	556	200	172	7.550000
1877	557	200	172	7.240000
1878	558	200	172	5.920000
1879	559	200	172	5.310000
1880	560	200	172	5.460000
1881	561	200	172	5.810000
1882	562	200	172	5.470000
1883	563	200	172	5.270000
1884	564	200	172	5.280000
1885	565	200	172	5.830000
1886	566	200	172	6.700000
1887	567	200	172	7.460000
1888	568	200	172	7.600000
1889	569	200	172	7.160000
1890	570	200	172	5.910000
1891	571	200	172	5.350000
1892	572	200	172	5.470000
1893	573	200	172	5.770000
1894	574	200	172	5.420000
1895	575	200	172	5.360000
1896	576	200	172	5.350000
1897	577	200	172	6.030000
1898	578	200	172	6.870000
1899	579	200	172	7.510000
1900	580	200	172	7.550000
1901	581	200	172	7.290000
1902	582	200	172	5.780000
1903	583	200	172	5.290000
1904	584	200	172	5.360000
1905	585	200	172	5.520000
1906	586	200	172	5.450000
1907	587	200	172	5.170000
1908	588	200	172	5.070000
1909	589	200	172	5.780000
1910	590	200	172	6.820000
1911	591	200	172	7.390000
1912	592	200	172	7.500000
1913	593	200	172	7.180000
1914	594	200	172	6.020000
1915	595	200	172	5.270000
1916	596	200	172	5.420000
1917	597	200	172	5.790000
1918	598	200	172	5.690000
1919	599	200	172	5.150000
1920	600	200	172	5.150000
1921	601	200	172	5.960000
1922	602	200	172	6.810000
1923	603	200	172	7.570000
1924	604	200	172	7.720000
1925	605	200	172	7.170000
1926	606	200	172	5.890000
1927	607	200	172	5.360000
1928	608	200	172	5.430000
1929	609	200	172	5.580000
1930	610	200	172	5.390000
1931	611	200	172	5.350000
1932	612	200	172	5.170000
1933	613	200	172	5.960000
1934	614	200	172	6.730000
1935	615	200	172	7.430000
1936	616	200	172	7.650000
1937	617	200	172	6.910000
1938	618	200	172	5.910000
1939	619	200	172	5.250000
1940	620	200	172	5.500000
1941	621	200	172	5.870000
1942	622	200	172	5.460000
1943	623	200	172	5.500000
1944	624	200	172	5.210000
1945	625	200	172	5.940000
1946	626	200	172	6.460000
1947	627	200	172	7.520000
1948	628	200	172	7.610000
1949	629	200	172	7.240000
1950	630	200	172	5.580000
1951	631	200	172	5.350000
1952	632	200	172	5.440000
1953	633	200	172	5.790000
1954	634	200	172	5.400000
1955	635	200	172	5.450000
1956	636	200	172	5.320000
1957	637	200	172	5.650000
1958	638	200	172	6.810000
1959	639	200	172	7.470000
1960	640	200	172	7.510000
1961	641	200	172	7.260000
1962	642	200	172	5.610000
1963	643	200	172	5.340000
1964	644	200	172	5.380000
1965	645	200	172	5.720000
1966	646	200	172	5.390000
1967	647	200	172	5.330000
1968	648	200	172	5.150000
1969	649	200	172	5.780000
1970	650	200	172	6.640000
1971	651	200	172	7.420000
1972	652	200	172	7.710000
1973	653	200	172	7.050000
1974	654	200	172	5.730000
1975	655	200	172	5.500000
1976	656	200	172	5.500000
1977	657	200	172	5.990000
1978	658	200	172	5.470000
1979	659	200	172	5.410000
1980	660	200	172	5.350000
1981	661	100	176	30.733300
1982	662	100	176	30.733300
1983	663	100	176	30.733300
1984	664	100	176	30.733300
1985	665	100	176	30.733300
1986	666	100	176	30.733300
1987	667	100	176	30.733300
1988	668	100	176	30.733300
1989	669	100	176	30.733300
1990	670	100	176	30.733300
1991	671	100	176	30.733300
1992	672	100	176	30.733300
1993	673	100	176	30.733300
1994	674	100	176	30.733300
1995	675	100	176	30.733300
1996	676	100	176	30.733300
1997	677	100	176	30.733300
1998	678	100	176	30.733300
1999	679	100	176	30.733300
2000	680	100	176	30.733300
2001	681	100	176	30.733300
2002	682	100	176	30.733300
2003	683	100	176	30.733300
2004	684	100	176	30.733300
2005	685	100	176	30.733300
2006	686	100	176	30.733300
2007	687	100	176	30.733300
2008	688	100	176	30.733300
2009	689	100	176	30.733300
2010	690	100	176	30.733300
2011	691	100	176	30.733300
2012	692	100	176	30.733300
2013	693	100	176	30.733300
2014	694	100	176	30.733300
2015	695	100	176	30.733300
2016	696	100	176	30.733300
2017	697	100	176	30.733300
2018	698	100	176	30.733300
2019	699	100	176	30.733300
2020	700	100	176	30.733300
2021	701	100	176	30.733300
2022	702	100	176	30.733300
2023	703	100	176	30.733300
2024	704	100	176	30.733300
2025	705	100	176	30.733300
2026	706	100	176	30.733300
2027	707	100	176	30.733300
2028	708	100	176	30.733300
2029	709	100	176	30.733300
2030	710	100	176	30.733300
2031	711	100	176	30.733300
2032	712	100	176	30.733300
2033	713	100	176	30.733300
2034	714	100	176	30.733300
2035	715	100	176	30.733300
2036	716	100	176	30.733300
2037	717	100	176	30.733300
2038	718	100	176	30.733300
2039	719	100	176	30.733300
2040	720	100	176	30.733300
2041	721	100	176	30.733300
2042	722	100	176	30.733300
2043	723	100	176	30.733300
2044	724	100	176	30.733300
2045	725	100	176	30.733300
2046	726	100	176	30.733300
2047	727	100	176	30.733300
2048	728	100	176	30.733300
2049	729	100	176	30.733300
2050	730	100	176	30.733300
2051	731	100	176	30.733300
2052	732	100	176	30.733300
2053	733	100	176	30.733300
2054	734	100	176	30.733300
2055	735	100	176	30.733300
2056	736	100	176	30.733300
2057	737	100	176	30.733300
2058	738	100	176	30.733300
2059	739	100	176	30.733300
2060	740	100	176	30.733300
2061	741	100	176	30.733300
2062	742	100	176	30.733300
2063	743	100	176	30.733300
2064	744	100	176	30.733300
2065	745	100	176	30.733300
2066	746	100	176	30.733300
2067	747	100	176	30.733300
2068	748	100	176	30.733300
2069	749	100	176	30.733300
2070	750	100	176	30.733300
2071	751	100	176	30.733300
2072	752	100	176	30.733300
2073	753	100	176	30.733300
2074	754	100	176	30.733300
2075	755	100	176	30.733300
2076	756	100	176	30.733300
2077	757	100	176	30.733300
2078	758	100	176	30.733300
2079	759	100	176	30.733300
2080	760	100	176	30.733300
2081	761	100	176	30.733300
2082	762	100	176	30.733300
2083	763	100	176	30.733300
2084	764	100	176	30.733300
2085	765	100	176	30.733300
2086	766	100	176	30.733300
2087	767	100	176	30.733300
2088	768	100	176	30.733300
2089	769	100	176	30.733300
2090	770	100	176	30.733300
2091	771	100	176	30.733300
2092	772	100	176	30.733300
2093	773	100	176	30.733300
2094	774	100	176	30.733300
2095	775	100	176	30.733300
2096	776	100	176	30.733300
2097	777	100	176	30.733300
2098	778	100	176	30.733300
2099	779	100	176	30.733300
2100	780	100	176	30.733300
2101	781	100	176	30.733300
2102	782	100	176	30.733300
2103	783	100	176	30.733300
2104	784	100	176	30.733300
2105	785	100	176	30.733300
2106	786	100	176	30.733300
2107	787	100	176	30.733300
2108	788	100	176	30.733300
2109	789	100	176	30.733300
2110	790	100	176	30.733300
2111	791	100	176	30.733300
2112	792	100	176	30.733300
2113	661	100	177	76.779400
2114	662	100	177	76.779400
2115	663	100	177	76.779400
2116	664	100	177	76.779400
2117	665	100	177	76.779400
2118	666	100	177	76.779400
2119	667	100	177	76.779400
2120	668	100	177	76.779400
2121	669	100	177	76.779400
2122	670	100	177	76.779400
2123	671	100	177	76.779400
2124	672	100	177	76.779400
2125	673	100	177	76.779400
2126	674	100	177	76.779400
2127	675	100	177	76.779400
2128	676	100	177	76.779400
2129	677	100	177	76.779400
2130	678	100	177	76.779400
2131	679	100	177	76.779400
2132	680	100	177	76.779400
2133	681	100	177	76.779400
2134	682	100	177	76.779400
2135	683	100	177	76.779400
2136	684	100	177	76.779400
2137	685	100	177	76.779400
2138	686	100	177	76.779400
2139	687	100	177	76.779400
2140	688	100	177	76.779400
2141	689	100	177	76.779400
2142	690	100	177	76.779400
2143	691	100	177	76.779400
2144	692	100	177	76.779400
2145	693	100	177	76.779400
2146	694	100	177	76.779400
2147	695	100	177	76.779400
2148	696	100	177	76.779400
2149	697	100	177	76.779400
2150	698	100	177	76.779400
2151	699	100	177	76.779400
2152	700	100	177	76.779400
2153	701	100	177	76.779400
2154	702	100	177	76.779400
2155	703	100	177	76.779400
2156	704	100	177	76.779400
2157	705	100	177	76.779400
2158	706	100	177	76.779400
2159	707	100	177	76.779400
2160	708	100	177	76.779400
2161	709	100	177	76.779400
2162	710	100	177	76.779400
2163	711	100	177	76.779400
2164	712	100	177	76.779400
2165	713	100	177	76.779400
2166	714	100	177	76.779400
2167	715	100	177	76.779400
2168	716	100	177	76.779400
2169	717	100	177	76.779400
2170	718	100	177	76.779400
2171	719	100	177	76.779400
2172	720	100	177	76.779400
2173	721	100	177	76.779400
2174	722	100	177	76.779400
2175	723	100	177	76.779400
2176	724	100	177	76.779400
2177	725	100	177	76.779400
2178	726	100	177	76.779400
2179	727	100	177	76.779400
2180	728	100	177	76.779400
2181	729	100	177	76.779400
2182	730	100	177	76.779400
2183	731	100	177	76.779400
2184	732	100	177	76.779400
2185	733	100	177	76.779400
2186	734	100	177	76.779400
2187	735	100	177	76.779400
2188	736	100	177	76.779400
2189	737	100	177	76.779400
2190	738	100	177	76.779400
2191	739	100	177	76.779400
2192	740	100	177	76.779400
2193	741	100	177	76.779400
2194	742	100	177	76.779400
2195	743	100	177	76.779400
2196	744	100	177	76.779400
2197	745	100	177	76.779400
2198	746	100	177	76.779400
2199	747	100	177	76.779400
2200	748	100	177	76.779400
2201	749	100	177	76.779400
2202	750	100	177	76.779400
2203	751	100	177	76.779400
2204	752	100	177	76.779400
2205	753	100	177	76.779400
2206	754	100	177	76.779400
2207	755	100	177	76.779400
2208	756	100	177	76.779400
2209	757	100	177	76.779400
2210	758	100	177	76.779400
2211	759	100	177	76.779400
2212	760	100	177	76.779400
2213	761	100	177	76.779400
2214	762	100	177	76.779400
2215	763	100	177	76.779400
2216	764	100	177	76.779400
2217	765	100	177	76.779400
2218	766	100	177	76.779400
2219	767	100	177	76.779400
2220	768	100	177	76.779400
2221	769	100	177	76.779400
2222	770	100	177	76.779400
2223	771	100	177	76.779400
2224	772	100	177	76.779400
2225	773	100	177	76.779400
2226	774	100	177	76.779400
2227	775	100	177	76.779400
2228	776	100	177	76.779400
2229	777	100	177	76.779400
2230	778	100	177	76.779400
2231	779	100	177	76.779400
2232	780	100	177	76.779400
2233	781	100	177	76.779400
2234	782	100	177	76.779400
2235	783	100	177	76.779400
2236	784	100	177	76.779400
2237	785	100	177	76.779400
2238	786	100	177	76.779400
2239	787	100	177	76.779400
2240	788	100	177	76.779400
2241	789	100	177	76.779400
2242	790	100	177	76.779400
2243	791	100	177	76.779400
2244	792	100	177	76.779400
2245	661	200	175	4.190000
2246	662	200	175	4.830000
2247	663	200	175	6.050000
2248	664	200	175	7.920000
2249	665	200	175	8.920000
2250	666	200	175	8.690000
2251	667	200	175	6.930000
2252	668	200	175	6.080000
2253	669	200	175	6.480000
2254	670	200	175	6.600000
2255	671	200	175	5.590000
2256	672	200	175	4.460000
2257	673	200	175	4.110000
2258	674	200	175	5.010000
2259	675	200	175	6.030000
2260	676	200	175	7.790000
2261	677	200	175	9.020000
2262	678	200	175	8.720000
2263	679	200	175	6.930000
2264	680	200	175	6.180000
2265	681	200	175	6.520000
2266	682	200	175	6.590000
2267	683	200	175	5.630000
2268	684	200	175	4.410000
2269	685	200	175	4.160000
2270	686	200	175	4.860000
2271	687	200	175	6.240000
2272	688	200	175	7.850000
2273	689	200	175	8.940000
2274	690	200	175	8.760000
2275	691	200	175	6.950000
2276	692	200	175	6.110000
2277	693	200	175	6.490000
2278	694	200	175	6.590000
2279	695	200	175	5.580000
2280	696	200	175	4.470000
2281	697	200	175	4.120000
2282	698	200	175	4.890000
2283	699	200	175	6.000000
2284	700	200	175	7.660000
2285	701	200	175	8.900000
2286	702	200	175	8.590000
2287	703	200	175	6.990000
2288	704	200	175	6.090000
2289	705	200	175	6.390000
2290	706	200	175	6.480000
2291	707	200	175	5.550000
2292	708	200	175	4.310000
2293	709	200	175	4.350000
2294	710	200	175	4.980000
2295	711	200	175	6.040000
2296	712	200	175	8.020000
2297	713	200	175	8.830000
2298	714	200	175	8.420000
2299	715	200	175	7.010000
2300	716	200	175	5.950000
2301	717	200	175	6.460000
2302	718	200	175	6.660000
2303	719	200	175	5.680000
2304	720	200	175	4.660000
2305	721	200	175	4.230000
2306	722	200	175	5.020000
2307	723	200	175	5.970000
2308	724	200	175	7.950000
2309	725	200	175	8.930000
2310	726	200	175	8.560000
2311	727	200	175	7.050000
2312	728	200	175	6.390000
2313	729	200	175	6.670000
2314	730	200	175	6.420000
2315	731	200	175	5.470000
2316	732	200	175	4.140000
2317	733	200	175	4.010000
2318	734	200	175	4.920000
2319	735	200	175	6.030000
2320	736	200	175	7.810000
2321	737	200	175	8.920000
2322	738	200	175	8.630000
2323	739	200	175	6.990000
2324	740	200	175	6.110000
2325	741	200	175	6.410000
2326	742	200	175	6.520000
2327	743	200	175	5.790000
2328	744	200	175	4.520000
2329	745	200	175	3.970000
2330	746	200	175	4.980000
2331	747	200	175	6.330000
2332	748	200	175	8.150000
2333	749	200	175	9.080000
2334	750	200	175	8.790000
2335	751	200	175	6.910000
2336	752	200	175	6.440000
2337	753	200	175	6.400000
2338	754	200	175	6.660000
2339	755	200	175	5.620000
2340	756	200	175	4.760000
2341	757	200	175	4.200000
2342	758	200	175	4.850000
2343	759	200	175	6.110000
2344	760	200	175	7.920000
2345	761	200	175	9.170000
2346	762	200	175	8.590000
2347	763	200	175	6.700000
2348	764	200	175	6.240000
2349	765	200	175	6.630000
2350	766	200	175	6.580000
2351	767	200	175	5.520000
2352	768	200	175	4.760000
2353	769	200	175	4.160000
2354	770	200	175	5.020000
2355	771	200	175	6.360000
2356	772	200	175	7.810000
2357	773	200	175	9.060000
2358	774	200	175	8.480000
2359	775	200	175	6.760000
2360	776	200	175	6.300000
2361	777	200	175	6.640000
2362	778	200	175	6.570000
2363	779	200	175	5.660000
2364	780	200	175	4.460000
2365	781	200	175	4.290000
2366	782	200	175	4.920000
2367	783	200	175	6.110000
2368	784	200	175	7.870000
2369	785	200	175	9.040000
2370	786	200	175	8.780000
2371	787	200	175	7.060000
2372	788	200	175	6.310000
2373	789	200	175	6.530000
2374	790	200	175	6.570000
2375	791	200	175	5.610000
2376	792	200	175	4.250000
2377	793	100	179	13.082700
2378	794	100	179	13.082700
2379	795	100	179	13.082700
2380	796	100	179	13.082700
2381	797	100	179	13.082700
2382	798	100	179	13.082700
2383	799	100	179	13.082700
2384	800	100	179	13.082700
2385	801	100	179	13.082700
2386	802	100	179	13.082700
2387	803	100	179	13.082700
2388	804	100	179	13.082700
2389	805	100	179	13.082700
2390	806	100	179	13.082700
2391	807	100	179	13.082700
2392	808	100	179	13.082700
2393	809	100	179	13.082700
2394	810	100	179	13.082700
2395	811	100	179	13.082700
2396	812	100	179	13.082700
2397	813	100	179	13.082700
2398	814	100	179	13.082700
2399	815	100	179	13.082700
2400	816	100	179	13.082700
2401	817	100	179	13.082700
2402	818	100	179	13.082700
2403	819	100	179	13.082700
2404	820	100	179	13.082700
2405	821	100	179	13.082700
2406	822	100	179	13.082700
2407	823	100	179	13.082700
2408	824	100	179	13.082700
2409	825	100	179	13.082700
2410	826	100	179	13.082700
2411	827	100	179	13.082700
2412	828	100	179	13.082700
2413	829	100	179	13.082700
2414	830	100	179	13.082700
2415	831	100	179	13.082700
2416	832	100	179	13.082700
2417	833	100	179	13.082700
2418	834	100	179	13.082700
2419	835	100	179	13.082700
2420	836	100	179	13.082700
2421	837	100	179	13.082700
2422	838	100	179	13.082700
2423	839	100	179	13.082700
2424	840	100	179	13.082700
2425	841	100	179	13.082700
2426	842	100	179	13.082700
2427	843	100	179	13.082700
2428	844	100	179	13.082700
2429	845	100	179	13.082700
2430	846	100	179	13.082700
2431	847	100	179	13.082700
2432	848	100	179	13.082700
2433	849	100	179	13.082700
2434	850	100	179	13.082700
2435	851	100	179	13.082700
2436	852	100	179	13.082700
2437	853	100	179	13.082700
2438	854	100	179	13.082700
2439	855	100	179	13.082700
2440	856	100	179	13.082700
2441	857	100	179	13.082700
2442	858	100	179	13.082700
2443	859	100	179	13.082700
2444	860	100	179	13.082700
2445	861	100	179	13.082700
2446	862	100	179	13.082700
2447	863	100	179	13.082700
2448	864	100	179	13.082700
2449	865	100	179	13.082700
2450	866	100	179	13.082700
2451	867	100	179	13.082700
2452	868	100	179	13.082700
2453	869	100	179	13.082700
2454	870	100	179	13.082700
2455	871	100	179	13.082700
2456	872	100	179	13.082700
2457	873	100	179	13.082700
2458	874	100	179	13.082700
2459	875	100	179	13.082700
2460	876	100	179	13.082700
2461	877	100	179	13.082700
2462	878	100	179	13.082700
2463	879	100	179	13.082700
2464	880	100	179	13.082700
2465	881	100	179	13.082700
2466	882	100	179	13.082700
2467	883	100	179	13.082700
2468	884	100	179	13.082700
2469	885	100	179	13.082700
2470	886	100	179	13.082700
2471	887	100	179	13.082700
2472	888	100	179	13.082700
2473	889	100	179	13.082700
2474	890	100	179	13.082700
2475	891	100	179	13.082700
2476	892	100	179	13.082700
2477	893	100	179	13.082700
2478	894	100	179	13.082700
2479	895	100	179	13.082700
2480	896	100	179	13.082700
2481	897	100	179	13.082700
2482	898	100	179	13.082700
2483	899	100	179	13.082700
2484	900	100	179	13.082700
2485	901	100	179	13.082700
2486	902	100	179	13.082700
2487	903	100	179	13.082700
2488	904	100	179	13.082700
2489	905	100	179	13.082700
2490	906	100	179	13.082700
2491	907	100	179	13.082700
2492	908	100	179	13.082700
2493	909	100	179	13.082700
2494	910	100	179	13.082700
2495	911	100	179	13.082700
2496	912	100	179	13.082700
2497	913	100	179	13.082700
2498	914	100	179	13.082700
2499	915	100	179	13.082700
2500	916	100	179	13.082700
2501	917	100	179	13.082700
2502	918	100	179	13.082700
2503	919	100	179	13.082700
2504	920	100	179	13.082700
2505	921	100	179	13.082700
2506	922	100	179	13.082700
2507	923	100	179	13.082700
2508	924	100	179	13.082700
2509	793	100	180	80.270700
2510	794	100	180	80.270700
2511	795	100	180	80.270700
2512	796	100	180	80.270700
2513	797	100	180	80.270700
2514	798	100	180	80.270700
2515	799	100	180	80.270700
2516	800	100	180	80.270700
2517	801	100	180	80.270700
2518	802	100	180	80.270700
2519	803	100	180	80.270700
2520	804	100	180	80.270700
2521	805	100	180	80.270700
2522	806	100	180	80.270700
2523	807	100	180	80.270700
2524	808	100	180	80.270700
2525	809	100	180	80.270700
2526	810	100	180	80.270700
2527	811	100	180	80.270700
2528	812	100	180	80.270700
2529	813	100	180	80.270700
2530	814	100	180	80.270700
2531	815	100	180	80.270700
2532	816	100	180	80.270700
2533	817	100	180	80.270700
2534	818	100	180	80.270700
2535	819	100	180	80.270700
2536	820	100	180	80.270700
2537	821	100	180	80.270700
2538	822	100	180	80.270700
2539	823	100	180	80.270700
2540	824	100	180	80.270700
2541	825	100	180	80.270700
2542	826	100	180	80.270700
2543	827	100	180	80.270700
2544	828	100	180	80.270700
2545	829	100	180	80.270700
2546	830	100	180	80.270700
2547	831	100	180	80.270700
2548	832	100	180	80.270700
2549	833	100	180	80.270700
2550	834	100	180	80.270700
2551	835	100	180	80.270700
2552	836	100	180	80.270700
2553	837	100	180	80.270700
2554	838	100	180	80.270700
2555	839	100	180	80.270700
2556	840	100	180	80.270700
2557	841	100	180	80.270700
2558	842	100	180	80.270700
2559	843	100	180	80.270700
2560	844	100	180	80.270700
2561	845	100	180	80.270700
2562	846	100	180	80.270700
2563	847	100	180	80.270700
2564	848	100	180	80.270700
2565	849	100	180	80.270700
2566	850	100	180	80.270700
2567	851	100	180	80.270700
2568	852	100	180	80.270700
2569	853	100	180	80.270700
2570	854	100	180	80.270700
2571	855	100	180	80.270700
2572	856	100	180	80.270700
2573	857	100	180	80.270700
2574	858	100	180	80.270700
2575	859	100	180	80.270700
2576	860	100	180	80.270700
2577	861	100	180	80.270700
2578	862	100	180	80.270700
2579	863	100	180	80.270700
2580	864	100	180	80.270700
2581	865	100	180	80.270700
2582	866	100	180	80.270700
2583	867	100	180	80.270700
2584	868	100	180	80.270700
2585	869	100	180	80.270700
2586	870	100	180	80.270700
2587	871	100	180	80.270700
2588	872	100	180	80.270700
2589	873	100	180	80.270700
2590	874	100	180	80.270700
2591	875	100	180	80.270700
2592	876	100	180	80.270700
2593	877	100	180	80.270700
2594	878	100	180	80.270700
2595	879	100	180	80.270700
2596	880	100	180	80.270700
2597	881	100	180	80.270700
2598	882	100	180	80.270700
2599	883	100	180	80.270700
2600	884	100	180	80.270700
2601	885	100	180	80.270700
2602	886	100	180	80.270700
2603	887	100	180	80.270700
2604	888	100	180	80.270700
2605	889	100	180	80.270700
2606	890	100	180	80.270700
2607	891	100	180	80.270700
2608	892	100	180	80.270700
2609	893	100	180	80.270700
2610	894	100	180	80.270700
2611	895	100	180	80.270700
2612	896	100	180	80.270700
2613	897	100	180	80.270700
2614	898	100	180	80.270700
2615	899	100	180	80.270700
2616	900	100	180	80.270700
2617	901	100	180	80.270700
2618	902	100	180	80.270700
2619	903	100	180	80.270700
2620	904	100	180	80.270700
2621	905	100	180	80.270700
2622	906	100	180	80.270700
2623	907	100	180	80.270700
2624	908	100	180	80.270700
2625	909	100	180	80.270700
2626	910	100	180	80.270700
2627	911	100	180	80.270700
2628	912	100	180	80.270700
2629	913	100	180	80.270700
2630	914	100	180	80.270700
2631	915	100	180	80.270700
2632	916	100	180	80.270700
2633	917	100	180	80.270700
2634	918	100	180	80.270700
2635	919	100	180	80.270700
2636	920	100	180	80.270700
2637	921	100	180	80.270700
2638	922	100	180	80.270700
2639	923	100	180	80.270700
2640	924	100	180	80.270700
2641	793	200	178	5.330000
2642	794	200	178	6.200000
2643	795	200	178	6.880000
2644	796	200	178	6.930000
2645	797	200	178	7.250000
2646	798	200	178	6.750000
2647	799	200	178	6.310000
2648	800	200	178	6.270000
2649	801	200	178	6.180000
2650	802	200	178	5.450000
2651	803	200	178	4.870000
2652	804	200	178	4.810000
2653	805	200	178	5.340000
2654	806	200	178	6.150000
2655	807	200	178	6.880000
2656	808	200	178	6.950000
2657	809	200	178	7.310000
2658	810	200	178	6.720000
2659	811	200	178	6.290000
2660	812	200	178	6.250000
2661	813	200	178	6.180000
2662	814	200	178	5.440000
2663	815	200	178	4.860000
2664	816	200	178	4.800000
2665	817	200	178	5.360000
2666	818	200	178	6.210000
2667	819	200	178	6.870000
2668	820	200	178	6.940000
2669	821	200	178	7.310000
2670	822	200	178	6.780000
2671	823	200	178	6.310000
2672	824	200	178	6.220000
2673	825	200	178	6.200000
2674	826	200	178	5.480000
2675	827	200	178	4.850000
2676	828	200	178	4.790000
2677	829	200	178	5.330000
2678	830	200	178	6.190000
2679	831	200	178	6.860000
2680	832	200	178	6.980000
2681	833	200	178	7.230000
2682	834	200	178	6.750000
2683	835	200	178	6.290000
2684	836	200	178	6.220000
2685	837	200	178	6.160000
2686	838	200	178	5.440000
2687	839	200	178	4.890000
2688	840	200	178	4.820000
2689	841	200	178	5.600000
2690	842	200	178	6.420000
2691	843	200	178	6.900000
2692	844	200	178	6.870000
2693	845	200	178	7.390000
2694	846	200	178	6.700000
2695	847	200	178	6.170000
2696	848	200	178	6.270000
2697	849	200	178	6.040000
2698	850	200	178	5.410000
2699	851	200	178	5.000000
2700	852	200	178	4.750000
2701	853	200	178	5.430000
2702	854	200	178	6.320000
2703	855	200	178	6.780000
2704	856	200	178	7.020000
2705	857	200	178	7.240000
2706	858	200	178	6.770000
2707	859	200	178	6.270000
2708	860	200	178	6.240000
2709	861	200	178	6.230000
2710	862	200	178	5.680000
2711	863	200	178	4.640000
2712	864	200	178	4.790000
2713	865	200	178	5.510000
2714	866	200	178	6.420000
2715	867	200	178	6.950000
2716	868	200	178	7.080000
2717	869	200	178	7.240000
2718	870	200	178	6.710000
2719	871	200	178	6.370000
2720	872	200	178	6.170000
2721	873	200	178	6.090000
2722	874	200	178	5.300000
2723	875	200	178	4.940000
2724	876	200	178	4.780000
2725	877	200	178	5.350000
2726	878	200	178	6.160000
2727	879	200	178	6.980000
2728	880	200	178	6.940000
2729	881	200	178	7.240000
2730	882	200	178	6.760000
2731	883	200	178	6.290000
2732	884	200	178	6.220000
2733	885	200	178	6.260000
2734	886	200	178	5.590000
2735	887	200	178	5.080000
2736	888	200	178	4.840000
2737	889	200	178	5.440000
2738	890	200	178	6.140000
2739	891	200	178	6.910000
2740	892	200	178	7.030000
2741	893	200	178	7.320000
2742	894	200	178	6.450000
2743	895	200	178	6.250000
2744	896	200	178	6.290000
2745	897	200	178	6.290000
2746	898	200	178	5.490000
2747	899	200	178	5.010000
2748	900	200	178	4.850000
2749	901	200	178	5.230000
2750	902	200	178	6.270000
2751	903	200	178	6.900000
2752	904	200	178	6.950000
2753	905	200	178	7.320000
2754	906	200	178	6.550000
2755	907	200	178	6.340000
2756	908	200	178	6.270000
2757	909	200	178	6.170000
2758	910	200	178	5.470000
2759	911	200	178	4.860000
2760	912	200	178	4.770000
2761	913	200	178	5.190000
2762	914	200	178	6.190000
2763	915	200	178	6.880000
2764	916	200	178	7.060000
2765	917	200	178	7.250000
2766	918	200	178	6.670000
2767	919	200	178	6.510000
2768	920	200	178	6.120000
2769	921	200	178	6.320000
2770	922	200	178	5.410000
2771	923	200	178	4.760000
2772	924	200	178	4.890000
2773	925	100	185	28.613900
2774	926	100	185	28.613900
2775	927	100	185	28.613900
2776	928	100	185	28.613900
2777	929	100	185	28.613900
2778	930	100	185	28.613900
2779	931	100	185	28.613900
2780	932	100	185	28.613900
2781	933	100	185	28.613900
2782	934	100	185	28.613900
2783	935	100	185	28.613900
2784	936	100	185	28.613900
2785	937	100	185	28.613900
2786	938	100	185	28.613900
2787	939	100	185	28.613900
2788	940	100	185	28.613900
2789	941	100	185	28.613900
2790	942	100	185	28.613900
2791	943	100	185	28.613900
2792	944	100	185	28.613900
2793	945	100	185	28.613900
2794	946	100	185	28.613900
2795	947	100	185	28.613900
2796	948	100	185	28.613900
2797	949	100	185	28.613900
2798	950	100	185	28.613900
2799	951	100	185	28.613900
2800	952	100	185	28.613900
2801	953	100	185	28.613900
2802	954	100	185	28.613900
2803	955	100	185	28.613900
2804	956	100	185	28.613900
2805	957	100	185	28.613900
2806	958	100	185	28.613900
2807	959	100	185	28.613900
2808	960	100	185	28.613900
2809	961	100	185	28.613900
2810	962	100	185	28.613900
2811	963	100	185	28.613900
2812	964	100	185	28.613900
2813	965	100	185	28.613900
2814	966	100	185	28.613900
2815	967	100	185	28.613900
2816	968	100	185	28.613900
2817	969	100	185	28.613900
2818	970	100	185	28.613900
2819	971	100	185	28.613900
2820	972	100	185	28.613900
2821	973	100	185	28.613900
2822	974	100	185	28.613900
2823	975	100	185	28.613900
2824	976	100	185	28.613900
2825	977	100	185	28.613900
2826	978	100	185	28.613900
2827	979	100	185	28.613900
2828	980	100	185	28.613900
2829	981	100	185	28.613900
2830	982	100	185	28.613900
2831	983	100	185	28.613900
2832	984	100	185	28.613900
2833	985	100	185	28.613900
2834	986	100	185	28.613900
2835	987	100	185	28.613900
2836	988	100	185	28.613900
2837	989	100	185	28.613900
2838	990	100	185	28.613900
2839	991	100	185	28.613900
2840	992	100	185	28.613900
2841	993	100	185	28.613900
2842	994	100	185	28.613900
2843	995	100	185	28.613900
2844	996	100	185	28.613900
2845	997	100	185	28.613900
2846	998	100	185	28.613900
2847	999	100	185	28.613900
2848	1000	100	185	28.613900
2849	1001	100	185	28.613900
2850	1002	100	185	28.613900
2851	1003	100	185	28.613900
2852	1004	100	185	28.613900
2853	1005	100	185	28.613900
2854	1006	100	185	28.613900
2855	1007	100	185	28.613900
2856	1008	100	185	28.613900
2857	1009	100	185	28.613900
2858	1010	100	185	28.613900
2859	1011	100	185	28.613900
2860	1012	100	185	28.613900
2861	1013	100	185	28.613900
2862	1014	100	185	28.613900
2863	1015	100	185	28.613900
2864	1016	100	185	28.613900
2865	1017	100	185	28.613900
2866	1018	100	185	28.613900
2867	1019	100	185	28.613900
2868	1020	100	185	28.613900
2869	1021	100	185	28.613900
2870	1022	100	185	28.613900
2871	1023	100	185	28.613900
2872	1024	100	185	28.613900
2873	1025	100	185	28.613900
2874	1026	100	185	28.613900
2875	1027	100	185	28.613900
2876	1028	100	185	28.613900
2877	1029	100	185	28.613900
2878	1030	100	185	28.613900
2879	1031	100	185	28.613900
2880	1032	100	185	28.613900
2881	1033	100	185	28.613900
2882	1034	100	185	28.613900
2883	1035	100	185	28.613900
2884	1036	100	185	28.613900
2885	1037	100	185	28.613900
2886	1038	100	185	28.613900
2887	1039	100	185	28.613900
2888	1040	100	185	28.613900
2889	1041	100	185	28.613900
2890	1042	100	185	28.613900
2891	1043	100	185	28.613900
2892	1044	100	185	28.613900
2893	1045	100	185	28.613900
2894	1046	100	185	28.613900
2895	1047	100	185	28.613900
2896	1048	100	185	28.613900
2897	1049	100	185	28.613900
2898	1050	100	185	28.613900
2899	1051	100	185	28.613900
2900	1052	100	185	28.613900
2901	1053	100	185	28.613900
2902	1054	100	185	28.613900
2903	1055	100	185	28.613900
2904	1056	100	185	28.613900
2905	925	100	186	77.209000
2906	926	100	186	77.209000
2907	927	100	186	77.209000
2908	928	100	186	77.209000
2909	929	100	186	77.209000
2910	930	100	186	77.209000
2911	931	100	186	77.209000
2912	932	100	186	77.209000
2913	933	100	186	77.209000
2914	934	100	186	77.209000
2915	935	100	186	77.209000
2916	936	100	186	77.209000
2917	937	100	186	77.209000
2918	938	100	186	77.209000
2919	939	100	186	77.209000
2920	940	100	186	77.209000
2921	941	100	186	77.209000
2922	942	100	186	77.209000
2923	943	100	186	77.209000
2924	944	100	186	77.209000
2925	945	100	186	77.209000
2926	946	100	186	77.209000
2927	947	100	186	77.209000
2928	948	100	186	77.209000
2929	949	100	186	77.209000
2930	950	100	186	77.209000
2931	951	100	186	77.209000
2932	952	100	186	77.209000
2933	953	100	186	77.209000
2934	954	100	186	77.209000
2935	955	100	186	77.209000
2936	956	100	186	77.209000
2937	957	100	186	77.209000
2938	958	100	186	77.209000
2939	959	100	186	77.209000
2940	960	100	186	77.209000
2941	961	100	186	77.209000
2942	962	100	186	77.209000
2943	963	100	186	77.209000
2944	964	100	186	77.209000
2945	965	100	186	77.209000
2946	966	100	186	77.209000
2947	967	100	186	77.209000
2948	968	100	186	77.209000
2949	969	100	186	77.209000
2950	970	100	186	77.209000
2951	971	100	186	77.209000
2952	972	100	186	77.209000
2953	973	100	186	77.209000
2954	974	100	186	77.209000
2955	975	100	186	77.209000
2956	976	100	186	77.209000
2957	977	100	186	77.209000
2958	978	100	186	77.209000
2959	979	100	186	77.209000
2960	980	100	186	77.209000
2961	981	100	186	77.209000
2962	982	100	186	77.209000
2963	983	100	186	77.209000
2964	984	100	186	77.209000
2965	985	100	186	77.209000
2966	986	100	186	77.209000
2967	987	100	186	77.209000
2968	988	100	186	77.209000
2969	989	100	186	77.209000
2970	990	100	186	77.209000
2971	991	100	186	77.209000
2972	992	100	186	77.209000
2973	993	100	186	77.209000
2974	994	100	186	77.209000
2975	995	100	186	77.209000
2976	996	100	186	77.209000
2977	997	100	186	77.209000
2978	998	100	186	77.209000
2979	999	100	186	77.209000
2980	1000	100	186	77.209000
2981	1001	100	186	77.209000
2982	1002	100	186	77.209000
2983	1003	100	186	77.209000
2984	1004	100	186	77.209000
2985	1005	100	186	77.209000
2986	1006	100	186	77.209000
2987	1007	100	186	77.209000
2988	1008	100	186	77.209000
2989	1009	100	186	77.209000
2990	1010	100	186	77.209000
2991	1011	100	186	77.209000
2992	1012	100	186	77.209000
2993	1013	100	186	77.209000
2994	1014	100	186	77.209000
2995	1015	100	186	77.209000
2996	1016	100	186	77.209000
2997	1017	100	186	77.209000
2998	1018	100	186	77.209000
2999	1019	100	186	77.209000
3000	1020	100	186	77.209000
3001	1021	100	186	77.209000
3002	1022	100	186	77.209000
3003	1023	100	186	77.209000
3004	1024	100	186	77.209000
3005	1025	100	186	77.209000
3006	1026	100	186	77.209000
3007	1027	100	186	77.209000
3008	1028	100	186	77.209000
3009	1029	100	186	77.209000
3010	1030	100	186	77.209000
3011	1031	100	186	77.209000
3012	1032	100	186	77.209000
3013	1033	100	186	77.209000
3014	1034	100	186	77.209000
3015	1035	100	186	77.209000
3016	1036	100	186	77.209000
3017	1037	100	186	77.209000
3018	1038	100	186	77.209000
3019	1039	100	186	77.209000
3020	1040	100	186	77.209000
3021	1041	100	186	77.209000
3022	1042	100	186	77.209000
3023	1043	100	186	77.209000
3024	1044	100	186	77.209000
3025	1045	100	186	77.209000
3026	1046	100	186	77.209000
3027	1047	100	186	77.209000
3028	1048	100	186	77.209000
3029	1049	100	186	77.209000
3030	1050	100	186	77.209000
3031	1051	100	186	77.209000
3032	1052	100	186	77.209000
3033	1053	100	186	77.209000
3034	1054	100	186	77.209000
3035	1055	100	186	77.209000
3036	1056	100	186	77.209000
3037	925	200	184	4.540000
3038	926	200	184	5.180000
3039	927	200	184	6.380000
3040	928	200	184	7.890000
3041	929	200	184	8.540000
3042	930	200	184	8.110000
3043	931	200	184	6.640000
3044	932	200	184	5.840000
3045	933	200	184	6.240000
3046	934	200	184	6.620000
3047	935	200	184	5.710000
3048	936	200	184	4.780000
3049	937	200	184	4.470000
3050	938	200	184	5.380000
3051	939	200	184	6.350000
3052	940	200	184	7.820000
3053	941	200	184	8.670000
3054	942	200	184	8.130000
3055	943	200	184	6.580000
3056	944	200	184	5.910000
3057	945	200	184	6.250000
3058	946	200	184	6.550000
3059	947	200	184	5.800000
3060	948	200	184	4.700000
3061	949	200	184	4.520000
3062	950	200	184	5.210000
3063	951	200	184	6.530000
3064	952	200	184	7.830000
3065	953	200	184	8.600000
3066	954	200	184	8.150000
3067	955	200	184	6.590000
3068	956	200	184	5.810000
3069	957	200	184	6.280000
3070	958	200	184	6.600000
3071	959	200	184	5.730000
3072	960	200	184	4.770000
3073	961	200	184	4.430000
3074	962	200	184	5.260000
3075	963	200	184	6.350000
3076	964	200	184	7.760000
3077	965	200	184	8.590000
3078	966	200	184	8.060000
3079	967	200	184	6.750000
3080	968	200	184	5.810000
3081	969	200	184	6.230000
3082	970	200	184	6.550000
3083	971	200	184	5.730000
3084	972	200	184	4.620000
3085	973	200	184	4.780000
3086	974	200	184	5.290000
3087	975	200	184	6.370000
3088	976	200	184	8.030000
3089	977	200	184	8.440000
3090	978	200	184	7.850000
3091	979	200	184	6.630000
3092	980	200	184	5.660000
3093	981	200	184	6.300000
3094	982	200	184	6.620000
3095	983	200	184	5.830000
3096	984	200	184	4.780000
3097	985	200	184	4.480000
3098	986	200	184	5.240000
3099	987	200	184	6.150000
3100	988	200	184	7.860000
3101	989	200	184	8.490000
3102	990	200	184	8.060000
3103	991	200	184	6.700000
3104	992	200	184	6.070000
3105	993	200	184	6.310000
3106	994	200	184	6.380000
3107	995	200	184	5.610000
3108	996	200	184	4.190000
3109	997	200	184	4.460000
3110	998	200	184	5.270000
3111	999	200	184	6.330000
3112	1000	200	184	7.790000
3113	1001	200	184	8.650000
3114	1002	200	184	8.050000
3115	1003	200	184	6.580000
3116	1004	200	184	5.750000
3117	1005	200	184	6.130000
3118	1006	200	184	6.490000
3119	1007	200	184	5.900000
3120	1008	200	184	4.620000
3121	1009	200	184	4.250000
3122	1010	200	184	5.160000
3123	1011	200	184	6.650000
3124	1012	200	184	8.110000
3125	1013	200	184	8.590000
3126	1014	200	184	8.220000
3127	1015	200	184	6.550000
3128	1016	200	184	6.230000
3129	1017	200	184	6.080000
3130	1018	200	184	6.590000
3131	1019	200	184	5.830000
3132	1020	200	184	4.840000
3133	1021	200	184	4.500000
3134	1022	200	184	5.130000
3135	1023	200	184	6.370000
3136	1024	200	184	7.790000
3137	1025	200	184	8.780000
3138	1026	200	184	7.930000
3139	1027	200	184	6.340000
3140	1028	200	184	5.970000
3141	1029	200	184	6.390000
3142	1030	200	184	6.500000
3143	1031	200	184	5.690000
3144	1032	200	184	5.030000
3145	1033	200	184	4.440000
3146	1034	200	184	5.290000
3147	1035	200	184	6.530000
3148	1036	200	184	7.820000
3149	1037	200	184	8.600000
3150	1038	200	184	7.900000
3151	1039	200	184	6.380000
3152	1040	200	184	6.080000
3153	1041	200	184	6.420000
3154	1042	200	184	6.530000
3155	1043	200	184	5.710000
3156	1044	200	184	4.610000
3157	1045	200	184	4.470000
3158	1046	200	184	5.160000
3159	1047	200	184	6.530000
3160	1048	200	184	7.890000
3161	1049	200	184	8.600000
3162	1050	200	184	8.200000
3163	1051	200	184	6.700000
3164	1052	200	184	5.970000
3165	1053	200	184	6.230000
3166	1054	200	184	6.570000
3167	1055	200	184	5.630000
3168	1056	200	184	4.410000
3169	1057	100	182	34.553900
3170	1058	100	182	34.553900
3171	1059	100	182	34.553900
3172	1060	100	182	34.553900
3173	1061	100	182	34.553900
3174	1062	100	182	34.553900
3175	1063	100	182	34.553900
3176	1064	100	182	34.553900
3177	1065	100	182	34.553900
3178	1066	100	182	34.553900
3179	1067	100	182	34.553900
3180	1068	100	182	34.553900
3181	1069	100	182	34.553900
3182	1070	100	182	34.553900
3183	1071	100	182	34.553900
3184	1072	100	182	34.553900
3185	1073	100	182	34.553900
3186	1074	100	182	34.553900
3187	1075	100	182	34.553900
3188	1076	100	182	34.553900
3189	1077	100	182	34.553900
3190	1078	100	182	34.553900
3191	1079	100	182	34.553900
3192	1080	100	182	34.553900
3193	1081	100	182	34.553900
3194	1082	100	182	34.553900
3195	1083	100	182	34.553900
3196	1084	100	182	34.553900
3197	1085	100	182	34.553900
3198	1086	100	182	34.553900
3199	1087	100	182	34.553900
3200	1088	100	182	34.553900
3201	1089	100	182	34.553900
3202	1090	100	182	34.553900
3203	1091	100	182	34.553900
3204	1092	100	182	34.553900
3205	1093	100	182	34.553900
3206	1094	100	182	34.553900
3207	1095	100	182	34.553900
3208	1096	100	182	34.553900
3209	1097	100	182	34.553900
3210	1098	100	182	34.553900
3211	1099	100	182	34.553900
3212	1100	100	182	34.553900
3213	1101	100	182	34.553900
3214	1102	100	182	34.553900
3215	1103	100	182	34.553900
3216	1104	100	182	34.553900
3217	1105	100	182	34.553900
3218	1106	100	182	34.553900
3219	1107	100	182	34.553900
3220	1108	100	182	34.553900
3221	1109	100	182	34.553900
3222	1110	100	182	34.553900
3223	1111	100	182	34.553900
3224	1112	100	182	34.553900
3225	1113	100	182	34.553900
3226	1114	100	182	34.553900
3227	1115	100	182	34.553900
3228	1116	100	182	34.553900
3229	1117	100	182	34.553900
3230	1118	100	182	34.553900
3231	1119	100	182	34.553900
3232	1120	100	182	34.553900
3233	1121	100	182	34.553900
3234	1122	100	182	34.553900
3235	1123	100	182	34.553900
3236	1124	100	182	34.553900
3237	1125	100	182	34.553900
3238	1126	100	182	34.553900
3239	1127	100	182	34.553900
3240	1128	100	182	34.553900
3241	1129	100	182	34.553900
3242	1130	100	182	34.553900
3243	1131	100	182	34.553900
3244	1132	100	182	34.553900
3245	1133	100	182	34.553900
3246	1134	100	182	34.553900
3247	1135	100	182	34.553900
3248	1136	100	182	34.553900
3249	1137	100	182	34.553900
3250	1138	100	182	34.553900
3251	1139	100	182	34.553900
3252	1140	100	182	34.553900
3253	1141	100	182	34.553900
3254	1142	100	182	34.553900
3255	1143	100	182	34.553900
3256	1144	100	182	34.553900
3257	1145	100	182	34.553900
3258	1146	100	182	34.553900
3259	1147	100	182	34.553900
3260	1148	100	182	34.553900
3261	1149	100	182	34.553900
3262	1150	100	182	34.553900
3263	1151	100	182	34.553900
3264	1152	100	182	34.553900
3265	1153	100	182	34.553900
3266	1154	100	182	34.553900
3267	1155	100	182	34.553900
3268	1156	100	182	34.553900
3269	1157	100	182	34.553900
3270	1158	100	182	34.553900
3271	1159	100	182	34.553900
3272	1160	100	182	34.553900
3273	1161	100	182	34.553900
3274	1162	100	182	34.553900
3275	1163	100	182	34.553900
3276	1164	100	182	34.553900
3277	1165	100	182	34.553900
3278	1166	100	182	34.553900
3279	1167	100	182	34.553900
3280	1168	100	182	34.553900
3281	1169	100	182	34.553900
3282	1170	100	182	34.553900
3283	1171	100	182	34.553900
3284	1172	100	182	34.553900
3285	1173	100	182	34.553900
3286	1174	100	182	34.553900
3287	1175	100	182	34.553900
3288	1176	100	182	34.553900
3289	1177	100	182	34.553900
3290	1178	100	182	34.553900
3291	1179	100	182	34.553900
3292	1180	100	182	34.553900
3293	1181	100	182	34.553900
3294	1182	100	182	34.553900
3295	1183	100	182	34.553900
3296	1184	100	182	34.553900
3297	1185	100	182	34.553900
3298	1186	100	182	34.553900
3299	1187	100	182	34.553900
3300	1188	100	182	34.553900
3301	1057	100	183	76.134900
3302	1058	100	183	76.134900
3303	1059	100	183	76.134900
3304	1060	100	183	76.134900
3305	1061	100	183	76.134900
3306	1062	100	183	76.134900
3307	1063	100	183	76.134900
3308	1064	100	183	76.134900
3309	1065	100	183	76.134900
3310	1066	100	183	76.134900
3311	1067	100	183	76.134900
3312	1068	100	183	76.134900
3313	1069	100	183	76.134900
3314	1070	100	183	76.134900
3315	1071	100	183	76.134900
3316	1072	100	183	76.134900
3317	1073	100	183	76.134900
3318	1074	100	183	76.134900
3319	1075	100	183	76.134900
3320	1076	100	183	76.134900
3321	1077	100	183	76.134900
3322	1078	100	183	76.134900
3323	1079	100	183	76.134900
3324	1080	100	183	76.134900
3325	1081	100	183	76.134900
3326	1082	100	183	76.134900
3327	1083	100	183	76.134900
3328	1084	100	183	76.134900
3329	1085	100	183	76.134900
3330	1086	100	183	76.134900
3331	1087	100	183	76.134900
3332	1088	100	183	76.134900
3333	1089	100	183	76.134900
3334	1090	100	183	76.134900
3335	1091	100	183	76.134900
3336	1092	100	183	76.134900
3337	1093	100	183	76.134900
3338	1094	100	183	76.134900
3339	1095	100	183	76.134900
3340	1096	100	183	76.134900
3341	1097	100	183	76.134900
3342	1098	100	183	76.134900
3343	1099	100	183	76.134900
3344	1100	100	183	76.134900
3345	1101	100	183	76.134900
3346	1102	100	183	76.134900
3347	1103	100	183	76.134900
3348	1104	100	183	76.134900
3349	1105	100	183	76.134900
3350	1106	100	183	76.134900
3351	1107	100	183	76.134900
3352	1108	100	183	76.134900
3353	1109	100	183	76.134900
3354	1110	100	183	76.134900
3355	1111	100	183	76.134900
3356	1112	100	183	76.134900
3357	1113	100	183	76.134900
3358	1114	100	183	76.134900
3359	1115	100	183	76.134900
3360	1116	100	183	76.134900
3361	1117	100	183	76.134900
3362	1118	100	183	76.134900
3363	1119	100	183	76.134900
3364	1120	100	183	76.134900
3365	1121	100	183	76.134900
3366	1122	100	183	76.134900
3367	1123	100	183	76.134900
3368	1124	100	183	76.134900
3369	1125	100	183	76.134900
3370	1126	100	183	76.134900
3371	1127	100	183	76.134900
3372	1128	100	183	76.134900
3373	1129	100	183	76.134900
3374	1130	100	183	76.134900
3375	1131	100	183	76.134900
3376	1132	100	183	76.134900
3377	1133	100	183	76.134900
3378	1134	100	183	76.134900
3379	1135	100	183	76.134900
3380	1136	100	183	76.134900
3381	1137	100	183	76.134900
3382	1138	100	183	76.134900
3383	1139	100	183	76.134900
3384	1140	100	183	76.134900
3385	1141	100	183	76.134900
3386	1142	100	183	76.134900
3387	1143	100	183	76.134900
3388	1144	100	183	76.134900
3389	1145	100	183	76.134900
3390	1146	100	183	76.134900
3391	1147	100	183	76.134900
3392	1148	100	183	76.134900
3393	1149	100	183	76.134900
3394	1150	100	183	76.134900
3395	1151	100	183	76.134900
3396	1152	100	183	76.134900
3397	1153	100	183	76.134900
3398	1154	100	183	76.134900
3399	1155	100	183	76.134900
3400	1156	100	183	76.134900
3401	1157	100	183	76.134900
3402	1158	100	183	76.134900
3403	1159	100	183	76.134900
3404	1160	100	183	76.134900
3405	1161	100	183	76.134900
3406	1162	100	183	76.134900
3407	1163	100	183	76.134900
3408	1164	100	183	76.134900
3409	1165	100	183	76.134900
3410	1166	100	183	76.134900
3411	1167	100	183	76.134900
3412	1168	100	183	76.134900
3413	1169	100	183	76.134900
3414	1170	100	183	76.134900
3415	1171	100	183	76.134900
3416	1172	100	183	76.134900
3417	1173	100	183	76.134900
3418	1174	100	183	76.134900
3419	1175	100	183	76.134900
3420	1176	100	183	76.134900
3421	1177	100	183	76.134900
3422	1178	100	183	76.134900
3423	1179	100	183	76.134900
3424	1180	100	183	76.134900
3425	1181	100	183	76.134900
3426	1182	100	183	76.134900
3427	1183	100	183	76.134900
3428	1184	100	183	76.134900
3429	1185	100	183	76.134900
3430	1186	100	183	76.134900
3431	1187	100	183	76.134900
3432	1188	100	183	76.134900
3433	1057	200	181	0.580000
3434	1058	200	181	0.740000
3435	1059	200	181	1.820000
3436	1060	200	181	4.340000
3437	1061	200	181	5.530000
3438	1062	200	181	6.200000
3439	1063	200	181	6.210000
3440	1064	200	181	5.810000
3441	1065	200	181	5.440000
3442	1066	200	181	4.460000
3443	1067	200	181	2.510000
3444	1068	200	181	0.980000
3445	1069	200	181	0.020000
3446	1070	200	181	1.050000
3447	1071	200	181	1.300000
3448	1072	200	181	4.380000
3449	1073	200	181	5.760000
3450	1074	200	181	6.410000
3451	1075	200	181	6.220000
3452	1076	200	181	5.800000
3453	1077	200	181	5.540000
3454	1078	200	181	4.430000
3455	1079	200	181	2.570000
3456	1080	200	181	0.950000
3457	1081	200	181	0.640000
3458	1082	200	181	0.740000
3459	1083	200	181	2.590000
3460	1084	200	181	3.440000
3461	1085	200	181	5.680000
3462	1086	200	181	6.420000
3463	1087	200	181	6.400000
3464	1088	200	181	5.920000
3465	1089	200	181	5.500000
3466	1090	200	181	4.380000
3467	1091	200	181	2.530000
3468	1092	200	181	0.970000
3469	1093	200	181	0.000000
3470	1094	200	181	0.020000
3471	1095	200	181	1.770000
3472	1096	200	181	3.760000
3473	1097	200	181	5.590000
3474	1098	200	181	6.200000
3475	1099	200	181	6.320000
3476	1100	200	181	5.950000
3477	1101	200	181	5.390000
3478	1102	200	181	4.200000
3479	1103	200	181	2.520000
3480	1104	200	181	0.890000
3481	1105	200	181	0.020000
3482	1106	200	181	0.990000
3483	1107	200	181	2.230000
3484	1108	200	181	4.350000
3485	1109	200	181	5.330000
3486	1110	200	181	6.070000
3487	1111	200	181	6.370000
3488	1112	200	181	5.600000
3489	1113	200	181	5.420000
3490	1114	200	181	4.410000
3491	1115	200	181	2.330000
3492	1116	200	181	1.010000
3493	1117	200	181	0.260000
3494	1118	200	181	0.800000
3495	1119	200	181	1.870000
3496	1120	200	181	4.470000
3497	1121	200	181	5.630000
3498	1122	200	181	6.060000
3499	1123	200	181	6.580000
3500	1124	200	181	6.060000
3501	1125	200	181	5.670000
3502	1126	200	181	4.360000
3503	1127	200	181	2.400000
3504	1128	200	181	0.860000
3505	1129	200	181	0.020000
3506	1130	200	181	0.990000
3507	1131	200	181	1.330000
3508	1132	200	181	4.350000
3509	1133	200	181	5.550000
3510	1134	200	181	6.160000
3511	1135	200	181	6.370000
3512	1136	200	181	5.830000
3513	1137	200	181	5.430000
3514	1138	200	181	4.510000
3515	1139	200	181	2.480000
3516	1140	200	181	0.890000
3517	1141	200	181	0.050000
3518	1142	200	181	1.050000
3519	1143	200	181	2.340000
3520	1144	200	181	4.820000
3521	1145	200	181	5.710000
3522	1146	200	181	6.470000
3523	1147	200	181	6.250000
3524	1148	200	181	6.000000
3525	1149	200	181	5.580000
3526	1150	200	181	4.590000
3527	1151	200	181	2.560000
3528	1152	200	181	1.040000
3529	1153	200	181	0.560000
3530	1154	200	181	0.500000
3531	1155	200	181	1.910000
3532	1156	200	181	4.810000
3533	1157	200	181	6.070000
3534	1158	200	181	6.300000
3535	1159	200	181	6.100000
3536	1160	200	181	5.830000
3537	1161	200	181	5.560000
3538	1162	200	181	4.540000
3539	1163	200	181	2.500000
3540	1164	200	181	0.930000
3541	1165	200	181	0.640000
3542	1166	200	181	1.060000
3543	1167	200	181	2.740000
3544	1168	200	181	4.320000
3545	1169	200	181	6.000000
3546	1170	200	181	6.030000
3547	1171	200	181	6.060000
3548	1172	200	181	5.980000
3549	1173	200	181	5.380000
3550	1174	200	181	4.470000
3551	1175	200	181	2.580000
3552	1176	200	181	0.880000
3553	1177	200	181	0.580000
3554	1178	200	181	0.740000
3555	1179	200	181	2.610000
3556	1180	200	181	4.370000
3557	1181	200	181	5.850000
3558	1182	200	181	6.470000
3559	1183	200	181	6.280000
3560	1184	200	181	5.920000
3561	1185	200	181	5.360000
3562	1186	200	181	4.490000
3563	1187	200	181	2.680000
3564	1188	200	181	0.840000
3565	1189	100	188	31.104800
3566	1190	100	188	31.104800
3567	1191	100	188	31.104800
3568	1192	100	188	31.104800
3569	1193	100	188	31.104800
3570	1194	100	188	31.104800
3571	1195	100	188	31.104800
3572	1196	100	188	31.104800
3573	1197	100	188	31.104800
3574	1198	100	188	31.104800
3575	1199	100	188	31.104800
3576	1200	100	188	31.104800
3577	1201	100	188	31.104800
3578	1202	100	188	31.104800
3579	1203	100	188	31.104800
3580	1204	100	188	31.104800
3581	1205	100	188	31.104800
3582	1206	100	188	31.104800
3583	1207	100	188	31.104800
3584	1208	100	188	31.104800
3585	1209	100	188	31.104800
3586	1210	100	188	31.104800
3587	1211	100	188	31.104800
3588	1212	100	188	31.104800
3589	1213	100	188	31.104800
3590	1214	100	188	31.104800
3591	1215	100	188	31.104800
3592	1216	100	188	31.104800
3593	1217	100	188	31.104800
3594	1218	100	188	31.104800
3595	1219	100	188	31.104800
3596	1220	100	188	31.104800
3597	1221	100	188	31.104800
3598	1222	100	188	31.104800
3599	1223	100	188	31.104800
3600	1224	100	188	31.104800
3601	1225	100	188	31.104800
3602	1226	100	188	31.104800
3603	1227	100	188	31.104800
3604	1228	100	188	31.104800
3605	1229	100	188	31.104800
3606	1230	100	188	31.104800
3607	1231	100	188	31.104800
3608	1232	100	188	31.104800
3609	1233	100	188	31.104800
3610	1234	100	188	31.104800
3611	1235	100	188	31.104800
3612	1236	100	188	31.104800
3613	1237	100	188	31.104800
3614	1238	100	188	31.104800
3615	1239	100	188	31.104800
3616	1240	100	188	31.104800
3617	1241	100	188	31.104800
3618	1242	100	188	31.104800
3619	1243	100	188	31.104800
3620	1244	100	188	31.104800
3621	1245	100	188	31.104800
3622	1246	100	188	31.104800
3623	1247	100	188	31.104800
3624	1248	100	188	31.104800
3625	1249	100	188	31.104800
3626	1250	100	188	31.104800
3627	1251	100	188	31.104800
3628	1252	100	188	31.104800
3629	1253	100	188	31.104800
3630	1254	100	188	31.104800
3631	1255	100	188	31.104800
3632	1256	100	188	31.104800
3633	1257	100	188	31.104800
3634	1258	100	188	31.104800
3635	1259	100	188	31.104800
3636	1260	100	188	31.104800
3637	1261	100	188	31.104800
3638	1262	100	188	31.104800
3639	1263	100	188	31.104800
3640	1264	100	188	31.104800
3641	1265	100	188	31.104800
3642	1266	100	188	31.104800
3643	1267	100	188	31.104800
3644	1268	100	188	31.104800
3645	1269	100	188	31.104800
3646	1270	100	188	31.104800
3647	1271	100	188	31.104800
3648	1272	100	188	31.104800
3649	1273	100	188	31.104800
3650	1274	100	188	31.104800
3651	1275	100	188	31.104800
3652	1276	100	188	31.104800
3653	1277	100	188	31.104800
3654	1278	100	188	31.104800
3655	1279	100	188	31.104800
3656	1280	100	188	31.104800
3657	1281	100	188	31.104800
3658	1282	100	188	31.104800
3659	1283	100	188	31.104800
3660	1284	100	188	31.104800
3661	1285	100	188	31.104800
3662	1286	100	188	31.104800
3663	1287	100	188	31.104800
3664	1288	100	188	31.104800
3665	1289	100	188	31.104800
3666	1290	100	188	31.104800
3667	1291	100	188	31.104800
3668	1292	100	188	31.104800
3669	1293	100	188	31.104800
3670	1294	100	188	31.104800
3671	1295	100	188	31.104800
3672	1296	100	188	31.104800
3673	1297	100	188	31.104800
3674	1298	100	188	31.104800
3675	1299	100	188	31.104800
3676	1300	100	188	31.104800
3677	1301	100	188	31.104800
3678	1302	100	188	31.104800
3679	1303	100	188	31.104800
3680	1304	100	188	31.104800
3681	1305	100	188	31.104800
3682	1306	100	188	31.104800
3683	1307	100	188	31.104800
3684	1308	100	188	31.104800
3685	1309	100	188	31.104800
3686	1310	100	188	31.104800
3687	1311	100	188	31.104800
3688	1312	100	188	31.104800
3689	1313	100	188	31.104800
3690	1314	100	188	31.104800
3691	1315	100	188	31.104800
3692	1316	100	188	31.104800
3693	1317	100	188	31.104800
3694	1318	100	188	31.104800
3695	1319	100	188	31.104800
3696	1320	100	188	31.104800
3697	1189	100	189	77.173400
3698	1190	100	189	77.173400
3699	1191	100	189	77.173400
3700	1192	100	189	77.173400
3701	1193	100	189	77.173400
3702	1194	100	189	77.173400
3703	1195	100	189	77.173400
3704	1196	100	189	77.173400
3705	1197	100	189	77.173400
3706	1198	100	189	77.173400
3707	1199	100	189	77.173400
3708	1200	100	189	77.173400
3709	1201	100	189	77.173400
3710	1202	100	189	77.173400
3711	1203	100	189	77.173400
3712	1204	100	189	77.173400
3713	1205	100	189	77.173400
3714	1206	100	189	77.173400
3715	1207	100	189	77.173400
3716	1208	100	189	77.173400
3717	1209	100	189	77.173400
3718	1210	100	189	77.173400
3719	1211	100	189	77.173400
3720	1212	100	189	77.173400
3721	1213	100	189	77.173400
3722	1214	100	189	77.173400
3723	1215	100	189	77.173400
3724	1216	100	189	77.173400
3725	1217	100	189	77.173400
3726	1218	100	189	77.173400
3727	1219	100	189	77.173400
3728	1220	100	189	77.173400
3729	1221	100	189	77.173400
3730	1222	100	189	77.173400
3731	1223	100	189	77.173400
3732	1224	100	189	77.173400
3733	1225	100	189	77.173400
3734	1226	100	189	77.173400
3735	1227	100	189	77.173400
3736	1228	100	189	77.173400
3737	1229	100	189	77.173400
3738	1230	100	189	77.173400
3739	1231	100	189	77.173400
3740	1232	100	189	77.173400
3741	1233	100	189	77.173400
3742	1234	100	189	77.173400
3743	1235	100	189	77.173400
3744	1236	100	189	77.173400
3745	1237	100	189	77.173400
3746	1238	100	189	77.173400
3747	1239	100	189	77.173400
3748	1240	100	189	77.173400
3749	1241	100	189	77.173400
3750	1242	100	189	77.173400
3751	1243	100	189	77.173400
3752	1244	100	189	77.173400
3753	1245	100	189	77.173400
3754	1246	100	189	77.173400
3755	1247	100	189	77.173400
3756	1248	100	189	77.173400
3757	1249	100	189	77.173400
3758	1250	100	189	77.173400
3759	1251	100	189	77.173400
3760	1252	100	189	77.173400
3761	1253	100	189	77.173400
3762	1254	100	189	77.173400
3763	1255	100	189	77.173400
3764	1256	100	189	77.173400
3765	1257	100	189	77.173400
3766	1258	100	189	77.173400
3767	1259	100	189	77.173400
3768	1260	100	189	77.173400
3769	1261	100	189	77.173400
3770	1262	100	189	77.173400
3771	1263	100	189	77.173400
3772	1264	100	189	77.173400
3773	1265	100	189	77.173400
3774	1266	100	189	77.173400
3775	1267	100	189	77.173400
3776	1268	100	189	77.173400
3777	1269	100	189	77.173400
3778	1270	100	189	77.173400
3779	1271	100	189	77.173400
3780	1272	100	189	77.173400
3781	1273	100	189	77.173400
3782	1274	100	189	77.173400
3783	1275	100	189	77.173400
3784	1276	100	189	77.173400
3785	1277	100	189	77.173400
3786	1278	100	189	77.173400
3787	1279	100	189	77.173400
3788	1280	100	189	77.173400
3789	1281	100	189	77.173400
3790	1282	100	189	77.173400
3791	1283	100	189	77.173400
3792	1284	100	189	77.173400
3793	1285	100	189	77.173400
3794	1286	100	189	77.173400
3795	1287	100	189	77.173400
3796	1288	100	189	77.173400
3797	1289	100	189	77.173400
3798	1290	100	189	77.173400
3799	1291	100	189	77.173400
3800	1292	100	189	77.173400
3801	1293	100	189	77.173400
3802	1294	100	189	77.173400
3803	1295	100	189	77.173400
3804	1296	100	189	77.173400
3805	1297	100	189	77.173400
3806	1298	100	189	77.173400
3807	1299	100	189	77.173400
3808	1300	100	189	77.173400
3809	1301	100	189	77.173400
3810	1302	100	189	77.173400
3811	1303	100	189	77.173400
3812	1304	100	189	77.173400
3813	1305	100	189	77.173400
3814	1306	100	189	77.173400
3815	1307	100	189	77.173400
3816	1308	100	189	77.173400
3817	1309	100	189	77.173400
3818	1310	100	189	77.173400
3819	1311	100	189	77.173400
3820	1312	100	189	77.173400
3821	1313	100	189	77.173400
3822	1314	100	189	77.173400
3823	1315	100	189	77.173400
3824	1316	100	189	77.173400
3825	1317	100	189	77.173400
3826	1318	100	189	77.173400
3827	1319	100	189	77.173400
3828	1320	100	189	77.173400
3829	1189	200	187	3.690000
3830	1190	200	187	4.200000
3831	1191	200	187	5.370000
3832	1192	200	187	7.100000
3833	1193	200	187	8.040000
3834	1194	200	187	7.810000
3835	1195	200	187	6.280000
3836	1196	200	187	5.670000
3837	1197	200	187	5.850000
3838	1198	200	187	5.870000
3839	1199	200	187	4.950000
3840	1200	200	187	3.930000
3841	1201	200	187	3.570000
3842	1202	200	187	4.390000
3843	1203	200	187	5.290000
3844	1204	200	187	6.980000
3845	1205	200	187	8.130000
3846	1206	200	187	7.820000
3847	1207	200	187	6.280000
3848	1208	200	187	5.720000
3849	1209	200	187	5.870000
3850	1210	200	187	5.860000
3851	1211	200	187	4.990000
3852	1212	200	187	3.910000
3853	1213	200	187	3.680000
3854	1214	200	187	4.230000
3855	1215	200	187	5.570000
3856	1216	200	187	6.970000
3857	1217	200	187	8.050000
3858	1218	200	187	7.900000
3859	1219	200	187	6.380000
3860	1220	200	187	5.710000
3861	1221	200	187	5.870000
3862	1222	200	187	5.860000
3863	1223	200	187	4.950000
3864	1224	200	187	3.930000
3865	1225	200	187	3.530000
3866	1226	200	187	4.230000
3867	1227	200	187	5.290000
3868	1228	200	187	6.800000
3869	1229	200	187	8.080000
3870	1230	200	187	7.770000
3871	1231	200	187	6.310000
3872	1232	200	187	5.650000
3873	1233	200	187	5.770000
3874	1234	200	187	5.690000
3875	1235	200	187	4.910000
3876	1236	200	187	3.770000
3877	1237	200	187	3.820000
3878	1238	200	187	4.380000
3879	1239	200	187	5.280000
3880	1240	200	187	7.190000
3881	1241	200	187	7.790000
3882	1242	200	187	7.510000
3883	1243	200	187	6.270000
3884	1244	200	187	5.340000
3885	1245	200	187	5.760000
3886	1246	200	187	5.830000
3887	1247	200	187	4.970000
3888	1248	200	187	4.050000
3889	1249	200	187	3.700000
3890	1250	200	187	4.380000
3891	1251	200	187	5.290000
3892	1252	200	187	7.180000
3893	1253	200	187	8.010000
3894	1254	200	187	7.690000
3895	1255	200	187	6.560000
3896	1256	200	187	6.050000
3897	1257	200	187	6.050000
3898	1258	200	187	5.710000
3899	1259	200	187	4.760000
3900	1260	200	187	3.690000
3901	1261	200	187	3.410000
3902	1262	200	187	4.300000
3903	1263	200	187	5.320000
3904	1264	200	187	6.920000
3905	1265	200	187	7.920000
3906	1266	200	187	7.640000
3907	1267	200	187	6.300000
3908	1268	200	187	5.590000
3909	1269	200	187	5.790000
3910	1270	200	187	5.770000
3911	1271	200	187	5.130000
3912	1272	200	187	4.040000
3913	1273	200	187	3.410000
3914	1274	200	187	4.400000
3915	1275	200	187	5.640000
3916	1276	200	187	7.400000
3917	1277	200	187	8.130000
3918	1278	200	187	7.910000
3919	1279	200	187	6.240000
3920	1280	200	187	6.010000
3921	1281	200	187	5.810000
3922	1282	200	187	5.880000
3923	1283	200	187	4.940000
3924	1284	200	187	4.190000
3925	1285	200	187	3.740000
3926	1286	200	187	4.240000
3927	1287	200	187	5.400000
3928	1288	200	187	7.100000
3929	1289	200	187	8.260000
3930	1290	200	187	7.650000
3931	1291	200	187	6.030000
3932	1292	200	187	5.740000
3933	1293	200	187	6.000000
3934	1294	200	187	5.790000
3935	1295	200	187	4.910000
3936	1296	200	187	4.170000
3937	1297	200	187	3.750000
3938	1298	200	187	4.390000
3939	1299	200	187	5.700000
3940	1300	200	187	6.910000
3941	1301	200	187	8.080000
3942	1302	200	187	7.530000
3943	1303	200	187	6.120000
3944	1304	200	187	5.880000
3945	1305	200	187	6.000000
3946	1306	200	187	5.850000
3947	1307	200	187	4.980000
3948	1308	200	187	3.890000
3949	1309	200	187	3.710000
3950	1310	200	187	4.290000
3951	1311	200	187	5.580000
3952	1312	200	187	7.060000
3953	1313	200	187	8.080000
3954	1314	200	187	7.930000
3955	1315	200	187	6.390000
3956	1316	200	187	5.820000
3957	1317	200	187	5.830000
3958	1318	200	187	5.820000
3959	1319	200	187	4.940000
3960	1320	200	187	3.580000
3961	1321	100	191	16.506200
3962	1322	100	191	16.506200
3963	1323	100	191	16.506200
3964	1324	100	191	16.506200
3965	1325	100	191	16.506200
3966	1326	100	191	16.506200
3967	1327	100	191	16.506200
3968	1328	100	191	16.506200
3969	1329	100	191	16.506200
3970	1330	100	191	16.506200
3971	1331	100	191	16.506200
3972	1332	100	191	16.506200
3973	1333	100	191	16.506200
3974	1334	100	191	16.506200
3975	1335	100	191	16.506200
3976	1336	100	191	16.506200
3977	1337	100	191	16.506200
3978	1338	100	191	16.506200
3979	1339	100	191	16.506200
3980	1340	100	191	16.506200
3981	1341	100	191	16.506200
3982	1342	100	191	16.506200
3983	1343	100	191	16.506200
3984	1344	100	191	16.506200
3985	1345	100	191	16.506200
3986	1346	100	191	16.506200
3987	1347	100	191	16.506200
3988	1348	100	191	16.506200
3989	1349	100	191	16.506200
3990	1350	100	191	16.506200
3991	1351	100	191	16.506200
3992	1352	100	191	16.506200
3993	1353	100	191	16.506200
3994	1354	100	191	16.506200
3995	1355	100	191	16.506200
3996	1356	100	191	16.506200
3997	1357	100	191	16.506200
3998	1358	100	191	16.506200
3999	1359	100	191	16.506200
4000	1360	100	191	16.506200
4001	1361	100	191	16.506200
4002	1362	100	191	16.506200
4003	1363	100	191	16.506200
4004	1364	100	191	16.506200
4005	1365	100	191	16.506200
4006	1366	100	191	16.506200
4007	1367	100	191	16.506200
4008	1368	100	191	16.506200
4009	1369	100	191	16.506200
4010	1370	100	191	16.506200
4011	1371	100	191	16.506200
4012	1372	100	191	16.506200
4013	1373	100	191	16.506200
4014	1374	100	191	16.506200
4015	1375	100	191	16.506200
4016	1376	100	191	16.506200
4017	1377	100	191	16.506200
4018	1378	100	191	16.506200
4019	1379	100	191	16.506200
4020	1380	100	191	16.506200
4021	1381	100	191	16.506200
4022	1382	100	191	16.506200
4023	1383	100	191	16.506200
4024	1384	100	191	16.506200
4025	1385	100	191	16.506200
4026	1386	100	191	16.506200
4027	1387	100	191	16.506200
4028	1388	100	191	16.506200
4029	1389	100	191	16.506200
4030	1390	100	191	16.506200
4031	1391	100	191	16.506200
4032	1392	100	191	16.506200
4033	1393	100	191	16.506200
4034	1394	100	191	16.506200
4035	1395	100	191	16.506200
4036	1396	100	191	16.506200
4037	1397	100	191	16.506200
4038	1398	100	191	16.506200
4039	1399	100	191	16.506200
4040	1400	100	191	16.506200
4041	1401	100	191	16.506200
4042	1402	100	191	16.506200
4043	1403	100	191	16.506200
4044	1404	100	191	16.506200
4045	1405	100	191	16.506200
4046	1406	100	191	16.506200
4047	1407	100	191	16.506200
4048	1408	100	191	16.506200
4049	1409	100	191	16.506200
4050	1410	100	191	16.506200
4051	1411	100	191	16.506200
4052	1412	100	191	16.506200
4053	1413	100	191	16.506200
4054	1414	100	191	16.506200
4055	1415	100	191	16.506200
4056	1416	100	191	16.506200
4057	1417	100	191	16.506200
4058	1418	100	191	16.506200
4059	1419	100	191	16.506200
4060	1420	100	191	16.506200
4061	1421	100	191	16.506200
4062	1422	100	191	16.506200
4063	1423	100	191	16.506200
4064	1424	100	191	16.506200
4065	1425	100	191	16.506200
4066	1426	100	191	16.506200
4067	1427	100	191	16.506200
4068	1428	100	191	16.506200
4069	1429	100	191	16.506200
4070	1430	100	191	16.506200
4071	1431	100	191	16.506200
4072	1432	100	191	16.506200
4073	1433	100	191	16.506200
4074	1434	100	191	16.506200
4075	1435	100	191	16.506200
4076	1436	100	191	16.506200
4077	1437	100	191	16.506200
4078	1438	100	191	16.506200
4079	1439	100	191	16.506200
4080	1440	100	191	16.506200
4081	1441	100	191	16.506200
4082	1442	100	191	16.506200
4083	1443	100	191	16.506200
4084	1444	100	191	16.506200
4085	1445	100	191	16.506200
4086	1446	100	191	16.506200
4087	1447	100	191	16.506200
4088	1448	100	191	16.506200
4089	1449	100	191	16.506200
4090	1450	100	191	16.506200
4091	1451	100	191	16.506200
4092	1452	100	191	16.506200
4093	1321	100	192	80.648000
4094	1322	100	192	80.648000
4095	1323	100	192	80.648000
4096	1324	100	192	80.648000
4097	1325	100	192	80.648000
4098	1326	100	192	80.648000
4099	1327	100	192	80.648000
4100	1328	100	192	80.648000
4101	1329	100	192	80.648000
4102	1330	100	192	80.648000
4103	1331	100	192	80.648000
4104	1332	100	192	80.648000
4105	1333	100	192	80.648000
4106	1334	100	192	80.648000
4107	1335	100	192	80.648000
4108	1336	100	192	80.648000
4109	1337	100	192	80.648000
4110	1338	100	192	80.648000
4111	1339	100	192	80.648000
4112	1340	100	192	80.648000
4113	1341	100	192	80.648000
4114	1342	100	192	80.648000
4115	1343	100	192	80.648000
4116	1344	100	192	80.648000
4117	1345	100	192	80.648000
4118	1346	100	192	80.648000
4119	1347	100	192	80.648000
4120	1348	100	192	80.648000
4121	1349	100	192	80.648000
4122	1350	100	192	80.648000
4123	1351	100	192	80.648000
4124	1352	100	192	80.648000
4125	1353	100	192	80.648000
4126	1354	100	192	80.648000
4127	1355	100	192	80.648000
4128	1356	100	192	80.648000
4129	1357	100	192	80.648000
4130	1358	100	192	80.648000
4131	1359	100	192	80.648000
4132	1360	100	192	80.648000
4133	1361	100	192	80.648000
4134	1362	100	192	80.648000
4135	1363	100	192	80.648000
4136	1364	100	192	80.648000
4137	1365	100	192	80.648000
4138	1366	100	192	80.648000
4139	1367	100	192	80.648000
4140	1368	100	192	80.648000
4141	1369	100	192	80.648000
4142	1370	100	192	80.648000
4143	1371	100	192	80.648000
4144	1372	100	192	80.648000
4145	1373	100	192	80.648000
4146	1374	100	192	80.648000
4147	1375	100	192	80.648000
4148	1376	100	192	80.648000
4149	1377	100	192	80.648000
4150	1378	100	192	80.648000
4151	1379	100	192	80.648000
4152	1380	100	192	80.648000
4153	1381	100	192	80.648000
4154	1382	100	192	80.648000
4155	1383	100	192	80.648000
4156	1384	100	192	80.648000
4157	1385	100	192	80.648000
4158	1386	100	192	80.648000
4159	1387	100	192	80.648000
4160	1388	100	192	80.648000
4161	1389	100	192	80.648000
4162	1390	100	192	80.648000
4163	1391	100	192	80.648000
4164	1392	100	192	80.648000
4165	1393	100	192	80.648000
4166	1394	100	192	80.648000
4167	1395	100	192	80.648000
4168	1396	100	192	80.648000
4169	1397	100	192	80.648000
4170	1398	100	192	80.648000
4171	1399	100	192	80.648000
4172	1400	100	192	80.648000
4173	1401	100	192	80.648000
4174	1402	100	192	80.648000
4175	1403	100	192	80.648000
4176	1404	100	192	80.648000
4177	1405	100	192	80.648000
4178	1406	100	192	80.648000
4179	1407	100	192	80.648000
4180	1408	100	192	80.648000
4181	1409	100	192	80.648000
4182	1410	100	192	80.648000
4183	1411	100	192	80.648000
4184	1412	100	192	80.648000
4185	1413	100	192	80.648000
4186	1414	100	192	80.648000
4187	1415	100	192	80.648000
4188	1416	100	192	80.648000
4189	1417	100	192	80.648000
4190	1418	100	192	80.648000
4191	1419	100	192	80.648000
4192	1420	100	192	80.648000
4193	1421	100	192	80.648000
4194	1422	100	192	80.648000
4195	1423	100	192	80.648000
4196	1424	100	192	80.648000
4197	1425	100	192	80.648000
4198	1426	100	192	80.648000
4199	1427	100	192	80.648000
4200	1428	100	192	80.648000
4201	1429	100	192	80.648000
4202	1430	100	192	80.648000
4203	1431	100	192	80.648000
4204	1432	100	192	80.648000
4205	1433	100	192	80.648000
4206	1434	100	192	80.648000
4207	1435	100	192	80.648000
4208	1436	100	192	80.648000
4209	1437	100	192	80.648000
4210	1438	100	192	80.648000
4211	1439	100	192	80.648000
4212	1440	100	192	80.648000
4213	1441	100	192	80.648000
4214	1442	100	192	80.648000
4215	1443	100	192	80.648000
4216	1444	100	192	80.648000
4217	1445	100	192	80.648000
4218	1446	100	192	80.648000
4219	1447	100	192	80.648000
4220	1448	100	192	80.648000
4221	1449	100	192	80.648000
4222	1450	100	192	80.648000
4223	1451	100	192	80.648000
4224	1452	100	192	80.648000
4225	1321	200	190	5.300000
4226	1322	200	190	6.020000
4227	1323	200	190	6.660000
4228	1324	200	190	7.010000
4229	1325	200	190	7.050000
4230	1326	200	190	6.250000
4231	1327	200	190	5.190000
4232	1328	200	190	5.020000
4233	1329	200	190	5.120000
4234	1330	200	190	5.300000
4235	1331	200	190	5.330000
4236	1332	200	190	5.130000
4237	1333	200	190	5.380000
4238	1334	200	190	6.010000
4239	1335	200	190	6.650000
4240	1336	200	190	7.010000
4241	1337	200	190	7.050000
4242	1338	200	190	6.230000
4243	1339	200	190	5.180000
4244	1340	200	190	5.080000
4245	1341	200	190	5.140000
4246	1342	200	190	5.290000
4247	1343	200	190	5.330000
4248	1344	200	190	5.140000
4249	1345	200	190	5.360000
4250	1346	200	190	6.020000
4251	1347	200	190	6.730000
4252	1348	200	190	7.030000
4253	1349	200	190	7.080000
4254	1350	200	190	6.250000
4255	1351	200	190	5.160000
4256	1352	200	190	4.960000
4257	1353	200	190	5.130000
4258	1354	200	190	5.300000
4259	1355	200	190	5.300000
4260	1356	200	190	5.160000
4261	1357	200	190	5.320000
4262	1358	200	190	6.010000
4263	1359	200	190	6.650000
4264	1360	200	190	7.100000
4265	1361	200	190	6.960000
4266	1362	200	190	6.230000
4267	1363	200	190	5.130000
4268	1364	200	190	5.020000
4269	1365	200	190	5.090000
4270	1366	200	190	5.230000
4271	1367	200	190	5.220000
4272	1368	200	190	5.140000
4273	1369	200	190	5.620000
4274	1370	200	190	6.030000
4275	1371	200	190	6.520000
4276	1372	200	190	6.950000
4277	1373	200	190	7.080000
4278	1374	200	190	6.230000
4279	1375	200	190	5.230000
4280	1376	200	190	4.680000
4281	1377	200	190	5.060000
4282	1378	200	190	5.380000
4283	1379	200	190	5.530000
4284	1380	200	190	5.010000
4285	1381	200	190	5.350000
4286	1382	200	190	6.090000
4287	1383	200	190	6.440000
4288	1384	200	190	6.920000
4289	1385	200	190	7.080000
4290	1386	200	190	6.350000
4291	1387	200	190	5.150000
4292	1388	200	190	5.260000
4293	1389	200	190	5.150000
4294	1390	200	190	5.610000
4295	1391	200	190	5.180000
4296	1392	200	190	4.790000
4297	1393	200	190	5.520000
4298	1394	200	190	5.890000
4299	1395	200	190	6.580000
4300	1396	200	190	7.060000
4301	1397	200	190	7.110000
4302	1398	200	190	6.290000
4303	1399	200	190	5.260000
4304	1400	200	190	4.940000
4305	1401	200	190	5.080000
4306	1402	200	190	5.220000
4307	1403	200	190	5.130000
4308	1404	200	190	5.150000
4309	1405	200	190	5.330000
4310	1406	200	190	6.140000
4311	1407	200	190	6.700000
4312	1408	200	190	7.180000
4313	1409	200	190	6.950000
4314	1410	200	190	6.290000
4315	1411	200	190	5.150000
4316	1412	200	190	4.890000
4317	1413	200	190	4.800000
4318	1414	200	190	5.370000
4319	1415	200	190	5.360000
4320	1416	200	190	4.930000
4321	1417	200	190	5.500000
4322	1418	200	190	5.600000
4323	1419	200	190	6.540000
4324	1420	200	190	7.120000
4325	1421	200	190	7.050000
4326	1422	200	190	6.110000
4327	1423	200	190	5.030000
4328	1424	200	190	5.040000
4329	1425	200	190	5.250000
4330	1426	200	190	5.560000
4331	1427	200	190	5.280000
4332	1428	200	190	5.150000
4333	1429	200	190	5.360000
4334	1430	200	190	6.000000
4335	1431	200	190	6.620000
4336	1432	200	190	6.910000
4337	1433	200	190	7.070000
4338	1434	200	190	5.850000
4339	1435	200	190	5.030000
4340	1436	200	190	4.960000
4341	1437	200	190	5.260000
4342	1438	200	190	5.360000
4343	1439	200	190	4.920000
4344	1440	200	190	4.890000
4345	1441	200	190	5.320000
4346	1442	200	190	5.970000
4347	1443	200	190	6.700000
4348	1444	200	190	7.190000
4349	1445	200	190	7.180000
4350	1446	200	190	6.360000
4351	1447	200	190	5.370000
4352	1448	200	190	4.970000
4353	1449	200	190	5.200000
4354	1450	200	190	5.420000
4355	1451	200	190	5.190000
4356	1452	200	190	5.090000
4357	1453	100	194	11.648000
4358	1454	100	194	11.648000
4359	1455	100	194	11.648000
4360	1456	100	194	11.648000
4361	1457	100	194	11.648000
4362	1458	100	194	11.648000
4363	1459	100	194	11.648000
4364	1460	100	194	11.648000
4365	1461	100	194	11.648000
4366	1462	100	194	11.648000
4367	1463	100	194	11.648000
4368	1464	100	194	11.648000
4369	1465	100	194	11.648000
4370	1466	100	194	11.648000
4371	1467	100	194	11.648000
4372	1468	100	194	11.648000
4373	1469	100	194	11.648000
4374	1470	100	194	11.648000
4375	1471	100	194	11.648000
4376	1472	100	194	11.648000
4377	1473	100	194	11.648000
4378	1474	100	194	11.648000
4379	1475	100	194	11.648000
4380	1476	100	194	11.648000
4381	1477	100	194	11.648000
4382	1478	100	194	11.648000
4383	1479	100	194	11.648000
4384	1480	100	194	11.648000
4385	1481	100	194	11.648000
4386	1482	100	194	11.648000
4387	1483	100	194	11.648000
4388	1484	100	194	11.648000
4389	1485	100	194	11.648000
4390	1486	100	194	11.648000
4391	1487	100	194	11.648000
4392	1488	100	194	11.648000
4393	1489	100	194	11.648000
4394	1490	100	194	11.648000
4395	1491	100	194	11.648000
4396	1492	100	194	11.648000
4397	1493	100	194	11.648000
4398	1494	100	194	11.648000
4399	1495	100	194	11.648000
4400	1496	100	194	11.648000
4401	1497	100	194	11.648000
4402	1498	100	194	11.648000
4403	1499	100	194	11.648000
4404	1500	100	194	11.648000
4405	1501	100	194	11.648000
4406	1502	100	194	11.648000
4407	1503	100	194	11.648000
4408	1504	100	194	11.648000
4409	1505	100	194	11.648000
4410	1506	100	194	11.648000
4411	1507	100	194	11.648000
4412	1508	100	194	11.648000
4413	1509	100	194	11.648000
4414	1510	100	194	11.648000
4415	1511	100	194	11.648000
4416	1512	100	194	11.648000
4417	1513	100	194	11.648000
4418	1514	100	194	11.648000
4419	1515	100	194	11.648000
4420	1516	100	194	11.648000
4421	1517	100	194	11.648000
4422	1518	100	194	11.648000
4423	1519	100	194	11.648000
4424	1520	100	194	11.648000
4425	1521	100	194	11.648000
4426	1522	100	194	11.648000
4427	1523	100	194	11.648000
4428	1524	100	194	11.648000
4429	1525	100	194	11.648000
4430	1526	100	194	11.648000
4431	1527	100	194	11.648000
4432	1528	100	194	11.648000
4433	1529	100	194	11.648000
4434	1530	100	194	11.648000
4435	1531	100	194	11.648000
4436	1532	100	194	11.648000
4437	1533	100	194	11.648000
4438	1534	100	194	11.648000
4439	1535	100	194	11.648000
4440	1536	100	194	11.648000
4441	1537	100	194	11.648000
4442	1538	100	194	11.648000
4443	1539	100	194	11.648000
4444	1540	100	194	11.648000
4445	1541	100	194	11.648000
4446	1542	100	194	11.648000
4447	1543	100	194	11.648000
4448	1544	100	194	11.648000
4449	1545	100	194	11.648000
4450	1546	100	194	11.648000
4451	1547	100	194	11.648000
4452	1548	100	194	11.648000
4453	1549	100	194	11.648000
4454	1550	100	194	11.648000
4455	1551	100	194	11.648000
4456	1552	100	194	11.648000
4457	1553	100	194	11.648000
4458	1554	100	194	11.648000
4459	1555	100	194	11.648000
4460	1556	100	194	11.648000
4461	1557	100	194	11.648000
4462	1558	100	194	11.648000
4463	1559	100	194	11.648000
4464	1560	100	194	11.648000
4465	1561	100	194	11.648000
4466	1562	100	194	11.648000
4467	1563	100	194	11.648000
4468	1564	100	194	11.648000
4469	1565	100	194	11.648000
4470	1566	100	194	11.648000
4471	1567	100	194	11.648000
4472	1568	100	194	11.648000
4473	1569	100	194	11.648000
4474	1570	100	194	11.648000
4475	1571	100	194	11.648000
4476	1572	100	194	11.648000
4477	1573	100	194	11.648000
4478	1574	100	194	11.648000
4479	1575	100	194	11.648000
4480	1576	100	194	11.648000
4481	1577	100	194	11.648000
4482	1578	100	194	11.648000
4483	1579	100	194	11.648000
4484	1580	100	194	11.648000
4485	1581	100	194	11.648000
4486	1582	100	194	11.648000
4487	1583	100	194	11.648000
4488	1584	100	194	11.648000
4489	1453	100	195	92.302400
4490	1454	100	195	92.302400
4491	1455	100	195	92.302400
4492	1456	100	195	92.302400
4493	1457	100	195	92.302400
4494	1458	100	195	92.302400
4495	1459	100	195	92.302400
4496	1460	100	195	92.302400
4497	1461	100	195	92.302400
4498	1462	100	195	92.302400
4499	1463	100	195	92.302400
4500	1464	100	195	92.302400
4501	1465	100	195	92.302400
4502	1466	100	195	92.302400
4503	1467	100	195	92.302400
4504	1468	100	195	92.302400
4505	1469	100	195	92.302400
4506	1470	100	195	92.302400
4507	1471	100	195	92.302400
4508	1472	100	195	92.302400
4509	1473	100	195	92.302400
4510	1474	100	195	92.302400
4511	1475	100	195	92.302400
4512	1476	100	195	92.302400
4513	1477	100	195	92.302400
4514	1478	100	195	92.302400
4515	1479	100	195	92.302400
4516	1480	100	195	92.302400
4517	1481	100	195	92.302400
4518	1482	100	195	92.302400
4519	1483	100	195	92.302400
4520	1484	100	195	92.302400
4521	1485	100	195	92.302400
4522	1486	100	195	92.302400
4523	1487	100	195	92.302400
4524	1488	100	195	92.302400
4525	1489	100	195	92.302400
4526	1490	100	195	92.302400
4527	1491	100	195	92.302400
4528	1492	100	195	92.302400
4529	1493	100	195	92.302400
4530	1494	100	195	92.302400
4531	1495	100	195	92.302400
4532	1496	100	195	92.302400
4533	1497	100	195	92.302400
4534	1498	100	195	92.302400
4535	1499	100	195	92.302400
4536	1500	100	195	92.302400
4537	1501	100	195	92.302400
4538	1502	100	195	92.302400
4539	1503	100	195	92.302400
4540	1504	100	195	92.302400
4541	1505	100	195	92.302400
4542	1506	100	195	92.302400
4543	1507	100	195	92.302400
4544	1508	100	195	92.302400
4545	1509	100	195	92.302400
4546	1510	100	195	92.302400
4547	1511	100	195	92.302400
4548	1512	100	195	92.302400
4549	1513	100	195	92.302400
4550	1514	100	195	92.302400
4551	1515	100	195	92.302400
4552	1516	100	195	92.302400
4553	1517	100	195	92.302400
4554	1518	100	195	92.302400
4555	1519	100	195	92.302400
4556	1520	100	195	92.302400
4557	1521	100	195	92.302400
4558	1522	100	195	92.302400
4559	1523	100	195	92.302400
4560	1524	100	195	92.302400
4561	1525	100	195	92.302400
4562	1526	100	195	92.302400
4563	1527	100	195	92.302400
4564	1528	100	195	92.302400
4565	1529	100	195	92.302400
4566	1530	100	195	92.302400
4567	1531	100	195	92.302400
4568	1532	100	195	92.302400
4569	1533	100	195	92.302400
4570	1534	100	195	92.302400
4571	1535	100	195	92.302400
4572	1536	100	195	92.302400
4573	1537	100	195	92.302400
4574	1538	100	195	92.302400
4575	1539	100	195	92.302400
4576	1540	100	195	92.302400
4577	1541	100	195	92.302400
4578	1542	100	195	92.302400
4579	1543	100	195	92.302400
4580	1544	100	195	92.302400
4581	1545	100	195	92.302400
4582	1546	100	195	92.302400
4583	1547	100	195	92.302400
4584	1548	100	195	92.302400
4585	1549	100	195	92.302400
4586	1550	100	195	92.302400
4587	1551	100	195	92.302400
4588	1552	100	195	92.302400
4589	1553	100	195	92.302400
4590	1554	100	195	92.302400
4591	1555	100	195	92.302400
4592	1556	100	195	92.302400
4593	1557	100	195	92.302400
4594	1558	100	195	92.302400
4595	1559	100	195	92.302400
4596	1560	100	195	92.302400
4597	1561	100	195	92.302400
4598	1562	100	195	92.302400
4599	1563	100	195	92.302400
4600	1564	100	195	92.302400
4601	1565	100	195	92.302400
4602	1566	100	195	92.302400
4603	1567	100	195	92.302400
4604	1568	100	195	92.302400
4605	1569	100	195	92.302400
4606	1570	100	195	92.302400
4607	1571	100	195	92.302400
4608	1572	100	195	92.302400
4609	1573	100	195	92.302400
4610	1574	100	195	92.302400
4611	1575	100	195	92.302400
4612	1576	100	195	92.302400
4613	1577	100	195	92.302400
4614	1578	100	195	92.302400
4615	1579	100	195	92.302400
4616	1580	100	195	92.302400
4617	1581	100	195	92.302400
4618	1582	100	195	92.302400
4619	1583	100	195	92.302400
4620	1584	100	195	92.302400
4621	1453	200	193	4.220000
4622	1454	200	193	4.510000
4623	1455	200	193	5.640000
4624	1456	200	193	6.090000
4625	1457	200	193	6.130000
4626	1458	200	193	5.770000
4627	1459	200	193	5.250000
4628	1460	200	193	5.120000
4629	1461	200	193	4.940000
4630	1462	200	193	5.000000
4631	1463	200	193	4.700000
4632	1464	200	193	4.160000
4633	1465	200	193	4.200000
4634	1466	200	193	4.730000
4635	1467	200	193	5.620000
4636	1468	200	193	5.970000
4637	1469	200	193	6.000000
4638	1470	200	193	5.620000
4639	1471	200	193	5.310000
4640	1472	200	193	5.140000
4641	1473	200	193	4.910000
4642	1474	200	193	5.040000
4643	1475	200	193	4.720000
4644	1476	200	193	4.350000
4645	1477	200	193	4.400000
4646	1478	200	193	4.710000
4647	1479	200	193	5.630000
4648	1480	200	193	6.050000
4649	1481	200	193	6.120000
4650	1482	200	193	5.750000
4651	1483	200	193	5.340000
4652	1484	200	193	5.150000
4653	1485	200	193	5.010000
4654	1486	200	193	5.070000
4655	1487	200	193	4.690000
4656	1488	200	193	4.240000
4657	1489	200	193	4.220000
4658	1490	200	193	4.640000
4659	1491	200	193	5.630000
4660	1492	200	193	6.010000
4661	1493	200	193	6.140000
4662	1494	200	193	5.660000
4663	1495	200	193	5.390000
4664	1496	200	193	5.190000
4665	1497	200	193	5.360000
4666	1498	200	193	5.060000
4667	1499	200	193	4.570000
4668	1500	200	193	4.340000
4669	1501	200	193	4.150000
4670	1502	200	193	4.640000
4671	1503	200	193	5.660000
4672	1504	200	193	5.770000
4673	1505	200	193	5.880000
4674	1506	200	193	5.820000
4675	1507	200	193	4.990000
4676	1508	200	193	5.110000
4677	1509	200	193	4.910000
4678	1510	200	193	4.970000
4679	1511	200	193	5.110000
4680	1512	200	193	4.610000
4681	1513	200	193	4.200000
4682	1514	200	193	4.570000
4683	1515	200	193	5.590000
4684	1516	200	193	5.850000
4685	1517	200	193	6.280000
4686	1518	200	193	5.510000
4687	1519	200	193	5.500000
4688	1520	200	193	5.560000
4689	1521	200	193	4.700000
4690	1522	200	193	5.090000
4691	1523	200	193	4.570000
4692	1524	200	193	3.730000
4693	1525	200	193	4.120000
4694	1526	200	193	4.510000
4695	1527	200	193	5.230000
4696	1528	200	193	5.760000
4697	1529	200	193	6.320000
4698	1530	200	193	5.820000
4699	1531	200	193	4.920000
4700	1532	200	193	4.780000
4701	1533	200	193	5.050000
4702	1534	200	193	4.790000
4703	1535	200	193	4.760000
4704	1536	200	193	4.290000
4705	1537	200	193	4.260000
4706	1538	200	193	4.990000
4707	1539	200	193	6.090000
4708	1540	200	193	6.420000
4709	1541	200	193	6.090000
4710	1542	200	193	5.800000
4711	1543	200	193	5.320000
4712	1544	200	193	5.100000
4713	1545	200	193	4.980000
4714	1546	200	193	4.790000
4715	1547	200	193	4.790000
4716	1548	200	193	4.310000
4717	1549	200	193	4.210000
4718	1550	200	193	4.350000
4719	1551	200	193	5.210000
4720	1552	200	193	5.750000
4721	1553	200	193	5.690000
4722	1554	200	193	5.630000
4723	1555	200	193	5.220000
4724	1556	200	193	4.970000
4725	1557	200	193	4.560000
4726	1558	200	193	5.010000
4727	1559	200	193	4.710000
4728	1560	200	193	4.370000
4729	1561	200	193	4.340000
4730	1562	200	193	4.700000
4731	1563	200	193	5.420000
4732	1564	200	193	5.960000
4733	1565	200	193	6.080000
4734	1566	200	193	5.620000
4735	1567	200	193	5.150000
4736	1568	200	193	5.490000
4737	1569	200	193	4.730000
4738	1570	200	193	4.560000
4739	1571	200	193	4.710000
4740	1572	200	193	4.080000
4741	1573	200	193	4.220000
4742	1574	200	193	4.830000
4743	1575	200	193	5.780000
4744	1576	200	193	5.980000
4745	1577	200	193	6.000000
4746	1578	200	193	5.720000
4747	1579	200	193	5.400000
4748	1580	200	193	5.320000
4749	1581	200	193	4.910000
4750	1582	200	193	5.150000
4751	1583	200	193	4.730000
4752	1584	200	193	4.000000
4753	1585	100	197	20.117000
4754	1586	100	197	20.117000
4755	1587	100	197	20.117000
4756	1588	100	197	20.117000
4757	1589	100	197	20.117000
4758	1590	100	197	20.117000
4759	1591	100	197	20.117000
4760	1592	100	197	20.117000
4761	1593	100	197	20.117000
4762	1594	100	197	20.117000
4763	1595	100	197	20.117000
4764	1596	100	197	20.117000
4765	1597	100	197	20.117000
4766	1598	100	197	20.117000
4767	1599	100	197	20.117000
4768	1600	100	197	20.117000
4769	1601	100	197	20.117000
4770	1602	100	197	20.117000
4771	1603	100	197	20.117000
4772	1604	100	197	20.117000
4773	1605	100	197	20.117000
4774	1606	100	197	20.117000
4775	1607	100	197	20.117000
4776	1608	100	197	20.117000
4777	1609	100	197	20.117000
4778	1610	100	197	20.117000
4779	1611	100	197	20.117000
4780	1612	100	197	20.117000
4781	1613	100	197	20.117000
4782	1614	100	197	20.117000
4783	1615	100	197	20.117000
4784	1616	100	197	20.117000
4785	1617	100	197	20.117000
4786	1618	100	197	20.117000
4787	1619	100	197	20.117000
4788	1620	100	197	20.117000
4789	1621	100	197	20.117000
4790	1622	100	197	20.117000
4791	1623	100	197	20.117000
4792	1624	100	197	20.117000
4793	1625	100	197	20.117000
4794	1626	100	197	20.117000
4795	1627	100	197	20.117000
4796	1628	100	197	20.117000
4797	1629	100	197	20.117000
4798	1630	100	197	20.117000
4799	1631	100	197	20.117000
4800	1632	100	197	20.117000
4801	1633	100	197	20.117000
4802	1634	100	197	20.117000
4803	1635	100	197	20.117000
4804	1636	100	197	20.117000
4805	1637	100	197	20.117000
4806	1638	100	197	20.117000
4807	1639	100	197	20.117000
4808	1640	100	197	20.117000
4809	1641	100	197	20.117000
4810	1642	100	197	20.117000
4811	1643	100	197	20.117000
4812	1644	100	197	20.117000
4813	1645	100	197	20.117000
4814	1646	100	197	20.117000
4815	1647	100	197	20.117000
4816	1648	100	197	20.117000
4817	1649	100	197	20.117000
4818	1650	100	197	20.117000
4819	1651	100	197	20.117000
4820	1652	100	197	20.117000
4821	1653	100	197	20.117000
4822	1654	100	197	20.117000
4823	1655	100	197	20.117000
4824	1656	100	197	20.117000
4825	1657	100	197	20.117000
4826	1658	100	197	20.117000
4827	1659	100	197	20.117000
4828	1660	100	197	20.117000
4829	1661	100	197	20.117000
4830	1662	100	197	20.117000
4831	1663	100	197	20.117000
4832	1664	100	197	20.117000
4833	1665	100	197	20.117000
4834	1666	100	197	20.117000
4835	1667	100	197	20.117000
4836	1668	100	197	20.117000
4837	1669	100	197	20.117000
4838	1670	100	197	20.117000
4839	1671	100	197	20.117000
4840	1672	100	197	20.117000
4841	1673	100	197	20.117000
4842	1674	100	197	20.117000
4843	1675	100	197	20.117000
4844	1676	100	197	20.117000
4845	1677	100	197	20.117000
4846	1678	100	197	20.117000
4847	1679	100	197	20.117000
4848	1680	100	197	20.117000
4849	1681	100	197	20.117000
4850	1682	100	197	20.117000
4851	1683	100	197	20.117000
4852	1684	100	197	20.117000
4853	1685	100	197	20.117000
4854	1686	100	197	20.117000
4855	1687	100	197	20.117000
4856	1688	100	197	20.117000
4857	1689	100	197	20.117000
4858	1690	100	197	20.117000
4859	1691	100	197	20.117000
4860	1692	100	197	20.117000
4861	1693	100	197	20.117000
4862	1694	100	197	20.117000
4863	1695	100	197	20.117000
4864	1696	100	197	20.117000
4865	1697	100	197	20.117000
4866	1698	100	197	20.117000
4867	1699	100	197	20.117000
4868	1700	100	197	20.117000
4869	1701	100	197	20.117000
4870	1702	100	197	20.117000
4871	1703	100	197	20.117000
4872	1704	100	197	20.117000
4873	1705	100	197	20.117000
4874	1706	100	197	20.117000
4875	1707	100	197	20.117000
4876	1708	100	197	20.117000
4877	1709	100	197	20.117000
4878	1710	100	197	20.117000
4879	1711	100	197	20.117000
4880	1712	100	197	20.117000
4881	1713	100	197	20.117000
4882	1714	100	197	20.117000
4883	1715	100	197	20.117000
4884	1716	100	197	20.117000
4885	1585	100	198	78.110800
4886	1586	100	198	78.110800
4887	1587	100	198	78.110800
4888	1588	100	198	78.110800
4889	1589	100	198	78.110800
4890	1590	100	198	78.110800
4891	1591	100	198	78.110800
4892	1592	100	198	78.110800
4893	1593	100	198	78.110800
4894	1594	100	198	78.110800
4895	1595	100	198	78.110800
4896	1596	100	198	78.110800
4897	1597	100	198	78.110800
4898	1598	100	198	78.110800
4899	1599	100	198	78.110800
4900	1600	100	198	78.110800
4901	1601	100	198	78.110800
4902	1602	100	198	78.110800
4903	1603	100	198	78.110800
4904	1604	100	198	78.110800
4905	1605	100	198	78.110800
4906	1606	100	198	78.110800
4907	1607	100	198	78.110800
4908	1608	100	198	78.110800
4909	1609	100	198	78.110800
4910	1610	100	198	78.110800
4911	1611	100	198	78.110800
4912	1612	100	198	78.110800
4913	1613	100	198	78.110800
4914	1614	100	198	78.110800
4915	1615	100	198	78.110800
4916	1616	100	198	78.110800
4917	1617	100	198	78.110800
4918	1618	100	198	78.110800
4919	1619	100	198	78.110800
4920	1620	100	198	78.110800
4921	1621	100	198	78.110800
4922	1622	100	198	78.110800
4923	1623	100	198	78.110800
4924	1624	100	198	78.110800
4925	1625	100	198	78.110800
4926	1626	100	198	78.110800
4927	1627	100	198	78.110800
4928	1628	100	198	78.110800
4929	1629	100	198	78.110800
4930	1630	100	198	78.110800
4931	1631	100	198	78.110800
4932	1632	100	198	78.110800
4933	1633	100	198	78.110800
4934	1634	100	198	78.110800
4935	1635	100	198	78.110800
4936	1636	100	198	78.110800
4937	1637	100	198	78.110800
4938	1638	100	198	78.110800
4939	1639	100	198	78.110800
4940	1640	100	198	78.110800
4941	1641	100	198	78.110800
4942	1642	100	198	78.110800
4943	1643	100	198	78.110800
4944	1644	100	198	78.110800
4945	1645	100	198	78.110800
4946	1646	100	198	78.110800
4947	1647	100	198	78.110800
4948	1648	100	198	78.110800
4949	1649	100	198	78.110800
4950	1650	100	198	78.110800
4951	1651	100	198	78.110800
4952	1652	100	198	78.110800
4953	1653	100	198	78.110800
4954	1654	100	198	78.110800
4955	1655	100	198	78.110800
4956	1656	100	198	78.110800
4957	1657	100	198	78.110800
4958	1658	100	198	78.110800
4959	1659	100	198	78.110800
4960	1660	100	198	78.110800
4961	1661	100	198	78.110800
4962	1662	100	198	78.110800
4963	1663	100	198	78.110800
4964	1664	100	198	78.110800
4965	1665	100	198	78.110800
4966	1666	100	198	78.110800
4967	1667	100	198	78.110800
4968	1668	100	198	78.110800
4969	1669	100	198	78.110800
4970	1670	100	198	78.110800
4971	1671	100	198	78.110800
4972	1672	100	198	78.110800
4973	1673	100	198	78.110800
4974	1674	100	198	78.110800
4975	1675	100	198	78.110800
4976	1676	100	198	78.110800
4977	1677	100	198	78.110800
4978	1678	100	198	78.110800
4979	1679	100	198	78.110800
4980	1680	100	198	78.110800
4981	1681	100	198	78.110800
4982	1682	100	198	78.110800
4983	1683	100	198	78.110800
4984	1684	100	198	78.110800
4985	1685	100	198	78.110800
4986	1686	100	198	78.110800
4987	1687	100	198	78.110800
4988	1688	100	198	78.110800
4989	1689	100	198	78.110800
4990	1690	100	198	78.110800
4991	1691	100	198	78.110800
4992	1692	100	198	78.110800
4993	1693	100	198	78.110800
4994	1694	100	198	78.110800
4995	1695	100	198	78.110800
4996	1696	100	198	78.110800
4997	1697	100	198	78.110800
4998	1698	100	198	78.110800
4999	1699	100	198	78.110800
5000	1700	100	198	78.110800
5001	1701	100	198	78.110800
5002	1702	100	198	78.110800
5003	1703	100	198	78.110800
5004	1704	100	198	78.110800
5005	1705	100	198	78.110800
5006	1706	100	198	78.110800
5007	1707	100	198	78.110800
5008	1708	100	198	78.110800
5009	1709	100	198	78.110800
5010	1710	100	198	78.110800
5011	1711	100	198	78.110800
5012	1712	100	198	78.110800
5013	1713	100	198	78.110800
5014	1714	100	198	78.110800
5015	1715	100	198	78.110800
5016	1716	100	198	78.110800
5017	1585	200	196	5.970000
5018	1586	200	196	6.790000
5019	1587	200	196	7.790000
5020	1588	200	196	8.520000
5021	1589	200	196	8.770000
5022	1590	200	196	7.560000
5023	1591	200	196	5.990000
5024	1592	200	196	5.360000
5025	1593	200	196	5.760000
5026	1594	200	196	6.420000
5027	1595	200	196	6.200000
5028	1596	200	196	5.760000
5029	1597	200	196	5.960000
5030	1598	200	196	6.830000
5031	1599	200	196	7.650000
5032	1600	200	196	8.450000
5033	1601	200	196	8.810000
5034	1602	200	196	7.640000
5035	1603	200	196	5.920000
5036	1604	200	196	5.360000
5037	1605	200	196	5.780000
5038	1606	200	196	6.460000
5039	1607	200	196	6.210000
5040	1608	200	196	5.730000
5041	1609	200	196	5.910000
5042	1610	200	196	6.790000
5043	1611	200	196	7.810000
5044	1612	200	196	8.430000
5045	1613	200	196	8.860000
5046	1614	200	196	7.510000
5047	1615	200	196	5.780000
5048	1616	200	196	5.270000
5049	1617	200	196	5.740000
5050	1618	200	196	6.470000
5051	1619	200	196	6.170000
5052	1620	200	196	5.850000
5053	1621	200	196	5.800000
5054	1622	200	196	6.790000
5055	1623	200	196	7.680000
5056	1624	200	196	8.470000
5057	1625	200	196	8.690000
5058	1626	200	196	7.580000
5059	1627	200	196	5.890000
5060	1628	200	196	5.390000
5061	1629	200	196	5.820000
5062	1630	200	196	6.450000
5063	1631	200	196	6.160000
5064	1632	200	196	5.890000
5065	1633	200	196	6.190000
5066	1634	200	196	6.870000
5067	1635	200	196	7.770000
5068	1636	200	196	8.480000
5069	1637	200	196	8.910000
5070	1638	200	196	7.670000
5071	1639	200	196	6.000000
5072	1640	200	196	5.140000
5073	1641	200	196	5.930000
5074	1642	200	196	6.360000
5075	1643	200	196	6.200000
5076	1644	200	196	5.800000
5077	1645	200	196	5.890000
5078	1646	200	196	6.770000
5079	1647	200	196	7.650000
5080	1648	200	196	8.260000
5081	1649	200	196	8.810000
5082	1650	200	196	7.580000
5083	1651	200	196	5.870000
5084	1652	200	196	5.440000
5085	1653	200	196	5.790000
5086	1654	200	196	6.480000
5087	1655	200	196	6.010000
5088	1656	200	196	5.440000
5089	1657	200	196	5.940000
5090	1658	200	196	6.830000
5091	1659	200	196	7.660000
5092	1660	200	196	8.530000
5093	1661	200	196	8.790000
5094	1662	200	196	7.560000
5095	1663	200	196	6.070000
5096	1664	200	196	5.420000
5097	1665	200	196	5.640000
5098	1666	200	196	6.370000
5099	1667	200	196	6.010000
5100	1668	200	196	5.850000
5101	1669	200	196	5.980000
5102	1670	200	196	6.760000
5103	1671	200	196	7.730000
5104	1672	200	196	8.610000
5105	1673	200	196	8.710000
5106	1674	200	196	7.340000
5107	1675	200	196	5.850000
5108	1676	200	196	5.260000
5109	1677	200	196	5.410000
5110	1678	200	196	6.400000
5111	1679	200	196	6.210000
5112	1680	200	196	5.800000
5113	1681	200	196	6.100000
5114	1682	200	196	6.650000
5115	1683	200	196	7.680000
5116	1684	200	196	8.610000
5117	1685	200	196	8.760000
5118	1686	200	196	7.230000
5119	1687	200	196	5.880000
5120	1688	200	196	5.320000
5121	1689	200	196	5.870000
5122	1690	200	196	6.670000
5123	1691	200	196	6.290000
5124	1692	200	196	5.920000
5125	1693	200	196	5.930000
5126	1694	200	196	6.920000
5127	1695	200	196	7.730000
5128	1696	200	196	8.370000
5129	1697	200	196	8.780000
5130	1698	200	196	7.210000
5131	1699	200	196	5.750000
5132	1700	200	196	5.260000
5133	1701	200	196	5.980000
5134	1702	200	196	6.420000
5135	1703	200	196	6.190000
5136	1704	200	196	5.860000
5137	1705	200	196	5.980000
5138	1706	200	196	6.750000
5139	1707	200	196	7.700000
5140	1708	200	196	8.500000
5141	1709	200	196	8.860000
5142	1710	200	196	7.260000
5143	1711	200	196	6.200000
5144	1712	200	196	5.080000
5145	1713	200	196	5.890000
5146	1714	200	196	6.540000
5147	1715	200	196	6.240000
5148	1716	200	196	5.840000
5149	1717	200	87	8.445000
5150	1718	200	87	40.745000
5151	1719	200	87	28.848000
5152	1720	200	87	78.600000
5153	1721	200	87	336.226000
5154	1722	200	87	393.790000
5155	1723	110	87	721.350000
5156	1724	200	87	496.501000
5157	1725	200	87	302.567000
5158	1726	200	87	152.732000
5159	1727	200	87	28.547000
5160	1728	200	87	24.699000
5161	1729	200	87	44.885000
5162	1730	200	87	45.576000
5163	1731	200	87	98.317000
5164	1732	200	87	100.091000
5165	1733	200	87	342.964000
5166	1734	110	87	701.195000
5167	1735	110	87	626.290000
5168	1736	200	87	474.642000
5169	1737	200	87	370.579000
5170	1738	200	87	85.013000
5171	1739	200	87	14.162000
5172	1740	200	87	0.011000
5173	1741	200	87	15.951000
5174	1742	200	87	39.815000
5175	1743	200	87	222.999000
5176	1744	200	87	165.084000
5177	1745	200	87	233.733000
5178	1746	200	87	543.178000
5179	1747	200	87	430.479000
5180	1748	200	87	520.494000
5181	1749	200	87	172.609000
5182	1750	200	87	54.322000
5183	1751	200	87	24.462000
5184	1752	200	87	9.189000
5185	1753	200	87	16.979000
5186	1754	200	87	26.788000
5187	1755	200	87	11.521000
5188	1756	200	87	95.178000
5189	1757	200	87	316.956000
5190	1758	200	87	500.380000
5191	1759	200	87	582.015000
5192	1760	200	87	530.421000
5193	1761	200	87	271.517000
5194	1762	200	87	62.740000
5195	1763	200	87	120.903000
5196	1764	200	87	1.288000
5197	1765	200	87	0.349000
5198	1766	200	87	35.748000
5199	1767	200	87	111.883000
5200	1768	200	87	230.501000
5201	1769	200	87	510.600000
5202	1770	200	87	423.191000
5203	1771	200	87	433.279000
5204	1772	200	87	510.514000
5205	1773	200	87	280.571000
5206	1774	200	87	179.269000
5207	1775	200	87	11.424000
5208	1776	200	87	1.798000
5209	1777	200	87	6.526000
5210	1778	200	87	7.815000
5211	1779	200	87	100.630000
5212	1780	200	87	128.284000
5213	1781	200	87	171.898000
5214	1782	200	87	335.097000
5215	1783	110	87	780.175000
5216	1784	200	87	383.457000
5217	1785	200	87	446.051000
5218	1786	200	87	55.822000
5219	1787	200	87	14.905000
5220	1788	200	87	35.913000
5221	1789	200	87	11.053000
5222	1790	200	87	11.793000
5223	1791	200	87	113.403000
5224	1792	200	87	204.541000
5225	1793	200	87	405.397000
5226	1794	200	87	357.168000
5227	1795	110	87	670.310000
5228	1796	110	87	645.525000
5229	1797	200	87	179.663000
5230	1798	200	87	98.544000
5231	1799	200	87	109.786000
5232	1800	200	87	0.011000
5233	1801	200	87	9.126000
5234	1802	200	87	6.638000
5235	1803	200	87	29.345000
5236	1804	200	87	47.026000
5237	1805	200	87	445.252000
5238	1806	200	87	340.953000
5239	1807	200	87	504.622000
5240	1808	200	87	382.472000
5241	1809	200	87	139.144000
5242	1810	200	87	220.979000
5243	1811	200	87	16.681000
5244	1812	200	87	5.524000
5245	1813	200	87	16.834000
5246	1814	200	87	38.905000
5247	1815	200	87	67.901000
5248	1816	200	87	336.646000
5249	1817	200	87	499.463000
5250	1818	200	87	221.825000
5251	1819	200	87	299.284000
5252	1820	200	87	590.067000
5253	1821	200	87	261.103000
5254	1822	200	87	132.080000
5255	1823	200	87	15.889000
5256	1824	200	87	7.801000
5257	1825	200	87	4.061000
5258	1826	200	87	12.945000
5259	1827	200	87	106.118000
5260	1828	200	87	153.697000
5261	1829	200	87	401.628000
5262	1830	200	87	458.399000
5263	1831	200	87	419.017000
5264	1832	110	87	639.512000
5265	1833	200	87	248.790000
5266	1834	200	87	232.459000
5267	1835	200	87	38.539000
5268	1836	200	87	3.153000
5269	1837	200	87	25.914000
5270	1838	200	87	7.491000
5271	1839	200	87	62.020000
5272	1840	200	87	277.633000
5273	1841	200	87	316.552000
5274	1842	110	87	740.277000
5275	1843	110	87	610.055000
5276	1844	200	87	388.970000
5277	1845	200	87	264.143000
5278	1846	200	87	113.449000
5279	1847	200	87	48.733000
5280	1848	200	87	3.664000
5281	1717	100	85	23.727100
5282	1718	100	85	23.727100
5283	1719	100	85	23.727100
5284	1720	100	85	23.727100
5285	1721	100	85	23.727100
5286	1722	100	85	23.727100
5287	1723	100	85	23.727100
5288	1724	100	85	23.727100
5289	1725	100	85	23.727100
5290	1726	100	85	23.727100
5291	1727	100	85	23.727100
5292	1728	100	85	23.727100
5293	1729	100	85	23.727100
5294	1730	100	85	23.727100
5295	1731	100	85	23.727100
5296	1732	100	85	23.727100
5297	1733	100	85	23.727100
5298	1734	100	85	23.727100
5299	1735	100	85	23.727100
5300	1736	100	85	23.727100
5301	1737	100	85	23.727100
5302	1738	100	85	23.727100
5303	1739	100	85	23.727100
5304	1740	100	85	23.727100
5305	1741	100	85	23.727100
5306	1742	100	85	23.727100
5307	1743	100	85	23.727100
5308	1744	100	85	23.727100
5309	1745	100	85	23.727100
5310	1746	100	85	23.727100
5311	1747	100	85	23.727100
5312	1748	100	85	23.727100
5313	1749	100	85	23.727100
5314	1750	100	85	23.727100
5315	1751	100	85	23.727100
5316	1752	100	85	23.727100
5317	1753	100	85	23.727100
5318	1754	100	85	23.727100
5319	1755	100	85	23.727100
5320	1756	100	85	23.727100
5321	1757	100	85	23.727100
5322	1758	100	85	23.727100
5323	1759	100	85	23.727100
5324	1760	100	85	23.727100
5325	1761	100	85	23.727100
5326	1762	100	85	23.727100
5327	1763	100	85	23.727100
5328	1764	100	85	23.727100
5329	1765	100	85	23.727100
5330	1766	100	85	23.727100
5331	1767	100	85	23.727100
5332	1768	100	85	23.727100
5333	1769	100	85	23.727100
5334	1770	100	85	23.727100
5335	1771	100	85	23.727100
5336	1772	100	85	23.727100
5337	1773	100	85	23.727100
5338	1774	100	85	23.727100
5339	1775	100	85	23.727100
5340	1776	100	85	23.727100
5341	1777	100	85	23.727100
5342	1778	100	85	23.727100
5343	1779	100	85	23.727100
5344	1780	100	85	23.727100
5345	1781	100	85	23.727100
5346	1782	100	85	23.727100
5347	1783	100	85	23.727100
5348	1784	100	85	23.727100
5349	1785	100	85	23.727100
5350	1786	100	85	23.727100
5351	1787	100	85	23.727100
5352	1788	100	85	23.727100
5353	1789	100	85	23.727100
5354	1790	100	85	23.727100
5355	1791	100	85	23.727100
5356	1792	100	85	23.727100
5357	1793	100	85	23.727100
5358	1794	100	85	23.727100
5359	1795	100	85	23.727100
5360	1796	100	85	23.727100
5361	1797	100	85	23.727100
5362	1798	100	85	23.727100
5363	1799	100	85	23.727100
5364	1800	100	85	23.727100
5365	1801	100	85	23.727100
5366	1802	100	85	23.727100
5367	1803	100	85	23.727100
5368	1804	100	85	23.727100
5369	1805	100	85	23.727100
5370	1806	100	85	23.727100
5371	1807	100	85	23.727100
5372	1808	100	85	23.727100
5373	1809	100	85	23.727100
5374	1810	100	85	23.727100
5375	1811	100	85	23.727100
5376	1812	100	85	23.727100
5377	1813	100	85	23.727100
5378	1814	100	85	23.727100
5379	1815	100	85	23.727100
5380	1816	100	85	23.727100
5381	1817	100	85	23.727100
5382	1818	100	85	23.727100
5383	1819	100	85	23.727100
5384	1820	100	85	23.727100
5385	1821	100	85	23.727100
5386	1822	100	85	23.727100
5387	1823	100	85	23.727100
5388	1824	100	85	23.727100
5389	1825	100	85	23.727100
5390	1826	100	85	23.727100
5391	1827	100	85	23.727100
5392	1828	100	85	23.727100
5393	1829	100	85	23.727100
5394	1830	100	85	23.727100
5395	1831	100	85	23.727100
5396	1832	100	85	23.727100
5397	1833	100	85	23.727100
5398	1834	100	85	23.727100
5399	1835	100	85	23.727100
5400	1836	100	85	23.727100
5401	1837	100	85	23.727100
5402	1838	100	85	23.727100
5403	1839	100	85	23.727100
5404	1840	100	85	23.727100
5405	1841	100	85	23.727100
5406	1842	100	85	23.727100
5407	1843	100	85	23.727100
5408	1844	100	85	23.727100
5409	1845	100	85	23.727100
5410	1846	100	85	23.727100
5411	1847	100	85	23.727100
5412	1848	100	85	23.727100
5413	1717	100	86	92.717600
5414	1718	100	86	92.717600
5415	1719	100	86	92.717600
5416	1720	100	86	92.717600
5417	1721	100	86	92.717600
5418	1722	100	86	92.717600
5419	1723	100	86	92.717600
5420	1724	100	86	92.717600
5421	1725	100	86	92.717600
5422	1726	100	86	92.717600
5423	1727	100	86	92.717600
5424	1728	100	86	92.717600
5425	1729	100	86	92.717600
5426	1730	100	86	92.717600
5427	1731	100	86	92.717600
5428	1732	100	86	92.717600
5429	1733	100	86	92.717600
5430	1734	100	86	92.717600
5431	1735	100	86	92.717600
5432	1736	100	86	92.717600
5433	1737	100	86	92.717600
5434	1738	100	86	92.717600
5435	1739	100	86	92.717600
5436	1740	100	86	92.717600
5437	1741	100	86	92.717600
5438	1742	100	86	92.717600
5439	1743	100	86	92.717600
5440	1744	100	86	92.717600
5441	1745	100	86	92.717600
5442	1746	100	86	92.717600
5443	1747	100	86	92.717600
5444	1748	100	86	92.717600
5445	1749	100	86	92.717600
5446	1750	100	86	92.717600
5447	1751	100	86	92.717600
5448	1752	100	86	92.717600
5449	1753	100	86	92.717600
5450	1754	100	86	92.717600
5451	1755	100	86	92.717600
5452	1756	100	86	92.717600
5453	1757	100	86	92.717600
5454	1758	100	86	92.717600
5455	1759	100	86	92.717600
5456	1760	100	86	92.717600
5457	1761	100	86	92.717600
5458	1762	100	86	92.717600
5459	1763	100	86	92.717600
5460	1764	100	86	92.717600
5461	1765	100	86	92.717600
5462	1766	100	86	92.717600
5463	1767	100	86	92.717600
5464	1768	100	86	92.717600
5465	1769	100	86	92.717600
5466	1770	100	86	92.717600
5467	1771	100	86	92.717600
5468	1772	100	86	92.717600
5469	1773	100	86	92.717600
5470	1774	100	86	92.717600
5471	1775	100	86	92.717600
5472	1776	100	86	92.717600
5473	1777	100	86	92.717600
5474	1778	100	86	92.717600
5475	1779	100	86	92.717600
5476	1780	100	86	92.717600
5477	1781	100	86	92.717600
5478	1782	100	86	92.717600
5479	1783	100	86	92.717600
5480	1784	100	86	92.717600
5481	1785	100	86	92.717600
5482	1786	100	86	92.717600
5483	1787	100	86	92.717600
5484	1788	100	86	92.717600
5485	1789	100	86	92.717600
5486	1790	100	86	92.717600
5487	1791	100	86	92.717600
5488	1792	100	86	92.717600
5489	1793	100	86	92.717600
5490	1794	100	86	92.717600
5491	1795	100	86	92.717600
5492	1796	100	86	92.717600
5493	1797	100	86	92.717600
5494	1798	100	86	92.717600
5495	1799	100	86	92.717600
5496	1800	100	86	92.717600
5497	1801	100	86	92.717600
5498	1802	100	86	92.717600
5499	1803	100	86	92.717600
5500	1804	100	86	92.717600
5501	1805	100	86	92.717600
5502	1806	100	86	92.717600
5503	1807	100	86	92.717600
5504	1808	100	86	92.717600
5505	1809	100	86	92.717600
5506	1810	100	86	92.717600
5507	1811	100	86	92.717600
5508	1812	100	86	92.717600
5509	1813	100	86	92.717600
5510	1814	100	86	92.717600
5511	1815	100	86	92.717600
5512	1816	100	86	92.717600
5513	1817	100	86	92.717600
5514	1818	100	86	92.717600
5515	1819	100	86	92.717600
5516	1820	100	86	92.717600
5517	1821	100	86	92.717600
5518	1822	100	86	92.717600
5519	1823	100	86	92.717600
5520	1824	100	86	92.717600
5521	1825	100	86	92.717600
5522	1826	100	86	92.717600
5523	1827	100	86	92.717600
5524	1828	100	86	92.717600
5525	1829	100	86	92.717600
5526	1830	100	86	92.717600
5527	1831	100	86	92.717600
5528	1832	100	86	92.717600
5529	1833	100	86	92.717600
5530	1834	100	86	92.717600
5531	1835	100	86	92.717600
5532	1836	100	86	92.717600
5533	1837	100	86	92.717600
5534	1838	100	86	92.717600
5535	1839	100	86	92.717600
5536	1840	100	86	92.717600
5537	1841	100	86	92.717600
5538	1842	100	86	92.717600
5539	1843	100	86	92.717600
5540	1844	100	86	92.717600
5541	1845	100	86	92.717600
5542	1846	100	86	92.717600
5543	1847	100	86	92.717600
5544	1848	100	86	92.717600
5545	1849	200	88	0.071000
5546	1850	200	88	0.000000
5547	1851	200	88	0.000000
5548	1852	200	88	10.610000
5549	1853	200	88	108.712000
5550	1854	200	88	159.065000
5551	1855	200	88	149.411000
5552	1856	200	88	80.328000
5553	1857	200	88	100.150000
5554	1858	200	88	159.647000
5555	1859	200	88	50.401000
5556	1860	200	88	1.042000
5557	1861	200	88	0.000000
5558	1862	200	88	0.015000
5559	1863	200	88	24.730000
5560	1864	200	88	40.832000
5561	1865	200	88	122.394000
5562	1866	200	88	127.303000
5563	1867	200	88	85.223000
5564	1868	200	88	92.275000
5565	1869	200	88	152.133000
5566	1870	200	88	180.645000
5567	1871	200	88	34.255000
5568	1872	200	88	73.323000
5569	1873	200	88	0.434000
5570	1874	200	88	1.410000
5571	1875	200	88	4.868000
5572	1876	200	88	18.343000
5573	1877	200	88	92.136000
5574	1878	200	88	43.557000
5575	1879	200	88	98.224000
5576	1880	200	88	49.760000
5577	1881	200	88	51.714000
5578	1882	200	88	199.805000
5579	1883	200	88	35.930000
5580	1884	200	88	6.666000
5581	1885	200	88	16.369000
5582	1886	200	88	0.095000
5583	1887	200	88	15.616000
5584	1888	200	88	36.338000
5585	1889	200	88	170.959000
5586	1890	200	88	90.003000
5587	1891	200	88	96.585000
5588	1892	200	88	162.770000
5589	1893	200	88	158.100000
5590	1894	200	88	174.222000
5591	1895	200	88	19.971000
5592	1896	200	88	0.247000
5593	1897	200	88	0.029000
5594	1898	200	88	0.037000
5595	1899	200	88	0.704000
5596	1900	200	88	101.242000
5597	1901	200	88	126.530000
5598	1902	200	88	206.435000
5599	1903	200	88	51.527000
5600	1904	200	88	203.064000
5601	1905	200	88	171.740000
5602	1906	200	88	184.890000
5603	1907	200	88	13.344000
5604	1908	200	88	21.866000
5605	1909	200	88	4.441000
5606	1910	200	88	0.000000
5607	1911	200	88	22.577000
5608	1912	200	88	73.290000
5609	1913	200	88	83.370000
5610	1914	200	88	76.097000
5611	1915	200	88	33.478000
5612	1916	200	88	114.252000
5613	1917	200	88	161.381000
5614	1918	200	88	314.376000
5615	1919	200	88	180.439000
5616	1920	200	88	27.500000
5617	1921	200	88	0.029000
5618	1922	200	88	0.176000
5619	1923	200	88	0.190000
5620	1924	200	88	95.813000
5621	1925	200	88	125.056000
5622	1926	200	88	59.412000
5623	1927	200	88	214.568000
5624	1928	200	88	256.596000
5625	1929	200	88	144.877000
5626	1930	200	88	219.250000
5627	1931	200	88	57.153000
5628	1932	200	88	45.443000
5629	1933	200	88	0.044000
5630	1934	200	88	10.569000
5631	1935	200	88	0.558000
5632	1936	200	88	77.580000
5633	1937	200	88	226.050000
5634	1938	200	88	73.117000
5635	1939	200	88	99.256000
5636	1940	200	88	68.211000
5637	1941	200	88	100.092000
5638	1942	200	88	194.140000
5639	1943	200	88	67.572000
5640	1944	200	88	5.645000
5641	1945	200	88	0.037000
5642	1946	200	88	11.832000
5643	1947	200	88	0.074000
5644	1948	200	88	80.108000
5645	1949	200	88	73.289000
5646	1950	200	88	89.692000
5647	1951	200	88	99.856000
5648	1952	200	88	193.458000
5649	1953	200	88	132.482000
5650	1954	200	88	291.835000
5651	1955	200	88	13.405000
5652	1956	200	88	14.699000
5653	1957	200	88	0.456000
5654	1958	200	88	0.117000
5655	1959	200	88	3.645000
5656	1960	200	88	102.717000
5657	1961	200	88	71.598000
5658	1962	200	88	35.690000
5659	1963	200	88	97.213000
5660	1964	200	88	64.211000
5661	1965	200	88	150.754000
5662	1966	200	88	165.144000
5663	1967	200	88	32.037000
5664	1968	200	88	8.252000
5665	1969	200	88	0.611000
5666	1970	200	88	0.122000
5667	1971	200	88	0.705000
5668	1972	200	88	10.388000
5669	1973	200	88	218.097000
5670	1974	200	88	160.305000
5671	1975	200	88	33.805000
5672	1976	200	88	40.268000
5673	1977	200	88	60.213000
5674	1978	200	88	183.967000
5675	1979	200	88	35.172000
5676	1980	200	88	4.541000
5677	1849	100	90	77.594600
5678	1850	100	90	77.594600
5679	1851	100	90	77.594600
5680	1852	100	90	77.594600
5681	1853	100	90	77.594600
5682	1854	100	90	77.594600
5683	1855	100	90	77.594600
5684	1856	100	90	77.594600
5685	1857	100	90	77.594600
5686	1858	100	90	77.594600
5687	1859	100	90	77.594600
5688	1860	100	90	77.594600
5689	1861	100	90	77.594600
5690	1862	100	90	77.594600
5691	1863	100	90	77.594600
5692	1864	100	90	77.594600
5693	1865	100	90	77.594600
5694	1866	100	90	77.594600
5695	1867	100	90	77.594600
5696	1868	100	90	77.594600
5697	1869	100	90	77.594600
5698	1870	100	90	77.594600
5699	1871	100	90	77.594600
5700	1872	100	90	77.594600
5701	1873	100	90	77.594600
5702	1874	100	90	77.594600
5703	1875	100	90	77.594600
5704	1876	100	90	77.594600
5705	1877	100	90	77.594600
5706	1878	100	90	77.594600
5707	1879	100	90	77.594600
5708	1880	100	90	77.594600
5709	1881	100	90	77.594600
5710	1882	100	90	77.594600
5711	1883	100	90	77.594600
5712	1884	100	90	77.594600
5713	1885	100	90	77.594600
5714	1886	100	90	77.594600
5715	1887	100	90	77.594600
5716	1888	100	90	77.594600
5717	1889	100	90	77.594600
5718	1890	100	90	77.594600
5719	1891	100	90	77.594600
5720	1892	100	90	77.594600
5721	1893	100	90	77.594600
5722	1894	100	90	77.594600
5723	1895	100	90	77.594600
5724	1896	100	90	77.594600
5725	1897	100	90	77.594600
5726	1898	100	90	77.594600
5727	1899	100	90	77.594600
5728	1900	100	90	77.594600
5729	1901	100	90	77.594600
5730	1902	100	90	77.594600
5731	1903	100	90	77.594600
5732	1904	100	90	77.594600
5733	1905	100	90	77.594600
5734	1906	100	90	77.594600
5735	1907	100	90	77.594600
5736	1908	100	90	77.594600
5737	1909	100	90	77.594600
5738	1910	100	90	77.594600
5739	1911	100	90	77.594600
5740	1912	100	90	77.594600
5741	1913	100	90	77.594600
5742	1914	100	90	77.594600
5743	1915	100	90	77.594600
5744	1916	100	90	77.594600
5745	1917	100	90	77.594600
5746	1918	100	90	77.594600
5747	1919	100	90	77.594600
5748	1920	100	90	77.594600
5749	1921	100	90	77.594600
5750	1922	100	90	77.594600
5751	1923	100	90	77.594600
5752	1924	100	90	77.594600
5753	1925	100	90	77.594600
5754	1926	100	90	77.594600
5755	1927	100	90	77.594600
5756	1928	100	90	77.594600
5757	1929	100	90	77.594600
5758	1930	100	90	77.594600
5759	1931	100	90	77.594600
5760	1932	100	90	77.594600
5761	1933	100	90	77.594600
5762	1934	100	90	77.594600
5763	1935	100	90	77.594600
5764	1936	100	90	77.594600
5765	1937	100	90	77.594600
5766	1938	100	90	77.594600
5767	1939	100	90	77.594600
5768	1940	100	90	77.594600
5769	1941	100	90	77.594600
5770	1942	100	90	77.594600
5771	1943	100	90	77.594600
5772	1944	100	90	77.594600
5773	1945	100	90	77.594600
5774	1946	100	90	77.594600
5775	1947	100	90	77.594600
5776	1948	100	90	77.594600
5777	1949	100	90	77.594600
5778	1950	100	90	77.594600
5779	1951	100	90	77.594600
5780	1952	100	90	77.594600
5781	1953	100	90	77.594600
5782	1954	100	90	77.594600
5783	1955	100	90	77.594600
5784	1956	100	90	77.594600
5785	1957	100	90	77.594600
5786	1958	100	90	77.594600
5787	1959	100	90	77.594600
5788	1960	100	90	77.594600
5789	1961	100	90	77.594600
5790	1962	100	90	77.594600
5791	1963	100	90	77.594600
5792	1964	100	90	77.594600
5793	1965	100	90	77.594600
5794	1966	100	90	77.594600
5795	1967	100	90	77.594600
5796	1968	100	90	77.594600
5797	1969	100	90	77.594600
5798	1970	100	90	77.594600
5799	1971	100	90	77.594600
5800	1972	100	90	77.594600
5801	1973	100	90	77.594600
5802	1974	100	90	77.594600
5803	1975	100	90	77.594600
5804	1976	100	90	77.594600
5805	1977	100	90	77.594600
5806	1978	100	90	77.594600
5807	1979	100	90	77.594600
5808	1980	100	90	77.594600
5809	1849	100	89	12.971600
5810	1850	100	89	12.971600
5811	1851	100	89	12.971600
5812	1852	100	89	12.971600
5813	1853	100	89	12.971600
5814	1854	100	89	12.971600
5815	1855	100	89	12.971600
5816	1856	100	89	12.971600
5817	1857	100	89	12.971600
5818	1858	100	89	12.971600
5819	1859	100	89	12.971600
5820	1860	100	89	12.971600
5821	1861	100	89	12.971600
5822	1862	100	89	12.971600
5823	1863	100	89	12.971600
5824	1864	100	89	12.971600
5825	1865	100	89	12.971600
5826	1866	100	89	12.971600
5827	1867	100	89	12.971600
5828	1868	100	89	12.971600
5829	1869	100	89	12.971600
5830	1870	100	89	12.971600
5831	1871	100	89	12.971600
5832	1872	100	89	12.971600
5833	1873	100	89	12.971600
5834	1874	100	89	12.971600
5835	1875	100	89	12.971600
5836	1876	100	89	12.971600
5837	1877	100	89	12.971600
5838	1878	100	89	12.971600
5839	1879	100	89	12.971600
5840	1880	100	89	12.971600
5841	1881	100	89	12.971600
5842	1882	100	89	12.971600
5843	1883	100	89	12.971600
5844	1884	100	89	12.971600
5845	1885	100	89	12.971600
5846	1886	100	89	12.971600
5847	1887	100	89	12.971600
5848	1888	100	89	12.971600
5849	1889	100	89	12.971600
5850	1890	100	89	12.971600
5851	1891	100	89	12.971600
5852	1892	100	89	12.971600
5853	1893	100	89	12.971600
5854	1894	100	89	12.971600
5855	1895	100	89	12.971600
5856	1896	100	89	12.971600
5857	1897	100	89	12.971600
5858	1898	100	89	12.971600
5859	1899	100	89	12.971600
5860	1900	100	89	12.971600
5861	1901	100	89	12.971600
5862	1902	100	89	12.971600
5863	1903	100	89	12.971600
5864	1904	100	89	12.971600
5865	1905	100	89	12.971600
5866	1906	100	89	12.971600
5867	1907	100	89	12.971600
5868	1908	100	89	12.971600
5869	1909	100	89	12.971600
5870	1910	100	89	12.971600
5871	1911	100	89	12.971600
5872	1912	100	89	12.971600
5873	1913	100	89	12.971600
5874	1914	100	89	12.971600
5875	1915	100	89	12.971600
5876	1916	100	89	12.971600
5877	1917	100	89	12.971600
5878	1918	100	89	12.971600
5879	1919	100	89	12.971600
5880	1920	100	89	12.971600
5881	1921	100	89	12.971600
5882	1922	100	89	12.971600
5883	1923	100	89	12.971600
5884	1924	100	89	12.971600
5885	1925	100	89	12.971600
5886	1926	100	89	12.971600
5887	1927	100	89	12.971600
5888	1928	100	89	12.971600
5889	1929	100	89	12.971600
5890	1930	100	89	12.971600
5891	1931	100	89	12.971600
5892	1932	100	89	12.971600
5893	1933	100	89	12.971600
5894	1934	100	89	12.971600
5895	1935	100	89	12.971600
5896	1936	100	89	12.971600
5897	1937	100	89	12.971600
5898	1938	100	89	12.971600
5899	1939	100	89	12.971600
5900	1940	100	89	12.971600
5901	1941	100	89	12.971600
5902	1942	100	89	12.971600
5903	1943	100	89	12.971600
5904	1944	100	89	12.971600
5905	1945	100	89	12.971600
5906	1946	100	89	12.971600
5907	1947	100	89	12.971600
5908	1948	100	89	12.971600
5909	1949	100	89	12.971600
5910	1950	100	89	12.971600
5911	1951	100	89	12.971600
5912	1952	100	89	12.971600
5913	1953	100	89	12.971600
5914	1954	100	89	12.971600
5915	1955	100	89	12.971600
5916	1956	100	89	12.971600
5917	1957	100	89	12.971600
5918	1958	100	89	12.971600
5919	1959	100	89	12.971600
5920	1960	100	89	12.971600
5921	1961	100	89	12.971600
5922	1962	100	89	12.971600
5923	1963	100	89	12.971600
5924	1964	100	89	12.971600
5925	1965	100	89	12.971600
5926	1966	100	89	12.971600
5927	1967	100	89	12.971600
5928	1968	100	89	12.971600
5929	1969	100	89	12.971600
5930	1970	100	89	12.971600
5931	1971	100	89	12.971600
5932	1972	100	89	12.971600
5933	1973	100	89	12.971600
5934	1974	100	89	12.971600
5935	1975	100	89	12.971600
5936	1976	100	89	12.971600
5937	1977	100	89	12.971600
5938	1978	100	89	12.971600
5939	1979	100	89	12.971600
5940	1980	100	89	12.971600
5941	1981	200	91	4.773000
5942	1982	200	91	15.804000
5943	1983	200	91	2.114000
5944	1984	200	91	2.902000
5945	1985	200	91	13.561000
5946	1986	200	91	2.337000
5947	1987	200	91	40.344000
5948	1988	200	91	61.845000
5949	1989	200	91	41.984000
5950	1990	200	91	13.365000
5951	1991	200	91	0.632000
5952	1992	200	91	0.001000
5953	1993	200	91	0.706000
5954	1994	200	91	2.111000
5955	1995	200	91	2.079000
5956	1996	200	91	1.146000
5957	1997	200	91	3.607000
5958	1998	200	91	30.891000
5959	1999	200	91	126.073000
5960	2000	200	91	17.928000
5961	2001	200	91	20.846000
5962	2002	200	91	5.132000
5963	2003	200	91	0.442000
5964	2004	200	91	0.000000
5965	2005	200	91	12.253000
5966	2006	200	91	1.094000
5967	2007	200	91	1.054000
5968	2008	200	91	3.257000
5969	2009	200	91	22.863000
5970	2010	200	91	19.542000
5971	2011	200	91	87.588000
5972	2012	200	91	99.624000
5973	2013	200	91	44.970000
5974	2014	200	91	0.000000
5975	2015	200	91	0.000000
5976	2016	200	91	0.958000
5977	2017	200	91	10.617000
5978	2018	200	91	16.644000
5979	2019	200	91	0.869000
5980	2020	200	91	16.175000
5981	2021	200	91	0.999000
5982	2022	200	91	17.264000
5983	2023	200	91	193.150000
5984	2024	200	91	59.643000
5985	2025	200	91	17.158000
5986	2026	200	91	8.736000
5987	2027	200	91	0.040000
5988	2028	200	91	0.277000
5989	2029	200	91	3.826000
5990	2030	200	91	2.792000
5991	2031	200	91	6.469000
5992	2032	200	91	6.559000
5993	2033	200	91	15.278000
5994	2034	200	91	129.786000
5995	2035	200	91	64.515000
5996	2036	200	91	77.725000
5997	2037	200	91	7.250000
5998	2038	200	91	3.009000
5999	2039	200	91	0.000000
6000	2040	200	91	0.000000
6001	2041	200	91	4.747000
6002	2042	200	91	1.698000
6003	2043	200	91	4.602000
6004	2044	200	91	7.815000
6005	2045	200	91	21.131000
6006	2046	200	91	82.689000
6007	2047	200	91	38.652000
6008	2048	200	91	96.041000
6009	2049	200	91	9.057000
6010	2050	200	91	16.769000
6011	2051	200	91	2.571000
6012	2052	200	91	3.452000
6013	2053	200	91	0.244000
6014	2054	200	91	3.773000
6015	2055	200	91	8.605000
6016	2056	200	91	55.115000
6017	2057	200	91	4.462000
6018	2058	200	91	37.255000
6019	2059	200	91	137.517000
6020	2060	200	91	24.577000
6021	2061	200	91	53.370000
6022	2062	200	91	9.395000
6023	2063	200	91	0.211000
6024	2064	200	91	4.451000
6025	2065	200	91	11.550000
6026	2066	200	91	5.643000
6027	2067	200	91	0.298000
6028	2068	200	91	0.000000
6029	2069	200	91	37.884000
6030	2070	200	91	10.102000
6031	2071	200	91	62.596000
6032	2072	200	91	35.763000
6033	2073	200	91	10.085000
6034	2074	200	91	2.649000
6035	2075	200	91	0.000000
6036	2076	200	91	0.000000
6037	2077	200	91	2.421000
6038	2078	200	91	2.682000
6039	2079	200	91	0.118000
6040	2080	200	91	0.347000
6041	2081	200	91	3.863000
6042	2082	200	91	16.821000
6043	2083	200	91	118.014000
6044	2084	200	91	25.040000
6045	2085	200	91	2.190000
6046	2086	200	91	0.000000
6047	2087	200	91	3.313000
6048	2088	200	91	0.220000
6049	2089	200	91	0.073000
6050	2090	200	91	0.612000
6051	2091	200	91	0.978000
6052	2092	200	91	16.336000
6053	2093	200	91	32.382000
6054	2094	200	91	65.070000
6055	2095	200	91	51.868000
6056	2096	200	91	32.333000
6057	2097	200	91	33.768000
6058	2098	200	91	3.292000
6059	2099	200	91	0.101000
6060	2100	200	91	0.000000
6061	2101	200	91	0.150000
6062	2102	200	91	0.697000
6063	2103	200	91	3.028000
6064	2104	200	91	10.983000
6065	2105	200	91	14.780000
6066	2106	200	91	5.182000
6067	2107	200	91	6.508000
6068	2108	200	91	12.630000
6069	2109	200	91	2.055000
6070	2110	200	91	0.000000
6071	2111	200	91	7.651000
6072	2112	200	91	13.280000
6073	1981	100	93	73.311900
6074	1982	100	93	73.311900
6075	1983	100	93	73.311900
6076	1984	100	93	73.311900
6077	1985	100	93	73.311900
6078	1986	100	93	73.311900
6079	1987	100	93	73.311900
6080	1988	100	93	73.311900
6081	1989	100	93	73.311900
6082	1990	100	93	73.311900
6083	1991	100	93	73.311900
6084	1992	100	93	73.311900
6085	1993	100	93	73.311900
6086	1994	100	93	73.311900
6087	1995	100	93	73.311900
6088	1996	100	93	73.311900
6089	1997	100	93	73.311900
6090	1998	100	93	73.311900
6091	1999	100	93	73.311900
6092	2000	100	93	73.311900
6093	2001	100	93	73.311900
6094	2002	100	93	73.311900
6095	2003	100	93	73.311900
6096	2004	100	93	73.311900
6097	2005	100	93	73.311900
6098	2006	100	93	73.311900
6099	2007	100	93	73.311900
6100	2008	100	93	73.311900
6101	2009	100	93	73.311900
6102	2010	100	93	73.311900
6103	2011	100	93	73.311900
6104	2012	100	93	73.311900
6105	2013	100	93	73.311900
6106	2014	100	93	73.311900
6107	2015	100	93	73.311900
6108	2016	100	93	73.311900
6109	2017	100	93	73.311900
6110	2018	100	93	73.311900
6111	2019	100	93	73.311900
6112	2020	100	93	73.311900
6113	2021	100	93	73.311900
6114	2022	100	93	73.311900
6115	2023	100	93	73.311900
6116	2024	100	93	73.311900
6117	2025	100	93	73.311900
6118	2026	100	93	73.311900
6119	2027	100	93	73.311900
6120	2028	100	93	73.311900
6121	2029	100	93	73.311900
6122	2030	100	93	73.311900
6123	2031	100	93	73.311900
6124	2032	100	93	73.311900
6125	2033	100	93	73.311900
6126	2034	100	93	73.311900
6127	2035	100	93	73.311900
6128	2036	100	93	73.311900
6129	2037	100	93	73.311900
6130	2038	100	93	73.311900
6131	2039	100	93	73.311900
6132	2040	100	93	73.311900
6133	2041	100	93	73.311900
6134	2042	100	93	73.311900
6135	2043	100	93	73.311900
6136	2044	100	93	73.311900
6137	2045	100	93	73.311900
6138	2046	100	93	73.311900
6139	2047	100	93	73.311900
6140	2048	100	93	73.311900
6141	2049	100	93	73.311900
6142	2050	100	93	73.311900
6143	2051	100	93	73.311900
6144	2052	100	93	73.311900
6145	2053	100	93	73.311900
6146	2054	100	93	73.311900
6147	2055	100	93	73.311900
6148	2056	100	93	73.311900
6149	2057	100	93	73.311900
6150	2058	100	93	73.311900
6151	2059	100	93	73.311900
6152	2060	100	93	73.311900
6153	2061	100	93	73.311900
6154	2062	100	93	73.311900
6155	2063	100	93	73.311900
6156	2064	100	93	73.311900
6157	2065	100	93	73.311900
6158	2066	100	93	73.311900
6159	2067	100	93	73.311900
6160	2068	100	93	73.311900
6161	2069	100	93	73.311900
6162	2070	100	93	73.311900
6163	2071	100	93	73.311900
6164	2072	100	93	73.311900
6165	2073	100	93	73.311900
6166	2074	100	93	73.311900
6167	2075	100	93	73.311900
6168	2076	100	93	73.311900
6169	2077	100	93	73.311900
6170	2078	100	93	73.311900
6171	2079	100	93	73.311900
6172	2080	100	93	73.311900
6173	2081	100	93	73.311900
6174	2082	100	93	73.311900
6175	2083	100	93	73.311900
6176	2084	100	93	73.311900
6177	2085	100	93	73.311900
6178	2086	100	93	73.311900
6179	2087	100	93	73.311900
6180	2088	100	93	73.311900
6181	2089	100	93	73.311900
6182	2090	100	93	73.311900
6183	2091	100	93	73.311900
6184	2092	100	93	73.311900
6185	2093	100	93	73.311900
6186	2094	100	93	73.311900
6187	2095	100	93	73.311900
6188	2096	100	93	73.311900
6189	2097	100	93	73.311900
6190	2098	100	93	73.311900
6191	2099	100	93	73.311900
6192	2100	100	93	73.311900
6193	2101	100	93	73.311900
6194	2102	100	93	73.311900
6195	2103	100	93	73.311900
6196	2104	100	93	73.311900
6197	2105	100	93	73.311900
6198	2106	100	93	73.311900
6199	2107	100	93	73.311900
6200	2108	100	93	73.311900
6201	2109	100	93	73.311900
6202	2110	100	93	73.311900
6203	2111	100	93	73.311900
6204	2112	100	93	73.311900
6205	1981	100	92	28.022900
6206	1982	100	92	28.022900
6207	1983	100	92	28.022900
6208	1984	100	92	28.022900
6209	1985	100	92	28.022900
6210	1986	100	92	28.022900
6211	1987	100	92	28.022900
6212	1988	100	92	28.022900
6213	1989	100	92	28.022900
6214	1990	100	92	28.022900
6215	1991	100	92	28.022900
6216	1992	100	92	28.022900
6217	1993	100	92	28.022900
6218	1994	100	92	28.022900
6219	1995	100	92	28.022900
6220	1996	100	92	28.022900
6221	1997	100	92	28.022900
6222	1998	100	92	28.022900
6223	1999	100	92	28.022900
6224	2000	100	92	28.022900
6225	2001	100	92	28.022900
6226	2002	100	92	28.022900
6227	2003	100	92	28.022900
6228	2004	100	92	28.022900
6229	2005	100	92	28.022900
6230	2006	100	92	28.022900
6231	2007	100	92	28.022900
6232	2008	100	92	28.022900
6233	2009	100	92	28.022900
6234	2010	100	92	28.022900
6235	2011	100	92	28.022900
6236	2012	100	92	28.022900
6237	2013	100	92	28.022900
6238	2014	100	92	28.022900
6239	2015	100	92	28.022900
6240	2016	100	92	28.022900
6241	2017	100	92	28.022900
6242	2018	100	92	28.022900
6243	2019	100	92	28.022900
6244	2020	100	92	28.022900
6245	2021	100	92	28.022900
6246	2022	100	92	28.022900
6247	2023	100	92	28.022900
6248	2024	100	92	28.022900
6249	2025	100	92	28.022900
6250	2026	100	92	28.022900
6251	2027	100	92	28.022900
6252	2028	100	92	28.022900
6253	2029	100	92	28.022900
6254	2030	100	92	28.022900
6255	2031	100	92	28.022900
6256	2032	100	92	28.022900
6257	2033	100	92	28.022900
6258	2034	100	92	28.022900
6259	2035	100	92	28.022900
6260	2036	100	92	28.022900
6261	2037	100	92	28.022900
6262	2038	100	92	28.022900
6263	2039	100	92	28.022900
6264	2040	100	92	28.022900
6265	2041	100	92	28.022900
6266	2042	100	92	28.022900
6267	2043	100	92	28.022900
6268	2044	100	92	28.022900
6269	2045	100	92	28.022900
6270	2046	100	92	28.022900
6271	2047	100	92	28.022900
6272	2048	100	92	28.022900
6273	2049	100	92	28.022900
6274	2050	100	92	28.022900
6275	2051	100	92	28.022900
6276	2052	100	92	28.022900
6277	2053	100	92	28.022900
6278	2054	100	92	28.022900
6279	2055	100	92	28.022900
6280	2056	100	92	28.022900
6281	2057	100	92	28.022900
6282	2058	100	92	28.022900
6283	2059	100	92	28.022900
6284	2060	100	92	28.022900
6285	2061	100	92	28.022900
6286	2062	100	92	28.022900
6287	2063	100	92	28.022900
6288	2064	100	92	28.022900
6289	2065	100	92	28.022900
6290	2066	100	92	28.022900
6291	2067	100	92	28.022900
6292	2068	100	92	28.022900
6293	2069	100	92	28.022900
6294	2070	100	92	28.022900
6295	2071	100	92	28.022900
6296	2072	100	92	28.022900
6297	2073	100	92	28.022900
6298	2074	100	92	28.022900
6299	2075	100	92	28.022900
6300	2076	100	92	28.022900
6301	2077	100	92	28.022900
6302	2078	100	92	28.022900
6303	2079	100	92	28.022900
6304	2080	100	92	28.022900
6305	2081	100	92	28.022900
6306	2082	100	92	28.022900
6307	2083	100	92	28.022900
6308	2084	100	92	28.022900
6309	2085	100	92	28.022900
6310	2086	100	92	28.022900
6311	2087	100	92	28.022900
6312	2088	100	92	28.022900
6313	2089	100	92	28.022900
6314	2090	100	92	28.022900
6315	2091	100	92	28.022900
6316	2092	100	92	28.022900
6317	2093	100	92	28.022900
6318	2094	100	92	28.022900
6319	2095	100	92	28.022900
6320	2096	100	92	28.022900
6321	2097	100	92	28.022900
6322	2098	100	92	28.022900
6323	2099	100	92	28.022900
6324	2100	100	92	28.022900
6325	2101	100	92	28.022900
6326	2102	100	92	28.022900
6327	2103	100	92	28.022900
6328	2104	100	92	28.022900
6329	2105	100	92	28.022900
6330	2106	100	92	28.022900
6331	2107	100	92	28.022900
6332	2108	100	92	28.022900
6333	2109	100	92	28.022900
6334	2110	100	92	28.022900
6335	2111	100	92	28.022900
6336	2112	100	92	28.022900
6337	2113	200	94	27.435000
6338	2114	200	94	7.313000
6339	2115	200	94	0.293000
6340	2116	200	94	8.195000
6341	2117	200	94	23.578000
6342	2118	200	94	141.053000
6343	2119	200	94	260.523000
6344	2120	200	94	136.898000
6345	2121	200	94	138.881000
6346	2122	200	94	81.756000
6347	2123	200	94	0.685000
6348	2124	200	94	0.000000
6349	2125	200	94	6.631000
6350	2126	200	94	0.453000
6351	2127	200	94	30.270000
6352	2128	200	94	24.926000
6353	2129	200	94	50.504000
6354	2130	200	94	187.411000
6355	2131	200	94	254.582000
6356	2132	200	94	265.376000
6357	2133	200	94	340.110000
6358	2134	200	94	113.031000
6359	2135	200	94	5.020000
6360	2136	200	94	0.000000
6361	2137	200	94	41.354000
6362	2138	200	94	37.394000
6363	2139	200	94	23.961000
6364	2140	200	94	34.664000
6365	2141	200	94	33.645000
6366	2142	200	94	332.093000
6367	2143	200	94	348.713000
6368	2144	200	94	356.021000
6369	2145	200	94	74.872000
6370	2146	200	94	162.247000
6371	2147	200	94	1.282000
6372	2148	200	94	0.000000
6373	2149	200	94	19.634000
6374	2150	200	94	25.083000
6375	2151	200	94	29.013000
6376	2152	200	94	5.098000
6377	2153	200	94	45.317000
6378	2154	200	94	58.249000
6379	2155	200	94	290.178000
6380	2156	200	94	246.684000
6381	2157	200	94	349.599000
6382	2158	200	94	53.830000
6383	2159	200	94	12.541000
6384	2160	200	94	0.000000
6385	2161	200	94	20.104000
6386	2162	200	94	19.715000
6387	2163	200	94	3.484000
6388	2164	200	94	13.003000
6389	2165	200	94	12.576000
6390	2166	200	94	315.410000
6391	2167	200	94	255.663000
6392	2168	200	94	424.590000
6393	2169	200	94	141.516000
6394	2170	200	94	167.315000
6395	2171	200	94	0.192000
6396	2172	200	94	0.000000
6397	2173	200	94	38.614000
6398	2174	200	94	9.358000
6399	2175	200	94	13.837000
6400	2176	200	94	25.809000
6401	2177	200	94	105.973000
6402	2178	200	94	35.783000
6403	2179	200	94	345.241000
6404	2180	200	94	409.267000
6405	2181	200	94	193.067000
6406	2182	200	94	38.129000
6407	2183	200	94	22.347000
6408	2184	200	94	15.218000
6409	2185	200	94	31.759000
6410	2186	200	94	53.510000
6411	2187	200	94	13.800000
6412	2188	200	94	23.393000
6413	2189	200	94	101.556000
6414	2190	200	94	96.867000
6415	2191	200	94	217.009000
6416	2192	200	94	234.927000
6417	2193	200	94	219.904000
6418	2194	200	94	236.243000
6419	2195	200	94	28.703000
6420	2196	200	94	0.000000
6421	2197	200	94	17.716000
6422	2198	200	94	10.176000
6423	2199	200	94	0.200000
6424	2200	200	94	0.301000
6425	2201	200	94	74.100000
6426	2202	200	94	155.674000
6427	2203	200	94	305.853000
6428	2204	200	94	370.687000
6429	2205	200	94	312.368000
6430	2206	200	94	39.927000
6431	2207	200	94	6.341000
6432	2208	200	94	0.000000
6433	2209	200	94	9.003000
6434	2210	200	94	48.375000
6435	2211	200	94	0.293000
6436	2212	200	94	37.059000
6437	2213	200	94	47.513000
6438	2214	200	94	186.207000
6439	2215	200	94	155.084000
6440	2216	200	94	169.394000
6441	2217	200	94	242.675000
6442	2218	200	94	14.467000
6443	2219	200	94	3.935000
6444	2220	200	94	0.708000
6445	2221	200	94	1.424000
6446	2222	200	94	3.001000
6447	2223	200	94	51.254000
6448	2224	200	94	22.249000
6449	2225	200	94	41.139000
6450	2226	200	94	117.440000
6451	2227	200	94	217.774000
6452	2228	200	94	293.551000
6453	2229	200	94	71.347000
6454	2230	200	94	113.283000
6455	2231	200	94	5.589000
6456	2232	200	94	0.000000
6457	2233	200	94	37.668000
6458	2234	200	94	16.824000
6459	2235	200	94	6.527000
6460	2236	200	94	25.359000
6461	2237	200	94	25.808000
6462	2238	200	94	112.870000
6463	2239	200	94	230.769000
6464	2240	200	94	357.657000
6465	2241	200	94	217.921000
6466	2242	200	94	102.026000
6467	2243	200	94	14.948000
6468	2244	200	94	0.000000
6469	2113	100	96	86.151100
6470	2114	100	96	86.151100
6471	2115	100	96	86.151100
6472	2116	100	96	86.151100
6473	2117	100	96	86.151100
6474	2118	100	96	86.151100
6475	2119	100	96	86.151100
6476	2120	100	96	86.151100
6477	2121	100	96	86.151100
6478	2122	100	96	86.151100
6479	2123	100	96	86.151100
6480	2124	100	96	86.151100
6481	2125	100	96	86.151100
6482	2126	100	96	86.151100
6483	2127	100	96	86.151100
6484	2128	100	96	86.151100
6485	2129	100	96	86.151100
6486	2130	100	96	86.151100
6487	2131	100	96	86.151100
6488	2132	100	96	86.151100
6489	2133	100	96	86.151100
6490	2134	100	96	86.151100
6491	2135	100	96	86.151100
6492	2136	100	96	86.151100
6493	2137	100	96	86.151100
6494	2138	100	96	86.151100
6495	2139	100	96	86.151100
6496	2140	100	96	86.151100
6497	2141	100	96	86.151100
6498	2142	100	96	86.151100
6499	2143	100	96	86.151100
6500	2144	100	96	86.151100
6501	2145	100	96	86.151100
6502	2146	100	96	86.151100
6503	2147	100	96	86.151100
6504	2148	100	96	86.151100
6505	2149	100	96	86.151100
6506	2150	100	96	86.151100
6507	2151	100	96	86.151100
6508	2152	100	96	86.151100
6509	2153	100	96	86.151100
6510	2154	100	96	86.151100
6511	2155	100	96	86.151100
6512	2156	100	96	86.151100
6513	2157	100	96	86.151100
6514	2158	100	96	86.151100
6515	2159	100	96	86.151100
6516	2160	100	96	86.151100
6517	2161	100	96	86.151100
6518	2162	100	96	86.151100
6519	2163	100	96	86.151100
6520	2164	100	96	86.151100
6521	2165	100	96	86.151100
6522	2166	100	96	86.151100
6523	2167	100	96	86.151100
6524	2168	100	96	86.151100
6525	2169	100	96	86.151100
6526	2170	100	96	86.151100
6527	2171	100	96	86.151100
6528	2172	100	96	86.151100
6529	2173	100	96	86.151100
6530	2174	100	96	86.151100
6531	2175	100	96	86.151100
6532	2176	100	96	86.151100
6533	2177	100	96	86.151100
6534	2178	100	96	86.151100
6535	2179	100	96	86.151100
6536	2180	100	96	86.151100
6537	2181	100	96	86.151100
6538	2182	100	96	86.151100
6539	2183	100	96	86.151100
6540	2184	100	96	86.151100
6541	2185	100	96	86.151100
6542	2186	100	96	86.151100
6543	2187	100	96	86.151100
6544	2188	100	96	86.151100
6545	2189	100	96	86.151100
6546	2190	100	96	86.151100
6547	2191	100	96	86.151100
6548	2192	100	96	86.151100
6549	2193	100	96	86.151100
6550	2194	100	96	86.151100
6551	2195	100	96	86.151100
6552	2196	100	96	86.151100
6553	2197	100	96	86.151100
6554	2198	100	96	86.151100
6555	2199	100	96	86.151100
6556	2200	100	96	86.151100
6557	2201	100	96	86.151100
6558	2202	100	96	86.151100
6559	2203	100	96	86.151100
6560	2204	100	96	86.151100
6561	2205	100	96	86.151100
6562	2206	100	96	86.151100
6563	2207	100	96	86.151100
6564	2208	100	96	86.151100
6565	2209	100	96	86.151100
6566	2210	100	96	86.151100
6567	2211	100	96	86.151100
6568	2212	100	96	86.151100
6569	2213	100	96	86.151100
6570	2214	100	96	86.151100
6571	2215	100	96	86.151100
6572	2216	100	96	86.151100
6573	2217	100	96	86.151100
6574	2218	100	96	86.151100
6575	2219	100	96	86.151100
6576	2220	100	96	86.151100
6577	2221	100	96	86.151100
6578	2222	100	96	86.151100
6579	2223	100	96	86.151100
6580	2224	100	96	86.151100
6581	2225	100	96	86.151100
6582	2226	100	96	86.151100
6583	2227	100	96	86.151100
6584	2228	100	96	86.151100
6585	2229	100	96	86.151100
6586	2230	100	96	86.151100
6587	2231	100	96	86.151100
6588	2232	100	96	86.151100
6589	2233	100	96	86.151100
6590	2234	100	96	86.151100
6591	2235	100	96	86.151100
6592	2236	100	96	86.151100
6593	2237	100	96	86.151100
6594	2238	100	96	86.151100
6595	2239	100	96	86.151100
6596	2240	100	96	86.151100
6597	2241	100	96	86.151100
6598	2242	100	96	86.151100
6599	2243	100	96	86.151100
6600	2244	100	96	86.151100
6601	2113	100	95	23.669300
6602	2114	100	95	23.669300
6603	2115	100	95	23.669300
6604	2116	100	95	23.669300
6605	2117	100	95	23.669300
6606	2118	100	95	23.669300
6607	2119	100	95	23.669300
6608	2120	100	95	23.669300
6609	2121	100	95	23.669300
6610	2122	100	95	23.669300
6611	2123	100	95	23.669300
6612	2124	100	95	23.669300
6613	2125	100	95	23.669300
6614	2126	100	95	23.669300
6615	2127	100	95	23.669300
6616	2128	100	95	23.669300
6617	2129	100	95	23.669300
6618	2130	100	95	23.669300
6619	2131	100	95	23.669300
6620	2132	100	95	23.669300
6621	2133	100	95	23.669300
6622	2134	100	95	23.669300
6623	2135	100	95	23.669300
6624	2136	100	95	23.669300
6625	2137	100	95	23.669300
6626	2138	100	95	23.669300
6627	2139	100	95	23.669300
6628	2140	100	95	23.669300
6629	2141	100	95	23.669300
6630	2142	100	95	23.669300
6631	2143	100	95	23.669300
6632	2144	100	95	23.669300
6633	2145	100	95	23.669300
6634	2146	100	95	23.669300
6635	2147	100	95	23.669300
6636	2148	100	95	23.669300
6637	2149	100	95	23.669300
6638	2150	100	95	23.669300
6639	2151	100	95	23.669300
6640	2152	100	95	23.669300
6641	2153	100	95	23.669300
6642	2154	100	95	23.669300
6643	2155	100	95	23.669300
6644	2156	100	95	23.669300
6645	2157	100	95	23.669300
6646	2158	100	95	23.669300
6647	2159	100	95	23.669300
6648	2160	100	95	23.669300
6649	2161	100	95	23.669300
6650	2162	100	95	23.669300
6651	2163	100	95	23.669300
6652	2164	100	95	23.669300
6653	2165	100	95	23.669300
6654	2166	100	95	23.669300
6655	2167	100	95	23.669300
6656	2168	100	95	23.669300
6657	2169	100	95	23.669300
6658	2170	100	95	23.669300
6659	2171	100	95	23.669300
6660	2172	100	95	23.669300
6661	2173	100	95	23.669300
6662	2174	100	95	23.669300
6663	2175	100	95	23.669300
6664	2176	100	95	23.669300
6665	2177	100	95	23.669300
6666	2178	100	95	23.669300
6667	2179	100	95	23.669300
6668	2180	100	95	23.669300
6669	2181	100	95	23.669300
6670	2182	100	95	23.669300
6671	2183	100	95	23.669300
6672	2184	100	95	23.669300
6673	2185	100	95	23.669300
6674	2186	100	95	23.669300
6675	2187	100	95	23.669300
6676	2188	100	95	23.669300
6677	2189	100	95	23.669300
6678	2190	100	95	23.669300
6679	2191	100	95	23.669300
6680	2192	100	95	23.669300
6681	2193	100	95	23.669300
6682	2194	100	95	23.669300
6683	2195	100	95	23.669300
6684	2196	100	95	23.669300
6685	2197	100	95	23.669300
6686	2198	100	95	23.669300
6687	2199	100	95	23.669300
6688	2200	100	95	23.669300
6689	2201	100	95	23.669300
6690	2202	100	95	23.669300
6691	2203	100	95	23.669300
6692	2204	100	95	23.669300
6693	2205	100	95	23.669300
6694	2206	100	95	23.669300
6695	2207	100	95	23.669300
6696	2208	100	95	23.669300
6697	2209	100	95	23.669300
6698	2210	100	95	23.669300
6699	2211	100	95	23.669300
6700	2212	100	95	23.669300
6701	2213	100	95	23.669300
6702	2214	100	95	23.669300
6703	2215	100	95	23.669300
6704	2216	100	95	23.669300
6705	2217	100	95	23.669300
6706	2218	100	95	23.669300
6707	2219	100	95	23.669300
6708	2220	100	95	23.669300
6709	2221	100	95	23.669300
6710	2222	100	95	23.669300
6711	2223	100	95	23.669300
6712	2224	100	95	23.669300
6713	2225	100	95	23.669300
6714	2226	100	95	23.669300
6715	2227	100	95	23.669300
6716	2228	100	95	23.669300
6717	2229	100	95	23.669300
6718	2230	100	95	23.669300
6719	2231	100	95	23.669300
6720	2232	100	95	23.669300
6721	2233	100	95	23.669300
6722	2234	100	95	23.669300
6723	2235	100	95	23.669300
6724	2236	100	95	23.669300
6725	2237	100	95	23.669300
6726	2238	100	95	23.669300
6727	2239	100	95	23.669300
6728	2240	100	95	23.669300
6729	2241	100	95	23.669300
6730	2242	100	95	23.669300
6731	2243	100	95	23.669300
6732	2244	100	95	23.669300
6733	2245	200	97	32.400000
6734	2246	200	97	39.700000
6735	2247	200	97	11.900000
6736	2248	200	97	8.800000
6737	2249	200	97	31.200000
6738	2250	200	97	35.700000
6739	2251	200	97	128.700000
6740	2252	200	97	220.800000
6741	2253	200	97	95.000000
6742	2254	200	97	4.600000
6743	2255	200	97	23.100000
6744	2256	200	97	1.200000
6745	2257	200	97	14.300000
6746	2258	200	97	15.500000
6747	2259	200	97	15.700000
6748	2260	200	97	15.300000
6749	2261	200	97	19.100000
6750	2262	200	97	77.100000
6751	2263	200	97	202.200000
6752	2264	200	97	57.500000
6753	2265	200	97	158.500000
6754	2266	200	97	0.000000
6755	2267	200	97	0.000000
6756	2268	200	97	0.000000
6757	2269	200	97	14.400000
6758	2270	200	97	7.400000
6759	2271	200	97	12.800000
6760	2272	200	97	7.000000
6761	2273	200	97	47.400000
6762	2274	200	97	42.700000
6763	2275	200	97	187.400000
6764	2276	200	97	154.200000
6765	2277	200	97	118.000000
6766	2278	200	97	1.700000
6767	2279	200	97	0.000000
6768	2280	200	97	5.000000
6769	2281	200	97	30.500000
6770	2282	200	97	72.000000
6771	2283	200	97	35.700000
6772	2284	200	97	7.100000
6773	2285	200	97	1.100000
6774	2286	200	97	69.700000
6775	2287	200	97	167.500000
6776	2288	200	97	304.600000
6777	2289	200	97	139.900000
6778	2290	200	97	1.800000
6779	2291	200	97	12.300000
6780	2292	200	97	1.000000
6781	2293	200	97	37.400000
6782	2294	200	97	31.400000
6783	2295	200	97	16.800000
6784	2296	200	97	5.800000
6785	2297	200	97	23.200000
6786	2298	200	97	187.000000
6787	2299	200	97	134.500000
6788	2300	200	97	287.300000
6789	2301	200	97	79.700000
6790	2302	200	97	8.600000
6791	2303	200	97	0.000000
6792	2304	200	97	0.400000
6793	2305	200	97	23.700000
6794	2306	200	97	10.200000
6795	2307	200	97	15.300000
6796	2308	200	97	39.800000
6797	2309	200	97	22.700000
6798	2310	200	97	132.500000
6799	2311	200	97	234.100000
6800	2312	200	97	268.400000
6801	2313	200	97	57.800000
6802	2314	200	97	22.200000
6803	2315	200	97	15.100000
6804	2316	200	97	3.800000
6805	2317	200	97	24.600000
6806	2318	200	97	32.200000
6807	2319	200	97	34.600000
6808	2320	200	97	21.600000
6809	2321	200	97	19.700000
6810	2322	200	97	12.600000
6811	2323	200	97	231.300000
6812	2324	200	97	179.600000
6813	2325	200	97	55.500000
6814	2326	200	97	17.800000
6815	2327	200	97	3.000000
6816	2328	200	97	0.400000
6817	2329	200	97	8.100000
6818	2330	200	97	6.900000
6819	2331	200	97	6.100000
6820	2332	200	97	1.200000
6821	2333	200	97	14.600000
6822	2334	200	97	78.900000
6823	2335	200	97	75.900000
6824	2336	200	97	124.400000
6825	2337	200	97	92.800000
6826	2338	200	97	4.300000
6827	2339	200	97	0.300000
6828	2340	200	97	3.600000
6829	2341	200	97	15.800000
6830	2342	200	97	27.700000
6831	2343	200	97	6.000000
6832	2344	200	97	1.900000
6833	2345	200	97	15.000000
6834	2346	200	97	87.600000
6835	2347	200	97	236.500000
6836	2348	200	97	134.600000
6837	2349	200	97	46.000000
6838	2350	200	97	0.000000
6839	2351	200	97	2.900000
6840	2352	200	97	0.200000
6841	2353	200	97	7.100000
6842	2354	200	97	6.400000
6843	2355	200	97	11.900000
6844	2356	200	97	10.300000
6845	2357	200	97	27.000000
6846	2358	200	97	68.700000
6847	2359	200	97	268.400000
6848	2360	200	97	31.500000
6849	2361	200	97	37.200000
6850	2362	200	97	0.300000
6851	2363	200	97	0.400000
6852	2364	200	97	1.300000
6853	2365	200	97	12.600000
6854	2366	200	97	24.000000
6855	2367	200	97	23.300000
6856	2368	200	97	5.400000
6857	2369	200	97	14.100000
6858	2370	200	97	48.200000
6859	2371	200	97	94.900000
6860	2372	200	97	120.900000
6861	2373	200	97	160.000000
6862	2374	200	97	0.600000
6863	2375	200	97	0.000000
6864	2376	200	97	4.000000
6865	2245	100	99	76.779400
6866	2246	100	99	76.779400
6867	2247	100	99	76.779400
6868	2248	100	99	76.779400
6869	2249	100	99	76.779400
6870	2250	100	99	76.779400
6871	2251	100	99	76.779400
6872	2252	100	99	76.779400
6873	2253	100	99	76.779400
6874	2254	100	99	76.779400
6875	2255	100	99	76.779400
6876	2256	100	99	76.779400
6877	2257	100	99	76.779400
6878	2258	100	99	76.779400
6879	2259	100	99	76.779400
6880	2260	100	99	76.779400
6881	2261	100	99	76.779400
6882	2262	100	99	76.779400
6883	2263	100	99	76.779400
6884	2264	100	99	76.779400
6885	2265	100	99	76.779400
6886	2266	100	99	76.779400
6887	2267	100	99	76.779400
6888	2268	100	99	76.779400
6889	2269	100	99	76.779400
6890	2270	100	99	76.779400
6891	2271	100	99	76.779400
6892	2272	100	99	76.779400
6893	2273	100	99	76.779400
6894	2274	100	99	76.779400
6895	2275	100	99	76.779400
6896	2276	100	99	76.779400
6897	2277	100	99	76.779400
6898	2278	100	99	76.779400
6899	2279	100	99	76.779400
6900	2280	100	99	76.779400
6901	2281	100	99	76.779400
6902	2282	100	99	76.779400
6903	2283	100	99	76.779400
6904	2284	100	99	76.779400
6905	2285	100	99	76.779400
6906	2286	100	99	76.779400
6907	2287	100	99	76.779400
6908	2288	100	99	76.779400
6909	2289	100	99	76.779400
6910	2290	100	99	76.779400
6911	2291	100	99	76.779400
6912	2292	100	99	76.779400
6913	2293	100	99	76.779400
6914	2294	100	99	76.779400
6915	2295	100	99	76.779400
6916	2296	100	99	76.779400
6917	2297	100	99	76.779400
6918	2298	100	99	76.779400
6919	2299	100	99	76.779400
6920	2300	100	99	76.779400
6921	2301	100	99	76.779400
6922	2302	100	99	76.779400
6923	2303	100	99	76.779400
6924	2304	100	99	76.779400
6925	2305	100	99	76.779400
6926	2306	100	99	76.779400
6927	2307	100	99	76.779400
6928	2308	100	99	76.779400
6929	2309	100	99	76.779400
6930	2310	100	99	76.779400
6931	2311	100	99	76.779400
6932	2312	100	99	76.779400
6933	2313	100	99	76.779400
6934	2314	100	99	76.779400
6935	2315	100	99	76.779400
6936	2316	100	99	76.779400
6937	2317	100	99	76.779400
6938	2318	100	99	76.779400
6939	2319	100	99	76.779400
6940	2320	100	99	76.779400
6941	2321	100	99	76.779400
6942	2322	100	99	76.779400
6943	2323	100	99	76.779400
6944	2324	100	99	76.779400
6945	2325	100	99	76.779400
6946	2326	100	99	76.779400
6947	2327	100	99	76.779400
6948	2328	100	99	76.779400
6949	2329	100	99	76.779400
6950	2330	100	99	76.779400
6951	2331	100	99	76.779400
6952	2332	100	99	76.779400
6953	2333	100	99	76.779400
6954	2334	100	99	76.779400
6955	2335	100	99	76.779400
6956	2336	100	99	76.779400
6957	2337	100	99	76.779400
6958	2338	100	99	76.779400
6959	2339	100	99	76.779400
6960	2340	100	99	76.779400
6961	2341	100	99	76.779400
6962	2342	100	99	76.779400
6963	2343	100	99	76.779400
6964	2344	100	99	76.779400
6965	2345	100	99	76.779400
6966	2346	100	99	76.779400
6967	2347	100	99	76.779400
6968	2348	100	99	76.779400
6969	2349	100	99	76.779400
6970	2350	100	99	76.779400
6971	2351	100	99	76.779400
6972	2352	100	99	76.779400
6973	2353	100	99	76.779400
6974	2354	100	99	76.779400
6975	2355	100	99	76.779400
6976	2356	100	99	76.779400
6977	2357	100	99	76.779400
6978	2358	100	99	76.779400
6979	2359	100	99	76.779400
6980	2360	100	99	76.779400
6981	2361	100	99	76.779400
6982	2362	100	99	76.779400
6983	2363	100	99	76.779400
6984	2364	100	99	76.779400
6985	2365	100	99	76.779400
6986	2366	100	99	76.779400
6987	2367	100	99	76.779400
6988	2368	100	99	76.779400
6989	2369	100	99	76.779400
6990	2370	100	99	76.779400
6991	2371	100	99	76.779400
6992	2372	100	99	76.779400
6993	2373	100	99	76.779400
6994	2374	100	99	76.779400
6995	2375	100	99	76.779400
6996	2376	100	99	76.779400
6997	2245	100	98	30.733300
6998	2246	100	98	30.733300
6999	2247	100	98	30.733300
7000	2248	100	98	30.733300
7001	2249	100	98	30.733300
7002	2250	100	98	30.733300
7003	2251	100	98	30.733300
7004	2252	100	98	30.733300
7005	2253	100	98	30.733300
7006	2254	100	98	30.733300
7007	2255	100	98	30.733300
7008	2256	100	98	30.733300
7009	2257	100	98	30.733300
7010	2258	100	98	30.733300
7011	2259	100	98	30.733300
7012	2260	100	98	30.733300
7013	2261	100	98	30.733300
7014	2262	100	98	30.733300
7015	2263	100	98	30.733300
7016	2264	100	98	30.733300
7017	2265	100	98	30.733300
7018	2266	100	98	30.733300
7019	2267	100	98	30.733300
7020	2268	100	98	30.733300
7021	2269	100	98	30.733300
7022	2270	100	98	30.733300
7023	2271	100	98	30.733300
7024	2272	100	98	30.733300
7025	2273	100	98	30.733300
7026	2274	100	98	30.733300
7027	2275	100	98	30.733300
7028	2276	100	98	30.733300
7029	2277	100	98	30.733300
7030	2278	100	98	30.733300
7031	2279	100	98	30.733300
7032	2280	100	98	30.733300
7033	2281	100	98	30.733300
7034	2282	100	98	30.733300
7035	2283	100	98	30.733300
7036	2284	100	98	30.733300
7037	2285	100	98	30.733300
7038	2286	100	98	30.733300
7039	2287	100	98	30.733300
7040	2288	100	98	30.733300
7041	2289	100	98	30.733300
7042	2290	100	98	30.733300
7043	2291	100	98	30.733300
7044	2292	100	98	30.733300
7045	2293	100	98	30.733300
7046	2294	100	98	30.733300
7047	2295	100	98	30.733300
7048	2296	100	98	30.733300
7049	2297	100	98	30.733300
7050	2298	100	98	30.733300
7051	2299	100	98	30.733300
7052	2300	100	98	30.733300
7053	2301	100	98	30.733300
7054	2302	100	98	30.733300
7055	2303	100	98	30.733300
7056	2304	100	98	30.733300
7057	2305	100	98	30.733300
7058	2306	100	98	30.733300
7059	2307	100	98	30.733300
7060	2308	100	98	30.733300
7061	2309	100	98	30.733300
7062	2310	100	98	30.733300
7063	2311	100	98	30.733300
7064	2312	100	98	30.733300
7065	2313	100	98	30.733300
7066	2314	100	98	30.733300
7067	2315	100	98	30.733300
7068	2316	100	98	30.733300
7069	2317	100	98	30.733300
7070	2318	100	98	30.733300
7071	2319	100	98	30.733300
7072	2320	100	98	30.733300
7073	2321	100	98	30.733300
7074	2322	100	98	30.733300
7075	2323	100	98	30.733300
7076	2324	100	98	30.733300
7077	2325	100	98	30.733300
7078	2326	100	98	30.733300
7079	2327	100	98	30.733300
7080	2328	100	98	30.733300
7081	2329	100	98	30.733300
7082	2330	100	98	30.733300
7083	2331	100	98	30.733300
7084	2332	100	98	30.733300
7085	2333	100	98	30.733300
7086	2334	100	98	30.733300
7087	2335	100	98	30.733300
7088	2336	100	98	30.733300
7089	2337	100	98	30.733300
7090	2338	100	98	30.733300
7091	2339	100	98	30.733300
7092	2340	100	98	30.733300
7093	2341	100	98	30.733300
7094	2342	100	98	30.733300
7095	2343	100	98	30.733300
7096	2344	100	98	30.733300
7097	2345	100	98	30.733300
7098	2346	100	98	30.733300
7099	2347	100	98	30.733300
7100	2348	100	98	30.733300
7101	2349	100	98	30.733300
7102	2350	100	98	30.733300
7103	2351	100	98	30.733300
7104	2352	100	98	30.733300
7105	2353	100	98	30.733300
7106	2354	100	98	30.733300
7107	2355	100	98	30.733300
7108	2356	100	98	30.733300
7109	2357	100	98	30.733300
7110	2358	100	98	30.733300
7111	2359	100	98	30.733300
7112	2360	100	98	30.733300
7113	2361	100	98	30.733300
7114	2362	100	98	30.733300
7115	2363	100	98	30.733300
7116	2364	100	98	30.733300
7117	2365	100	98	30.733300
7118	2366	100	98	30.733300
7119	2367	100	98	30.733300
7120	2368	100	98	30.733300
7121	2369	100	98	30.733300
7122	2370	100	98	30.733300
7123	2371	100	98	30.733300
7124	2372	100	98	30.733300
7125	2373	100	98	30.733300
7126	2374	100	98	30.733300
7127	2375	100	98	30.733300
7128	2376	100	98	30.733300
7129	2377	200	100	11.325000
7130	2378	200	100	34.389000
7131	2379	200	100	34.704000
7132	2380	200	100	181.497000
7133	2381	200	100	402.760000
7134	2382	200	100	677.978000
7135	2383	200	100	652.509000
7136	2384	200	100	614.343000
7137	2385	200	100	328.991000
7138	2386	200	100	110.168000
7139	2387	200	100	7.104000
7140	2388	200	100	18.845000
7141	2389	200	100	36.636000
7142	2390	200	100	59.642000
7143	2391	200	100	105.232000
7144	2392	200	100	224.823000
7145	2393	200	100	491.168000
7146	2394	200	100	840.470000
7147	2395	200	100	596.262000
7148	2396	200	100	647.162000
7149	2397	200	100	430.819000
7150	2398	200	100	52.143000
7151	2399	200	100	1.186000
7152	2400	200	100	0.000000
7153	2401	200	100	19.333000
7154	2402	200	100	30.005000
7155	2403	200	100	122.033000
7156	2404	200	100	229.501000
7157	2405	200	100	275.083000
7158	2406	200	100	606.498000
7159	2407	200	100	374.215000
7160	2408	200	100	527.205000
7161	2409	200	100	102.687000
7162	2410	200	100	227.569000
7163	2411	200	100	9.905000
7164	2412	200	100	0.365000
7165	2413	200	100	12.471000
7166	2414	200	100	16.700000
7167	2415	200	100	47.325000
7168	2416	200	100	168.245000
7169	2417	200	100	251.399000
7170	2418	200	100	675.362000
7171	2419	200	100	885.310000
7172	2420	200	100	514.394000
7173	2421	200	100	584.945000
7174	2422	200	100	50.409000
7175	2423	200	100	60.630000
7176	2424	200	100	5.316000
7177	2425	200	100	10.161000
7178	2426	200	100	28.600000
7179	2427	200	100	84.384000
7180	2428	200	100	89.306000
7181	2429	200	100	709.900000
7182	2430	200	100	375.782000
7183	2431	200	100	623.544000
7184	2432	200	100	504.791000
7185	2433	200	100	193.714000
7186	2434	200	100	240.527000
7187	2435	200	100	0.241000
7188	2436	200	100	0.000000
7189	2437	200	100	12.973000
7190	2438	200	100	22.810000
7191	2439	200	100	47.336000
7192	2440	200	100	198.789000
7193	2441	200	100	299.021000
7194	2442	200	100	446.055000
7195	2443	200	100	414.206000
7196	2444	200	100	367.075000
7197	2445	200	100	396.857000
7198	2446	200	100	20.739000
7199	2447	200	100	6.593000
7200	2448	200	100	34.575000
7201	2449	200	100	3.174000
7202	2450	200	100	21.680000
7203	2451	200	100	129.971000
7204	2452	200	100	184.516000
7205	2453	200	100	299.468000
7206	2454	200	100	390.258000
7207	2455	200	100	545.316000
7208	2456	200	100	500.429000
7209	2457	200	100	310.771000
7210	2458	200	100	254.760000
7211	2459	200	100	24.354000
7212	2460	200	100	0.000000
7213	2461	200	100	0.105000
7214	2462	200	100	2.699000
7215	2463	200	100	18.568000
7216	2464	200	100	69.045000
7217	2465	200	100	459.084000
7218	2466	200	100	513.277000
7219	2467	200	100	607.796000
7220	2468	200	100	592.540000
7221	2469	200	100	291.028000
7222	2470	200	100	212.809000
7223	2471	200	100	35.272000
7224	2472	200	100	1.084000
7225	2473	200	100	10.035000
7226	2474	200	100	16.249000
7227	2475	200	100	64.511000
7228	2476	200	100	123.570000
7229	2477	200	100	581.172000
7230	2478	200	100	545.397000
7231	2479	200	100	388.555000
7232	2480	200	100	649.074000
7233	2481	200	100	300.943000
7234	2482	200	100	73.469000
7235	2483	200	100	3.039000
7236	2484	200	100	1.730000
7237	2485	200	100	1.902000
7238	2486	200	100	15.764000
7239	2487	200	100	22.781000
7240	2488	200	100	221.524000
7241	2489	200	100	457.651000
7242	2490	200	100	575.999000
7243	2491	200	100	466.650000
7244	2492	200	100	372.101000
7245	2493	200	100	350.911000
7246	2494	200	100	280.318000
7247	2495	200	100	16.547000
7248	2496	200	100	0.337000
7249	2497	200	100	15.943000
7250	2498	200	100	12.168000
7251	2499	200	100	98.125000
7252	2500	200	100	357.855000
7253	2501	200	100	370.244000
7254	2502	200	100	717.393000
7255	2503	200	100	570.333000
7256	2504	200	100	341.892000
7257	2505	200	100	234.693000
7258	2506	200	100	57.062000
7259	2507	200	100	52.757000
7260	2508	200	100	0.036000
7261	2377	100	102	92.027300
7262	2378	100	102	92.027300
7263	2379	100	102	92.027300
7264	2380	100	102	92.027300
7265	2381	100	102	92.027300
7266	2382	100	102	92.027300
7267	2383	100	102	92.027300
7268	2384	100	102	92.027300
7269	2385	100	102	92.027300
7270	2386	100	102	92.027300
7271	2387	100	102	92.027300
7272	2388	100	102	92.027300
7273	2389	100	102	92.027300
7274	2390	100	102	92.027300
7275	2391	100	102	92.027300
7276	2392	100	102	92.027300
7277	2393	100	102	92.027300
7278	2394	100	102	92.027300
7279	2395	100	102	92.027300
7280	2396	100	102	92.027300
7281	2397	100	102	92.027300
7282	2398	100	102	92.027300
7283	2399	100	102	92.027300
7284	2400	100	102	92.027300
7285	2401	100	102	92.027300
7286	2402	100	102	92.027300
7287	2403	100	102	92.027300
7288	2404	100	102	92.027300
7289	2405	100	102	92.027300
7290	2406	100	102	92.027300
7291	2407	100	102	92.027300
7292	2408	100	102	92.027300
7293	2409	100	102	92.027300
7294	2410	100	102	92.027300
7295	2411	100	102	92.027300
7296	2412	100	102	92.027300
7297	2413	100	102	92.027300
7298	2414	100	102	92.027300
7299	2415	100	102	92.027300
7300	2416	100	102	92.027300
7301	2417	100	102	92.027300
7302	2418	100	102	92.027300
7303	2419	100	102	92.027300
7304	2420	100	102	92.027300
7305	2421	100	102	92.027300
7306	2422	100	102	92.027300
7307	2423	100	102	92.027300
7308	2424	100	102	92.027300
7309	2425	100	102	92.027300
7310	2426	100	102	92.027300
7311	2427	100	102	92.027300
7312	2428	100	102	92.027300
7313	2429	100	102	92.027300
7314	2430	100	102	92.027300
7315	2431	100	102	92.027300
7316	2432	100	102	92.027300
7317	2433	100	102	92.027300
7318	2434	100	102	92.027300
7319	2435	100	102	92.027300
7320	2436	100	102	92.027300
7321	2437	100	102	92.027300
7322	2438	100	102	92.027300
7323	2439	100	102	92.027300
7324	2440	100	102	92.027300
7325	2441	100	102	92.027300
7326	2442	100	102	92.027300
7327	2443	100	102	92.027300
7328	2444	100	102	92.027300
7329	2445	100	102	92.027300
7330	2446	100	102	92.027300
7331	2447	100	102	92.027300
7332	2448	100	102	92.027300
7333	2449	100	102	92.027300
7334	2450	100	102	92.027300
7335	2451	100	102	92.027300
7336	2452	100	102	92.027300
7337	2453	100	102	92.027300
7338	2454	100	102	92.027300
7339	2455	100	102	92.027300
7340	2456	100	102	92.027300
7341	2457	100	102	92.027300
7342	2458	100	102	92.027300
7343	2459	100	102	92.027300
7344	2460	100	102	92.027300
7345	2461	100	102	92.027300
7346	2462	100	102	92.027300
7347	2463	100	102	92.027300
7348	2464	100	102	92.027300
7349	2465	100	102	92.027300
7350	2466	100	102	92.027300
7351	2467	100	102	92.027300
7352	2468	100	102	92.027300
7353	2469	100	102	92.027300
7354	2470	100	102	92.027300
7355	2471	100	102	92.027300
7356	2472	100	102	92.027300
7357	2473	100	102	92.027300
7358	2474	100	102	92.027300
7359	2475	100	102	92.027300
7360	2476	100	102	92.027300
7361	2477	100	102	92.027300
7362	2478	100	102	92.027300
7363	2479	100	102	92.027300
7364	2480	100	102	92.027300
7365	2481	100	102	92.027300
7366	2482	100	102	92.027300
7367	2483	100	102	92.027300
7368	2484	100	102	92.027300
7369	2485	100	102	92.027300
7370	2486	100	102	92.027300
7371	2487	100	102	92.027300
7372	2488	100	102	92.027300
7373	2489	100	102	92.027300
7374	2490	100	102	92.027300
7375	2491	100	102	92.027300
7376	2492	100	102	92.027300
7377	2493	100	102	92.027300
7378	2494	100	102	92.027300
7379	2495	100	102	92.027300
7380	2496	100	102	92.027300
7381	2497	100	102	92.027300
7382	2498	100	102	92.027300
7383	2499	100	102	92.027300
7384	2500	100	102	92.027300
7385	2501	100	102	92.027300
7386	2502	100	102	92.027300
7387	2503	100	102	92.027300
7388	2504	100	102	92.027300
7389	2505	100	102	92.027300
7390	2506	100	102	92.027300
7391	2507	100	102	92.027300
7392	2508	100	102	92.027300
7393	2377	100	101	26.452300
7394	2378	100	101	26.452300
7395	2379	100	101	26.452300
7396	2380	100	101	26.452300
7397	2381	100	101	26.452300
7398	2382	100	101	26.452300
7399	2383	100	101	26.452300
7400	2384	100	101	26.452300
7401	2385	100	101	26.452300
7402	2386	100	101	26.452300
7403	2387	100	101	26.452300
7404	2388	100	101	26.452300
7405	2389	100	101	26.452300
7406	2390	100	101	26.452300
7407	2391	100	101	26.452300
7408	2392	100	101	26.452300
7409	2393	100	101	26.452300
7410	2394	100	101	26.452300
7411	2395	100	101	26.452300
7412	2396	100	101	26.452300
7413	2397	100	101	26.452300
7414	2398	100	101	26.452300
7415	2399	100	101	26.452300
7416	2400	100	101	26.452300
7417	2401	100	101	26.452300
7418	2402	100	101	26.452300
7419	2403	100	101	26.452300
7420	2404	100	101	26.452300
7421	2405	100	101	26.452300
7422	2406	100	101	26.452300
7423	2407	100	101	26.452300
7424	2408	100	101	26.452300
7425	2409	100	101	26.452300
7426	2410	100	101	26.452300
7427	2411	100	101	26.452300
7428	2412	100	101	26.452300
7429	2413	100	101	26.452300
7430	2414	100	101	26.452300
7431	2415	100	101	26.452300
7432	2416	100	101	26.452300
7433	2417	100	101	26.452300
7434	2418	100	101	26.452300
7435	2419	100	101	26.452300
7436	2420	100	101	26.452300
7437	2421	100	101	26.452300
7438	2422	100	101	26.452300
7439	2423	100	101	26.452300
7440	2424	100	101	26.452300
7441	2425	100	101	26.452300
7442	2426	100	101	26.452300
7443	2427	100	101	26.452300
7444	2428	100	101	26.452300
7445	2429	100	101	26.452300
7446	2430	100	101	26.452300
7447	2431	100	101	26.452300
7448	2432	100	101	26.452300
7449	2433	100	101	26.452300
7450	2434	100	101	26.452300
7451	2435	100	101	26.452300
7452	2436	100	101	26.452300
7453	2437	100	101	26.452300
7454	2438	100	101	26.452300
7455	2439	100	101	26.452300
7456	2440	100	101	26.452300
7457	2441	100	101	26.452300
7458	2442	100	101	26.452300
7459	2443	100	101	26.452300
7460	2444	100	101	26.452300
7461	2445	100	101	26.452300
7462	2446	100	101	26.452300
7463	2447	100	101	26.452300
7464	2448	100	101	26.452300
7465	2449	100	101	26.452300
7466	2450	100	101	26.452300
7467	2451	100	101	26.452300
7468	2452	100	101	26.452300
7469	2453	100	101	26.452300
7470	2454	100	101	26.452300
7471	2455	100	101	26.452300
7472	2456	100	101	26.452300
7473	2457	100	101	26.452300
7474	2458	100	101	26.452300
7475	2459	100	101	26.452300
7476	2460	100	101	26.452300
7477	2461	100	101	26.452300
7478	2462	100	101	26.452300
7479	2463	100	101	26.452300
7480	2464	100	101	26.452300
7481	2465	100	101	26.452300
7482	2466	100	101	26.452300
7483	2467	100	101	26.452300
7484	2468	100	101	26.452300
7485	2469	100	101	26.452300
7486	2470	100	101	26.452300
7487	2471	100	101	26.452300
7488	2472	100	101	26.452300
7489	2473	100	101	26.452300
7490	2474	100	101	26.452300
7491	2475	100	101	26.452300
7492	2476	100	101	26.452300
7493	2477	100	101	26.452300
7494	2478	100	101	26.452300
7495	2479	100	101	26.452300
7496	2480	100	101	26.452300
7497	2481	100	101	26.452300
7498	2482	100	101	26.452300
7499	2483	100	101	26.452300
7500	2484	100	101	26.452300
7501	2485	100	101	26.452300
7502	2486	100	101	26.452300
7503	2487	100	101	26.452300
7504	2488	100	101	26.452300
7505	2489	100	101	26.452300
7506	2490	100	101	26.452300
7507	2491	100	101	26.452300
7508	2492	100	101	26.452300
7509	2493	100	101	26.452300
7510	2494	100	101	26.452300
7511	2495	100	101	26.452300
7512	2496	100	101	26.452300
7513	2497	100	101	26.452300
7514	2498	100	101	26.452300
7515	2499	100	101	26.452300
7516	2500	100	101	26.452300
7517	2501	100	101	26.452300
7518	2502	100	101	26.452300
7519	2503	100	101	26.452300
7520	2504	100	101	26.452300
7521	2505	100	101	26.452300
7522	2506	100	101	26.452300
7523	2507	100	101	26.452300
7524	2508	100	101	26.452300
7525	2509	200	106	16.472000
7526	2510	200	106	20.817000
7527	2511	200	106	0.345000
7528	2512	200	106	6.045000
7529	2513	200	106	4.189000
7530	2514	200	106	7.755000
7531	2515	200	106	79.804000
7532	2516	200	106	182.209000
7533	2517	200	106	84.768000
7534	2518	200	106	3.646000
7535	2519	200	106	40.997000
7536	2520	200	106	0.145000
7537	2521	200	106	10.271000
7538	2522	200	106	6.872000
7539	2523	200	106	5.382000
7540	2524	200	106	6.026000
7541	2525	200	106	11.390000
7542	2526	200	106	99.651000
7543	2527	200	106	303.667000
7544	2528	200	106	134.818000
7545	2529	200	106	170.842000
7546	2530	200	106	0.418000
7547	2531	200	106	0.027000
7548	2532	200	106	0.000000
7549	2533	200	106	23.109000
7550	2534	200	106	4.082000
7551	2535	200	106	12.182000
7552	2536	200	106	7.263000
7553	2537	200	106	17.270000
7554	2538	200	106	41.701000
7555	2539	200	106	405.846000
7556	2540	200	106	213.373000
7557	2541	200	106	16.396000
7558	2542	200	106	0.254000
7559	2543	200	106	0.000000
7560	2544	200	106	1.726000
7561	2545	200	106	47.506000
7562	2546	200	106	25.996000
7563	2547	200	106	21.836000
7564	2548	200	106	1.218000
7565	2549	200	106	0.199000
7566	2550	200	106	24.907000
7567	2551	200	106	62.585000
7568	2552	200	106	472.549000
7569	2553	200	106	137.894000
7570	2554	200	106	1.165000
7571	2555	200	106	2.354000
7572	2556	200	106	0.573000
7573	2557	200	106	6.218000
7574	2558	200	106	15.735000
7575	2559	200	106	3.828000
7576	2560	200	106	0.954000
7577	2561	200	106	11.430000
7578	2562	200	106	136.029000
7579	2563	200	106	157.191000
7580	2564	200	106	289.638000
7581	2565	200	106	102.621000
7582	2566	200	106	9.746000
7583	2567	200	106	0.000000
7584	2568	200	106	0.000000
7585	2569	200	106	7.527000
7586	2570	200	106	2.018000
7587	2571	200	106	6.436000
7588	2572	200	106	33.180000
7589	2573	200	106	41.108000
7590	2574	200	106	105.745000
7591	2575	200	106	77.366000
7592	2576	200	106	195.125000
7593	2577	200	106	61.354000
7594	2578	200	106	29.200000
7595	2579	200	106	25.822000
7596	2580	200	106	9.546000
7597	2581	200	106	0.000000
7598	2582	200	106	20.019000
7599	2583	200	106	17.499000
7600	2584	200	106	5.474000
7601	2585	200	106	9.518000
7602	2586	200	106	81.744000
7603	2587	200	106	137.837000
7604	2588	200	106	189.910000
7605	2589	200	106	192.551000
7606	2590	200	106	27.511000
7607	2591	200	106	26.894000
7608	2592	200	106	0.827000
7609	2593	200	106	40.070000
7610	2594	200	106	2.011000
7611	2595	200	106	0.364000
7612	2596	200	106	0.000000
7613	2597	200	106	12.663000
7614	2598	200	106	49.933000
7615	2599	200	106	101.662000
7616	2600	200	106	68.130000
7617	2601	200	106	57.251000
7618	2602	200	106	12.157000
7619	2603	200	106	0.000000
7620	2604	200	106	0.000000
7621	2605	200	106	22.398000
7622	2606	200	106	42.016000
7623	2607	200	106	12.580000
7624	2608	200	106	0.691000
7625	2609	200	106	12.074000
7626	2610	200	106	80.690000
7627	2611	200	106	272.234000
7628	2612	200	106	125.493000
7629	2613	200	106	20.492000
7630	2614	200	106	0.000000
7631	2615	200	106	2.644000
7632	2616	200	106	21.908000
7633	2617	200	106	9.508000
7634	2618	200	106	10.536000
7635	2619	200	106	3.645000
7636	2620	200	106	25.055000
7637	2621	200	106	57.248000
7638	2622	200	106	84.749000
7639	2623	200	106	131.645000
7640	2624	200	106	221.571000
7641	2625	200	106	35.809000
7642	2626	200	106	3.438000
7643	2627	200	106	0.000000
7644	2628	200	106	0.000000
7645	2629	200	106	12.935000
7646	2630	200	106	12.027000
7647	2631	200	106	1.899000
7648	2632	200	106	0.909000
7649	2633	200	106	2.636000
7650	2634	200	106	33.037000
7651	2635	200	106	13.052000
7652	2636	200	106	118.931000
7653	2637	200	106	142.816000
7654	2638	200	106	0.463000
7655	2639	200	106	0.636000
7656	2640	200	106	10.208000
7657	2509	100	108	77.209000
7658	2510	100	108	77.209000
7659	2511	100	108	77.209000
7660	2512	100	108	77.209000
7661	2513	100	108	77.209000
7662	2514	100	108	77.209000
7663	2515	100	108	77.209000
7664	2516	100	108	77.209000
7665	2517	100	108	77.209000
7666	2518	100	108	77.209000
7667	2519	100	108	77.209000
7668	2520	100	108	77.209000
7669	2521	100	108	77.209000
7670	2522	100	108	77.209000
7671	2523	100	108	77.209000
7672	2524	100	108	77.209000
7673	2525	100	108	77.209000
7674	2526	100	108	77.209000
7675	2527	100	108	77.209000
7676	2528	100	108	77.209000
7677	2529	100	108	77.209000
7678	2530	100	108	77.209000
7679	2531	100	108	77.209000
7680	2532	100	108	77.209000
7681	2533	100	108	77.209000
7682	2534	100	108	77.209000
7683	2535	100	108	77.209000
7684	2536	100	108	77.209000
7685	2537	100	108	77.209000
7686	2538	100	108	77.209000
7687	2539	100	108	77.209000
7688	2540	100	108	77.209000
7689	2541	100	108	77.209000
7690	2542	100	108	77.209000
7691	2543	100	108	77.209000
7692	2544	100	108	77.209000
7693	2545	100	108	77.209000
7694	2546	100	108	77.209000
7695	2547	100	108	77.209000
7696	2548	100	108	77.209000
7697	2549	100	108	77.209000
7698	2550	100	108	77.209000
7699	2551	100	108	77.209000
7700	2552	100	108	77.209000
7701	2553	100	108	77.209000
7702	2554	100	108	77.209000
7703	2555	100	108	77.209000
7704	2556	100	108	77.209000
7705	2557	100	108	77.209000
7706	2558	100	108	77.209000
7707	2559	100	108	77.209000
7708	2560	100	108	77.209000
7709	2561	100	108	77.209000
7710	2562	100	108	77.209000
7711	2563	100	108	77.209000
7712	2564	100	108	77.209000
7713	2565	100	108	77.209000
7714	2566	100	108	77.209000
7715	2567	100	108	77.209000
7716	2568	100	108	77.209000
7717	2569	100	108	77.209000
7718	2570	100	108	77.209000
7719	2571	100	108	77.209000
7720	2572	100	108	77.209000
7721	2573	100	108	77.209000
7722	2574	100	108	77.209000
7723	2575	100	108	77.209000
7724	2576	100	108	77.209000
7725	2577	100	108	77.209000
7726	2578	100	108	77.209000
7727	2579	100	108	77.209000
7728	2580	100	108	77.209000
7729	2581	100	108	77.209000
7730	2582	100	108	77.209000
7731	2583	100	108	77.209000
7732	2584	100	108	77.209000
7733	2585	100	108	77.209000
7734	2586	100	108	77.209000
7735	2587	100	108	77.209000
7736	2588	100	108	77.209000
7737	2589	100	108	77.209000
7738	2590	100	108	77.209000
7739	2591	100	108	77.209000
7740	2592	100	108	77.209000
7741	2593	100	108	77.209000
7742	2594	100	108	77.209000
7743	2595	100	108	77.209000
7744	2596	100	108	77.209000
7745	2597	100	108	77.209000
7746	2598	100	108	77.209000
7747	2599	100	108	77.209000
7748	2600	100	108	77.209000
7749	2601	100	108	77.209000
7750	2602	100	108	77.209000
7751	2603	100	108	77.209000
7752	2604	100	108	77.209000
7753	2605	100	108	77.209000
7754	2606	100	108	77.209000
7755	2607	100	108	77.209000
7756	2608	100	108	77.209000
7757	2609	100	108	77.209000
7758	2610	100	108	77.209000
7759	2611	100	108	77.209000
7760	2612	100	108	77.209000
7761	2613	100	108	77.209000
7762	2614	100	108	77.209000
7763	2615	100	108	77.209000
7764	2616	100	108	77.209000
7765	2617	100	108	77.209000
7766	2618	100	108	77.209000
7767	2619	100	108	77.209000
7768	2620	100	108	77.209000
7769	2621	100	108	77.209000
7770	2622	100	108	77.209000
7771	2623	100	108	77.209000
7772	2624	100	108	77.209000
7773	2625	100	108	77.209000
7774	2626	100	108	77.209000
7775	2627	100	108	77.209000
7776	2628	100	108	77.209000
7777	2629	100	108	77.209000
7778	2630	100	108	77.209000
7779	2631	100	108	77.209000
7780	2632	100	108	77.209000
7781	2633	100	108	77.209000
7782	2634	100	108	77.209000
7783	2635	100	108	77.209000
7784	2636	100	108	77.209000
7785	2637	100	108	77.209000
7786	2638	100	108	77.209000
7787	2639	100	108	77.209000
7788	2640	100	108	77.209000
7789	2509	100	107	28.613900
7790	2510	100	107	28.613900
7791	2511	100	107	28.613900
7792	2512	100	107	28.613900
7793	2513	100	107	28.613900
7794	2514	100	107	28.613900
7795	2515	100	107	28.613900
7796	2516	100	107	28.613900
7797	2517	100	107	28.613900
7798	2518	100	107	28.613900
7799	2519	100	107	28.613900
7800	2520	100	107	28.613900
7801	2521	100	107	28.613900
7802	2522	100	107	28.613900
7803	2523	100	107	28.613900
7804	2524	100	107	28.613900
7805	2525	100	107	28.613900
7806	2526	100	107	28.613900
7807	2527	100	107	28.613900
7808	2528	100	107	28.613900
7809	2529	100	107	28.613900
7810	2530	100	107	28.613900
7811	2531	100	107	28.613900
7812	2532	100	107	28.613900
7813	2533	100	107	28.613900
7814	2534	100	107	28.613900
7815	2535	100	107	28.613900
7816	2536	100	107	28.613900
7817	2537	100	107	28.613900
7818	2538	100	107	28.613900
7819	2539	100	107	28.613900
7820	2540	100	107	28.613900
7821	2541	100	107	28.613900
7822	2542	100	107	28.613900
7823	2543	100	107	28.613900
7824	2544	100	107	28.613900
7825	2545	100	107	28.613900
7826	2546	100	107	28.613900
7827	2547	100	107	28.613900
7828	2548	100	107	28.613900
7829	2549	100	107	28.613900
7830	2550	100	107	28.613900
7831	2551	100	107	28.613900
7832	2552	100	107	28.613900
7833	2553	100	107	28.613900
7834	2554	100	107	28.613900
7835	2555	100	107	28.613900
7836	2556	100	107	28.613900
7837	2557	100	107	28.613900
7838	2558	100	107	28.613900
7839	2559	100	107	28.613900
7840	2560	100	107	28.613900
7841	2561	100	107	28.613900
7842	2562	100	107	28.613900
7843	2563	100	107	28.613900
7844	2564	100	107	28.613900
7845	2565	100	107	28.613900
7846	2566	100	107	28.613900
7847	2567	100	107	28.613900
7848	2568	100	107	28.613900
7849	2569	100	107	28.613900
7850	2570	100	107	28.613900
7851	2571	100	107	28.613900
7852	2572	100	107	28.613900
7853	2573	100	107	28.613900
7854	2574	100	107	28.613900
7855	2575	100	107	28.613900
7856	2576	100	107	28.613900
7857	2577	100	107	28.613900
7858	2578	100	107	28.613900
7859	2579	100	107	28.613900
7860	2580	100	107	28.613900
7861	2581	100	107	28.613900
7862	2582	100	107	28.613900
7863	2583	100	107	28.613900
7864	2584	100	107	28.613900
7865	2585	100	107	28.613900
7866	2586	100	107	28.613900
7867	2587	100	107	28.613900
7868	2588	100	107	28.613900
7869	2589	100	107	28.613900
7870	2590	100	107	28.613900
7871	2591	100	107	28.613900
7872	2592	100	107	28.613900
7873	2593	100	107	28.613900
7874	2594	100	107	28.613900
7875	2595	100	107	28.613900
7876	2596	100	107	28.613900
7877	2597	100	107	28.613900
7878	2598	100	107	28.613900
7879	2599	100	107	28.613900
7880	2600	100	107	28.613900
7881	2601	100	107	28.613900
7882	2602	100	107	28.613900
7883	2603	100	107	28.613900
7884	2604	100	107	28.613900
7885	2605	100	107	28.613900
7886	2606	100	107	28.613900
7887	2607	100	107	28.613900
7888	2608	100	107	28.613900
7889	2609	100	107	28.613900
7890	2610	100	107	28.613900
7891	2611	100	107	28.613900
7892	2612	100	107	28.613900
7893	2613	100	107	28.613900
7894	2614	100	107	28.613900
7895	2615	100	107	28.613900
7896	2616	100	107	28.613900
7897	2617	100	107	28.613900
7898	2618	100	107	28.613900
7899	2619	100	107	28.613900
7900	2620	100	107	28.613900
7901	2621	100	107	28.613900
7902	2622	100	107	28.613900
7903	2623	100	107	28.613900
7904	2624	100	107	28.613900
7905	2625	100	107	28.613900
7906	2626	100	107	28.613900
7907	2627	100	107	28.613900
7908	2628	100	107	28.613900
7909	2629	100	107	28.613900
7910	2630	100	107	28.613900
7911	2631	100	107	28.613900
7912	2632	100	107	28.613900
7913	2633	100	107	28.613900
7914	2634	100	107	28.613900
7915	2635	100	107	28.613900
7916	2636	100	107	28.613900
7917	2637	100	107	28.613900
7918	2638	100	107	28.613900
7919	2639	100	107	28.613900
7920	2640	100	107	28.613900
7921	2641	200	103	15.759000
7922	2642	200	103	5.318000
7923	2643	200	103	1.611000
7924	2644	200	103	4.791000
7925	2645	200	103	20.413000
7926	2646	200	103	13.163000
7927	2647	200	103	235.166000
7928	2648	200	103	205.486000
7929	2649	200	103	108.277000
7930	2650	200	103	64.171000
7931	2651	200	103	0.968000
7932	2652	200	103	0.000000
7933	2653	200	103	10.465000
7934	2654	200	103	0.207000
7935	2655	200	103	9.396000
7936	2656	200	103	9.188000
7937	2657	200	103	42.975000
7938	2658	200	103	50.766000
7939	2659	200	103	72.305000
7940	2660	200	103	174.008000
7941	2661	200	103	265.563000
7942	2662	200	103	70.411000
7943	2663	200	103	1.733000
7944	2664	200	103	0.000000
7945	2665	200	103	61.349000
7946	2666	200	103	29.983000
7947	2667	200	103	21.752000
7948	2668	200	103	11.664000
7949	2669	200	103	21.725000
7950	2670	200	103	45.457000
7951	2671	200	103	209.227000
7952	2672	200	103	284.967000
7953	2673	200	103	60.784000
7954	2674	200	103	113.844000
7955	2675	200	103	0.190000
7956	2676	200	103	0.000000
7957	2677	200	103	12.625000
7958	2678	200	103	22.558000
7959	2679	200	103	12.075000
7960	2680	200	103	1.791000
7961	2681	200	103	30.188000
7962	2682	200	103	26.627000
7963	2683	200	103	190.796000
7964	2684	200	103	274.661000
7965	2685	200	103	168.294000
7966	2686	200	103	10.207000
7967	2687	200	103	25.309000
7968	2688	200	103	0.595000
7969	2689	200	103	25.038000
7970	2690	200	103	12.838000
7971	2691	200	103	2.042000
7972	2692	200	103	4.971000
7973	2693	200	103	18.931000
7974	2694	200	103	33.726000
7975	2695	200	103	176.559000
7976	2696	200	103	307.271000
7977	2697	200	103	149.148000
7978	2698	200	103	165.797000
7979	2699	200	103	0.000000
7980	2700	200	103	0.000000
7981	2701	200	103	14.234000
7982	2702	200	103	12.440000
7983	2703	200	103	3.885000
7984	2704	200	103	5.503000
7985	2705	200	103	96.720000
7986	2706	200	103	93.779000
7987	2707	200	103	190.382000
7988	2708	200	103	324.665000
7989	2709	200	103	128.540000
7990	2710	200	103	51.695000
7991	2711	200	103	30.818000
7992	2712	200	103	8.982000
7993	2713	200	103	0.583000
7994	2714	200	103	14.915000
7995	2715	200	103	6.318000
7996	2716	200	103	10.028000
7997	2717	200	103	96.882000
7998	2718	200	103	37.427000
7999	2719	200	103	209.401000
8000	2720	200	103	292.297000
8001	2721	200	103	159.467000
8002	2722	200	103	141.625000
8003	2723	200	103	24.624000
8004	2724	200	103	0.000000
8005	2725	200	103	21.909000
8006	2726	200	103	10.283000
8007	2727	200	103	1.512000
8008	2728	200	103	0.000000
8009	2729	200	103	52.406000
8010	2730	200	103	94.149000
8011	2731	200	103	281.389000
8012	2732	200	103	249.249000
8013	2733	200	103	158.467000
8014	2734	200	103	40.414000
8015	2735	200	103	1.451000
8016	2736	200	103	0.420000
8017	2737	200	103	11.232000
8018	2738	200	103	15.729000
8019	2739	200	103	8.695000
8020	2740	200	103	11.564000
8021	2741	200	103	16.974000
8022	2742	200	103	120.913000
8023	2743	200	103	136.968000
8024	2744	200	103	143.367000
8025	2745	200	103	231.260000
8026	2746	200	103	0.801000
8027	2747	200	103	0.000000
8028	2748	200	103	0.587000
8029	2749	200	103	2.432000
8030	2750	200	103	2.625000
8031	2751	200	103	18.665000
8032	2752	200	103	10.703000
8033	2753	200	103	21.831000
8034	2754	200	103	39.127000
8035	2755	200	103	257.062000
8036	2756	200	103	271.509000
8037	2757	200	103	58.985000
8038	2758	200	103	104.898000
8039	2759	200	103	0.000000
8040	2760	200	103	0.524000
8041	2761	200	103	17.049000
8042	2762	200	103	11.188000
8043	2763	200	103	5.200000
8044	2764	200	103	8.436000
8045	2765	200	103	21.361000
8046	2766	200	103	40.806000
8047	2767	200	103	205.718000
8048	2768	200	103	270.386000
8049	2769	200	103	173.996000
8050	2770	200	103	145.161000
8051	2771	200	103	17.335000
8052	2772	200	103	0.524000
8053	2641	100	105	85.364700
8054	2642	100	105	85.364700
8055	2643	100	105	85.364700
8056	2644	100	105	85.364700
8057	2645	100	105	85.364700
8058	2646	100	105	85.364700
8059	2647	100	105	85.364700
8060	2648	100	105	85.364700
8061	2649	100	105	85.364700
8062	2650	100	105	85.364700
8063	2651	100	105	85.364700
8064	2652	100	105	85.364700
8065	2653	100	105	85.364700
8066	2654	100	105	85.364700
8067	2655	100	105	85.364700
8068	2656	100	105	85.364700
8069	2657	100	105	85.364700
8070	2658	100	105	85.364700
8071	2659	100	105	85.364700
8072	2660	100	105	85.364700
8073	2661	100	105	85.364700
8074	2662	100	105	85.364700
8075	2663	100	105	85.364700
8076	2664	100	105	85.364700
8077	2665	100	105	85.364700
8078	2666	100	105	85.364700
8079	2667	100	105	85.364700
8080	2668	100	105	85.364700
8081	2669	100	105	85.364700
8082	2670	100	105	85.364700
8083	2671	100	105	85.364700
8084	2672	100	105	85.364700
8085	2673	100	105	85.364700
8086	2674	100	105	85.364700
8087	2675	100	105	85.364700
8088	2676	100	105	85.364700
8089	2677	100	105	85.364700
8090	2678	100	105	85.364700
8091	2679	100	105	85.364700
8092	2680	100	105	85.364700
8093	2681	100	105	85.364700
8094	2682	100	105	85.364700
8095	2683	100	105	85.364700
8096	2684	100	105	85.364700
8097	2685	100	105	85.364700
8098	2686	100	105	85.364700
8099	2687	100	105	85.364700
8100	2688	100	105	85.364700
8101	2689	100	105	85.364700
8102	2690	100	105	85.364700
8103	2691	100	105	85.364700
8104	2692	100	105	85.364700
8105	2693	100	105	85.364700
8106	2694	100	105	85.364700
8107	2695	100	105	85.364700
8108	2696	100	105	85.364700
8109	2697	100	105	85.364700
8110	2698	100	105	85.364700
8111	2699	100	105	85.364700
8112	2700	100	105	85.364700
8113	2701	100	105	85.364700
8114	2702	100	105	85.364700
8115	2703	100	105	85.364700
8116	2704	100	105	85.364700
8117	2705	100	105	85.364700
8118	2706	100	105	85.364700
8119	2707	100	105	85.364700
8120	2708	100	105	85.364700
8121	2709	100	105	85.364700
8122	2710	100	105	85.364700
8123	2711	100	105	85.364700
8124	2712	100	105	85.364700
8125	2713	100	105	85.364700
8126	2714	100	105	85.364700
8127	2715	100	105	85.364700
8128	2716	100	105	85.364700
8129	2717	100	105	85.364700
8130	2718	100	105	85.364700
8131	2719	100	105	85.364700
8132	2720	100	105	85.364700
8133	2721	100	105	85.364700
8134	2722	100	105	85.364700
8135	2723	100	105	85.364700
8136	2724	100	105	85.364700
8137	2725	100	105	85.364700
8138	2726	100	105	85.364700
8139	2727	100	105	85.364700
8140	2728	100	105	85.364700
8141	2729	100	105	85.364700
8142	2730	100	105	85.364700
8143	2731	100	105	85.364700
8144	2732	100	105	85.364700
8145	2733	100	105	85.364700
8146	2734	100	105	85.364700
8147	2735	100	105	85.364700
8148	2736	100	105	85.364700
8149	2737	100	105	85.364700
8150	2738	100	105	85.364700
8151	2739	100	105	85.364700
8152	2740	100	105	85.364700
8153	2741	100	105	85.364700
8154	2742	100	105	85.364700
8155	2743	100	105	85.364700
8156	2744	100	105	85.364700
8157	2745	100	105	85.364700
8158	2746	100	105	85.364700
8159	2747	100	105	85.364700
8160	2748	100	105	85.364700
8161	2749	100	105	85.364700
8162	2750	100	105	85.364700
8163	2751	100	105	85.364700
8164	2752	100	105	85.364700
8165	2753	100	105	85.364700
8166	2754	100	105	85.364700
8167	2755	100	105	85.364700
8168	2756	100	105	85.364700
8169	2757	100	105	85.364700
8170	2758	100	105	85.364700
8171	2759	100	105	85.364700
8172	2760	100	105	85.364700
8173	2761	100	105	85.364700
8174	2762	100	105	85.364700
8175	2763	100	105	85.364700
8176	2764	100	105	85.364700
8177	2765	100	105	85.364700
8178	2766	100	105	85.364700
8179	2767	100	105	85.364700
8180	2768	100	105	85.364700
8181	2769	100	105	85.364700
8182	2770	100	105	85.364700
8183	2771	100	105	85.364700
8184	2772	100	105	85.364700
8185	2641	100	104	26.120900
8186	2642	100	104	26.120900
8187	2643	100	104	26.120900
8188	2644	100	104	26.120900
8189	2645	100	104	26.120900
8190	2646	100	104	26.120900
8191	2647	100	104	26.120900
8192	2648	100	104	26.120900
8193	2649	100	104	26.120900
8194	2650	100	104	26.120900
8195	2651	100	104	26.120900
8196	2652	100	104	26.120900
8197	2653	100	104	26.120900
8198	2654	100	104	26.120900
8199	2655	100	104	26.120900
8200	2656	100	104	26.120900
8201	2657	100	104	26.120900
8202	2658	100	104	26.120900
8203	2659	100	104	26.120900
8204	2660	100	104	26.120900
8205	2661	100	104	26.120900
8206	2662	100	104	26.120900
8207	2663	100	104	26.120900
8208	2664	100	104	26.120900
8209	2665	100	104	26.120900
8210	2666	100	104	26.120900
8211	2667	100	104	26.120900
8212	2668	100	104	26.120900
8213	2669	100	104	26.120900
8214	2670	100	104	26.120900
8215	2671	100	104	26.120900
8216	2672	100	104	26.120900
8217	2673	100	104	26.120900
8218	2674	100	104	26.120900
8219	2675	100	104	26.120900
8220	2676	100	104	26.120900
8221	2677	100	104	26.120900
8222	2678	100	104	26.120900
8223	2679	100	104	26.120900
8224	2680	100	104	26.120900
8225	2681	100	104	26.120900
8226	2682	100	104	26.120900
8227	2683	100	104	26.120900
8228	2684	100	104	26.120900
8229	2685	100	104	26.120900
8230	2686	100	104	26.120900
8231	2687	100	104	26.120900
8232	2688	100	104	26.120900
8233	2689	100	104	26.120900
8234	2690	100	104	26.120900
8235	2691	100	104	26.120900
8236	2692	100	104	26.120900
8237	2693	100	104	26.120900
8238	2694	100	104	26.120900
8239	2695	100	104	26.120900
8240	2696	100	104	26.120900
8241	2697	100	104	26.120900
8242	2698	100	104	26.120900
8243	2699	100	104	26.120900
8244	2700	100	104	26.120900
8245	2701	100	104	26.120900
8246	2702	100	104	26.120900
8247	2703	100	104	26.120900
8248	2704	100	104	26.120900
8249	2705	100	104	26.120900
8250	2706	100	104	26.120900
8251	2707	100	104	26.120900
8252	2708	100	104	26.120900
8253	2709	100	104	26.120900
8254	2710	100	104	26.120900
8255	2711	100	104	26.120900
8256	2712	100	104	26.120900
8257	2713	100	104	26.120900
8258	2714	100	104	26.120900
8259	2715	100	104	26.120900
8260	2716	100	104	26.120900
8261	2717	100	104	26.120900
8262	2718	100	104	26.120900
8263	2719	100	104	26.120900
8264	2720	100	104	26.120900
8265	2721	100	104	26.120900
8266	2722	100	104	26.120900
8267	2723	100	104	26.120900
8268	2724	100	104	26.120900
8269	2725	100	104	26.120900
8270	2726	100	104	26.120900
8271	2727	100	104	26.120900
8272	2728	100	104	26.120900
8273	2729	100	104	26.120900
8274	2730	100	104	26.120900
8275	2731	100	104	26.120900
8276	2732	100	104	26.120900
8277	2733	100	104	26.120900
8278	2734	100	104	26.120900
8279	2735	100	104	26.120900
8280	2736	100	104	26.120900
8281	2737	100	104	26.120900
8282	2738	100	104	26.120900
8283	2739	100	104	26.120900
8284	2740	100	104	26.120900
8285	2741	100	104	26.120900
8286	2742	100	104	26.120900
8287	2743	100	104	26.120900
8288	2744	100	104	26.120900
8289	2745	100	104	26.120900
8290	2746	100	104	26.120900
8291	2747	100	104	26.120900
8292	2748	100	104	26.120900
8293	2749	100	104	26.120900
8294	2750	100	104	26.120900
8295	2751	100	104	26.120900
8296	2752	100	104	26.120900
8297	2753	100	104	26.120900
8298	2754	100	104	26.120900
8299	2755	100	104	26.120900
8300	2756	100	104	26.120900
8301	2757	100	104	26.120900
8302	2758	100	104	26.120900
8303	2759	100	104	26.120900
8304	2760	100	104	26.120900
8305	2761	100	104	26.120900
8306	2762	100	104	26.120900
8307	2763	100	104	26.120900
8308	2764	100	104	26.120900
8309	2765	100	104	26.120900
8310	2766	100	104	26.120900
8311	2767	100	104	26.120900
8312	2768	100	104	26.120900
8313	2769	100	104	26.120900
8314	2770	100	104	26.120900
8315	2771	100	104	26.120900
8316	2772	100	104	26.120900
8317	2773	200	109	44.468000
8318	2774	200	109	65.227000
8319	2775	200	109	29.859000
8320	2776	200	109	12.458000
8321	2777	200	109	42.963000
8322	2778	200	109	65.210000
8323	2779	200	109	207.358000
8324	2780	200	109	223.526000
8325	2781	200	109	101.838000
8326	2782	200	109	7.325000
8327	2783	200	109	47.443000
8328	2784	200	109	1.488000
8329	2785	200	109	19.427000
8330	2786	200	109	26.112000
8331	2787	200	109	23.642000
8332	2788	200	109	22.143000
8333	2789	200	109	23.648000
8334	2790	200	109	159.083000
8335	2791	200	109	202.819000
8336	2792	200	109	52.888000
8337	2793	200	109	200.683000
8338	2794	200	109	0.115000
8339	2795	200	109	0.000000
8340	2796	200	109	0.115000
8341	2797	200	109	28.931000
8342	2798	200	109	16.680000
8343	2799	200	109	16.827000
8344	2800	200	109	9.746000
8345	2801	200	109	65.784000
8346	2802	200	109	54.874000
8347	2803	200	109	279.142000
8348	2804	200	109	221.788000
8349	2805	200	109	124.577000
8350	2806	200	109	2.792000
8351	2807	200	109	0.000000
8352	2808	200	109	6.521000
8353	2809	200	109	56.537000
8354	2810	200	109	111.764000
8355	2811	200	109	40.109000
8356	2812	200	109	9.881000
8357	2813	200	109	1.728000
8358	2814	200	109	126.295000
8359	2815	200	109	226.788000
8360	2816	200	109	402.494000
8361	2817	200	109	149.423000
8362	2818	200	109	3.721000
8363	2819	200	109	37.210000
8364	2820	200	109	1.185000
8365	2821	200	109	67.309000
8366	2822	200	109	59.939000
8367	2823	200	109	32.905000
8368	2824	200	109	22.301000
8369	2825	200	109	29.957000
8370	2826	200	109	250.293000
8371	2827	200	109	197.310000
8372	2828	200	109	412.096000
8373	2829	200	109	115.110000
8374	2830	200	109	19.118000
8375	2831	200	109	0.121000
8376	2832	200	109	4.301000
8377	2833	200	109	24.705000
8378	2834	200	109	12.385000
8379	2835	200	109	18.699000
8380	2836	200	109	74.159000
8381	2837	200	109	32.589000
8382	2838	200	109	205.422000
8383	2839	200	109	195.024000
8384	2840	200	109	232.364000
8385	2841	200	109	88.122000
8386	2842	200	109	19.738000
8387	2843	200	109	24.953000
8388	2844	200	109	8.544000
8389	2845	200	109	25.814000
8390	2846	200	109	46.287000
8391	2847	200	109	54.915000
8392	2848	200	109	42.211000
8393	2849	200	109	20.323000
8394	2850	200	109	23.993000
8395	2851	200	109	243.183000
8396	2852	200	109	243.630000
8397	2853	200	109	130.808000
8398	2854	200	109	34.933000
8399	2855	200	109	7.272000
8400	2856	200	109	4.392000
8401	2857	200	109	27.559000
8402	2858	200	109	20.378000
8403	2859	200	109	7.682000
8404	2860	200	109	16.306000
8405	2861	200	109	28.823000
8406	2862	200	109	101.485000
8407	2863	200	109	142.376000
8408	2864	200	109	195.400000
8409	2865	200	109	113.817000
8410	2866	200	109	11.756000
8411	2867	200	109	4.253000
8412	2868	200	109	7.446000
8413	2869	200	109	23.775000
8414	2870	200	109	56.475000
8415	2871	200	109	16.643000
8416	2872	200	109	6.909000
8417	2873	200	109	33.728000
8418	2874	200	109	162.576000
8419	2875	200	109	183.044000
8420	2876	200	109	190.284000
8421	2877	200	109	80.394000
8422	2878	200	109	0.115000
8423	2879	200	109	1.952000
8424	2880	200	109	1.408000
8425	2881	200	109	11.745000
8426	2882	200	109	16.766000
8427	2883	200	109	10.761000
8428	2884	200	109	27.270000
8429	2885	200	109	51.763000
8430	2886	200	109	92.745000
8431	2887	200	109	263.438000
8432	2888	200	109	110.665000
8433	2889	200	109	71.706000
8434	2890	200	109	3.276000
8435	2891	200	109	3.980000
8436	2892	200	109	4.887000
8437	2893	200	109	33.952000
8438	2894	200	109	58.414000
8439	2895	200	109	56.694000
8440	2896	200	109	16.107000
8441	2897	200	109	10.530000
8442	2898	200	109	84.806000
8443	2899	200	109	120.285000
8444	2900	200	109	180.256000
8445	2901	200	109	239.217000
8446	2902	200	109	2.557000
8447	2903	200	109	0.020000
8448	2904	200	109	1.665000
8449	2773	100	111	77.173400
8450	2774	100	111	77.173400
8451	2775	100	111	77.173400
8452	2776	100	111	77.173400
8453	2777	100	111	77.173400
8454	2778	100	111	77.173400
8455	2779	100	111	77.173400
8456	2780	100	111	77.173400
8457	2781	100	111	77.173400
8458	2782	100	111	77.173400
8459	2783	100	111	77.173400
8460	2784	100	111	77.173400
8461	2785	100	111	77.173400
8462	2786	100	111	77.173400
8463	2787	100	111	77.173400
8464	2788	100	111	77.173400
8465	2789	100	111	77.173400
8466	2790	100	111	77.173400
8467	2791	100	111	77.173400
8468	2792	100	111	77.173400
8469	2793	100	111	77.173400
8470	2794	100	111	77.173400
8471	2795	100	111	77.173400
8472	2796	100	111	77.173400
8473	2797	100	111	77.173400
8474	2798	100	111	77.173400
8475	2799	100	111	77.173400
8476	2800	100	111	77.173400
8477	2801	100	111	77.173400
8478	2802	100	111	77.173400
8479	2803	100	111	77.173400
8480	2804	100	111	77.173400
8481	2805	100	111	77.173400
8482	2806	100	111	77.173400
8483	2807	100	111	77.173400
8484	2808	100	111	77.173400
8485	2809	100	111	77.173400
8486	2810	100	111	77.173400
8487	2811	100	111	77.173400
8488	2812	100	111	77.173400
8489	2813	100	111	77.173400
8490	2814	100	111	77.173400
8491	2815	100	111	77.173400
8492	2816	100	111	77.173400
8493	2817	100	111	77.173400
8494	2818	100	111	77.173400
8495	2819	100	111	77.173400
8496	2820	100	111	77.173400
8497	2821	100	111	77.173400
8498	2822	100	111	77.173400
8499	2823	100	111	77.173400
8500	2824	100	111	77.173400
8501	2825	100	111	77.173400
8502	2826	100	111	77.173400
8503	2827	100	111	77.173400
8504	2828	100	111	77.173400
8505	2829	100	111	77.173400
8506	2830	100	111	77.173400
8507	2831	100	111	77.173400
8508	2832	100	111	77.173400
8509	2833	100	111	77.173400
8510	2834	100	111	77.173400
8511	2835	100	111	77.173400
8512	2836	100	111	77.173400
8513	2837	100	111	77.173400
8514	2838	100	111	77.173400
8515	2839	100	111	77.173400
8516	2840	100	111	77.173400
8517	2841	100	111	77.173400
8518	2842	100	111	77.173400
8519	2843	100	111	77.173400
8520	2844	100	111	77.173400
8521	2845	100	111	77.173400
8522	2846	100	111	77.173400
8523	2847	100	111	77.173400
8524	2848	100	111	77.173400
8525	2849	100	111	77.173400
8526	2850	100	111	77.173400
8527	2851	100	111	77.173400
8528	2852	100	111	77.173400
8529	2853	100	111	77.173400
8530	2854	100	111	77.173400
8531	2855	100	111	77.173400
8532	2856	100	111	77.173400
8533	2857	100	111	77.173400
8534	2858	100	111	77.173400
8535	2859	100	111	77.173400
8536	2860	100	111	77.173400
8537	2861	100	111	77.173400
8538	2862	100	111	77.173400
8539	2863	100	111	77.173400
8540	2864	100	111	77.173400
8541	2865	100	111	77.173400
8542	2866	100	111	77.173400
8543	2867	100	111	77.173400
8544	2868	100	111	77.173400
8545	2869	100	111	77.173400
8546	2870	100	111	77.173400
8547	2871	100	111	77.173400
8548	2872	100	111	77.173400
8549	2873	100	111	77.173400
8550	2874	100	111	77.173400
8551	2875	100	111	77.173400
8552	2876	100	111	77.173400
8553	2877	100	111	77.173400
8554	2878	100	111	77.173400
8555	2879	100	111	77.173400
8556	2880	100	111	77.173400
8557	2881	100	111	77.173400
8558	2882	100	111	77.173400
8559	2883	100	111	77.173400
8560	2884	100	111	77.173400
8561	2885	100	111	77.173400
8562	2886	100	111	77.173400
8563	2887	100	111	77.173400
8564	2888	100	111	77.173400
8565	2889	100	111	77.173400
8566	2890	100	111	77.173400
8567	2891	100	111	77.173400
8568	2892	100	111	77.173400
8569	2893	100	111	77.173400
8570	2894	100	111	77.173400
8571	2895	100	111	77.173400
8572	2896	100	111	77.173400
8573	2897	100	111	77.173400
8574	2898	100	111	77.173400
8575	2899	100	111	77.173400
8576	2900	100	111	77.173400
8577	2901	100	111	77.173400
8578	2902	100	111	77.173400
8579	2903	100	111	77.173400
8580	2904	100	111	77.173400
8581	2773	100	110	31.104800
8582	2774	100	110	31.104800
8583	2775	100	110	31.104800
8584	2776	100	110	31.104800
8585	2777	100	110	31.104800
8586	2778	100	110	31.104800
8587	2779	100	110	31.104800
8588	2780	100	110	31.104800
8589	2781	100	110	31.104800
8590	2782	100	110	31.104800
8591	2783	100	110	31.104800
8592	2784	100	110	31.104800
8593	2785	100	110	31.104800
8594	2786	100	110	31.104800
8595	2787	100	110	31.104800
8596	2788	100	110	31.104800
8597	2789	100	110	31.104800
8598	2790	100	110	31.104800
8599	2791	100	110	31.104800
8600	2792	100	110	31.104800
8601	2793	100	110	31.104800
8602	2794	100	110	31.104800
8603	2795	100	110	31.104800
8604	2796	100	110	31.104800
8605	2797	100	110	31.104800
8606	2798	100	110	31.104800
8607	2799	100	110	31.104800
8608	2800	100	110	31.104800
8609	2801	100	110	31.104800
8610	2802	100	110	31.104800
8611	2803	100	110	31.104800
8612	2804	100	110	31.104800
8613	2805	100	110	31.104800
8614	2806	100	110	31.104800
8615	2807	100	110	31.104800
8616	2808	100	110	31.104800
8617	2809	100	110	31.104800
8618	2810	100	110	31.104800
8619	2811	100	110	31.104800
8620	2812	100	110	31.104800
8621	2813	100	110	31.104800
8622	2814	100	110	31.104800
8623	2815	100	110	31.104800
8624	2816	100	110	31.104800
8625	2817	100	110	31.104800
8626	2818	100	110	31.104800
8627	2819	100	110	31.104800
8628	2820	100	110	31.104800
8629	2821	100	110	31.104800
8630	2822	100	110	31.104800
8631	2823	100	110	31.104800
8632	2824	100	110	31.104800
8633	2825	100	110	31.104800
8634	2826	100	110	31.104800
8635	2827	100	110	31.104800
8636	2828	100	110	31.104800
8637	2829	100	110	31.104800
8638	2830	100	110	31.104800
8639	2831	100	110	31.104800
8640	2832	100	110	31.104800
8641	2833	100	110	31.104800
8642	2834	100	110	31.104800
8643	2835	100	110	31.104800
8644	2836	100	110	31.104800
8645	2837	100	110	31.104800
8646	2838	100	110	31.104800
8647	2839	100	110	31.104800
8648	2840	100	110	31.104800
8649	2841	100	110	31.104800
8650	2842	100	110	31.104800
8651	2843	100	110	31.104800
8652	2844	100	110	31.104800
8653	2845	100	110	31.104800
8654	2846	100	110	31.104800
8655	2847	100	110	31.104800
8656	2848	100	110	31.104800
8657	2849	100	110	31.104800
8658	2850	100	110	31.104800
8659	2851	100	110	31.104800
8660	2852	100	110	31.104800
8661	2853	100	110	31.104800
8662	2854	100	110	31.104800
8663	2855	100	110	31.104800
8664	2856	100	110	31.104800
8665	2857	100	110	31.104800
8666	2858	100	110	31.104800
8667	2859	100	110	31.104800
8668	2860	100	110	31.104800
8669	2861	100	110	31.104800
8670	2862	100	110	31.104800
8671	2863	100	110	31.104800
8672	2864	100	110	31.104800
8673	2865	100	110	31.104800
8674	2866	100	110	31.104800
8675	2867	100	110	31.104800
8676	2868	100	110	31.104800
8677	2869	100	110	31.104800
8678	2870	100	110	31.104800
8679	2871	100	110	31.104800
8680	2872	100	110	31.104800
8681	2873	100	110	31.104800
8682	2874	100	110	31.104800
8683	2875	100	110	31.104800
8684	2876	100	110	31.104800
8685	2877	100	110	31.104800
8686	2878	100	110	31.104800
8687	2879	100	110	31.104800
8688	2880	100	110	31.104800
8689	2881	100	110	31.104800
8690	2882	100	110	31.104800
8691	2883	100	110	31.104800
8692	2884	100	110	31.104800
8693	2885	100	110	31.104800
8694	2886	100	110	31.104800
8695	2887	100	110	31.104800
8696	2888	100	110	31.104800
8697	2889	100	110	31.104800
8698	2890	100	110	31.104800
8699	2891	100	110	31.104800
8700	2892	100	110	31.104800
8701	2893	100	110	31.104800
8702	2894	100	110	31.104800
8703	2895	100	110	31.104800
8704	2896	100	110	31.104800
8705	2897	100	110	31.104800
8706	2898	100	110	31.104800
8707	2899	100	110	31.104800
8708	2900	100	110	31.104800
8709	2901	100	110	31.104800
8710	2902	100	110	31.104800
8711	2903	100	110	31.104800
8712	2904	100	110	31.104800
8713	2905	200	112	6.477000
8714	2906	200	112	0.610000
8715	2907	200	112	0.000000
8716	2908	200	112	4.129000
8717	2909	200	112	89.440000
8718	2910	200	112	132.675000
8719	2911	200	112	263.476000
8720	2912	200	112	264.679000
8721	2913	200	112	222.370000
8722	2914	200	112	121.253000
8723	2915	200	112	188.019000
8724	2916	200	112	0.014000
8725	2917	200	112	3.818000
8726	2918	200	112	0.000000
8727	2919	200	112	6.197000
8728	2920	200	112	41.168000
8729	2921	200	112	63.445000
8730	2922	200	112	114.672000
8731	2923	200	112	145.063000
8732	2924	200	112	181.423000
8733	2925	200	112	221.283000
8734	2926	200	112	296.202000
8735	2927	200	112	4.588000
8736	2928	200	112	0.091000
8737	2929	200	112	0.212000
8738	2930	200	112	1.745000
8739	2931	200	112	17.617000
8740	2932	200	112	34.553000
8741	2933	200	112	66.375000
8742	2934	200	112	65.357000
8743	2935	200	112	319.626000
8744	2936	200	112	212.759000
8745	2937	200	112	138.300000
8746	2938	200	112	182.620000
8747	2939	200	112	64.225000
8748	2940	200	112	0.014000
8749	2941	200	112	17.311000
8750	2942	200	112	0.498000
8751	2943	200	112	21.172000
8752	2944	200	112	25.735000
8753	2945	200	112	55.173000
8754	2946	200	112	80.926000
8755	2947	200	112	236.392000
8756	2948	200	112	133.497000
8757	2949	200	112	177.899000
8758	2950	200	112	407.040000
8759	2951	200	112	70.228000
8760	2952	200	112	0.014000
8761	2953	200	112	3.246000
8762	2954	200	112	0.521000
8763	2955	200	112	3.241000
8764	2956	200	112	55.812000
8765	2957	200	112	33.639000
8766	2958	200	112	271.921000
8767	2959	200	112	105.600000
8768	2960	200	112	212.538000
8769	2961	200	112	158.308000
8770	2962	200	112	212.391000
8771	2963	200	112	41.321000
8772	2964	200	112	9.424000
8773	2965	200	112	10.924000
8774	2966	200	112	1.559000
8775	2967	200	112	49.835000
8776	2968	200	112	64.932000
8777	2969	200	112	7.201000
8778	2970	200	112	42.460000
8779	2971	200	112	249.530000
8780	2972	200	112	176.546000
8781	2973	200	112	209.552000
8782	2974	200	112	60.546000
8783	2975	200	112	111.115000
8784	2976	200	112	29.624000
8785	2977	200	112	20.834000
8786	2978	200	112	43.217000
8787	2979	200	112	1.429000
8788	2980	200	112	36.567000
8789	2981	200	112	53.653000
8790	2982	200	112	114.627000
8791	2983	200	112	270.513000
8792	2984	200	112	196.982000
8793	2985	200	112	270.896000
8794	2986	200	112	247.744000
8795	2987	200	112	164.709000
8796	2988	200	112	0.014000
8797	2989	200	112	0.424000
8798	2990	200	112	0.000000
8799	2991	200	112	0.000000
8800	2992	200	112	0.408000
8801	2993	200	112	74.018000
8802	2994	200	112	157.189000
8803	2995	200	112	83.564000
8804	2996	200	112	310.857000
8805	2997	200	112	132.179000
8806	2998	200	112	153.973000
8807	2999	200	112	8.008000
8808	3000	200	112	0.841000
8809	3001	200	112	0.000000
8810	3002	200	112	31.016000
8811	3003	200	112	0.000000
8812	3004	200	112	19.836000
8813	3005	200	112	38.502000
8814	3006	200	112	265.521000
8815	3007	200	112	139.410000
8816	3008	200	112	266.612000
8817	3009	200	112	115.908000
8818	3010	200	112	130.221000
8819	3011	200	112	3.450000
8820	3012	200	112	0.014000
8821	3013	200	112	0.182000
8822	3014	200	112	0.055000
8823	3015	200	112	4.850000
8824	3016	200	112	33.658000
8825	3017	200	112	57.246000
8826	3018	200	112	112.471000
8827	3019	200	112	141.046000
8828	3020	200	112	303.224000
8829	3021	200	112	164.128000
8830	3022	200	112	151.975000
8831	3023	200	112	111.071000
8832	3024	200	112	3.009000
8833	3025	200	112	30.940000
8834	3026	200	112	0.299000
8835	3027	200	112	2.204000
8836	3028	200	112	107.196000
8837	3029	200	112	35.631000
8838	3030	200	112	115.000000
8839	3031	200	112	136.241000
8840	3032	200	112	283.702000
8841	3033	200	112	61.538000
8842	3034	200	112	60.112000
8843	3035	200	112	42.078000
8844	3036	200	112	0.014000
8845	2905	100	114	80.648000
8846	2906	100	114	80.648000
8847	2907	100	114	80.648000
8848	2908	100	114	80.648000
8849	2909	100	114	80.648000
8850	2910	100	114	80.648000
8851	2911	100	114	80.648000
8852	2912	100	114	80.648000
8853	2913	100	114	80.648000
8854	2914	100	114	80.648000
8855	2915	100	114	80.648000
8856	2916	100	114	80.648000
8857	2917	100	114	80.648000
8858	2918	100	114	80.648000
8859	2919	100	114	80.648000
8860	2920	100	114	80.648000
8861	2921	100	114	80.648000
8862	2922	100	114	80.648000
8863	2923	100	114	80.648000
8864	2924	100	114	80.648000
8865	2925	100	114	80.648000
8866	2926	100	114	80.648000
8867	2927	100	114	80.648000
8868	2928	100	114	80.648000
8869	2929	100	114	80.648000
8870	2930	100	114	80.648000
8871	2931	100	114	80.648000
8872	2932	100	114	80.648000
8873	2933	100	114	80.648000
8874	2934	100	114	80.648000
8875	2935	100	114	80.648000
8876	2936	100	114	80.648000
8877	2937	100	114	80.648000
8878	2938	100	114	80.648000
8879	2939	100	114	80.648000
8880	2940	100	114	80.648000
8881	2941	100	114	80.648000
8882	2942	100	114	80.648000
8883	2943	100	114	80.648000
8884	2944	100	114	80.648000
8885	2945	100	114	80.648000
8886	2946	100	114	80.648000
8887	2947	100	114	80.648000
8888	2948	100	114	80.648000
8889	2949	100	114	80.648000
8890	2950	100	114	80.648000
8891	2951	100	114	80.648000
8892	2952	100	114	80.648000
8893	2953	100	114	80.648000
8894	2954	100	114	80.648000
8895	2955	100	114	80.648000
8896	2956	100	114	80.648000
8897	2957	100	114	80.648000
8898	2958	100	114	80.648000
8899	2959	100	114	80.648000
8900	2960	100	114	80.648000
8901	2961	100	114	80.648000
8902	2962	100	114	80.648000
8903	2963	100	114	80.648000
8904	2964	100	114	80.648000
8905	2965	100	114	80.648000
8906	2966	100	114	80.648000
8907	2967	100	114	80.648000
8908	2968	100	114	80.648000
8909	2969	100	114	80.648000
8910	2970	100	114	80.648000
8911	2971	100	114	80.648000
8912	2972	100	114	80.648000
8913	2973	100	114	80.648000
8914	2974	100	114	80.648000
8915	2975	100	114	80.648000
8916	2976	100	114	80.648000
8917	2977	100	114	80.648000
8918	2978	100	114	80.648000
8919	2979	100	114	80.648000
8920	2980	100	114	80.648000
8921	2981	100	114	80.648000
8922	2982	100	114	80.648000
8923	2983	100	114	80.648000
8924	2984	100	114	80.648000
8925	2985	100	114	80.648000
8926	2986	100	114	80.648000
8927	2987	100	114	80.648000
8928	2988	100	114	80.648000
8929	2989	100	114	80.648000
8930	2990	100	114	80.648000
8931	2991	100	114	80.648000
8932	2992	100	114	80.648000
8933	2993	100	114	80.648000
8934	2994	100	114	80.648000
8935	2995	100	114	80.648000
8936	2996	100	114	80.648000
8937	2997	100	114	80.648000
8938	2998	100	114	80.648000
8939	2999	100	114	80.648000
8940	3000	100	114	80.648000
8941	3001	100	114	80.648000
8942	3002	100	114	80.648000
8943	3003	100	114	80.648000
8944	3004	100	114	80.648000
8945	3005	100	114	80.648000
8946	3006	100	114	80.648000
8947	3007	100	114	80.648000
8948	3008	100	114	80.648000
8949	3009	100	114	80.648000
8950	3010	100	114	80.648000
8951	3011	100	114	80.648000
8952	3012	100	114	80.648000
8953	3013	100	114	80.648000
8954	3014	100	114	80.648000
8955	3015	100	114	80.648000
8956	3016	100	114	80.648000
8957	3017	100	114	80.648000
8958	3018	100	114	80.648000
8959	3019	100	114	80.648000
8960	3020	100	114	80.648000
8961	3021	100	114	80.648000
8962	3022	100	114	80.648000
8963	3023	100	114	80.648000
8964	3024	100	114	80.648000
8965	3025	100	114	80.648000
8966	3026	100	114	80.648000
8967	3027	100	114	80.648000
8968	3028	100	114	80.648000
8969	3029	100	114	80.648000
8970	3030	100	114	80.648000
8971	3031	100	114	80.648000
8972	3032	100	114	80.648000
8973	3033	100	114	80.648000
8974	3034	100	114	80.648000
8975	3035	100	114	80.648000
8976	3036	100	114	80.648000
8977	2905	100	113	16.506200
8978	2906	100	113	16.506200
8979	2907	100	113	16.506200
8980	2908	100	113	16.506200
8981	2909	100	113	16.506200
8982	2910	100	113	16.506200
8983	2911	100	113	16.506200
8984	2912	100	113	16.506200
8985	2913	100	113	16.506200
8986	2914	100	113	16.506200
8987	2915	100	113	16.506200
8988	2916	100	113	16.506200
8989	2917	100	113	16.506200
8990	2918	100	113	16.506200
8991	2919	100	113	16.506200
8992	2920	100	113	16.506200
8993	2921	100	113	16.506200
8994	2922	100	113	16.506200
8995	2923	100	113	16.506200
8996	2924	100	113	16.506200
8997	2925	100	113	16.506200
8998	2926	100	113	16.506200
8999	2927	100	113	16.506200
9000	2928	100	113	16.506200
9001	2929	100	113	16.506200
9002	2930	100	113	16.506200
9003	2931	100	113	16.506200
9004	2932	100	113	16.506200
9005	2933	100	113	16.506200
9006	2934	100	113	16.506200
9007	2935	100	113	16.506200
9008	2936	100	113	16.506200
9009	2937	100	113	16.506200
9010	2938	100	113	16.506200
9011	2939	100	113	16.506200
9012	2940	100	113	16.506200
9013	2941	100	113	16.506200
9014	2942	100	113	16.506200
9015	2943	100	113	16.506200
9016	2944	100	113	16.506200
9017	2945	100	113	16.506200
9018	2946	100	113	16.506200
9019	2947	100	113	16.506200
9020	2948	100	113	16.506200
9021	2949	100	113	16.506200
9022	2950	100	113	16.506200
9023	2951	100	113	16.506200
9024	2952	100	113	16.506200
9025	2953	100	113	16.506200
9026	2954	100	113	16.506200
9027	2955	100	113	16.506200
9028	2956	100	113	16.506200
9029	2957	100	113	16.506200
9030	2958	100	113	16.506200
9031	2959	100	113	16.506200
9032	2960	100	113	16.506200
9033	2961	100	113	16.506200
9034	2962	100	113	16.506200
9035	2963	100	113	16.506200
9036	2964	100	113	16.506200
9037	2965	100	113	16.506200
9038	2966	100	113	16.506200
9039	2967	100	113	16.506200
9040	2968	100	113	16.506200
9041	2969	100	113	16.506200
9042	2970	100	113	16.506200
9043	2971	100	113	16.506200
9044	2972	100	113	16.506200
9045	2973	100	113	16.506200
9046	2974	100	113	16.506200
9047	2975	100	113	16.506200
9048	2976	100	113	16.506200
9049	2977	100	113	16.506200
9050	2978	100	113	16.506200
9051	2979	100	113	16.506200
9052	2980	100	113	16.506200
9053	2981	100	113	16.506200
9054	2982	100	113	16.506200
9055	2983	100	113	16.506200
9056	2984	100	113	16.506200
9057	2985	100	113	16.506200
9058	2986	100	113	16.506200
9059	2987	100	113	16.506200
9060	2988	100	113	16.506200
9061	2989	100	113	16.506200
9062	2990	100	113	16.506200
9063	2991	100	113	16.506200
9064	2992	100	113	16.506200
9065	2993	100	113	16.506200
9066	2994	100	113	16.506200
9067	2995	100	113	16.506200
9068	2996	100	113	16.506200
9069	2997	100	113	16.506200
9070	2998	100	113	16.506200
9071	2999	100	113	16.506200
9072	3000	100	113	16.506200
9073	3001	100	113	16.506200
9074	3002	100	113	16.506200
9075	3003	100	113	16.506200
9076	3004	100	113	16.506200
9077	3005	100	113	16.506200
9078	3006	100	113	16.506200
9079	3007	100	113	16.506200
9080	3008	100	113	16.506200
9081	3009	100	113	16.506200
9082	3010	100	113	16.506200
9083	3011	100	113	16.506200
9084	3012	100	113	16.506200
9085	3013	100	113	16.506200
9086	3014	100	113	16.506200
9087	3015	100	113	16.506200
9088	3016	100	113	16.506200
9089	3017	100	113	16.506200
9090	3018	100	113	16.506200
9091	3019	100	113	16.506200
9092	3020	100	113	16.506200
9093	3021	100	113	16.506200
9094	3022	100	113	16.506200
9095	3023	100	113	16.506200
9096	3024	100	113	16.506200
9097	3025	100	113	16.506200
9098	3026	100	113	16.506200
9099	3027	100	113	16.506200
9100	3028	100	113	16.506200
9101	3029	100	113	16.506200
9102	3030	100	113	16.506200
9103	3031	100	113	16.506200
9104	3032	100	113	16.506200
9105	3033	100	113	16.506200
9106	3034	100	113	16.506200
9107	3035	100	113	16.506200
9108	3036	100	113	16.506200
9109	3037	200	115	11.321000
9110	3038	200	115	24.140000
9111	3039	200	115	38.929000
9112	3040	200	115	311.896000
9113	3041	200	115	216.654000
9114	3042	200	115	371.473000
9115	3043	200	115	441.673000
9116	3044	200	115	414.945000
9117	3045	200	115	211.334000
9118	3046	200	115	129.485000
9119	3047	200	115	3.429000
9120	3048	200	115	9.087000
9121	3049	200	115	30.072000
9122	3050	200	115	41.666000
9123	3051	200	115	65.446000
9124	3052	200	115	224.521000
9125	3053	200	115	320.915000
9126	3054	200	115	459.567000
9127	3055	200	115	312.764000
9128	3056	200	115	471.257000
9129	3057	200	115	335.334000
9130	3058	200	115	55.891000
9131	3059	200	115	4.768000
9132	3060	200	115	0.049000
9133	3061	200	115	15.933000
9134	3062	200	115	17.673000
9135	3063	200	115	67.341000
9136	3064	200	115	233.772000
9137	3065	200	115	189.861000
9138	3066	200	115	340.074000
9139	3067	200	115	367.758000
9140	3068	200	115	367.576000
9141	3069	200	115	115.902000
9142	3070	200	115	134.253000
9143	3071	200	115	11.919000
9144	3072	200	115	0.010000
9145	3073	200	115	23.745000
9146	3074	200	115	10.643000
9147	3075	200	115	29.868000
9148	3076	200	115	153.382000
9149	3077	200	115	280.014000
9150	3078	200	115	631.678000
9151	3079	200	115	600.476000
9152	3080	200	115	370.237000
9153	3081	200	115	411.381000
9154	3082	200	115	27.684000
9155	3083	200	115	57.193000
9156	3084	200	115	5.227000
9157	3085	200	115	8.957000
9158	3086	200	115	16.869000
9159	3087	200	115	46.436000
9160	3088	200	115	62.734000
9161	3089	200	115	509.026000
9162	3090	200	115	336.648000
9163	3091	200	115	431.897000
9164	3092	200	115	345.749000
9165	3093	200	115	189.296000
9166	3094	200	115	163.599000
9167	3095	200	115	0.200000
9168	3096	200	115	0.010000
9169	3097	200	115	12.119000
9170	3098	200	115	29.514000
9171	3099	200	115	53.523000
9172	3100	200	115	157.463000
9173	3101	200	115	205.063000
9174	3102	200	115	382.609000
9175	3103	200	115	312.753000
9176	3104	200	115	241.393000
9177	3105	200	115	324.545000
9178	3106	200	115	21.520000
9179	3107	200	115	11.468000
9180	3108	200	115	28.081000
9181	3109	200	115	3.006000
9182	3110	200	115	12.412000
9183	3111	200	115	82.365000
9184	3112	200	115	167.903000
9185	3113	200	115	201.808000
9186	3114	200	115	466.141000
9187	3115	200	115	441.197000
9188	3116	200	115	412.523000
9189	3117	200	115	249.290000
9190	3118	200	115	186.968000
9191	3119	200	115	5.475000
9192	3120	200	115	0.010000
9193	3121	200	115	0.227000
9194	3122	200	115	8.987000
9195	3123	200	115	15.216000
9196	3124	200	115	69.006000
9197	3125	200	115	376.234000
9198	3126	200	115	412.231000
9199	3127	200	115	460.617000
9200	3128	200	115	456.549000
9201	3129	200	115	268.531000
9202	3130	200	115	135.498000
9203	3131	200	115	19.447000
9204	3132	200	115	0.801000
9205	3133	200	115	12.084000
9206	3134	200	115	8.495000
9207	3135	200	115	69.419000
9208	3136	200	115	77.782000
9209	3137	200	115	396.149000
9210	3138	200	115	420.913000
9211	3139	200	115	333.650000
9212	3140	200	115	506.771000
9213	3141	200	115	266.213000
9214	3142	200	115	40.959000
9215	3143	200	115	3.685000
9216	3144	200	115	0.802000
9217	3145	200	115	1.102000
9218	3146	200	115	10.593000
9219	3147	200	115	14.465000
9220	3148	200	115	172.538000
9221	3149	200	115	310.599000
9222	3150	200	115	491.115000
9223	3151	200	115	436.224000
9224	3152	200	115	266.674000
9225	3153	200	115	264.158000
9226	3154	200	115	196.771000
9227	3155	200	115	8.795000
9228	3156	200	115	0.904000
9229	3157	200	115	11.484000
9230	3158	200	115	16.121000
9231	3159	200	115	49.400000
9232	3160	200	115	258.640000
9233	3161	200	115	317.606000
9234	3162	200	115	464.894000
9235	3163	200	115	463.541000
9236	3164	200	115	298.081000
9237	3165	200	115	271.615000
9238	3166	200	115	44.859000
9239	3167	200	115	30.407000
9240	3168	200	115	0.010000
9241	3037	100	117	92.302400
9242	3038	100	117	92.302400
9243	3039	100	117	92.302400
9244	3040	100	117	92.302400
9245	3041	100	117	92.302400
9246	3042	100	117	92.302400
9247	3043	100	117	92.302400
9248	3044	100	117	92.302400
9249	3045	100	117	92.302400
9250	3046	100	117	92.302400
9251	3047	100	117	92.302400
9252	3048	100	117	92.302400
9253	3049	100	117	92.302400
9254	3050	100	117	92.302400
9255	3051	100	117	92.302400
9256	3052	100	117	92.302400
9257	3053	100	117	92.302400
9258	3054	100	117	92.302400
9259	3055	100	117	92.302400
9260	3056	100	117	92.302400
9261	3057	100	117	92.302400
9262	3058	100	117	92.302400
9263	3059	100	117	92.302400
9264	3060	100	117	92.302400
9265	3061	100	117	92.302400
9266	3062	100	117	92.302400
9267	3063	100	117	92.302400
9268	3064	100	117	92.302400
9269	3065	100	117	92.302400
9270	3066	100	117	92.302400
9271	3067	100	117	92.302400
9272	3068	100	117	92.302400
9273	3069	100	117	92.302400
9274	3070	100	117	92.302400
9275	3071	100	117	92.302400
9276	3072	100	117	92.302400
9277	3073	100	117	92.302400
9278	3074	100	117	92.302400
9279	3075	100	117	92.302400
9280	3076	100	117	92.302400
9281	3077	100	117	92.302400
9282	3078	100	117	92.302400
9283	3079	100	117	92.302400
9284	3080	100	117	92.302400
9285	3081	100	117	92.302400
9286	3082	100	117	92.302400
9287	3083	100	117	92.302400
9288	3084	100	117	92.302400
9289	3085	100	117	92.302400
9290	3086	100	117	92.302400
9291	3087	100	117	92.302400
9292	3088	100	117	92.302400
9293	3089	100	117	92.302400
9294	3090	100	117	92.302400
9295	3091	100	117	92.302400
9296	3092	100	117	92.302400
9297	3093	100	117	92.302400
9298	3094	100	117	92.302400
9299	3095	100	117	92.302400
9300	3096	100	117	92.302400
9301	3097	100	117	92.302400
9302	3098	100	117	92.302400
9303	3099	100	117	92.302400
9304	3100	100	117	92.302400
9305	3101	100	117	92.302400
9306	3102	100	117	92.302400
9307	3103	100	117	92.302400
9308	3104	100	117	92.302400
9309	3105	100	117	92.302400
9310	3106	100	117	92.302400
9311	3107	100	117	92.302400
9312	3108	100	117	92.302400
9313	3109	100	117	92.302400
9314	3110	100	117	92.302400
9315	3111	100	117	92.302400
9316	3112	100	117	92.302400
9317	3113	100	117	92.302400
9318	3114	100	117	92.302400
9319	3115	100	117	92.302400
9320	3116	100	117	92.302400
9321	3117	100	117	92.302400
9322	3118	100	117	92.302400
9323	3119	100	117	92.302400
9324	3120	100	117	92.302400
9325	3121	100	117	92.302400
9326	3122	100	117	92.302400
9327	3123	100	117	92.302400
9328	3124	100	117	92.302400
9329	3125	100	117	92.302400
9330	3126	100	117	92.302400
9331	3127	100	117	92.302400
9332	3128	100	117	92.302400
9333	3129	100	117	92.302400
9334	3130	100	117	92.302400
9335	3131	100	117	92.302400
9336	3132	100	117	92.302400
9337	3133	100	117	92.302400
9338	3134	100	117	92.302400
9339	3135	100	117	92.302400
9340	3136	100	117	92.302400
9341	3137	100	117	92.302400
9342	3138	100	117	92.302400
9343	3139	100	117	92.302400
9344	3140	100	117	92.302400
9345	3141	100	117	92.302400
9346	3142	100	117	92.302400
9347	3143	100	117	92.302400
9348	3144	100	117	92.302400
9349	3145	100	117	92.302400
9350	3146	100	117	92.302400
9351	3147	100	117	92.302400
9352	3148	100	117	92.302400
9353	3149	100	117	92.302400
9354	3150	100	117	92.302400
9355	3151	100	117	92.302400
9356	3152	100	117	92.302400
9357	3153	100	117	92.302400
9358	3154	100	117	92.302400
9359	3155	100	117	92.302400
9360	3156	100	117	92.302400
9361	3157	100	117	92.302400
9362	3158	100	117	92.302400
9363	3159	100	117	92.302400
9364	3160	100	117	92.302400
9365	3161	100	117	92.302400
9366	3162	100	117	92.302400
9367	3163	100	117	92.302400
9368	3164	100	117	92.302400
9369	3165	100	117	92.302400
9370	3166	100	117	92.302400
9371	3167	100	117	92.302400
9372	3168	100	117	92.302400
9373	3037	100	116	27.342800
9374	3038	100	116	27.342800
9375	3039	100	116	27.342800
9376	3040	100	116	27.342800
9377	3041	100	116	27.342800
9378	3042	100	116	27.342800
9379	3043	100	116	27.342800
9380	3044	100	116	27.342800
9381	3045	100	116	27.342800
9382	3046	100	116	27.342800
9383	3047	100	116	27.342800
9384	3048	100	116	27.342800
9385	3049	100	116	27.342800
9386	3050	100	116	27.342800
9387	3051	100	116	27.342800
9388	3052	100	116	27.342800
9389	3053	100	116	27.342800
9390	3054	100	116	27.342800
9391	3055	100	116	27.342800
9392	3056	100	116	27.342800
9393	3057	100	116	27.342800
9394	3058	100	116	27.342800
9395	3059	100	116	27.342800
9396	3060	100	116	27.342800
9397	3061	100	116	27.342800
9398	3062	100	116	27.342800
9399	3063	100	116	27.342800
9400	3064	100	116	27.342800
9401	3065	100	116	27.342800
9402	3066	100	116	27.342800
9403	3067	100	116	27.342800
9404	3068	100	116	27.342800
9405	3069	100	116	27.342800
9406	3070	100	116	27.342800
9407	3071	100	116	27.342800
9408	3072	100	116	27.342800
9409	3073	100	116	27.342800
9410	3074	100	116	27.342800
9411	3075	100	116	27.342800
9412	3076	100	116	27.342800
9413	3077	100	116	27.342800
9414	3078	100	116	27.342800
9415	3079	100	116	27.342800
9416	3080	100	116	27.342800
9417	3081	100	116	27.342800
9418	3082	100	116	27.342800
9419	3083	100	116	27.342800
9420	3084	100	116	27.342800
9421	3085	100	116	27.342800
9422	3086	100	116	27.342800
9423	3087	100	116	27.342800
9424	3088	100	116	27.342800
9425	3089	100	116	27.342800
9426	3090	100	116	27.342800
9427	3091	100	116	27.342800
9428	3092	100	116	27.342800
9429	3093	100	116	27.342800
9430	3094	100	116	27.342800
9431	3095	100	116	27.342800
9432	3096	100	116	27.342800
9433	3097	100	116	27.342800
9434	3098	100	116	27.342800
9435	3099	100	116	27.342800
9436	3100	100	116	27.342800
9437	3101	100	116	27.342800
9438	3102	100	116	27.342800
9439	3103	100	116	27.342800
9440	3104	100	116	27.342800
9441	3105	100	116	27.342800
9442	3106	100	116	27.342800
9443	3107	100	116	27.342800
9444	3108	100	116	27.342800
9445	3109	100	116	27.342800
9446	3110	100	116	27.342800
9447	3111	100	116	27.342800
9448	3112	100	116	27.342800
9449	3113	100	116	27.342800
9450	3114	100	116	27.342800
9451	3115	100	116	27.342800
9452	3116	100	116	27.342800
9453	3117	100	116	27.342800
9454	3118	100	116	27.342800
9455	3119	100	116	27.342800
9456	3120	100	116	27.342800
9457	3121	100	116	27.342800
9458	3122	100	116	27.342800
9459	3123	100	116	27.342800
9460	3124	100	116	27.342800
9461	3125	100	116	27.342800
9462	3126	100	116	27.342800
9463	3127	100	116	27.342800
9464	3128	100	116	27.342800
9465	3129	100	116	27.342800
9466	3130	100	116	27.342800
9467	3131	100	116	27.342800
9468	3132	100	116	27.342800
9469	3133	100	116	27.342800
9470	3134	100	116	27.342800
9471	3135	100	116	27.342800
9472	3136	100	116	27.342800
9473	3137	100	116	27.342800
9474	3138	100	116	27.342800
9475	3139	100	116	27.342800
9476	3140	100	116	27.342800
9477	3141	100	116	27.342800
9478	3142	100	116	27.342800
9479	3143	100	116	27.342800
9480	3144	100	116	27.342800
9481	3145	100	116	27.342800
9482	3146	100	116	27.342800
9483	3147	100	116	27.342800
9484	3148	100	116	27.342800
9485	3149	100	116	27.342800
9486	3150	100	116	27.342800
9487	3151	100	116	27.342800
9488	3152	100	116	27.342800
9489	3153	100	116	27.342800
9490	3154	100	116	27.342800
9491	3155	100	116	27.342800
9492	3156	100	116	27.342800
9493	3157	100	116	27.342800
9494	3158	100	116	27.342800
9495	3159	100	116	27.342800
9496	3160	100	116	27.342800
9497	3161	100	116	27.342800
9498	3162	100	116	27.342800
9499	3163	100	116	27.342800
9500	3164	100	116	27.342800
9501	3165	100	116	27.342800
9502	3166	100	116	27.342800
9503	3167	100	116	27.342800
9504	3168	100	116	27.342800
9505	3169	200	118	0.005000
9506	3170	200	118	1.460000
9507	3171	200	118	0.000000
9508	3172	200	118	3.084000
9509	3173	200	118	25.145000
9510	3174	200	118	71.337000
9511	3175	200	118	121.383000
9512	3176	200	118	332.365000
9513	3177	200	118	243.232000
9514	3178	200	118	35.025000
9515	3179	200	118	4.893000
9516	3180	200	118	0.000000
9517	3181	200	118	0.000000
9518	3182	200	118	6.829000
9519	3183	200	118	21.471000
9520	3184	200	118	2.514000
9521	3185	200	118	6.593000
9522	3186	200	118	91.090000
9523	3187	200	118	303.397000
9524	3188	200	118	211.120000
9525	3189	200	118	207.288000
9526	3190	200	118	149.300000
9527	3191	200	118	0.070000
9528	3192	200	118	8.695000
9529	3193	200	118	17.135000
9530	3194	200	118	12.038000
9531	3195	200	118	10.709000
9532	3196	200	118	36.237000
9533	3197	200	118	4.716000
9534	3198	200	118	139.849000
9535	3199	200	118	285.919000
9536	3200	200	118	228.791000
9537	3201	200	118	213.800000
9538	3202	200	118	94.692000
9539	3203	200	118	11.693000
9540	3204	200	118	0.000000
9541	3205	200	118	37.221000
9542	3206	200	118	0.039000
9543	3207	200	118	48.433000
9544	3208	200	118	1.711000
9545	3209	200	118	21.788000
9546	3210	200	118	136.607000
9547	3211	200	118	407.104000
9548	3212	200	118	142.245000
9549	3213	200	118	261.992000
9550	3214	200	118	67.463000
9551	3215	200	118	4.552000
9552	3216	200	118	0.036000
9553	3217	200	118	3.060000
9554	3218	200	118	3.563000
9555	3219	200	118	6.138000
9556	3220	200	118	5.328000
9557	3221	200	118	1.718000
9558	3222	200	118	41.203000
9559	3223	200	118	260.309000
9560	3224	200	118	334.258000
9561	3225	200	118	269.355000
9562	3226	200	118	139.594000
9563	3227	200	118	15.921000
9564	3228	200	118	0.000000
9565	3229	200	118	26.892000
9566	3230	200	118	0.000000
9567	3231	200	118	2.700000
9568	3232	200	118	26.131000
9569	3233	200	118	6.689000
9570	3234	200	118	82.798000
9571	3235	200	118	188.604000
9572	3236	200	118	232.244000
9573	3237	200	118	91.573000
9574	3238	200	118	51.556000
9575	3239	200	118	92.557000
9576	3240	200	118	31.918000
9577	3241	200	118	5.746000
9578	3242	200	118	4.585000
9579	3243	200	118	9.593000
9580	3244	200	118	3.527000
9581	3245	200	118	5.747000
9582	3246	200	118	69.104000
9583	3247	200	118	212.667000
9584	3248	200	118	277.319000
9585	3249	200	118	370.856000
9586	3250	200	118	75.561000
9587	3251	200	118	51.495000
9588	3252	200	118	0.000000
9589	3253	200	118	0.177000
9590	3254	200	118	24.769000
9591	3255	200	118	0.000000
9592	3256	200	118	1.011000
9593	3257	200	118	56.187000
9594	3258	200	118	132.907000
9595	3259	200	118	218.419000
9596	3260	200	118	287.394000
9597	3261	200	118	257.769000
9598	3262	200	118	94.944000
9599	3263	200	118	0.057000
9600	3264	200	118	0.000000
9601	3265	200	118	0.000000
9602	3266	200	118	9.814000
9603	3267	200	118	0.000000
9604	3268	200	118	1.482000
9605	3269	200	118	23.164000
9606	3270	200	118	157.387000
9607	3271	200	118	262.314000
9608	3272	200	118	299.110000
9609	3273	200	118	60.016000
9610	3274	200	118	7.045000
9611	3275	200	118	0.446000
9612	3276	200	118	0.660000
9613	3277	200	118	24.188000
9614	3278	200	118	0.000000
9615	3279	200	118	32.100000
9616	3280	200	118	14.441000
9617	3281	200	118	12.485000
9618	3282	200	118	187.701000
9619	3283	200	118	95.259000
9620	3284	200	118	243.491000
9621	3285	200	118	49.571000
9622	3286	200	118	62.732000
9623	3287	200	118	0.307000
9624	3288	200	118	0.000000
9625	3289	200	118	22.258000
9626	3290	200	118	2.694000
9627	3291	200	118	6.653000
9628	3292	200	118	4.761000
9629	3293	200	118	14.115000
9630	3294	200	118	228.952000
9631	3295	200	118	71.770000
9632	3296	200	118	302.998000
9633	3297	200	118	146.674000
9634	3298	200	118	51.333000
9635	3299	200	118	2.413000
9636	3300	200	118	0.000000
9637	3169	100	120	78.110800
9638	3170	100	120	78.110800
9639	3171	100	120	78.110800
9640	3172	100	120	78.110800
9641	3173	100	120	78.110800
9642	3174	100	120	78.110800
9643	3175	100	120	78.110800
9644	3176	100	120	78.110800
9645	3177	100	120	78.110800
9646	3178	100	120	78.110800
9647	3179	100	120	78.110800
9648	3180	100	120	78.110800
9649	3181	100	120	78.110800
9650	3182	100	120	78.110800
9651	3183	100	120	78.110800
9652	3184	100	120	78.110800
9653	3185	100	120	78.110800
9654	3186	100	120	78.110800
9655	3187	100	120	78.110800
9656	3188	100	120	78.110800
9657	3189	100	120	78.110800
9658	3190	100	120	78.110800
9659	3191	100	120	78.110800
9660	3192	100	120	78.110800
9661	3193	100	120	78.110800
9662	3194	100	120	78.110800
9663	3195	100	120	78.110800
9664	3196	100	120	78.110800
9665	3197	100	120	78.110800
9666	3198	100	120	78.110800
9667	3199	100	120	78.110800
9668	3200	100	120	78.110800
9669	3201	100	120	78.110800
9670	3202	100	120	78.110800
9671	3203	100	120	78.110800
9672	3204	100	120	78.110800
9673	3205	100	120	78.110800
9674	3206	100	120	78.110800
9675	3207	100	120	78.110800
9676	3208	100	120	78.110800
9677	3209	100	120	78.110800
9678	3210	100	120	78.110800
9679	3211	100	120	78.110800
9680	3212	100	120	78.110800
9681	3213	100	120	78.110800
9682	3214	100	120	78.110800
9683	3215	100	120	78.110800
9684	3216	100	120	78.110800
9685	3217	100	120	78.110800
9686	3218	100	120	78.110800
9687	3219	100	120	78.110800
9688	3220	100	120	78.110800
9689	3221	100	120	78.110800
9690	3222	100	120	78.110800
9691	3223	100	120	78.110800
9692	3224	100	120	78.110800
9693	3225	100	120	78.110800
9694	3226	100	120	78.110800
9695	3227	100	120	78.110800
9696	3228	100	120	78.110800
9697	3229	100	120	78.110800
9698	3230	100	120	78.110800
9699	3231	100	120	78.110800
9700	3232	100	120	78.110800
9701	3233	100	120	78.110800
9702	3234	100	120	78.110800
9703	3235	100	120	78.110800
9704	3236	100	120	78.110800
9705	3237	100	120	78.110800
9706	3238	100	120	78.110800
9707	3239	100	120	78.110800
9708	3240	100	120	78.110800
9709	3241	100	120	78.110800
9710	3242	100	120	78.110800
9711	3243	100	120	78.110800
9712	3244	100	120	78.110800
9713	3245	100	120	78.110800
9714	3246	100	120	78.110800
9715	3247	100	120	78.110800
9716	3248	100	120	78.110800
9717	3249	100	120	78.110800
9718	3250	100	120	78.110800
9719	3251	100	120	78.110800
9720	3252	100	120	78.110800
9721	3253	100	120	78.110800
9722	3254	100	120	78.110800
9723	3255	100	120	78.110800
9724	3256	100	120	78.110800
9725	3257	100	120	78.110800
9726	3258	100	120	78.110800
9727	3259	100	120	78.110800
9728	3260	100	120	78.110800
9729	3261	100	120	78.110800
9730	3262	100	120	78.110800
9731	3263	100	120	78.110800
9732	3264	100	120	78.110800
9733	3265	100	120	78.110800
9734	3266	100	120	78.110800
9735	3267	100	120	78.110800
9736	3268	100	120	78.110800
9737	3269	100	120	78.110800
9738	3270	100	120	78.110800
9739	3271	100	120	78.110800
9740	3272	100	120	78.110800
9741	3273	100	120	78.110800
9742	3274	100	120	78.110800
9743	3275	100	120	78.110800
9744	3276	100	120	78.110800
9745	3277	100	120	78.110800
9746	3278	100	120	78.110800
9747	3279	100	120	78.110800
9748	3280	100	120	78.110800
9749	3281	100	120	78.110800
9750	3282	100	120	78.110800
9751	3283	100	120	78.110800
9752	3284	100	120	78.110800
9753	3285	100	120	78.110800
9754	3286	100	120	78.110800
9755	3287	100	120	78.110800
9756	3288	100	120	78.110800
9757	3289	100	120	78.110800
9758	3290	100	120	78.110800
9759	3291	100	120	78.110800
9760	3292	100	120	78.110800
9761	3293	100	120	78.110800
9762	3294	100	120	78.110800
9763	3295	100	120	78.110800
9764	3296	100	120	78.110800
9765	3297	100	120	78.110800
9766	3298	100	120	78.110800
9767	3299	100	120	78.110800
9768	3300	100	120	78.110800
9769	3169	100	119	20.117000
9770	3170	100	119	20.117000
9771	3171	100	119	20.117000
9772	3172	100	119	20.117000
9773	3173	100	119	20.117000
9774	3174	100	119	20.117000
9775	3175	100	119	20.117000
9776	3176	100	119	20.117000
9777	3177	100	119	20.117000
9778	3178	100	119	20.117000
9779	3179	100	119	20.117000
9780	3180	100	119	20.117000
9781	3181	100	119	20.117000
9782	3182	100	119	20.117000
9783	3183	100	119	20.117000
9784	3184	100	119	20.117000
9785	3185	100	119	20.117000
9786	3186	100	119	20.117000
9787	3187	100	119	20.117000
9788	3188	100	119	20.117000
9789	3189	100	119	20.117000
9790	3190	100	119	20.117000
9791	3191	100	119	20.117000
9792	3192	100	119	20.117000
9793	3193	100	119	20.117000
9794	3194	100	119	20.117000
9795	3195	100	119	20.117000
9796	3196	100	119	20.117000
9797	3197	100	119	20.117000
9798	3198	100	119	20.117000
9799	3199	100	119	20.117000
9800	3200	100	119	20.117000
9801	3201	100	119	20.117000
9802	3202	100	119	20.117000
9803	3203	100	119	20.117000
9804	3204	100	119	20.117000
9805	3205	100	119	20.117000
9806	3206	100	119	20.117000
9807	3207	100	119	20.117000
9808	3208	100	119	20.117000
9809	3209	100	119	20.117000
9810	3210	100	119	20.117000
9811	3211	100	119	20.117000
9812	3212	100	119	20.117000
9813	3213	100	119	20.117000
9814	3214	100	119	20.117000
9815	3215	100	119	20.117000
9816	3216	100	119	20.117000
9817	3217	100	119	20.117000
9818	3218	100	119	20.117000
9819	3219	100	119	20.117000
9820	3220	100	119	20.117000
9821	3221	100	119	20.117000
9822	3222	100	119	20.117000
9823	3223	100	119	20.117000
9824	3224	100	119	20.117000
9825	3225	100	119	20.117000
9826	3226	100	119	20.117000
9827	3227	100	119	20.117000
9828	3228	100	119	20.117000
9829	3229	100	119	20.117000
9830	3230	100	119	20.117000
9831	3231	100	119	20.117000
9832	3232	100	119	20.117000
9833	3233	100	119	20.117000
9834	3234	100	119	20.117000
9835	3235	100	119	20.117000
9836	3236	100	119	20.117000
9837	3237	100	119	20.117000
9838	3238	100	119	20.117000
9839	3239	100	119	20.117000
9840	3240	100	119	20.117000
9841	3241	100	119	20.117000
9842	3242	100	119	20.117000
9843	3243	100	119	20.117000
9844	3244	100	119	20.117000
9845	3245	100	119	20.117000
9846	3246	100	119	20.117000
9847	3247	100	119	20.117000
9848	3248	100	119	20.117000
9849	3249	100	119	20.117000
9850	3250	100	119	20.117000
9851	3251	100	119	20.117000
9852	3252	100	119	20.117000
9853	3253	100	119	20.117000
9854	3254	100	119	20.117000
9855	3255	100	119	20.117000
9856	3256	100	119	20.117000
9857	3257	100	119	20.117000
9858	3258	100	119	20.117000
9859	3259	100	119	20.117000
9860	3260	100	119	20.117000
9861	3261	100	119	20.117000
9862	3262	100	119	20.117000
9863	3263	100	119	20.117000
9864	3264	100	119	20.117000
9865	3265	100	119	20.117000
9866	3266	100	119	20.117000
9867	3267	100	119	20.117000
9868	3268	100	119	20.117000
9869	3269	100	119	20.117000
9870	3270	100	119	20.117000
9871	3271	100	119	20.117000
9872	3272	100	119	20.117000
9873	3273	100	119	20.117000
9874	3274	100	119	20.117000
9875	3275	100	119	20.117000
9876	3276	100	119	20.117000
9877	3277	100	119	20.117000
9878	3278	100	119	20.117000
9879	3279	100	119	20.117000
9880	3280	100	119	20.117000
9881	3281	100	119	20.117000
9882	3282	100	119	20.117000
9883	3283	100	119	20.117000
9884	3284	100	119	20.117000
9885	3285	100	119	20.117000
9886	3286	100	119	20.117000
9887	3287	100	119	20.117000
9888	3288	100	119	20.117000
9889	3289	100	119	20.117000
9890	3290	100	119	20.117000
9891	3291	100	119	20.117000
9892	3292	100	119	20.117000
9893	3293	100	119	20.117000
9894	3294	100	119	20.117000
9895	3295	100	119	20.117000
9896	3296	100	119	20.117000
9897	3297	100	119	20.117000
9898	3298	100	119	20.117000
9899	3299	100	119	20.117000
9900	3300	100	119	20.117000
9901	3301	200	84	0.059000
9902	3302	200	84	0.000000
9903	3303	200	84	0.000000
9904	3304	200	84	0.000000
9905	3305	200	84	0.258000
9906	3306	200	84	36.774000
9907	3307	200	84	185.149000
9908	3308	200	84	101.797000
9909	3309	200	84	232.333000
9910	3310	200	84	3.171000
9911	3311	200	84	5.641000
9912	3312	200	84	0.000000
9913	3313	200	84	0.000000
9914	3314	200	84	0.018000
9915	3315	200	84	0.184000
9916	3316	200	84	0.000000
9917	3317	200	84	2.008000
9918	3318	200	84	22.959000
9919	3319	200	84	337.363000
9920	3320	200	84	41.281000
9921	3321	200	84	88.401000
9922	3322	200	84	17.328000
9923	3323	200	84	20.466000
9924	3324	200	84	0.169000
9925	3325	200	84	3.849000
9926	3326	200	84	0.000000
9927	3327	200	84	3.330000
9928	3328	200	84	0.041000
9929	3329	200	84	0.354000
9930	3330	200	84	86.887000
9931	3331	200	84	284.332000
9932	3332	200	84	201.961000
9933	3333	200	84	422.753000
9934	3334	200	84	1.430000
9935	3335	200	84	0.822000
9936	3336	200	84	0.000000
9937	3337	200	84	0.100000
9938	3338	200	84	0.000000
9939	3339	200	84	2.240000
9940	3340	200	84	0.654000
9941	3341	200	84	0.293000
9942	3342	200	84	10.688000
9943	3343	200	84	183.091000
9944	3344	200	84	47.507000
9945	3345	200	84	72.991000
9946	3346	200	84	1.272000
9947	3347	200	84	9.012000
9948	3348	200	84	1.876000
9949	3349	200	84	0.330000
9950	3350	200	84	0.019000
9951	3351	200	84	0.000000
9952	3352	200	84	0.000000
9953	3353	200	84	0.331000
9954	3354	200	84	104.996000
9955	3355	200	84	315.675000
9956	3356	200	84	144.774000
9957	3357	200	84	77.163000
9958	3358	200	84	53.049000
9959	3359	200	84	0.443000
9960	3360	200	84	0.000000
9961	3361	200	84	4.123000
9962	3362	200	84	0.000000
9963	3363	200	84	0.133000
9964	3364	200	84	2.581000
9965	3365	200	84	9.394000
9966	3366	200	84	139.682000
9967	3367	200	84	140.995000
9968	3368	200	84	190.251000
9969	3369	200	84	109.369000
9970	3370	200	84	1.803000
9971	3371	200	84	6.380000
9972	3372	200	84	0.524000
9973	3373	200	84	0.023000
9974	3374	200	84	0.763000
9975	3375	200	84	0.416000
9976	3376	200	84	0.000000
9977	3377	200	84	0.223000
9978	3378	200	84	112.060000
9979	3379	200	84	343.773000
9980	3380	200	84	155.212000
9981	3381	200	84	170.253000
9982	3382	200	84	70.045000
9983	3383	200	84	4.173000
9984	3384	200	84	0.000000
9985	3385	200	84	0.000000
9986	3386	200	84	1.608000
9987	3387	200	84	0.000000
9988	3388	200	84	0.000000
9989	3389	200	84	3.413000
9990	3390	200	84	165.644000
9991	3391	200	84	202.264000
9992	3392	200	84	26.084000
9993	3393	200	84	28.682000
9994	3394	200	84	58.777000
9995	3395	200	84	0.285000
9996	3396	200	84	0.001000
9997	3397	200	84	0.000000
9998	3398	200	84	0.000000
9999	3399	200	84	0.000000
10000	3400	200	84	0.000000
10001	3401	200	84	9.196000
10002	3402	200	84	55.405000
10003	3403	200	84	335.661000
10004	3404	200	84	81.557000
10005	3405	200	84	8.842000
10006	3406	200	84	2.065000
10007	3407	200	84	1.293000
10008	3408	200	84	0.000000
10009	3409	200	84	0.000000
10010	3410	200	84	0.000000
10011	3411	200	84	0.013000
10012	3412	200	84	0.048000
10013	3413	200	84	25.457000
10014	3414	200	84	194.499000
10015	3415	200	84	180.938000
10016	3416	200	84	108.017000
10017	3417	200	84	9.049000
10018	3418	200	84	34.520000
10019	3419	200	84	1.966000
10020	3420	200	84	0.000000
10021	3421	200	84	0.000000
10022	3422	200	84	0.084000
10023	3423	200	84	0.092000
10024	3424	200	84	0.311000
10025	3425	200	84	0.106000
10026	3426	200	84	137.818000
10027	3427	200	84	43.226000
10028	3428	200	84	101.494000
10029	3429	200	84	53.125000
10030	3430	200	84	0.198000
10031	3431	200	84	0.285000
10032	3432	200	84	0.098000
10033	3301	100	82	72.571400
10034	3302	100	82	72.571400
10035	3303	100	82	72.571400
10036	3304	100	82	72.571400
10037	3305	100	82	72.571400
10038	3306	100	82	72.571400
10039	3307	100	82	72.571400
10040	3308	100	82	72.571400
10041	3309	100	82	72.571400
10042	3310	100	82	72.571400
10043	3311	100	82	72.571400
10044	3312	100	82	72.571400
10045	3313	100	82	72.571400
10046	3314	100	82	72.571400
10047	3315	100	82	72.571400
10048	3316	100	82	72.571400
10049	3317	100	82	72.571400
10050	3318	100	82	72.571400
10051	3319	100	82	72.571400
10052	3320	100	82	72.571400
10053	3321	100	82	72.571400
10054	3322	100	82	72.571400
10055	3323	100	82	72.571400
10056	3324	100	82	72.571400
10057	3325	100	82	72.571400
10058	3326	100	82	72.571400
10059	3327	100	82	72.571400
10060	3328	100	82	72.571400
10061	3329	100	82	72.571400
10062	3330	100	82	72.571400
10063	3331	100	82	72.571400
10064	3332	100	82	72.571400
10065	3333	100	82	72.571400
10066	3334	100	82	72.571400
10067	3335	100	82	72.571400
10068	3336	100	82	72.571400
10069	3337	100	82	72.571400
10070	3338	100	82	72.571400
10071	3339	100	82	72.571400
10072	3340	100	82	72.571400
10073	3341	100	82	72.571400
10074	3342	100	82	72.571400
10075	3343	100	82	72.571400
10076	3344	100	82	72.571400
10077	3345	100	82	72.571400
10078	3346	100	82	72.571400
10079	3347	100	82	72.571400
10080	3348	100	82	72.571400
10081	3349	100	82	72.571400
10082	3350	100	82	72.571400
10083	3351	100	82	72.571400
10084	3352	100	82	72.571400
10085	3353	100	82	72.571400
10086	3354	100	82	72.571400
10087	3355	100	82	72.571400
10088	3356	100	82	72.571400
10089	3357	100	82	72.571400
10090	3358	100	82	72.571400
10091	3359	100	82	72.571400
10092	3360	100	82	72.571400
10093	3361	100	82	72.571400
10094	3362	100	82	72.571400
10095	3363	100	82	72.571400
10096	3364	100	82	72.571400
10097	3365	100	82	72.571400
10098	3366	100	82	72.571400
10099	3367	100	82	72.571400
10100	3368	100	82	72.571400
10101	3369	100	82	72.571400
10102	3370	100	82	72.571400
10103	3371	100	82	72.571400
10104	3372	100	82	72.571400
10105	3373	100	82	72.571400
10106	3374	100	82	72.571400
10107	3375	100	82	72.571400
10108	3376	100	82	72.571400
10109	3377	100	82	72.571400
10110	3378	100	82	72.571400
10111	3379	100	82	72.571400
10112	3380	100	82	72.571400
10113	3381	100	82	72.571400
10114	3382	100	82	72.571400
10115	3383	100	82	72.571400
10116	3384	100	82	72.571400
10117	3385	100	82	72.571400
10118	3386	100	82	72.571400
10119	3387	100	82	72.571400
10120	3388	100	82	72.571400
10121	3389	100	82	72.571400
10122	3390	100	82	72.571400
10123	3391	100	82	72.571400
10124	3392	100	82	72.571400
10125	3393	100	82	72.571400
10126	3394	100	82	72.571400
10127	3395	100	82	72.571400
10128	3396	100	82	72.571400
10129	3397	100	82	72.571400
10130	3398	100	82	72.571400
10131	3399	100	82	72.571400
10132	3400	100	82	72.571400
10133	3401	100	82	72.571400
10134	3402	100	82	72.571400
10135	3403	100	82	72.571400
10136	3404	100	82	72.571400
10137	3405	100	82	72.571400
10138	3406	100	82	72.571400
10139	3407	100	82	72.571400
10140	3408	100	82	72.571400
10141	3409	100	82	72.571400
10142	3410	100	82	72.571400
10143	3411	100	82	72.571400
10144	3412	100	82	72.571400
10145	3413	100	82	72.571400
10146	3414	100	82	72.571400
10147	3415	100	82	72.571400
10148	3416	100	82	72.571400
10149	3417	100	82	72.571400
10150	3418	100	82	72.571400
10151	3419	100	82	72.571400
10152	3420	100	82	72.571400
10153	3421	100	82	72.571400
10154	3422	100	82	72.571400
10155	3423	100	82	72.571400
10156	3424	100	82	72.571400
10157	3425	100	82	72.571400
10158	3426	100	82	72.571400
10159	3427	100	82	72.571400
10160	3428	100	82	72.571400
10161	3429	100	82	72.571400
10162	3430	100	82	72.571400
10163	3431	100	82	72.571400
10164	3432	100	82	72.571400
10165	3301	100	83	23.022500
10166	3302	100	83	23.022500
10167	3303	100	83	23.022500
10168	3304	100	83	23.022500
10169	3305	100	83	23.022500
10170	3306	100	83	23.022500
10171	3307	100	83	23.022500
10172	3308	100	83	23.022500
10173	3309	100	83	23.022500
10174	3310	100	83	23.022500
10175	3311	100	83	23.022500
10176	3312	100	83	23.022500
10177	3313	100	83	23.022500
10178	3314	100	83	23.022500
10179	3315	100	83	23.022500
10180	3316	100	83	23.022500
10181	3317	100	83	23.022500
10182	3318	100	83	23.022500
10183	3319	100	83	23.022500
10184	3320	100	83	23.022500
10185	3321	100	83	23.022500
10186	3322	100	83	23.022500
10187	3323	100	83	23.022500
10188	3324	100	83	23.022500
10189	3325	100	83	23.022500
10190	3326	100	83	23.022500
10191	3327	100	83	23.022500
10192	3328	100	83	23.022500
10193	3329	100	83	23.022500
10194	3330	100	83	23.022500
10195	3331	100	83	23.022500
10196	3332	100	83	23.022500
10197	3333	100	83	23.022500
10198	3334	100	83	23.022500
10199	3335	100	83	23.022500
10200	3336	100	83	23.022500
10201	3337	100	83	23.022500
10202	3338	100	83	23.022500
10203	3339	100	83	23.022500
10204	3340	100	83	23.022500
10205	3341	100	83	23.022500
10206	3342	100	83	23.022500
10207	3343	100	83	23.022500
10208	3344	100	83	23.022500
10209	3345	100	83	23.022500
10210	3346	100	83	23.022500
10211	3347	100	83	23.022500
10212	3348	100	83	23.022500
10213	3349	100	83	23.022500
10214	3350	100	83	23.022500
10215	3351	100	83	23.022500
10216	3352	100	83	23.022500
10217	3353	100	83	23.022500
10218	3354	100	83	23.022500
10219	3355	100	83	23.022500
10220	3356	100	83	23.022500
10221	3357	100	83	23.022500
10222	3358	100	83	23.022500
10223	3359	100	83	23.022500
10224	3360	100	83	23.022500
10225	3361	100	83	23.022500
10226	3362	100	83	23.022500
10227	3363	100	83	23.022500
10228	3364	100	83	23.022500
10229	3365	100	83	23.022500
10230	3366	100	83	23.022500
10231	3367	100	83	23.022500
10232	3368	100	83	23.022500
10233	3369	100	83	23.022500
10234	3370	100	83	23.022500
10235	3371	100	83	23.022500
10236	3372	100	83	23.022500
10237	3373	100	83	23.022500
10238	3374	100	83	23.022500
10239	3375	100	83	23.022500
10240	3376	100	83	23.022500
10241	3377	100	83	23.022500
10242	3378	100	83	23.022500
10243	3379	100	83	23.022500
10244	3380	100	83	23.022500
10245	3381	100	83	23.022500
10246	3382	100	83	23.022500
10247	3383	100	83	23.022500
10248	3384	100	83	23.022500
10249	3385	100	83	23.022500
10250	3386	100	83	23.022500
10251	3387	100	83	23.022500
10252	3388	100	83	23.022500
10253	3389	100	83	23.022500
10254	3390	100	83	23.022500
10255	3391	100	83	23.022500
10256	3392	100	83	23.022500
10257	3393	100	83	23.022500
10258	3394	100	83	23.022500
10259	3395	100	83	23.022500
10260	3396	100	83	23.022500
10261	3397	100	83	23.022500
10262	3398	100	83	23.022500
10263	3399	100	83	23.022500
10264	3400	100	83	23.022500
10265	3401	100	83	23.022500
10266	3402	100	83	23.022500
10267	3403	100	83	23.022500
10268	3404	100	83	23.022500
10269	3405	100	83	23.022500
10270	3406	100	83	23.022500
10271	3407	100	83	23.022500
10272	3408	100	83	23.022500
10273	3409	100	83	23.022500
10274	3410	100	83	23.022500
10275	3411	100	83	23.022500
10276	3412	100	83	23.022500
10277	3413	100	83	23.022500
10278	3414	100	83	23.022500
10279	3415	100	83	23.022500
10280	3416	100	83	23.022500
10281	3417	100	83	23.022500
10282	3418	100	83	23.022500
10283	3419	100	83	23.022500
10284	3420	100	83	23.022500
10285	3421	100	83	23.022500
10286	3422	100	83	23.022500
10287	3423	100	83	23.022500
10288	3424	100	83	23.022500
10289	3425	100	83	23.022500
10290	3426	100	83	23.022500
10291	3427	100	83	23.022500
10292	3428	100	83	23.022500
10293	3429	100	83	23.022500
10294	3430	100	83	23.022500
10295	3431	100	83	23.022500
10296	3432	100	83	23.022500
10297	3433	100	121	12.971600
10298	3434	100	121	12.971600
10299	3435	100	121	12.971600
10300	3436	100	121	12.971600
10301	3437	100	121	12.971600
10302	3438	100	121	12.971600
10303	3439	100	121	12.971600
10304	3440	100	121	12.971600
10305	3441	100	121	12.971600
10306	3442	100	121	12.971600
10307	3443	100	121	12.971600
10308	3444	100	121	12.971600
10309	3445	100	121	12.971600
10310	3446	100	121	12.971600
10311	3447	100	121	12.971600
10312	3448	100	121	12.971600
10313	3449	100	121	12.971600
10314	3450	100	121	12.971600
10315	3451	100	121	12.971600
10316	3452	100	121	12.971600
10317	3453	100	121	12.971600
10318	3454	100	121	12.971600
10319	3455	100	121	12.971600
10320	3456	100	121	12.971600
10321	3457	100	121	12.971600
10322	3458	100	121	12.971600
10323	3459	100	121	12.971600
10324	3460	100	121	12.971600
10325	3461	100	121	12.971600
10326	3462	100	121	12.971600
10327	3463	100	121	12.971600
10328	3464	100	121	12.971600
10329	3465	100	121	12.971600
10330	3466	100	121	12.971600
10331	3467	100	121	12.971600
10332	3468	100	121	12.971600
10333	3469	100	121	12.971600
10334	3470	100	121	12.971600
10335	3471	100	121	12.971600
10336	3472	100	121	12.971600
10337	3473	100	121	12.971600
10338	3474	100	121	12.971600
10339	3475	100	121	12.971600
10340	3476	100	121	12.971600
10341	3477	100	121	12.971600
10342	3478	100	121	12.971600
10343	3479	100	121	12.971600
10344	3480	100	121	12.971600
10345	3481	100	121	12.971600
10346	3482	100	121	12.971600
10347	3483	100	121	12.971600
10348	3484	100	121	12.971600
10349	3485	100	121	12.971600
10350	3486	100	121	12.971600
10351	3487	100	121	12.971600
10352	3488	100	121	12.971600
10353	3489	100	121	12.971600
10354	3490	100	121	12.971600
10355	3491	100	121	12.971600
10356	3492	100	121	12.971600
10357	3493	100	121	12.971600
10358	3494	100	121	12.971600
10359	3495	100	121	12.971600
10360	3496	100	121	12.971600
10361	3497	100	121	12.971600
10362	3498	100	121	12.971600
10363	3499	100	121	12.971600
10364	3500	100	121	12.971600
10365	3501	100	121	12.971600
10366	3502	100	121	12.971600
10367	3503	100	121	12.971600
10368	3504	100	121	12.971600
10369	3505	100	121	12.971600
10370	3506	100	121	12.971600
10371	3507	100	121	12.971600
10372	3508	100	121	12.971600
10373	3509	100	121	12.971600
10374	3510	100	121	12.971600
10375	3511	100	121	12.971600
10376	3512	100	121	12.971600
10377	3513	100	121	12.971600
10378	3514	100	121	12.971600
10379	3515	100	121	12.971600
10380	3516	100	121	12.971600
10381	3517	100	121	12.971600
10382	3518	100	121	12.971600
10383	3519	100	121	12.971600
10384	3520	100	121	12.971600
10385	3521	100	121	12.971600
10386	3522	100	121	12.971600
10387	3523	100	121	12.971600
10388	3524	100	121	12.971600
10389	3525	100	121	12.971600
10390	3526	100	121	12.971600
10391	3527	100	121	12.971600
10392	3528	100	121	12.971600
10393	3529	100	121	12.971600
10394	3530	100	121	12.971600
10395	3531	100	121	12.971600
10396	3532	100	121	12.971600
10397	3533	100	121	12.971600
10398	3534	100	121	12.971600
10399	3535	100	121	12.971600
10400	3536	100	121	12.971600
10401	3537	100	121	12.971600
10402	3538	100	121	12.971600
10403	3539	100	121	12.971600
10404	3540	100	121	12.971600
10405	3541	100	121	12.971600
10406	3542	100	121	12.971600
10407	3543	100	121	12.971600
10408	3544	100	121	12.971600
10409	3545	100	121	12.971600
10410	3546	100	121	12.971600
10411	3547	100	121	12.971600
10412	3548	100	121	12.971600
10413	3549	100	121	12.971600
10414	3550	100	121	12.971600
10415	3551	100	121	12.971600
10416	3552	100	121	12.971600
10417	3553	100	121	12.971600
10418	3554	100	121	12.971600
10419	3555	100	121	12.971600
10420	3556	100	121	12.971600
10421	3557	100	121	12.971600
10422	3558	100	121	12.971600
10423	3559	100	121	12.971600
10424	3560	100	121	12.971600
10425	3561	100	121	12.971600
10426	3562	100	121	12.971600
10427	3563	100	121	12.971600
10428	3564	100	121	12.971600
10429	3433	100	122	77.594600
10430	3434	100	122	77.594600
10431	3435	100	122	77.594600
10432	3436	100	122	77.594600
10433	3437	100	122	77.594600
10434	3438	100	122	77.594600
10435	3439	100	122	77.594600
10436	3440	100	122	77.594600
10437	3441	100	122	77.594600
10438	3442	100	122	77.594600
10439	3443	100	122	77.594600
10440	3444	100	122	77.594600
10441	3445	100	122	77.594600
10442	3446	100	122	77.594600
10443	3447	100	122	77.594600
10444	3448	100	122	77.594600
10445	3449	100	122	77.594600
10446	3450	100	122	77.594600
10447	3451	100	122	77.594600
10448	3452	100	122	77.594600
10449	3453	100	122	77.594600
10450	3454	100	122	77.594600
10451	3455	100	122	77.594600
10452	3456	100	122	77.594600
10453	3457	100	122	77.594600
10454	3458	100	122	77.594600
10455	3459	100	122	77.594600
10456	3460	100	122	77.594600
10457	3461	100	122	77.594600
10458	3462	100	122	77.594600
10459	3463	100	122	77.594600
10460	3464	100	122	77.594600
10461	3465	100	122	77.594600
10462	3466	100	122	77.594600
10463	3467	100	122	77.594600
10464	3468	100	122	77.594600
10465	3469	100	122	77.594600
10466	3470	100	122	77.594600
10467	3471	100	122	77.594600
10468	3472	100	122	77.594600
10469	3473	100	122	77.594600
10470	3474	100	122	77.594600
10471	3475	100	122	77.594600
10472	3476	100	122	77.594600
10473	3477	100	122	77.594600
10474	3478	100	122	77.594600
10475	3479	100	122	77.594600
10476	3480	100	122	77.594600
10477	3481	100	122	77.594600
10478	3482	100	122	77.594600
10479	3483	100	122	77.594600
10480	3484	100	122	77.594600
10481	3485	100	122	77.594600
10482	3486	100	122	77.594600
10483	3487	100	122	77.594600
10484	3488	100	122	77.594600
10485	3489	100	122	77.594600
10486	3490	100	122	77.594600
10487	3491	100	122	77.594600
10488	3492	100	122	77.594600
10489	3493	100	122	77.594600
10490	3494	100	122	77.594600
10491	3495	100	122	77.594600
10492	3496	100	122	77.594600
10493	3497	100	122	77.594600
10494	3498	100	122	77.594600
10495	3499	100	122	77.594600
10496	3500	100	122	77.594600
10497	3501	100	122	77.594600
10498	3502	100	122	77.594600
10499	3503	100	122	77.594600
10500	3504	100	122	77.594600
10501	3505	100	122	77.594600
10502	3506	100	122	77.594600
10503	3507	100	122	77.594600
10504	3508	100	122	77.594600
10505	3509	100	122	77.594600
10506	3510	100	122	77.594600
10507	3511	100	122	77.594600
10508	3512	100	122	77.594600
10509	3513	100	122	77.594600
10510	3514	100	122	77.594600
10511	3515	100	122	77.594600
10512	3516	100	122	77.594600
10513	3517	100	122	77.594600
10514	3518	100	122	77.594600
10515	3519	100	122	77.594600
10516	3520	100	122	77.594600
10517	3521	100	122	77.594600
10518	3522	100	122	77.594600
10519	3523	100	122	77.594600
10520	3524	100	122	77.594600
10521	3525	100	122	77.594600
10522	3526	100	122	77.594600
10523	3527	100	122	77.594600
10524	3528	100	122	77.594600
10525	3529	100	122	77.594600
10526	3530	100	122	77.594600
10527	3531	100	122	77.594600
10528	3532	100	122	77.594600
10529	3533	100	122	77.594600
10530	3534	100	122	77.594600
10531	3535	100	122	77.594600
10532	3536	100	122	77.594600
10533	3537	100	122	77.594600
10534	3538	100	122	77.594600
10535	3539	100	122	77.594600
10536	3540	100	122	77.594600
10537	3541	100	122	77.594600
10538	3542	100	122	77.594600
10539	3543	100	122	77.594600
10540	3544	100	122	77.594600
10541	3545	100	122	77.594600
10542	3546	100	122	77.594600
10543	3547	100	122	77.594600
10544	3548	100	122	77.594600
10545	3549	100	122	77.594600
10546	3550	100	122	77.594600
10547	3551	100	122	77.594600
10548	3552	100	122	77.594600
10549	3553	100	122	77.594600
10550	3554	100	122	77.594600
10551	3555	100	122	77.594600
10552	3556	100	122	77.594600
10553	3557	100	122	77.594600
10554	3558	100	122	77.594600
10555	3559	100	122	77.594600
10556	3560	100	122	77.594600
10557	3561	100	122	77.594600
10558	3562	100	122	77.594600
10559	3563	100	122	77.594600
10560	3564	100	122	77.594600
10561	3433	100	123	5.790000
10562	3434	100	123	6.670000
10563	3435	100	123	7.450000
10564	3436	100	123	7.580000
10565	3437	100	123	7.210000
10566	3438	100	123	5.880000
10567	3439	100	123	5.340000
10568	3440	100	123	5.460000
10569	3441	100	123	5.760000
10570	3442	100	123	5.430000
10571	3443	100	123	5.330000
10572	3444	100	123	5.280000
10573	3445	100	123	5.850000
10574	3446	100	123	6.630000
10575	3447	100	123	7.430000
10576	3448	100	123	7.580000
10577	3449	100	123	7.270000
10578	3450	100	123	5.920000
10579	3451	100	123	5.350000
10580	3452	100	123	5.490000
10581	3453	100	123	5.750000
10582	3454	100	123	5.420000
10583	3455	100	123	5.300000
10584	3456	100	123	5.280000
10585	3457	100	123	5.860000
10586	3458	100	123	6.670000
10587	3459	100	123	7.470000
10588	3460	100	123	7.550000
10589	3461	100	123	7.240000
10590	3462	100	123	5.920000
10591	3463	100	123	5.310000
10592	3464	100	123	5.460000
10593	3465	100	123	5.810000
10594	3466	100	123	5.470000
10595	3467	100	123	5.270000
10596	3468	100	123	5.280000
10597	3469	100	123	5.830000
10598	3470	100	123	6.700000
10599	3471	100	123	7.460000
10600	3472	100	123	7.600000
10601	3473	100	123	7.160000
10602	3474	100	123	5.910000
10603	3475	100	123	5.350000
10604	3476	100	123	5.470000
10605	3477	100	123	5.770000
10606	3478	100	123	5.420000
10607	3479	100	123	5.360000
10608	3480	100	123	5.350000
10609	3481	100	123	6.030000
10610	3482	100	123	6.870000
10611	3483	100	123	7.510000
10612	3484	100	123	7.550000
10613	3485	100	123	7.290000
10614	3486	100	123	5.780000
10615	3487	100	123	5.290000
10616	3488	100	123	5.360000
10617	3489	100	123	5.520000
10618	3490	100	123	5.450000
10619	3491	100	123	5.170000
10620	3492	100	123	5.070000
10621	3493	100	123	5.780000
10622	3494	100	123	6.820000
10623	3495	100	123	7.390000
10624	3496	100	123	7.500000
10625	3497	100	123	7.180000
10626	3498	100	123	6.020000
10627	3499	100	123	5.270000
10628	3500	100	123	5.420000
10629	3501	100	123	5.790000
10630	3502	100	123	5.690000
10631	3503	100	123	5.150000
10632	3504	100	123	5.150000
10633	3505	100	123	5.960000
10634	3506	100	123	6.810000
10635	3507	100	123	7.570000
10636	3508	100	123	7.720000
10637	3509	100	123	7.170000
10638	3510	100	123	5.890000
10639	3511	100	123	5.360000
10640	3512	100	123	5.430000
10641	3513	100	123	5.580000
10642	3514	100	123	5.390000
10643	3515	100	123	5.350000
10644	3516	100	123	5.170000
10645	3517	100	123	5.960000
10646	3518	100	123	6.730000
10647	3519	100	123	7.430000
10648	3520	100	123	7.650000
10649	3521	100	123	6.910000
10650	3522	100	123	5.910000
10651	3523	100	123	5.250000
10652	3524	100	123	5.500000
10653	3525	100	123	5.870000
10654	3526	100	123	5.460000
10655	3527	100	123	5.500000
10656	3528	100	123	5.210000
10657	3529	100	123	5.940000
10658	3530	100	123	6.460000
10659	3531	100	123	7.520000
10660	3532	100	123	7.610000
10661	3533	100	123	7.240000
10662	3534	100	123	5.580000
10663	3535	100	123	5.350000
10664	3536	100	123	5.440000
10665	3537	100	123	5.790000
10666	3538	100	123	5.400000
10667	3539	100	123	5.450000
10668	3540	100	123	5.320000
10669	3541	100	123	5.650000
10670	3542	100	123	6.810000
10671	3543	100	123	7.470000
10672	3544	100	123	7.510000
10673	3545	100	123	7.260000
10674	3546	100	123	5.610000
10675	3547	100	123	5.340000
10676	3548	100	123	5.380000
10677	3549	100	123	5.720000
10678	3550	100	123	5.390000
10679	3551	100	123	5.330000
10680	3552	100	123	5.150000
10681	3553	100	123	5.780000
10682	3554	100	123	6.640000
10683	3555	100	123	7.420000
10684	3556	100	123	7.710000
10685	3557	100	123	7.050000
10686	3558	100	123	5.730000
10687	3559	100	123	5.500000
10688	3560	100	123	5.500000
10689	3561	100	123	5.990000
10690	3562	100	123	5.470000
10691	3563	100	123	5.410000
10692	3564	100	123	5.350000
10693	3565	100	126	28.022900
10694	3566	100	126	28.022900
10695	3567	100	126	28.022900
10696	3568	100	126	28.022900
10697	3569	100	126	28.022900
10698	3570	100	126	28.022900
10699	3571	100	126	28.022900
10700	3572	100	126	28.022900
10701	3573	100	126	28.022900
10702	3574	100	126	28.022900
10703	3575	100	126	28.022900
10704	3576	100	126	28.022900
10705	3577	100	126	28.022900
10706	3578	100	126	28.022900
10707	3579	100	126	28.022900
10708	3580	100	126	28.022900
10709	3581	100	126	28.022900
10710	3582	100	126	28.022900
10711	3583	100	126	28.022900
10712	3584	100	126	28.022900
10713	3585	100	126	28.022900
10714	3586	100	126	28.022900
10715	3587	100	126	28.022900
10716	3588	100	126	28.022900
10717	3589	100	126	28.022900
10718	3590	100	126	28.022900
10719	3591	100	126	28.022900
10720	3592	100	126	28.022900
10721	3593	100	126	28.022900
10722	3594	100	126	28.022900
10723	3595	100	126	28.022900
10724	3596	100	126	28.022900
10725	3597	100	126	28.022900
10726	3598	100	126	28.022900
10727	3599	100	126	28.022900
10728	3600	100	126	28.022900
10729	3601	100	126	28.022900
10730	3602	100	126	28.022900
10731	3603	100	126	28.022900
10732	3604	100	126	28.022900
10733	3605	100	126	28.022900
10734	3606	100	126	28.022900
10735	3607	100	126	28.022900
10736	3608	100	126	28.022900
10737	3609	100	126	28.022900
10738	3610	100	126	28.022900
10739	3611	100	126	28.022900
10740	3612	100	126	28.022900
10741	3613	100	126	28.022900
10742	3614	100	126	28.022900
10743	3615	100	126	28.022900
10744	3616	100	126	28.022900
10745	3617	100	126	28.022900
10746	3618	100	126	28.022900
10747	3619	100	126	28.022900
10748	3620	100	126	28.022900
10749	3621	100	126	28.022900
10750	3622	100	126	28.022900
10751	3623	100	126	28.022900
10752	3624	100	126	28.022900
10753	3625	100	126	28.022900
10754	3626	100	126	28.022900
10755	3627	100	126	28.022900
10756	3628	100	126	28.022900
10757	3629	100	126	28.022900
10758	3630	100	126	28.022900
10759	3631	100	126	28.022900
10760	3632	100	126	28.022900
10761	3633	100	126	28.022900
10762	3634	100	126	28.022900
10763	3635	100	126	28.022900
10764	3636	100	126	28.022900
10765	3637	100	126	28.022900
10766	3638	100	126	28.022900
10767	3639	100	126	28.022900
10768	3640	100	126	28.022900
10769	3641	100	126	28.022900
10770	3642	100	126	28.022900
10771	3643	100	126	28.022900
10772	3644	100	126	28.022900
10773	3645	100	126	28.022900
10774	3646	100	126	28.022900
10775	3647	100	126	28.022900
10776	3648	100	126	28.022900
10777	3649	100	126	28.022900
10778	3650	100	126	28.022900
10779	3651	100	126	28.022900
10780	3652	100	126	28.022900
10781	3653	100	126	28.022900
10782	3654	100	126	28.022900
10783	3655	100	126	28.022900
10784	3656	100	126	28.022900
10785	3657	100	126	28.022900
10786	3658	100	126	28.022900
10787	3659	100	126	28.022900
10788	3660	100	126	28.022900
10789	3661	100	126	28.022900
10790	3662	100	126	28.022900
10791	3663	100	126	28.022900
10792	3664	100	126	28.022900
10793	3665	100	126	28.022900
10794	3666	100	126	28.022900
10795	3667	100	126	28.022900
10796	3668	100	126	28.022900
10797	3669	100	126	28.022900
10798	3670	100	126	28.022900
10799	3671	100	126	28.022900
10800	3672	100	126	28.022900
10801	3673	100	126	28.022900
10802	3674	100	126	28.022900
10803	3675	100	126	28.022900
10804	3676	100	126	28.022900
10805	3677	100	126	28.022900
10806	3678	100	126	28.022900
10807	3679	100	126	28.022900
10808	3680	100	126	28.022900
10809	3681	100	126	28.022900
10810	3682	100	126	28.022900
10811	3683	100	126	28.022900
10812	3684	100	126	28.022900
10813	3685	100	126	28.022900
10814	3686	100	126	28.022900
10815	3687	100	126	28.022900
10816	3688	100	126	28.022900
10817	3689	100	126	28.022900
10818	3690	100	126	28.022900
10819	3691	100	126	28.022900
10820	3692	100	126	28.022900
10821	3693	100	126	28.022900
10822	3694	100	126	28.022900
10823	3695	100	126	28.022900
10824	3696	100	126	28.022900
10825	3565	100	125	73.311900
10826	3566	100	125	73.311900
10827	3567	100	125	73.311900
10828	3568	100	125	73.311900
10829	3569	100	125	73.311900
10830	3570	100	125	73.311900
10831	3571	100	125	73.311900
10832	3572	100	125	73.311900
10833	3573	100	125	73.311900
10834	3574	100	125	73.311900
10835	3575	100	125	73.311900
10836	3576	100	125	73.311900
10837	3577	100	125	73.311900
10838	3578	100	125	73.311900
10839	3579	100	125	73.311900
10840	3580	100	125	73.311900
10841	3581	100	125	73.311900
10842	3582	100	125	73.311900
10843	3583	100	125	73.311900
10844	3584	100	125	73.311900
10845	3585	100	125	73.311900
10846	3586	100	125	73.311900
10847	3587	100	125	73.311900
10848	3588	100	125	73.311900
10849	3589	100	125	73.311900
10850	3590	100	125	73.311900
10851	3591	100	125	73.311900
10852	3592	100	125	73.311900
10853	3593	100	125	73.311900
10854	3594	100	125	73.311900
10855	3595	100	125	73.311900
10856	3596	100	125	73.311900
10857	3597	100	125	73.311900
10858	3598	100	125	73.311900
10859	3599	100	125	73.311900
10860	3600	100	125	73.311900
10861	3601	100	125	73.311900
10862	3602	100	125	73.311900
10863	3603	100	125	73.311900
10864	3604	100	125	73.311900
10865	3605	100	125	73.311900
10866	3606	100	125	73.311900
10867	3607	100	125	73.311900
10868	3608	100	125	73.311900
10869	3609	100	125	73.311900
10870	3610	100	125	73.311900
10871	3611	100	125	73.311900
10872	3612	100	125	73.311900
10873	3613	100	125	73.311900
10874	3614	100	125	73.311900
10875	3615	100	125	73.311900
10876	3616	100	125	73.311900
10877	3617	100	125	73.311900
10878	3618	100	125	73.311900
10879	3619	100	125	73.311900
10880	3620	100	125	73.311900
10881	3621	100	125	73.311900
10882	3622	100	125	73.311900
10883	3623	100	125	73.311900
10884	3624	100	125	73.311900
10885	3625	100	125	73.311900
10886	3626	100	125	73.311900
10887	3627	100	125	73.311900
10888	3628	100	125	73.311900
10889	3629	100	125	73.311900
10890	3630	100	125	73.311900
10891	3631	100	125	73.311900
10892	3632	100	125	73.311900
10893	3633	100	125	73.311900
10894	3634	100	125	73.311900
10895	3635	100	125	73.311900
10896	3636	100	125	73.311900
10897	3637	100	125	73.311900
10898	3638	100	125	73.311900
10899	3639	100	125	73.311900
10900	3640	100	125	73.311900
10901	3641	100	125	73.311900
10902	3642	100	125	73.311900
10903	3643	100	125	73.311900
10904	3644	100	125	73.311900
10905	3645	100	125	73.311900
10906	3646	100	125	73.311900
10907	3647	100	125	73.311900
10908	3648	100	125	73.311900
10909	3649	100	125	73.311900
10910	3650	100	125	73.311900
10911	3651	100	125	73.311900
10912	3652	100	125	73.311900
10913	3653	100	125	73.311900
10914	3654	100	125	73.311900
10915	3655	100	125	73.311900
10916	3656	100	125	73.311900
10917	3657	100	125	73.311900
10918	3658	100	125	73.311900
10919	3659	100	125	73.311900
10920	3660	100	125	73.311900
10921	3661	100	125	73.311900
10922	3662	100	125	73.311900
10923	3663	100	125	73.311900
10924	3664	100	125	73.311900
10925	3665	100	125	73.311900
10926	3666	100	125	73.311900
10927	3667	100	125	73.311900
10928	3668	100	125	73.311900
10929	3669	100	125	73.311900
10930	3670	100	125	73.311900
10931	3671	100	125	73.311900
10932	3672	100	125	73.311900
10933	3673	100	125	73.311900
10934	3674	100	125	73.311900
10935	3675	100	125	73.311900
10936	3676	100	125	73.311900
10937	3677	100	125	73.311900
10938	3678	100	125	73.311900
10939	3679	100	125	73.311900
10940	3680	100	125	73.311900
10941	3681	100	125	73.311900
10942	3682	100	125	73.311900
10943	3683	100	125	73.311900
10944	3684	100	125	73.311900
10945	3685	100	125	73.311900
10946	3686	100	125	73.311900
10947	3687	100	125	73.311900
10948	3688	100	125	73.311900
10949	3689	100	125	73.311900
10950	3690	100	125	73.311900
10951	3691	100	125	73.311900
10952	3692	100	125	73.311900
10953	3693	100	125	73.311900
10954	3694	100	125	73.311900
10955	3695	100	125	73.311900
10956	3696	100	125	73.311900
10957	3565	100	124	7.306000
10958	3566	100	124	7.445000
10959	3567	100	124	8.398000
10960	3568	100	124	10.149000
10961	3569	100	124	15.334000
10962	3570	100	124	25.992000
10963	3571	100	124	27.202000
10964	3572	100	124	27.897000
10965	3573	100	124	22.619000
10966	3574	100	124	13.089000
10967	3575	100	124	9.090000
10968	3576	100	124	8.657000
10969	3577	100	124	7.230000
10970	3578	100	124	8.410000
10971	3579	100	124	8.497000
10972	3580	100	124	10.461000
10973	3581	100	124	16.537000
10974	3582	100	124	23.083000
10975	3583	100	124	27.120000
10976	3584	100	124	27.921000
10977	3585	100	124	24.095000
10978	3586	100	124	13.833000
10979	3587	100	124	9.573000
10980	3588	100	124	8.909000
10981	3589	100	124	7.547000
10982	3590	100	124	7.873000
10983	3591	100	124	10.071000
10984	3592	100	124	10.018000
10985	3593	100	124	16.390000
10986	3594	100	124	24.618000
10987	3595	100	124	25.930000
10988	3596	100	124	28.020000
10989	3597	100	124	22.209000
10990	3598	100	124	13.084000
10991	3599	100	124	9.372000
10992	3600	100	124	8.257000
10993	3601	100	124	7.189000
10994	3602	100	124	8.007000
10995	3603	100	124	8.382000
10996	3604	100	124	10.986000
10997	3605	100	124	16.836000
10998	3606	100	124	25.622000
10999	3607	100	124	27.424000
11000	3608	100	124	28.165000
11001	3609	100	124	25.021000
11002	3610	100	124	13.898000
11003	3611	100	124	8.958000
11004	3612	100	124	8.274000
11005	3613	100	124	7.090000
11006	3614	100	124	8.106000
11007	3615	100	124	10.119000
11008	3616	100	124	11.076000
11009	3617	100	124	14.841000
11010	3618	100	124	22.244000
11011	3619	100	124	27.086000
11012	3620	100	124	27.911000
11013	3621	100	124	23.894000
11014	3622	100	124	13.092000
11015	3623	100	124	8.606000
11016	3624	100	124	7.543000
11017	3625	100	124	7.067000
11018	3626	100	124	7.730000
11019	3627	100	124	8.926000
11020	3628	100	124	9.675000
11021	3629	100	124	13.847000
11022	3630	100	124	21.206000
11023	3631	100	124	27.605000
11024	3632	100	124	27.760000
11025	3633	100	124	23.625000
11026	3634	100	124	11.272000
11027	3635	100	124	8.766000
11028	3636	100	124	7.153000
11029	3637	100	124	7.086000
11030	3638	100	124	7.756000
11031	3639	100	124	8.448000
11032	3640	100	124	11.489000
11033	3641	100	124	16.097000
11034	3642	100	124	23.275000
11035	3643	100	124	27.135000
11036	3644	100	124	29.638000
11037	3645	100	124	23.683000
11038	3646	100	124	13.090000
11039	3647	100	124	9.133000
11040	3648	100	124	8.208000
11041	3649	100	124	7.148000
11042	3650	100	124	7.983000
11043	3651	100	124	8.977000
11044	3652	100	124	11.785000
11045	3653	100	124	15.872000
11046	3654	100	124	22.077000
11047	3655	100	124	27.120000
11048	3656	100	124	27.759000
11049	3657	100	124	24.479000
11050	3658	100	124	14.017000
11051	3659	100	124	9.964000
11052	3660	100	124	8.340000
11053	3661	100	124	7.529000
11054	3662	100	124	7.672000
11055	3663	100	124	8.940000
11056	3664	100	124	12.435000
11057	3665	100	124	17.467000
11058	3666	100	124	23.221000
11059	3667	100	124	27.160000
11060	3668	100	124	27.748000
11061	3669	100	124	23.623000
11062	3670	100	124	13.724000
11063	3671	100	124	9.721000
11064	3672	100	124	8.465000
11065	3673	100	124	7.035000
11066	3674	100	124	7.381000
11067	3675	100	124	8.738000
11068	3676	100	124	10.578000
11069	3677	100	124	15.386000
11070	3678	100	124	21.878000
11071	3679	100	124	25.961000
11072	3680	100	124	27.743000
11073	3681	100	124	24.769000
11074	3682	100	124	14.175000
11075	3683	100	124	9.313000
11076	3684	100	124	8.431000
11077	3685	100	124	7.584000
11078	3686	100	124	8.015000
11079	3687	100	124	9.395000
11080	3688	100	124	11.778000
11081	3689	100	124	16.571000
11082	3690	100	124	24.374000
11083	3691	100	124	27.460000
11084	3692	100	124	29.622000
11085	3693	100	124	24.952000
11086	3694	100	124	13.132000
11087	3695	100	124	8.886000
11088	3696	100	124	8.276000
11089	3697	100	129	23.669300
11090	3698	100	129	23.669300
11091	3699	100	129	23.669300
11092	3700	100	129	23.669300
11093	3701	100	129	23.669300
11094	3702	100	129	23.669300
11095	3703	100	129	23.669300
11096	3704	100	129	23.669300
11097	3705	100	129	23.669300
11098	3706	100	129	23.669300
11099	3707	100	129	23.669300
11100	3708	100	129	23.669300
11101	3709	100	129	23.669300
11102	3710	100	129	23.669300
11103	3711	100	129	23.669300
11104	3712	100	129	23.669300
11105	3713	100	129	23.669300
11106	3714	100	129	23.669300
11107	3715	100	129	23.669300
11108	3716	100	129	23.669300
11109	3717	100	129	23.669300
11110	3718	100	129	23.669300
11111	3719	100	129	23.669300
11112	3720	100	129	23.669300
11113	3721	100	129	23.669300
11114	3722	100	129	23.669300
11115	3723	100	129	23.669300
11116	3724	100	129	23.669300
11117	3725	100	129	23.669300
11118	3726	100	129	23.669300
11119	3727	100	129	23.669300
11120	3728	100	129	23.669300
11121	3729	100	129	23.669300
11122	3730	100	129	23.669300
11123	3731	100	129	23.669300
11124	3732	100	129	23.669300
11125	3733	100	129	23.669300
11126	3734	100	129	23.669300
11127	3735	100	129	23.669300
11128	3736	100	129	23.669300
11129	3737	100	129	23.669300
11130	3738	100	129	23.669300
11131	3739	100	129	23.669300
11132	3740	100	129	23.669300
11133	3741	100	129	23.669300
11134	3742	100	129	23.669300
11135	3743	100	129	23.669300
11136	3744	100	129	23.669300
11137	3745	100	129	23.669300
11138	3746	100	129	23.669300
11139	3747	100	129	23.669300
11140	3748	100	129	23.669300
11141	3749	100	129	23.669300
11142	3750	100	129	23.669300
11143	3751	100	129	23.669300
11144	3752	100	129	23.669300
11145	3753	100	129	23.669300
11146	3754	100	129	23.669300
11147	3755	100	129	23.669300
11148	3756	100	129	23.669300
11149	3757	100	129	23.669300
11150	3758	100	129	23.669300
11151	3759	100	129	23.669300
11152	3760	100	129	23.669300
11153	3761	100	129	23.669300
11154	3762	100	129	23.669300
11155	3763	100	129	23.669300
11156	3764	100	129	23.669300
11157	3765	100	129	23.669300
11158	3766	100	129	23.669300
11159	3767	100	129	23.669300
11160	3768	100	129	23.669300
11161	3769	100	129	23.669300
11162	3770	100	129	23.669300
11163	3771	100	129	23.669300
11164	3772	100	129	23.669300
11165	3773	100	129	23.669300
11166	3774	100	129	23.669300
11167	3775	100	129	23.669300
11168	3776	100	129	23.669300
11169	3777	100	129	23.669300
11170	3778	100	129	23.669300
11171	3779	100	129	23.669300
11172	3780	100	129	23.669300
11173	3781	100	129	23.669300
11174	3782	100	129	23.669300
11175	3783	100	129	23.669300
11176	3784	100	129	23.669300
11177	3785	100	129	23.669300
11178	3786	100	129	23.669300
11179	3787	100	129	23.669300
11180	3788	100	129	23.669300
11181	3789	100	129	23.669300
11182	3790	100	129	23.669300
11183	3791	100	129	23.669300
11184	3792	100	129	23.669300
11185	3793	100	129	23.669300
11186	3794	100	129	23.669300
11187	3795	100	129	23.669300
11188	3796	100	129	23.669300
11189	3797	100	129	23.669300
11190	3798	100	129	23.669300
11191	3799	100	129	23.669300
11192	3800	100	129	23.669300
11193	3801	100	129	23.669300
11194	3802	100	129	23.669300
11195	3803	100	129	23.669300
11196	3804	100	129	23.669300
11197	3805	100	129	23.669300
11198	3806	100	129	23.669300
11199	3807	100	129	23.669300
11200	3808	100	129	23.669300
11201	3809	100	129	23.669300
11202	3810	100	129	23.669300
11203	3811	100	129	23.669300
11204	3812	100	129	23.669300
11205	3813	100	129	23.669300
11206	3814	100	129	23.669300
11207	3815	100	129	23.669300
11208	3816	100	129	23.669300
11209	3817	100	129	23.669300
11210	3818	100	129	23.669300
11211	3819	100	129	23.669300
11212	3820	100	129	23.669300
11213	3821	100	129	23.669300
11214	3822	100	129	23.669300
11215	3823	100	129	23.669300
11216	3824	100	129	23.669300
11217	3825	100	129	23.669300
11218	3826	100	129	23.669300
11219	3827	100	129	23.669300
11220	3828	100	129	23.669300
11221	3697	100	128	86.151100
11222	3698	100	128	86.151100
11223	3699	100	128	86.151100
11224	3700	100	128	86.151100
11225	3701	100	128	86.151100
11226	3702	100	128	86.151100
11227	3703	100	128	86.151100
11228	3704	100	128	86.151100
11229	3705	100	128	86.151100
11230	3706	100	128	86.151100
11231	3707	100	128	86.151100
11232	3708	100	128	86.151100
11233	3709	100	128	86.151100
11234	3710	100	128	86.151100
11235	3711	100	128	86.151100
11236	3712	100	128	86.151100
11237	3713	100	128	86.151100
11238	3714	100	128	86.151100
11239	3715	100	128	86.151100
11240	3716	100	128	86.151100
11241	3717	100	128	86.151100
11242	3718	100	128	86.151100
11243	3719	100	128	86.151100
11244	3720	100	128	86.151100
11245	3721	100	128	86.151100
11246	3722	100	128	86.151100
11247	3723	100	128	86.151100
11248	3724	100	128	86.151100
11249	3725	100	128	86.151100
11250	3726	100	128	86.151100
11251	3727	100	128	86.151100
11252	3728	100	128	86.151100
11253	3729	100	128	86.151100
11254	3730	100	128	86.151100
11255	3731	100	128	86.151100
11256	3732	100	128	86.151100
11257	3733	100	128	86.151100
11258	3734	100	128	86.151100
11259	3735	100	128	86.151100
11260	3736	100	128	86.151100
11261	3737	100	128	86.151100
11262	3738	100	128	86.151100
11263	3739	100	128	86.151100
11264	3740	100	128	86.151100
11265	3741	100	128	86.151100
11266	3742	100	128	86.151100
11267	3743	100	128	86.151100
11268	3744	100	128	86.151100
11269	3745	100	128	86.151100
11270	3746	100	128	86.151100
11271	3747	100	128	86.151100
11272	3748	100	128	86.151100
11273	3749	100	128	86.151100
11274	3750	100	128	86.151100
11275	3751	100	128	86.151100
11276	3752	100	128	86.151100
11277	3753	100	128	86.151100
11278	3754	100	128	86.151100
11279	3755	100	128	86.151100
11280	3756	100	128	86.151100
11281	3757	100	128	86.151100
11282	3758	100	128	86.151100
11283	3759	100	128	86.151100
11284	3760	100	128	86.151100
11285	3761	100	128	86.151100
11286	3762	100	128	86.151100
11287	3763	100	128	86.151100
11288	3764	100	128	86.151100
11289	3765	100	128	86.151100
11290	3766	100	128	86.151100
11291	3767	100	128	86.151100
11292	3768	100	128	86.151100
11293	3769	100	128	86.151100
11294	3770	100	128	86.151100
11295	3771	100	128	86.151100
11296	3772	100	128	86.151100
11297	3773	100	128	86.151100
11298	3774	100	128	86.151100
11299	3775	100	128	86.151100
11300	3776	100	128	86.151100
11301	3777	100	128	86.151100
11302	3778	100	128	86.151100
11303	3779	100	128	86.151100
11304	3780	100	128	86.151100
11305	3781	100	128	86.151100
11306	3782	100	128	86.151100
11307	3783	100	128	86.151100
11308	3784	100	128	86.151100
11309	3785	100	128	86.151100
11310	3786	100	128	86.151100
11311	3787	100	128	86.151100
11312	3788	100	128	86.151100
11313	3789	100	128	86.151100
11314	3790	100	128	86.151100
11315	3791	100	128	86.151100
11316	3792	100	128	86.151100
11317	3793	100	128	86.151100
11318	3794	100	128	86.151100
11319	3795	100	128	86.151100
11320	3796	100	128	86.151100
11321	3797	100	128	86.151100
11322	3798	100	128	86.151100
11323	3799	100	128	86.151100
11324	3800	100	128	86.151100
11325	3801	100	128	86.151100
11326	3802	100	128	86.151100
11327	3803	100	128	86.151100
11328	3804	100	128	86.151100
11329	3805	100	128	86.151100
11330	3806	100	128	86.151100
11331	3807	100	128	86.151100
11332	3808	100	128	86.151100
11333	3809	100	128	86.151100
11334	3810	100	128	86.151100
11335	3811	100	128	86.151100
11336	3812	100	128	86.151100
11337	3813	100	128	86.151100
11338	3814	100	128	86.151100
11339	3815	100	128	86.151100
11340	3816	100	128	86.151100
11341	3817	100	128	86.151100
11342	3818	100	128	86.151100
11343	3819	100	128	86.151100
11344	3820	100	128	86.151100
11345	3821	100	128	86.151100
11346	3822	100	128	86.151100
11347	3823	100	128	86.151100
11348	3824	100	128	86.151100
11349	3825	100	128	86.151100
11350	3826	100	128	86.151100
11351	3827	100	128	86.151100
11352	3828	100	128	86.151100
11353	3697	100	127	13.851000
11354	3698	100	127	15.065000
11355	3699	100	127	16.726000
11356	3700	100	127	20.537000
11357	3701	100	127	25.723000
11358	3702	100	127	30.726000
11359	3703	100	127	31.955000
11360	3704	100	127	31.505000
11361	3705	100	127	30.563000
11362	3706	100	127	24.734000
11363	3707	100	127	17.547000
11364	3708	100	127	14.437000
11365	3709	100	127	14.953000
11366	3710	100	127	15.991000
11367	3711	100	127	15.724000
11368	3712	100	127	18.285000
11369	3713	100	127	26.215000
11370	3714	100	127	30.808000
11371	3715	100	127	31.112000
11372	3716	100	127	31.559000
11373	3717	100	127	30.559000
11374	3718	100	127	25.573000
11375	3719	100	127	17.497000
11376	3720	100	127	14.236000
11377	3721	100	127	15.146000
11378	3722	100	127	15.602000
11379	3723	100	127	16.777000
11380	3724	100	127	19.686000
11381	3725	100	127	26.562000
11382	3726	100	127	30.575000
11383	3727	100	127	31.011000
11384	3728	100	127	31.461000
11385	3729	100	127	30.564000
11386	3730	100	127	24.582000
11387	3731	100	127	17.448000
11388	3732	100	127	14.236000
11389	3733	100	127	13.954000
11390	3734	100	127	16.247000
11391	3735	100	127	15.724000
11392	3736	100	127	20.248000
11393	3737	100	127	27.179000
11394	3738	100	127	32.932000
11395	3739	100	127	31.011000
11396	3740	100	127	31.511000
11397	3741	100	127	30.470000
11398	3742	100	127	24.884000
11399	3743	100	127	17.955000
11400	3744	100	127	14.581000
11401	3745	100	127	15.055000
11402	3746	100	127	15.501000
11403	3747	100	127	16.734000
11404	3748	100	127	19.586000
11405	3749	100	127	27.673000
11406	3750	100	127	30.477000
11407	3751	100	127	31.015000
11408	3752	100	127	31.607000
11409	3753	100	127	30.559000
11410	3754	100	127	24.686000
11411	3755	100	127	18.037000
11412	3756	100	127	14.437000
11413	3757	100	127	14.800000
11414	3758	100	127	14.959000
11415	3759	100	127	16.174000
11416	3760	100	127	18.524000
11417	3761	100	127	26.168000
11418	3762	100	127	30.987000
11419	3763	100	127	31.011000
11420	3764	100	127	31.555000
11421	3765	100	127	30.560000
11422	3766	100	127	24.442000
11423	3767	100	127	18.365000
11424	3768	100	127	15.235000
11425	3769	100	127	14.655000
11426	3770	100	127	16.101000
11427	3771	100	127	15.327000
11428	3772	100	127	20.089000
11429	3773	100	127	26.376000
11430	3774	100	127	33.861000
11431	3775	100	127	31.011000
11432	3776	100	127	31.555000
11433	3777	100	127	30.515000
11434	3778	100	127	27.089000
11435	3779	100	127	20.007000
11436	3780	100	127	14.527000
11437	3781	100	127	14.642000
11438	3782	100	127	16.658000
11439	3783	100	127	16.475000
11440	3784	100	127	21.406000
11441	3785	100	127	26.168000
11442	3786	100	127	30.477000
11443	3787	100	127	31.011000
11444	3788	100	127	31.559000
11445	3789	100	127	31.065000
11446	3790	100	127	24.632000
11447	3791	100	127	18.046000
11448	3792	100	127	16.228000
11449	3793	100	127	14.873000
11450	3794	100	127	16.558000
11451	3795	100	127	16.176000
11452	3796	100	127	19.783000
11453	3797	100	127	26.511000
11454	3798	100	127	30.280000
11455	3799	100	127	31.011000
11456	3800	100	127	31.555000
11457	3801	100	127	30.559000
11458	3802	100	127	24.683000
11459	3803	100	127	18.637000
11460	3804	100	127	14.329000
11461	3805	100	127	14.796000
11462	3806	100	127	15.847000
11463	3807	100	127	15.724000
11464	3808	100	127	19.634000
11465	3809	100	127	26.266000
11466	3810	100	127	29.627000
11467	3811	100	127	31.421000
11468	3812	100	127	31.559000
11469	3813	100	127	30.619000
11470	3814	100	127	26.126000
11471	3815	100	127	19.815000
11472	3816	100	127	14.329000
11473	3817	100	127	14.802000
11474	3818	100	127	16.351000
11475	3819	100	127	15.724000
11476	3820	100	127	19.636000
11477	3821	100	127	26.069000
11478	3822	100	127	30.476000
11479	3823	100	127	32.544000
11480	3824	100	127	31.607000
11481	3825	100	127	30.564000
11482	3826	100	127	24.634000
11483	3827	100	127	17.650000
11484	3828	100	127	14.329000
11485	3829	100	132	30.733300
11486	3830	100	132	30.733300
11487	3831	100	132	30.733300
11488	3832	100	132	30.733300
11489	3833	100	132	30.733300
11490	3834	100	132	30.733300
11491	3835	100	132	30.733300
11492	3836	100	132	30.733300
11493	3837	100	132	30.733300
11494	3838	100	132	30.733300
11495	3839	100	132	30.733300
11496	3840	100	132	30.733300
11497	3841	100	132	30.733300
11498	3842	100	132	30.733300
11499	3843	100	132	30.733300
11500	3844	100	132	30.733300
11501	3845	100	132	30.733300
11502	3846	100	132	30.733300
11503	3847	100	132	30.733300
11504	3848	100	132	30.733300
11505	3849	100	132	30.733300
11506	3850	100	132	30.733300
11507	3851	100	132	30.733300
11508	3852	100	132	30.733300
11509	3853	100	132	30.733300
11510	3854	100	132	30.733300
11511	3855	100	132	30.733300
11512	3856	100	132	30.733300
11513	3857	100	132	30.733300
11514	3858	100	132	30.733300
11515	3859	100	132	30.733300
11516	3860	100	132	30.733300
11517	3861	100	132	30.733300
11518	3862	100	132	30.733300
11519	3863	100	132	30.733300
11520	3864	100	132	30.733300
11521	3865	100	132	30.733300
11522	3866	100	132	30.733300
11523	3867	100	132	30.733300
11524	3868	100	132	30.733300
11525	3869	100	132	30.733300
11526	3870	100	132	30.733300
11527	3871	100	132	30.733300
11528	3872	100	132	30.733300
11529	3873	100	132	30.733300
11530	3874	100	132	30.733300
11531	3875	100	132	30.733300
11532	3876	100	132	30.733300
11533	3877	100	132	30.733300
11534	3878	100	132	30.733300
11535	3879	100	132	30.733300
11536	3880	100	132	30.733300
11537	3881	100	132	30.733300
11538	3882	100	132	30.733300
11539	3883	100	132	30.733300
11540	3884	100	132	30.733300
11541	3885	100	132	30.733300
11542	3886	100	132	30.733300
11543	3887	100	132	30.733300
11544	3888	100	132	30.733300
11545	3889	100	132	30.733300
11546	3890	100	132	30.733300
11547	3891	100	132	30.733300
11548	3892	100	132	30.733300
11549	3893	100	132	30.733300
11550	3894	100	132	30.733300
11551	3895	100	132	30.733300
11552	3896	100	132	30.733300
11553	3897	100	132	30.733300
11554	3898	100	132	30.733300
11555	3899	100	132	30.733300
11556	3900	100	132	30.733300
11557	3901	100	132	30.733300
11558	3902	100	132	30.733300
11559	3903	100	132	30.733300
11560	3904	100	132	30.733300
11561	3905	100	132	30.733300
11562	3906	100	132	30.733300
11563	3907	100	132	30.733300
11564	3908	100	132	30.733300
11565	3909	100	132	30.733300
11566	3910	100	132	30.733300
11567	3911	100	132	30.733300
11568	3912	100	132	30.733300
11569	3913	100	132	30.733300
11570	3914	100	132	30.733300
11571	3915	100	132	30.733300
11572	3916	100	132	30.733300
11573	3917	100	132	30.733300
11574	3918	100	132	30.733300
11575	3919	100	132	30.733300
11576	3920	100	132	30.733300
11577	3921	100	132	30.733300
11578	3922	100	132	30.733300
11579	3923	100	132	30.733300
11580	3924	100	132	30.733300
11581	3925	100	132	30.733300
11582	3926	100	132	30.733300
11583	3927	100	132	30.733300
11584	3928	100	132	30.733300
11585	3929	100	132	30.733300
11586	3930	100	132	30.733300
11587	3931	100	132	30.733300
11588	3932	100	132	30.733300
11589	3933	100	132	30.733300
11590	3934	100	132	30.733300
11591	3935	100	132	30.733300
11592	3936	100	132	30.733300
11593	3937	100	132	30.733300
11594	3938	100	132	30.733300
11595	3939	100	132	30.733300
11596	3940	100	132	30.733300
11597	3941	100	132	30.733300
11598	3942	100	132	30.733300
11599	3943	100	132	30.733300
11600	3944	100	132	30.733300
11601	3945	100	132	30.733300
11602	3946	100	132	30.733300
11603	3947	100	132	30.733300
11604	3948	100	132	30.733300
11605	3949	100	132	30.733300
11606	3950	100	132	30.733300
11607	3951	100	132	30.733300
11608	3952	100	132	30.733300
11609	3953	100	132	30.733300
11610	3954	100	132	30.733300
11611	3955	100	132	30.733300
11612	3956	100	132	30.733300
11613	3957	100	132	30.733300
11614	3958	100	132	30.733300
11615	3959	100	132	30.733300
11616	3960	100	132	30.733300
11617	3829	100	131	76.779400
11618	3830	100	131	76.779400
11619	3831	100	131	76.779400
11620	3832	100	131	76.779400
11621	3833	100	131	76.779400
11622	3834	100	131	76.779400
11623	3835	100	131	76.779400
11624	3836	100	131	76.779400
11625	3837	100	131	76.779400
11626	3838	100	131	76.779400
11627	3839	100	131	76.779400
11628	3840	100	131	76.779400
11629	3841	100	131	76.779400
11630	3842	100	131	76.779400
11631	3843	100	131	76.779400
11632	3844	100	131	76.779400
11633	3845	100	131	76.779400
11634	3846	100	131	76.779400
11635	3847	100	131	76.779400
11636	3848	100	131	76.779400
11637	3849	100	131	76.779400
11638	3850	100	131	76.779400
11639	3851	100	131	76.779400
11640	3852	100	131	76.779400
11641	3853	100	131	76.779400
11642	3854	100	131	76.779400
11643	3855	100	131	76.779400
11644	3856	100	131	76.779400
11645	3857	100	131	76.779400
11646	3858	100	131	76.779400
11647	3859	100	131	76.779400
11648	3860	100	131	76.779400
11649	3861	100	131	76.779400
11650	3862	100	131	76.779400
11651	3863	100	131	76.779400
11652	3864	100	131	76.779400
11653	3865	100	131	76.779400
11654	3866	100	131	76.779400
11655	3867	100	131	76.779400
11656	3868	100	131	76.779400
11657	3869	100	131	76.779400
11658	3870	100	131	76.779400
11659	3871	100	131	76.779400
11660	3872	100	131	76.779400
11661	3873	100	131	76.779400
11662	3874	100	131	76.779400
11663	3875	100	131	76.779400
11664	3876	100	131	76.779400
11665	3877	100	131	76.779400
11666	3878	100	131	76.779400
11667	3879	100	131	76.779400
11668	3880	100	131	76.779400
11669	3881	100	131	76.779400
11670	3882	100	131	76.779400
11671	3883	100	131	76.779400
11672	3884	100	131	76.779400
11673	3885	100	131	76.779400
11674	3886	100	131	76.779400
11675	3887	100	131	76.779400
11676	3888	100	131	76.779400
11677	3889	100	131	76.779400
11678	3890	100	131	76.779400
11679	3891	100	131	76.779400
11680	3892	100	131	76.779400
11681	3893	100	131	76.779400
11682	3894	100	131	76.779400
11683	3895	100	131	76.779400
11684	3896	100	131	76.779400
11685	3897	100	131	76.779400
11686	3898	100	131	76.779400
11687	3899	100	131	76.779400
11688	3900	100	131	76.779400
11689	3901	100	131	76.779400
11690	3902	100	131	76.779400
11691	3903	100	131	76.779400
11692	3904	100	131	76.779400
11693	3905	100	131	76.779400
11694	3906	100	131	76.779400
11695	3907	100	131	76.779400
11696	3908	100	131	76.779400
11697	3909	100	131	76.779400
11698	3910	100	131	76.779400
11699	3911	100	131	76.779400
11700	3912	100	131	76.779400
11701	3913	100	131	76.779400
11702	3914	100	131	76.779400
11703	3915	100	131	76.779400
11704	3916	100	131	76.779400
11705	3917	100	131	76.779400
11706	3918	100	131	76.779400
11707	3919	100	131	76.779400
11708	3920	100	131	76.779400
11709	3921	100	131	76.779400
11710	3922	100	131	76.779400
11711	3923	100	131	76.779400
11712	3924	100	131	76.779400
11713	3925	100	131	76.779400
11714	3926	100	131	76.779400
11715	3927	100	131	76.779400
11716	3928	100	131	76.779400
11717	3929	100	131	76.779400
11718	3930	100	131	76.779400
11719	3931	100	131	76.779400
11720	3932	100	131	76.779400
11721	3933	100	131	76.779400
11722	3934	100	131	76.779400
11723	3935	100	131	76.779400
11724	3936	100	131	76.779400
11725	3937	100	131	76.779400
11726	3938	100	131	76.779400
11727	3939	100	131	76.779400
11728	3940	100	131	76.779400
11729	3941	100	131	76.779400
11730	3942	100	131	76.779400
11731	3943	100	131	76.779400
11732	3944	100	131	76.779400
11733	3945	100	131	76.779400
11734	3946	100	131	76.779400
11735	3947	100	131	76.779400
11736	3948	100	131	76.779400
11737	3949	100	131	76.779400
11738	3950	100	131	76.779400
11739	3951	100	131	76.779400
11740	3952	100	131	76.779400
11741	3953	100	131	76.779400
11742	3954	100	131	76.779400
11743	3955	100	131	76.779400
11744	3956	100	131	76.779400
11745	3957	100	131	76.779400
11746	3958	100	131	76.779400
11747	3959	100	131	76.779400
11748	3960	100	131	76.779400
11749	3829	100	130	9.900000
11750	3830	100	130	10.000000
11751	3831	100	130	11.700000
11752	3832	100	130	12.400000
11753	3833	100	130	15.000000
11754	3834	100	130	24.100000
11755	3835	100	130	30.200000
11756	3836	100	130	31.000000
11757	3837	100	130	26.700000
11758	3838	100	130	16.800000
11759	3839	100	130	12.000000
11760	3840	100	130	10.700000
11761	3841	100	130	9.700000
11762	3842	100	130	11.700000
11763	3843	100	130	10.800000
11764	3844	100	130	12.100000
11765	3845	100	130	15.900000
11766	3846	100	130	23.600000
11767	3847	100	130	30.100000
11768	3848	100	130	30.900000
11769	3849	100	130	25.600000
11770	3850	100	130	16.800000
11771	3851	100	130	12.100000
11772	3852	100	130	11.100000
11773	3853	100	130	10.300000
11774	3854	100	130	10.600000
11775	3855	100	130	12.300000
11776	3856	100	130	12.400000
11777	3857	100	130	16.500000
11778	3858	100	130	25.000000
11779	3859	100	130	30.200000
11780	3860	100	130	31.200000
11781	3861	100	130	25.900000
11782	3862	100	130	16.900000
11783	3863	100	130	12.000000
11784	3864	100	130	10.700000
11785	3865	100	130	9.500000
11786	3866	100	130	10.500000
11787	3867	100	130	11.600000
11788	3868	100	130	13.100000
11789	3869	100	130	17.100000
11790	3870	100	130	26.000000
11791	3871	100	130	30.600000
11792	3872	100	130	30.600000
11793	3873	100	130	27.000000
11794	3874	100	130	17.000000
11795	3875	100	130	11.900000
11796	3876	100	130	10.600000
11797	3877	100	130	9.600000
11798	3878	100	130	10.500000
11799	3879	100	130	12.300000
11800	3880	100	130	13.300000
11801	3881	100	130	15.500000
11802	3882	100	130	23.900000
11803	3883	100	130	29.500000
11804	3884	100	130	30.500000
11805	3885	100	130	26.500000
11806	3886	100	130	16.900000
11807	3887	100	130	12.000000
11808	3888	100	130	10.200000
11809	3889	100	130	9.900000
11810	3890	100	130	10.500000
11811	3891	100	130	11.700000
11812	3892	100	130	11.900000
11813	3893	100	130	14.700000
11814	3894	100	130	21.500000
11815	3895	100	130	30.100000
11816	3896	100	130	31.000000
11817	3897	100	130	25.900000
11818	3898	100	130	15.700000
11819	3899	100	130	11.800000
11820	3900	100	130	9.900000
11821	3901	100	130	8.600000
11822	3902	100	130	10.700000
11823	3903	100	130	11.100000
11824	3904	100	130	13.100000
11825	3905	100	130	17.100000
11826	3906	100	130	23.600000
11827	3907	100	130	30.200000
11828	3908	100	130	32.000000
11829	3909	100	130	25.900000
11830	3910	100	130	16.900000
11831	3911	100	130	12.000000
11832	3912	100	130	11.000000
11833	3913	100	130	9.800000
11834	3914	100	130	12.100000
11835	3915	100	130	12.400000
11836	3916	100	130	16.100000
11837	3917	100	130	16.600000
11838	3918	100	130	23.300000
11839	3919	100	130	30.600000
11840	3920	100	130	31.800000
11841	3921	100	130	26.200000
11842	3922	100	130	17.600000
11843	3923	100	130	12.600000
11844	3924	100	130	11.100000
11845	3925	100	130	10.400000
11846	3926	100	130	10.400000
11847	3927	100	130	11.700000
11848	3928	100	130	14.100000
11849	3929	100	130	17.200000
11850	3930	100	130	23.000000
11851	3931	100	130	30.200000
11852	3932	100	130	31.100000
11853	3933	100	130	26.000000
11854	3934	100	130	17.700000
11855	3935	100	130	12.900000
11856	3936	100	130	11.700000
11857	3937	100	130	9.800000
11858	3938	100	130	10.400000
11859	3939	100	130	11.800000
11860	3940	100	130	13.000000
11861	3941	100	130	15.800000
11862	3942	100	130	21.400000
11863	3943	100	130	30.400000
11864	3944	100	130	31.100000
11865	3945	100	130	27.000000
11866	3946	100	130	17.600000
11867	3947	100	130	12.300000
11868	3948	100	130	10.900000
11869	3949	100	130	10.000000
11870	3950	100	130	10.700000
11871	3951	100	130	12.300000
11872	3952	100	130	14.000000
11873	3953	100	130	16.600000
11874	3954	100	130	23.700000
11875	3955	100	130	30.900000
11876	3956	100	130	32.200000
11877	3957	100	130	24.600000
11878	3958	100	130	17.000000
11879	3959	100	130	12.000000
11880	3960	100	130	11.100000
11881	3961	100	135	13.082700
11882	3962	100	135	13.082700
11883	3963	100	135	13.082700
11884	3964	100	135	13.082700
11885	3965	100	135	13.082700
11886	3966	100	135	13.082700
11887	3967	100	135	13.082700
11888	3968	100	135	13.082700
11889	3969	100	135	13.082700
11890	3970	100	135	13.082700
11891	3971	100	135	13.082700
11892	3972	100	135	13.082700
11893	3973	100	135	13.082700
11894	3974	100	135	13.082700
11895	3975	100	135	13.082700
11896	3976	100	135	13.082700
11897	3977	100	135	13.082700
11898	3978	100	135	13.082700
11899	3979	100	135	13.082700
11900	3980	100	135	13.082700
11901	3981	100	135	13.082700
11902	3982	100	135	13.082700
11903	3983	100	135	13.082700
11904	3984	100	135	13.082700
11905	3985	100	135	13.082700
11906	3986	100	135	13.082700
11907	3987	100	135	13.082700
11908	3988	100	135	13.082700
11909	3989	100	135	13.082700
11910	3990	100	135	13.082700
11911	3991	100	135	13.082700
11912	3992	100	135	13.082700
11913	3993	100	135	13.082700
11914	3994	100	135	13.082700
11915	3995	100	135	13.082700
11916	3996	100	135	13.082700
11917	3997	100	135	13.082700
11918	3998	100	135	13.082700
11919	3999	100	135	13.082700
11920	4000	100	135	13.082700
11921	4001	100	135	13.082700
11922	4002	100	135	13.082700
11923	4003	100	135	13.082700
11924	4004	100	135	13.082700
11925	4005	100	135	13.082700
11926	4006	100	135	13.082700
11927	4007	100	135	13.082700
11928	4008	100	135	13.082700
11929	4009	100	135	13.082700
11930	4010	100	135	13.082700
11931	4011	100	135	13.082700
11932	4012	100	135	13.082700
11933	4013	100	135	13.082700
11934	4014	100	135	13.082700
11935	4015	100	135	13.082700
11936	4016	100	135	13.082700
11937	4017	100	135	13.082700
11938	4018	100	135	13.082700
11939	4019	100	135	13.082700
11940	4020	100	135	13.082700
11941	4021	100	135	13.082700
11942	4022	100	135	13.082700
11943	4023	100	135	13.082700
11944	4024	100	135	13.082700
11945	4025	100	135	13.082700
11946	4026	100	135	13.082700
11947	4027	100	135	13.082700
11948	4028	100	135	13.082700
11949	4029	100	135	13.082700
11950	4030	100	135	13.082700
11951	4031	100	135	13.082700
11952	4032	100	135	13.082700
11953	4033	100	135	13.082700
11954	4034	100	135	13.082700
11955	4035	100	135	13.082700
11956	4036	100	135	13.082700
11957	4037	100	135	13.082700
11958	4038	100	135	13.082700
11959	4039	100	135	13.082700
11960	4040	100	135	13.082700
11961	4041	100	135	13.082700
11962	4042	100	135	13.082700
11963	4043	100	135	13.082700
11964	4044	100	135	13.082700
11965	4045	100	135	13.082700
11966	4046	100	135	13.082700
11967	4047	100	135	13.082700
11968	4048	100	135	13.082700
11969	4049	100	135	13.082700
11970	4050	100	135	13.082700
11971	4051	100	135	13.082700
11972	4052	100	135	13.082700
11973	4053	100	135	13.082700
11974	4054	100	135	13.082700
11975	4055	100	135	13.082700
11976	4056	100	135	13.082700
11977	4057	100	135	13.082700
11978	4058	100	135	13.082700
11979	4059	100	135	13.082700
11980	4060	100	135	13.082700
11981	4061	100	135	13.082700
11982	4062	100	135	13.082700
11983	4063	100	135	13.082700
11984	4064	100	135	13.082700
11985	4065	100	135	13.082700
11986	4066	100	135	13.082700
11987	4067	100	135	13.082700
11988	4068	100	135	13.082700
11989	4069	100	135	13.082700
11990	4070	100	135	13.082700
11991	4071	100	135	13.082700
11992	4072	100	135	13.082700
11993	4073	100	135	13.082700
11994	4074	100	135	13.082700
11995	4075	100	135	13.082700
11996	4076	100	135	13.082700
11997	4077	100	135	13.082700
11998	4078	100	135	13.082700
11999	4079	100	135	13.082700
12000	4080	100	135	13.082700
12001	4081	100	135	13.082700
12002	4082	100	135	13.082700
12003	4083	100	135	13.082700
12004	4084	100	135	13.082700
12005	4085	100	135	13.082700
12006	4086	100	135	13.082700
12007	4087	100	135	13.082700
12008	4088	100	135	13.082700
12009	4089	100	135	13.082700
12010	4090	100	135	13.082700
12011	4091	100	135	13.082700
12012	4092	100	135	13.082700
12013	3961	100	134	80.270700
12014	3962	100	134	80.270700
12015	3963	100	134	80.270700
12016	3964	100	134	80.270700
12017	3965	100	134	80.270700
12018	3966	100	134	80.270700
12019	3967	100	134	80.270700
12020	3968	100	134	80.270700
12021	3969	100	134	80.270700
12022	3970	100	134	80.270700
12023	3971	100	134	80.270700
12024	3972	100	134	80.270700
12025	3973	100	134	80.270700
12026	3974	100	134	80.270700
12027	3975	100	134	80.270700
12028	3976	100	134	80.270700
12029	3977	100	134	80.270700
12030	3978	100	134	80.270700
12031	3979	100	134	80.270700
12032	3980	100	134	80.270700
12033	3981	100	134	80.270700
12034	3982	100	134	80.270700
12035	3983	100	134	80.270700
12036	3984	100	134	80.270700
12037	3985	100	134	80.270700
12038	3986	100	134	80.270700
12039	3987	100	134	80.270700
12040	3988	100	134	80.270700
12041	3989	100	134	80.270700
12042	3990	100	134	80.270700
12043	3991	100	134	80.270700
12044	3992	100	134	80.270700
12045	3993	100	134	80.270700
12046	3994	100	134	80.270700
12047	3995	100	134	80.270700
12048	3996	100	134	80.270700
12049	3997	100	134	80.270700
12050	3998	100	134	80.270700
12051	3999	100	134	80.270700
12052	4000	100	134	80.270700
12053	4001	100	134	80.270700
12054	4002	100	134	80.270700
12055	4003	100	134	80.270700
12056	4004	100	134	80.270700
12057	4005	100	134	80.270700
12058	4006	100	134	80.270700
12059	4007	100	134	80.270700
12060	4008	100	134	80.270700
12061	4009	100	134	80.270700
12062	4010	100	134	80.270700
12063	4011	100	134	80.270700
12064	4012	100	134	80.270700
12065	4013	100	134	80.270700
12066	4014	100	134	80.270700
12067	4015	100	134	80.270700
12068	4016	100	134	80.270700
12069	4017	100	134	80.270700
12070	4018	100	134	80.270700
12071	4019	100	134	80.270700
12072	4020	100	134	80.270700
12073	4021	100	134	80.270700
12074	4022	100	134	80.270700
12075	4023	100	134	80.270700
12076	4024	100	134	80.270700
12077	4025	100	134	80.270700
12078	4026	100	134	80.270700
12079	4027	100	134	80.270700
12080	4028	100	134	80.270700
12081	4029	100	134	80.270700
12082	4030	100	134	80.270700
12083	4031	100	134	80.270700
12084	4032	100	134	80.270700
12085	4033	100	134	80.270700
12086	4034	100	134	80.270700
12087	4035	100	134	80.270700
12088	4036	100	134	80.270700
12089	4037	100	134	80.270700
12090	4038	100	134	80.270700
12091	4039	100	134	80.270700
12092	4040	100	134	80.270700
12093	4041	100	134	80.270700
12094	4042	100	134	80.270700
12095	4043	100	134	80.270700
12096	4044	100	134	80.270700
12097	4045	100	134	80.270700
12098	4046	100	134	80.270700
12099	4047	100	134	80.270700
12100	4048	100	134	80.270700
12101	4049	100	134	80.270700
12102	4050	100	134	80.270700
12103	4051	100	134	80.270700
12104	4052	100	134	80.270700
12105	4053	100	134	80.270700
12106	4054	100	134	80.270700
12107	4055	100	134	80.270700
12108	4056	100	134	80.270700
12109	4057	100	134	80.270700
12110	4058	100	134	80.270700
12111	4059	100	134	80.270700
12112	4060	100	134	80.270700
12113	4061	100	134	80.270700
12114	4062	100	134	80.270700
12115	4063	100	134	80.270700
12116	4064	100	134	80.270700
12117	4065	100	134	80.270700
12118	4066	100	134	80.270700
12119	4067	100	134	80.270700
12120	4068	100	134	80.270700
12121	4069	100	134	80.270700
12122	4070	100	134	80.270700
12123	4071	100	134	80.270700
12124	4072	100	134	80.270700
12125	4073	100	134	80.270700
12126	4074	100	134	80.270700
12127	4075	100	134	80.270700
12128	4076	100	134	80.270700
12129	4077	100	134	80.270700
12130	4078	100	134	80.270700
12131	4079	100	134	80.270700
12132	4080	100	134	80.270700
12133	4081	100	134	80.270700
12134	4082	100	134	80.270700
12135	4083	100	134	80.270700
12136	4084	100	134	80.270700
12137	4085	100	134	80.270700
12138	4086	100	134	80.270700
12139	4087	100	134	80.270700
12140	4088	100	134	80.270700
12141	4089	100	134	80.270700
12142	4090	100	134	80.270700
12143	4091	100	134	80.270700
12144	4092	100	134	80.270700
12145	3961	100	133	22.470000
12146	3962	100	133	23.170000
12147	3963	100	133	25.470000
12148	3964	100	133	29.547000
12149	3965	100	133	31.047000
12150	3966	100	133	28.347000
12151	3967	100	133	27.724000
12152	3968	100	133	28.159000
12153	3969	100	133	29.047000
12154	3970	100	133	28.536000
12155	3971	100	133	25.770000
12156	3972	100	133	23.870000
12157	3973	100	133	22.470000
12158	3974	100	133	23.170000
12159	3975	100	133	25.470000
12160	3976	100	133	29.547000
12161	3977	100	133	31.047000
12162	3978	100	133	28.347000
12163	3979	100	133	27.635000
12164	3980	100	133	28.159000
12165	3981	100	133	29.047000
12166	3982	100	133	28.536000
12167	3983	100	133	26.494000
12168	3984	100	133	23.870000
12169	3985	100	133	22.470000
12170	3986	100	133	23.170000
12171	3987	100	133	25.470000
12172	3988	100	133	29.547000
12173	3989	100	133	31.635000
12174	3990	100	133	28.247000
12175	3991	100	133	27.635000
12176	3992	100	133	28.159000
12177	3993	100	133	30.235000
12178	3994	100	133	28.447000
12179	3995	100	133	25.682000
12180	3996	100	133	23.870000
12181	3997	100	133	22.470000
12182	3998	100	133	23.170000
12183	3999	100	133	25.470000
12184	4000	100	133	29.547000
12185	4001	100	133	30.118000
12186	4002	100	133	29.200000
12187	4003	100	133	27.635000
12188	4004	100	133	28.159000
12189	4005	100	133	29.047000
12190	4006	100	133	28.536000
12191	4007	100	133	27.282000
12192	4008	100	133	23.870000
12193	4009	100	133	22.559000
12194	4010	100	133	23.170000
12195	4011	100	133	25.505000
12196	4012	100	133	29.547000
12197	4013	100	133	32.247000
12198	4014	100	133	27.724000
12199	4015	100	133	27.635000
12200	4016	100	133	28.159000
12201	4017	100	133	29.047000
12202	4018	100	133	28.536000
12203	4019	100	133	25.682000
12204	4020	100	133	23.870000
12205	4021	100	133	22.458000
12206	4022	100	133	22.971000
12207	4023	100	133	25.470000
12208	4024	100	133	29.547000
12209	4025	100	133	31.047000
12210	4026	100	133	29.447000
12211	4027	100	133	29.335000
12212	4028	100	133	28.159000
12213	4029	100	133	29.047000
12214	4030	100	133	28.435000
12215	4031	100	133	26.671000
12216	4032	100	133	24.359000
12217	4033	100	133	24.047000
12218	4034	100	133	24.682000
12219	4035	100	133	27.094000
12220	4036	100	133	29.547000
12221	4037	100	133	32.236000
12222	4038	100	133	30.047000
12223	4039	100	133	27.635000
12224	4040	100	133	28.070000
12225	4041	100	133	29.047000
12226	4042	100	133	28.835000
12227	4043	100	133	26.982000
12228	4044	100	133	23.870000
12229	4045	100	133	22.470000
12230	4046	100	133	23.470000
12231	4047	100	133	26.993000
12232	4048	100	133	29.547000
12233	4049	100	133	31.047000
12234	4050	100	133	28.347000
12235	4051	100	133	27.635000
12236	4052	100	133	28.159000
12237	4053	100	133	29.047000
12238	4054	100	133	28.536000
12239	4055	100	133	25.682000
12240	4056	100	133	23.870000
12241	4057	100	133	23.593000
12242	4058	100	133	24.383000
12243	4059	100	133	25.470000
12244	4060	100	133	29.547000
12245	4061	100	133	31.047000
12246	4062	100	133	27.859000
12247	4063	100	133	27.635000
12248	4064	100	133	28.159000
12249	4065	100	133	29.047000
12250	4066	100	133	28.700000
12251	4067	100	133	26.170000
12252	4068	100	133	23.870000
12253	4069	100	133	23.459000
12254	4070	100	133	24.059000
12255	4071	100	133	26.905000
12256	4072	100	133	29.547000
12257	4073	100	133	32.059000
12258	4074	100	133	28.347000
12259	4075	100	133	28.347000
12260	4076	100	133	28.159000
12261	4077	100	133	29.423000
12262	4078	100	133	28.536000
12263	4079	100	133	26.359000
12264	4080	100	133	23.870000
12265	4081	100	133	23.782000
12266	4082	100	133	23.470000
12267	4083	100	133	25.794000
12268	4084	100	133	29.547000
12269	4085	100	133	31.889000
12270	4086	100	133	28.247000
12271	4087	100	133	29.335000
12272	4088	100	133	28.159000
12273	4089	100	133	30.847000
12274	4090	100	133	28.435000
12275	4091	100	133	25.682000
12276	4092	100	133	23.870000
12277	4093	100	138	20.180900
12278	4094	100	138	20.180900
12279	4095	100	138	20.180900
12280	4096	100	138	20.180900
12281	4097	100	138	20.180900
12282	4098	100	138	20.180900
12283	4099	100	138	20.180900
12284	4100	100	138	20.180900
12285	4101	100	138	20.180900
12286	4102	100	138	20.180900
12287	4103	100	138	20.180900
12288	4104	100	138	20.180900
12289	4105	100	138	20.180900
12290	4106	100	138	20.180900
12291	4107	100	138	20.180900
12292	4108	100	138	20.180900
12293	4109	100	138	20.180900
12294	4110	100	138	20.180900
12295	4111	100	138	20.180900
12296	4112	100	138	20.180900
12297	4113	100	138	20.180900
12298	4114	100	138	20.180900
12299	4115	100	138	20.180900
12300	4116	100	138	20.180900
12301	4117	100	138	20.180900
12302	4118	100	138	20.180900
12303	4119	100	138	20.180900
12304	4120	100	138	20.180900
12305	4121	100	138	20.180900
12306	4122	100	138	20.180900
12307	4123	100	138	20.180900
12308	4124	100	138	20.180900
12309	4125	100	138	20.180900
12310	4126	100	138	20.180900
12311	4127	100	138	20.180900
12312	4128	100	138	20.180900
12313	4129	100	138	20.180900
12314	4130	100	138	20.180900
12315	4131	100	138	20.180900
12316	4132	100	138	20.180900
12317	4133	100	138	20.180900
12318	4134	100	138	20.180900
12319	4135	100	138	20.180900
12320	4136	100	138	20.180900
12321	4137	100	138	20.180900
12322	4138	100	138	20.180900
12323	4139	100	138	20.180900
12324	4140	100	138	20.180900
12325	4141	100	138	20.180900
12326	4142	100	138	20.180900
12327	4143	100	138	20.180900
12328	4144	100	138	20.180900
12329	4145	100	138	20.180900
12330	4146	100	138	20.180900
12331	4147	100	138	20.180900
12332	4148	100	138	20.180900
12333	4149	100	138	20.180900
12334	4150	100	138	20.180900
12335	4151	100	138	20.180900
12336	4152	100	138	20.180900
12337	4153	100	138	20.180900
12338	4154	100	138	20.180900
12339	4155	100	138	20.180900
12340	4156	100	138	20.180900
12341	4157	100	138	20.180900
12342	4158	100	138	20.180900
12343	4159	100	138	20.180900
12344	4160	100	138	20.180900
12345	4161	100	138	20.180900
12346	4162	100	138	20.180900
12347	4163	100	138	20.180900
12348	4164	100	138	20.180900
12349	4165	100	138	20.180900
12350	4166	100	138	20.180900
12351	4167	100	138	20.180900
12352	4168	100	138	20.180900
12353	4169	100	138	20.180900
12354	4170	100	138	20.180900
12355	4171	100	138	20.180900
12356	4172	100	138	20.180900
12357	4173	100	138	20.180900
12358	4174	100	138	20.180900
12359	4175	100	138	20.180900
12360	4176	100	138	20.180900
12361	4177	100	138	20.180900
12362	4178	100	138	20.180900
12363	4179	100	138	20.180900
12364	4180	100	138	20.180900
12365	4181	100	138	20.180900
12366	4182	100	138	20.180900
12367	4183	100	138	20.180900
12368	4184	100	138	20.180900
12369	4185	100	138	20.180900
12370	4186	100	138	20.180900
12371	4187	100	138	20.180900
12372	4188	100	138	20.180900
12373	4189	100	138	20.180900
12374	4190	100	138	20.180900
12375	4191	100	138	20.180900
12376	4192	100	138	20.180900
12377	4193	100	138	20.180900
12378	4194	100	138	20.180900
12379	4195	100	138	20.180900
12380	4196	100	138	20.180900
12381	4197	100	138	20.180900
12382	4198	100	138	20.180900
12383	4199	100	138	20.180900
12384	4200	100	138	20.180900
12385	4201	100	138	20.180900
12386	4202	100	138	20.180900
12387	4203	100	138	20.180900
12388	4204	100	138	20.180900
12389	4205	100	138	20.180900
12390	4206	100	138	20.180900
12391	4207	100	138	20.180900
12392	4208	100	138	20.180900
12393	4209	100	138	20.180900
12394	4210	100	138	20.180900
12395	4211	100	138	20.180900
12396	4212	100	138	20.180900
12397	4213	100	138	20.180900
12398	4214	100	138	20.180900
12399	4215	100	138	20.180900
12400	4216	100	138	20.180900
12401	4217	100	138	20.180900
12402	4218	100	138	20.180900
12403	4219	100	138	20.180900
12404	4220	100	138	20.180900
12405	4221	100	138	20.180900
12406	4222	100	138	20.180900
12407	4223	100	138	20.180900
12408	4224	100	138	20.180900
12409	4093	100	137	73.016900
12410	4094	100	137	73.016900
12411	4095	100	137	73.016900
12412	4096	100	137	73.016900
12413	4097	100	137	73.016900
12414	4098	100	137	73.016900
12415	4099	100	137	73.016900
12416	4100	100	137	73.016900
12417	4101	100	137	73.016900
12418	4102	100	137	73.016900
12419	4103	100	137	73.016900
12420	4104	100	137	73.016900
12421	4105	100	137	73.016900
12422	4106	100	137	73.016900
12423	4107	100	137	73.016900
12424	4108	100	137	73.016900
12425	4109	100	137	73.016900
12426	4110	100	137	73.016900
12427	4111	100	137	73.016900
12428	4112	100	137	73.016900
12429	4113	100	137	73.016900
12430	4114	100	137	73.016900
12431	4115	100	137	73.016900
12432	4116	100	137	73.016900
12433	4117	100	137	73.016900
12434	4118	100	137	73.016900
12435	4119	100	137	73.016900
12436	4120	100	137	73.016900
12437	4121	100	137	73.016900
12438	4122	100	137	73.016900
12439	4123	100	137	73.016900
12440	4124	100	137	73.016900
12441	4125	100	137	73.016900
12442	4126	100	137	73.016900
12443	4127	100	137	73.016900
12444	4128	100	137	73.016900
12445	4129	100	137	73.016900
12446	4130	100	137	73.016900
12447	4131	100	137	73.016900
12448	4132	100	137	73.016900
12449	4133	100	137	73.016900
12450	4134	100	137	73.016900
12451	4135	100	137	73.016900
12452	4136	100	137	73.016900
12453	4137	100	137	73.016900
12454	4138	100	137	73.016900
12455	4139	100	137	73.016900
12456	4140	100	137	73.016900
12457	4141	100	137	73.016900
12458	4142	100	137	73.016900
12459	4143	100	137	73.016900
12460	4144	100	137	73.016900
12461	4145	100	137	73.016900
12462	4146	100	137	73.016900
12463	4147	100	137	73.016900
12464	4148	100	137	73.016900
12465	4149	100	137	73.016900
12466	4150	100	137	73.016900
12467	4151	100	137	73.016900
12468	4152	100	137	73.016900
12469	4153	100	137	73.016900
12470	4154	100	137	73.016900
12471	4155	100	137	73.016900
12472	4156	100	137	73.016900
12473	4157	100	137	73.016900
12474	4158	100	137	73.016900
12475	4159	100	137	73.016900
12476	4160	100	137	73.016900
12477	4161	100	137	73.016900
12478	4162	100	137	73.016900
12479	4163	100	137	73.016900
12480	4164	100	137	73.016900
12481	4165	100	137	73.016900
12482	4166	100	137	73.016900
12483	4167	100	137	73.016900
12484	4168	100	137	73.016900
12485	4169	100	137	73.016900
12486	4170	100	137	73.016900
12487	4171	100	137	73.016900
12488	4172	100	137	73.016900
12489	4173	100	137	73.016900
12490	4174	100	137	73.016900
12491	4175	100	137	73.016900
12492	4176	100	137	73.016900
12493	4177	100	137	73.016900
12494	4178	100	137	73.016900
12495	4179	100	137	73.016900
12496	4180	100	137	73.016900
12497	4181	100	137	73.016900
12498	4182	100	137	73.016900
12499	4183	100	137	73.016900
12500	4184	100	137	73.016900
12501	4185	100	137	73.016900
12502	4186	100	137	73.016900
12503	4187	100	137	73.016900
12504	4188	100	137	73.016900
12505	4189	100	137	73.016900
12506	4190	100	137	73.016900
12507	4191	100	137	73.016900
12508	4192	100	137	73.016900
12509	4193	100	137	73.016900
12510	4194	100	137	73.016900
12511	4195	100	137	73.016900
12512	4196	100	137	73.016900
12513	4197	100	137	73.016900
12514	4198	100	137	73.016900
12515	4199	100	137	73.016900
12516	4200	100	137	73.016900
12517	4201	100	137	73.016900
12518	4202	100	137	73.016900
12519	4203	100	137	73.016900
12520	4204	100	137	73.016900
12521	4205	100	137	73.016900
12522	4206	100	137	73.016900
12523	4207	100	137	73.016900
12524	4208	100	137	73.016900
12525	4209	100	137	73.016900
12526	4210	100	137	73.016900
12527	4211	100	137	73.016900
12528	4212	100	137	73.016900
12529	4213	100	137	73.016900
12530	4214	100	137	73.016900
12531	4215	100	137	73.016900
12532	4216	100	137	73.016900
12533	4217	100	137	73.016900
12534	4218	100	137	73.016900
12535	4219	100	137	73.016900
12536	4220	100	137	73.016900
12537	4221	100	137	73.016900
12538	4222	100	137	73.016900
12539	4223	100	137	73.016900
12540	4224	100	137	73.016900
12541	4093	100	136	13.430000
12542	4094	100	136	13.676000
12543	4095	100	136	16.624000
12544	4096	100	136	20.964000
12545	4097	100	136	23.093000
12546	4098	100	136	26.778000
12547	4099	100	136	25.959000
12548	4100	100	136	23.994000
12549	4101	100	136	23.912000
12550	4102	100	136	16.542000
12551	4103	100	136	17.688000
12552	4104	100	136	15.313000
12553	4105	100	136	13.430000
12554	4106	100	136	14.986000
12555	4107	100	136	16.296000
12556	4108	100	136	21.209000
12557	4109	100	136	23.093000
12558	4110	100	136	26.369000
12559	4111	100	136	25.058000
12560	4112	100	136	24.731000
12561	4113	100	136	23.994000
12562	4114	100	136	16.542000
12563	4115	100	136	18.016000
12564	4116	100	136	15.232000
12565	4117	100	136	13.921000
12566	4118	100	136	14.413000
12567	4119	100	136	17.443000
12568	4120	100	136	20.636000
12569	4121	100	136	23.175000
12570	4122	100	136	25.140000
12571	4123	100	136	24.731000
12572	4124	100	136	23.994000
12573	4125	100	136	23.994000
12574	4126	100	136	16.542000
12575	4127	100	136	17.852000
12576	4128	100	136	14.331000
12577	4129	100	136	12.939000
12578	4130	100	136	14.576000
12579	4131	100	136	15.887000
12580	4132	100	136	21.209000
12581	4133	100	136	23.748000
12582	4134	100	136	27.679000
12583	4135	100	136	25.058000
12584	4136	100	136	25.222000
12585	4137	100	136	23.994000
12586	4138	100	136	16.787000
12587	4139	100	136	17.688000
12588	4140	100	136	15.313000
12589	4141	100	136	13.758000
12590	4142	100	136	15.150000
12591	4143	100	136	17.606000
12592	4144	100	136	21.209000
12593	4145	100	136	23.093000
12594	4146	100	136	26.287000
12595	4147	100	136	25.140000
12596	4148	100	136	23.994000
12597	4149	100	136	23.994000
12598	4150	100	136	16.542000
12599	4151	100	136	17.524000
12600	4152	100	136	14.904000
12601	4153	100	136	13.184000
12602	4154	100	136	13.758000
12603	4155	100	136	16.624000
12604	4156	100	136	20.391000
12605	4157	100	136	23.093000
12606	4158	100	136	25.304000
12607	4159	100	136	25.058000
12608	4160	100	136	23.994000
12609	4161	100	136	23.994000
12610	4162	100	136	16.050000
12611	4163	100	136	19.490000
12612	4164	100	136	15.395000
12613	4165	100	136	13.430000
12614	4166	100	136	14.413000
12615	4167	100	136	16.624000
12616	4168	100	136	22.028000
12617	4169	100	136	24.403000
12618	4170	100	136	26.041000
12619	4171	100	136	25.058000
12620	4172	100	136	24.567000
12621	4173	100	136	23.994000
12622	4174	100	136	16.787000
12623	4175	100	136	17.688000
12624	4176	100	136	15.150000
12625	4177	100	136	13.184000
12626	4178	100	136	15.232000
12627	4179	100	136	16.624000
12628	4180	100	136	21.209000
12629	4181	100	136	23.093000
12630	4182	100	136	25.304000
12631	4183	100	136	25.058000
12632	4184	100	136	23.994000
12633	4185	100	136	23.994000
12634	4186	100	136	16.624000
12635	4187	100	136	17.934000
12636	4188	100	136	14.986000
12637	4189	100	136	13.594000
12638	4190	100	136	13.839000
12639	4191	100	136	16.214000
12640	4192	100	136	22.110000
12641	4193	100	136	23.011000
12642	4194	100	136	25.304000
12643	4195	100	136	25.058000
12644	4196	100	136	24.321000
12645	4197	100	136	23.994000
12646	4198	100	136	17.279000
12647	4199	100	136	18.098000
12648	4200	100	136	15.477000
12649	4201	100	136	13.430000
12650	4202	100	136	14.658000
12651	4203	100	136	16.624000
12652	4204	100	136	21.209000
12653	4205	100	136	23.011000
12654	4206	100	136	24.321000
12655	4207	100	136	24.239000
12656	4208	100	136	23.994000
12657	4209	100	136	23.994000
12658	4210	100	136	16.624000
12659	4211	100	136	17.688000
12660	4212	100	136	14.986000
12661	4213	100	136	13.430000
12662	4214	100	136	15.068000
12663	4215	100	136	17.197000
12664	4216	100	136	22.438000
12665	4217	100	136	23.584000
12666	4218	100	136	25.304000
12667	4219	100	136	25.058000
12668	4220	100	136	23.994000
12669	4221	100	136	23.994000
12670	4222	100	136	17.361000
12671	4223	100	136	17.688000
12672	4224	100	136	15.395000
12673	4225	100	150	28.613900
12674	4226	100	150	28.613900
12675	4227	100	150	28.613900
12676	4228	100	150	28.613900
12677	4229	100	150	28.613900
12678	4230	100	150	28.613900
12679	4231	100	150	28.613900
12680	4232	100	150	28.613900
12681	4233	100	150	28.613900
12682	4234	100	150	28.613900
12683	4235	100	150	28.613900
12684	4236	100	150	28.613900
12685	4237	100	150	28.613900
12686	4238	100	150	28.613900
12687	4239	100	150	28.613900
12688	4240	100	150	28.613900
12689	4241	100	150	28.613900
12690	4242	100	150	28.613900
12691	4243	100	150	28.613900
12692	4244	100	150	28.613900
12693	4245	100	150	28.613900
12694	4246	100	150	28.613900
12695	4247	100	150	28.613900
12696	4248	100	150	28.613900
12697	4249	100	150	28.613900
12698	4250	100	150	28.613900
12699	4251	100	150	28.613900
12700	4252	100	150	28.613900
12701	4253	100	150	28.613900
12702	4254	100	150	28.613900
12703	4255	100	150	28.613900
12704	4256	100	150	28.613900
12705	4257	100	150	28.613900
12706	4258	100	150	28.613900
12707	4259	100	150	28.613900
12708	4260	100	150	28.613900
12709	4261	100	150	28.613900
12710	4262	100	150	28.613900
12711	4263	100	150	28.613900
12712	4264	100	150	28.613900
12713	4265	100	150	28.613900
12714	4266	100	150	28.613900
12715	4267	100	150	28.613900
12716	4268	100	150	28.613900
12717	4269	100	150	28.613900
12718	4270	100	150	28.613900
12719	4271	100	150	28.613900
12720	4272	100	150	28.613900
12721	4273	100	150	28.613900
12722	4274	100	150	28.613900
12723	4275	100	150	28.613900
12724	4276	100	150	28.613900
12725	4277	100	150	28.613900
12726	4278	100	150	28.613900
12727	4279	100	150	28.613900
12728	4280	100	150	28.613900
12729	4281	100	150	28.613900
12730	4282	100	150	28.613900
12731	4283	100	150	28.613900
12732	4284	100	150	28.613900
12733	4285	100	150	28.613900
12734	4286	100	150	28.613900
12735	4287	100	150	28.613900
12736	4288	100	150	28.613900
12737	4289	100	150	28.613900
12738	4290	100	150	28.613900
12739	4291	100	150	28.613900
12740	4292	100	150	28.613900
12741	4293	100	150	28.613900
12742	4294	100	150	28.613900
12743	4295	100	150	28.613900
12744	4296	100	150	28.613900
12745	4297	100	150	28.613900
12746	4298	100	150	28.613900
12747	4299	100	150	28.613900
12748	4300	100	150	28.613900
12749	4301	100	150	28.613900
12750	4302	100	150	28.613900
12751	4303	100	150	28.613900
12752	4304	100	150	28.613900
12753	4305	100	150	28.613900
12754	4306	100	150	28.613900
12755	4307	100	150	28.613900
12756	4308	100	150	28.613900
12757	4309	100	150	28.613900
12758	4310	100	150	28.613900
12759	4311	100	150	28.613900
12760	4312	100	150	28.613900
12761	4313	100	150	28.613900
12762	4314	100	150	28.613900
12763	4315	100	150	28.613900
12764	4316	100	150	28.613900
12765	4317	100	150	28.613900
12766	4318	100	150	28.613900
12767	4319	100	150	28.613900
12768	4320	100	150	28.613900
12769	4321	100	150	28.613900
12770	4322	100	150	28.613900
12771	4323	100	150	28.613900
12772	4324	100	150	28.613900
12773	4325	100	150	28.613900
12774	4326	100	150	28.613900
12775	4327	100	150	28.613900
12776	4328	100	150	28.613900
12777	4329	100	150	28.613900
12778	4330	100	150	28.613900
12779	4331	100	150	28.613900
12780	4332	100	150	28.613900
12781	4333	100	150	28.613900
12782	4334	100	150	28.613900
12783	4335	100	150	28.613900
12784	4336	100	150	28.613900
12785	4337	100	150	28.613900
12786	4338	100	150	28.613900
12787	4339	100	150	28.613900
12788	4340	100	150	28.613900
12789	4341	100	150	28.613900
12790	4342	100	150	28.613900
12791	4343	100	150	28.613900
12792	4344	100	150	28.613900
12793	4345	100	150	28.613900
12794	4346	100	150	28.613900
12795	4347	100	150	28.613900
12796	4348	100	150	28.613900
12797	4349	100	150	28.613900
12798	4350	100	150	28.613900
12799	4351	100	150	28.613900
12800	4352	100	150	28.613900
12801	4353	100	150	28.613900
12802	4354	100	150	28.613900
12803	4355	100	150	28.613900
12804	4356	100	150	28.613900
12805	4225	100	149	77.209000
12806	4226	100	149	77.209000
12807	4227	100	149	77.209000
12808	4228	100	149	77.209000
12809	4229	100	149	77.209000
12810	4230	100	149	77.209000
12811	4231	100	149	77.209000
12812	4232	100	149	77.209000
12813	4233	100	149	77.209000
12814	4234	100	149	77.209000
12815	4235	100	149	77.209000
12816	4236	100	149	77.209000
12817	4237	100	149	77.209000
12818	4238	100	149	77.209000
12819	4239	100	149	77.209000
12820	4240	100	149	77.209000
12821	4241	100	149	77.209000
12822	4242	100	149	77.209000
12823	4243	100	149	77.209000
12824	4244	100	149	77.209000
12825	4245	100	149	77.209000
12826	4246	100	149	77.209000
12827	4247	100	149	77.209000
12828	4248	100	149	77.209000
12829	4249	100	149	77.209000
12830	4250	100	149	77.209000
12831	4251	100	149	77.209000
12832	4252	100	149	77.209000
12833	4253	100	149	77.209000
12834	4254	100	149	77.209000
12835	4255	100	149	77.209000
12836	4256	100	149	77.209000
12837	4257	100	149	77.209000
12838	4258	100	149	77.209000
12839	4259	100	149	77.209000
12840	4260	100	149	77.209000
12841	4261	100	149	77.209000
12842	4262	100	149	77.209000
12843	4263	100	149	77.209000
12844	4264	100	149	77.209000
12845	4265	100	149	77.209000
12846	4266	100	149	77.209000
12847	4267	100	149	77.209000
12848	4268	100	149	77.209000
12849	4269	100	149	77.209000
12850	4270	100	149	77.209000
12851	4271	100	149	77.209000
12852	4272	100	149	77.209000
12853	4273	100	149	77.209000
12854	4274	100	149	77.209000
12855	4275	100	149	77.209000
12856	4276	100	149	77.209000
12857	4277	100	149	77.209000
12858	4278	100	149	77.209000
12859	4279	100	149	77.209000
12860	4280	100	149	77.209000
12861	4281	100	149	77.209000
12862	4282	100	149	77.209000
12863	4283	100	149	77.209000
12864	4284	100	149	77.209000
12865	4285	100	149	77.209000
12866	4286	100	149	77.209000
12867	4287	100	149	77.209000
12868	4288	100	149	77.209000
12869	4289	100	149	77.209000
12870	4290	100	149	77.209000
12871	4291	100	149	77.209000
12872	4292	100	149	77.209000
12873	4293	100	149	77.209000
12874	4294	100	149	77.209000
12875	4295	100	149	77.209000
12876	4296	100	149	77.209000
12877	4297	100	149	77.209000
12878	4298	100	149	77.209000
12879	4299	100	149	77.209000
12880	4300	100	149	77.209000
12881	4301	100	149	77.209000
12882	4302	100	149	77.209000
12883	4303	100	149	77.209000
12884	4304	100	149	77.209000
12885	4305	100	149	77.209000
12886	4306	100	149	77.209000
12887	4307	100	149	77.209000
12888	4308	100	149	77.209000
12889	4309	100	149	77.209000
12890	4310	100	149	77.209000
12891	4311	100	149	77.209000
12892	4312	100	149	77.209000
12893	4313	100	149	77.209000
12894	4314	100	149	77.209000
12895	4315	100	149	77.209000
12896	4316	100	149	77.209000
12897	4317	100	149	77.209000
12898	4318	100	149	77.209000
12899	4319	100	149	77.209000
12900	4320	100	149	77.209000
12901	4321	100	149	77.209000
12902	4322	100	149	77.209000
12903	4323	100	149	77.209000
12904	4324	100	149	77.209000
12905	4325	100	149	77.209000
12906	4326	100	149	77.209000
12907	4327	100	149	77.209000
12908	4328	100	149	77.209000
12909	4329	100	149	77.209000
12910	4330	100	149	77.209000
12911	4331	100	149	77.209000
12912	4332	100	149	77.209000
12913	4333	100	149	77.209000
12914	4334	100	149	77.209000
12915	4335	100	149	77.209000
12916	4336	100	149	77.209000
12917	4337	100	149	77.209000
12918	4338	100	149	77.209000
12919	4339	100	149	77.209000
12920	4340	100	149	77.209000
12921	4341	100	149	77.209000
12922	4342	100	149	77.209000
12923	4343	100	149	77.209000
12924	4344	100	149	77.209000
12925	4345	100	149	77.209000
12926	4346	100	149	77.209000
12927	4347	100	149	77.209000
12928	4348	100	149	77.209000
12929	4349	100	149	77.209000
12930	4350	100	149	77.209000
12931	4351	100	149	77.209000
12932	4352	100	149	77.209000
12933	4353	100	149	77.209000
12934	4354	100	149	77.209000
12935	4355	100	149	77.209000
12936	4356	100	149	77.209000
12937	4225	100	148	8.936000
12938	4226	100	148	8.546000
12939	4227	100	148	8.964000
12940	4228	100	148	9.363000
12941	4229	100	148	12.782000
12942	4230	100	148	24.591000
12943	4231	100	148	29.027000
12944	4232	100	148	29.355000
12945	4233	100	148	24.627000
12946	4234	100	148	14.428000
12947	4235	100	148	9.681000
12948	4236	100	148	9.363000
12949	4237	100	148	9.036000
12950	4238	100	148	10.118000
12951	4239	100	148	8.209000
12952	4240	100	148	8.991000
12953	4241	100	148	13.992000
12954	4242	100	148	22.909000
12955	4243	100	148	29.027000
12956	4244	100	148	29.364000
12957	4245	100	148	23.891000
12958	4246	100	148	14.428000
12959	4247	100	148	9.699000
12960	4248	100	148	9.990000
12961	4249	100	148	9.436000
12962	4250	100	148	9.145000
12963	4251	100	148	9.781000
12964	4252	100	148	9.455000
12965	4253	100	148	14.527000
12966	4254	100	148	24.409000
12967	4255	100	148	28.209000
12968	4256	100	148	29.355000
12969	4257	100	148	24.509000
12970	4258	100	148	14.419000
12971	4259	100	148	9.681000
12972	4260	100	148	9.463000
12973	4261	100	148	8.736000
12974	4262	100	148	9.145000
12975	4263	100	148	8.864000
12976	4264	100	148	9.990000
12977	4265	100	148	15.118000
12978	4266	100	148	25.909000
12979	4267	100	148	29.228000
12980	4268	100	148	28.673000
12981	4269	100	148	25.500000
12982	4270	100	148	14.754000
12983	4271	100	148	9.681000
12984	4272	100	148	9.673000
12985	4273	100	148	8.736000
12986	4274	100	148	9.145000
12987	4275	100	148	9.799000
12988	4276	100	148	10.091000
12989	4277	100	148	13.354000
12990	4278	100	148	22.600000
12991	4279	100	148	28.718000
12992	4280	100	148	28.918000
12993	4281	100	148	24.573000
12994	4282	100	148	14.428000
12995	4283	100	148	9.591000
12996	4284	100	148	8.964000
12997	4285	100	148	8.936000
12998	4286	100	148	9.045000
12999	4287	100	148	9.081000
13000	4288	100	148	8.754000
13001	4289	100	148	12.537000
13002	4290	100	148	20.837000
13003	4291	100	148	29.027000
13004	4292	100	148	29.154000
13005	4293	100	148	24.481000
13006	4294	100	148	13.336000
13007	4295	100	148	9.609000
13008	4296	100	148	8.555000
13009	4297	100	148	8.237000
13010	4298	100	148	9.054000
13011	4299	100	148	8.482000
13012	4300	100	148	10.237000
13013	4301	100	148	14.681000
13014	4302	100	148	23.018000
13015	4303	100	148	29.027000
13016	4304	100	148	29.182000
13017	4305	100	148	24.490000
13018	4306	100	148	14.428000
13019	4307	100	148	9.873000
13020	4308	100	148	9.482000
13021	4309	100	148	8.936000
13022	4310	100	148	9.500000
13023	4311	100	148	9.690000
13024	4312	100	148	11.855000
13025	4313	100	148	14.382000
13026	4314	100	148	22.800000
13027	4315	100	148	29.027000
13028	4316	100	148	30.672000
13029	4317	100	148	24.582000
13030	4318	100	148	14.428000
13031	4319	100	148	10.354000
13032	4320	100	148	9.564000
13033	4321	100	148	9.309000
13034	4322	100	148	8.464000
13035	4323	100	148	9.081000
13036	4324	100	148	11.118000
13037	4325	100	148	14.246000
13038	4326	100	148	21.710000
13039	4327	100	148	29.027000
13040	4328	100	148	29.882000
13041	4329	100	148	24.982000
13042	4330	100	148	14.664000
13043	4331	100	148	10.555000
13044	4332	100	148	10.237000
13045	4333	100	148	8.936000
13046	4334	100	148	9.327000
13047	4335	100	148	9.081000
13048	4336	100	148	9.772000
13049	4337	100	148	13.427000
13050	4338	100	148	20.554000
13051	4339	100	148	29.873000
13052	4340	100	148	30.737000
13053	4341	100	148	26.081000
13054	4342	100	148	15.427000
13055	4343	100	148	10.264000
13056	4344	100	148	10.327000
13057	4345	100	148	9.036000
13058	4346	100	148	9.045000
13059	4347	100	148	9.781000
13060	4348	100	148	10.846000
13061	4349	100	148	14.772000
13062	4350	100	148	22.945000
13063	4351	100	148	31.173000
13064	4352	100	148	30.936000
13065	4353	100	148	24.046000
13066	4354	100	148	14.428000
13067	4355	100	148	9.609000
13068	4356	100	148	9.882000
13069	4357	100	141	25.502100
13070	4358	100	141	25.502100
13071	4359	100	141	25.502100
13072	4360	100	141	25.502100
13073	4361	100	141	25.502100
13074	4362	100	141	25.502100
13075	4363	100	141	25.502100
13076	4364	100	141	25.502100
13077	4365	100	141	25.502100
13078	4366	100	141	25.502100
13079	4367	100	141	25.502100
13080	4368	100	141	25.502100
13081	4369	100	141	25.502100
13082	4370	100	141	25.502100
13083	4371	100	141	25.502100
13084	4372	100	141	25.502100
13085	4373	100	141	25.502100
13086	4374	100	141	25.502100
13087	4375	100	141	25.502100
13088	4376	100	141	25.502100
13089	4377	100	141	25.502100
13090	4378	100	141	25.502100
13091	4379	100	141	25.502100
13092	4380	100	141	25.502100
13093	4381	100	141	25.502100
13094	4382	100	141	25.502100
13095	4383	100	141	25.502100
13096	4384	100	141	25.502100
13097	4385	100	141	25.502100
13098	4386	100	141	25.502100
13099	4387	100	141	25.502100
13100	4388	100	141	25.502100
13101	4389	100	141	25.502100
13102	4390	100	141	25.502100
13103	4391	100	141	25.502100
13104	4392	100	141	25.502100
13105	4393	100	141	25.502100
13106	4394	100	141	25.502100
13107	4395	100	141	25.502100
13108	4396	100	141	25.502100
13109	4397	100	141	25.502100
13110	4398	100	141	25.502100
13111	4399	100	141	25.502100
13112	4400	100	141	25.502100
13113	4401	100	141	25.502100
13114	4402	100	141	25.502100
13115	4403	100	141	25.502100
13116	4404	100	141	25.502100
13117	4405	100	141	25.502100
13118	4406	100	141	25.502100
13119	4407	100	141	25.502100
13120	4408	100	141	25.502100
13121	4409	100	141	25.502100
13122	4410	100	141	25.502100
13123	4411	100	141	25.502100
13124	4412	100	141	25.502100
13125	4413	100	141	25.502100
13126	4414	100	141	25.502100
13127	4415	100	141	25.502100
13128	4416	100	141	25.502100
13129	4417	100	141	25.502100
13130	4418	100	141	25.502100
13131	4419	100	141	25.502100
13132	4420	100	141	25.502100
13133	4421	100	141	25.502100
13134	4422	100	141	25.502100
13135	4423	100	141	25.502100
13136	4424	100	141	25.502100
13137	4425	100	141	25.502100
13138	4426	100	141	25.502100
13139	4427	100	141	25.502100
13140	4428	100	141	25.502100
13141	4429	100	141	25.502100
13142	4430	100	141	25.502100
13143	4431	100	141	25.502100
13144	4432	100	141	25.502100
13145	4433	100	141	25.502100
13146	4434	100	141	25.502100
13147	4435	100	141	25.502100
13148	4436	100	141	25.502100
13149	4437	100	141	25.502100
13150	4438	100	141	25.502100
13151	4439	100	141	25.502100
13152	4440	100	141	25.502100
13153	4441	100	141	25.502100
13154	4442	100	141	25.502100
13155	4443	100	141	25.502100
13156	4444	100	141	25.502100
13157	4445	100	141	25.502100
13158	4446	100	141	25.502100
13159	4447	100	141	25.502100
13160	4448	100	141	25.502100
13161	4449	100	141	25.502100
13162	4450	100	141	25.502100
13163	4451	100	141	25.502100
13164	4452	100	141	25.502100
13165	4453	100	141	25.502100
13166	4454	100	141	25.502100
13167	4455	100	141	25.502100
13168	4456	100	141	25.502100
13169	4457	100	141	25.502100
13170	4458	100	141	25.502100
13171	4459	100	141	25.502100
13172	4460	100	141	25.502100
13173	4461	100	141	25.502100
13174	4462	100	141	25.502100
13175	4463	100	141	25.502100
13176	4464	100	141	25.502100
13177	4465	100	141	25.502100
13178	4466	100	141	25.502100
13179	4467	100	141	25.502100
13180	4468	100	141	25.502100
13181	4469	100	141	25.502100
13182	4470	100	141	25.502100
13183	4471	100	141	25.502100
13184	4472	100	141	25.502100
13185	4473	100	141	25.502100
13186	4474	100	141	25.502100
13187	4475	100	141	25.502100
13188	4476	100	141	25.502100
13189	4477	100	141	25.502100
13190	4478	100	141	25.502100
13191	4479	100	141	25.502100
13192	4480	100	141	25.502100
13193	4481	100	141	25.502100
13194	4482	100	141	25.502100
13195	4483	100	141	25.502100
13196	4484	100	141	25.502100
13197	4485	100	141	25.502100
13198	4486	100	141	25.502100
13199	4487	100	141	25.502100
13200	4488	100	141	25.502100
13201	4357	100	140	92.341900
13202	4358	100	140	92.341900
13203	4359	100	140	92.341900
13204	4360	100	140	92.341900
13205	4361	100	140	92.341900
13206	4362	100	140	92.341900
13207	4363	100	140	92.341900
13208	4364	100	140	92.341900
13209	4365	100	140	92.341900
13210	4366	100	140	92.341900
13211	4367	100	140	92.341900
13212	4368	100	140	92.341900
13213	4369	100	140	92.341900
13214	4370	100	140	92.341900
13215	4371	100	140	92.341900
13216	4372	100	140	92.341900
13217	4373	100	140	92.341900
13218	4374	100	140	92.341900
13219	4375	100	140	92.341900
13220	4376	100	140	92.341900
13221	4377	100	140	92.341900
13222	4378	100	140	92.341900
13223	4379	100	140	92.341900
13224	4380	100	140	92.341900
13225	4381	100	140	92.341900
13226	4382	100	140	92.341900
13227	4383	100	140	92.341900
13228	4384	100	140	92.341900
13229	4385	100	140	92.341900
13230	4386	100	140	92.341900
13231	4387	100	140	92.341900
13232	4388	100	140	92.341900
13233	4389	100	140	92.341900
13234	4390	100	140	92.341900
13235	4391	100	140	92.341900
13236	4392	100	140	92.341900
13237	4393	100	140	92.341900
13238	4394	100	140	92.341900
13239	4395	100	140	92.341900
13240	4396	100	140	92.341900
13241	4397	100	140	92.341900
13242	4398	100	140	92.341900
13243	4399	100	140	92.341900
13244	4400	100	140	92.341900
13245	4401	100	140	92.341900
13246	4402	100	140	92.341900
13247	4403	100	140	92.341900
13248	4404	100	140	92.341900
13249	4405	100	140	92.341900
13250	4406	100	140	92.341900
13251	4407	100	140	92.341900
13252	4408	100	140	92.341900
13253	4409	100	140	92.341900
13254	4410	100	140	92.341900
13255	4411	100	140	92.341900
13256	4412	100	140	92.341900
13257	4413	100	140	92.341900
13258	4414	100	140	92.341900
13259	4415	100	140	92.341900
13260	4416	100	140	92.341900
13261	4417	100	140	92.341900
13262	4418	100	140	92.341900
13263	4419	100	140	92.341900
13264	4420	100	140	92.341900
13265	4421	100	140	92.341900
13266	4422	100	140	92.341900
13267	4423	100	140	92.341900
13268	4424	100	140	92.341900
13269	4425	100	140	92.341900
13270	4426	100	140	92.341900
13271	4427	100	140	92.341900
13272	4428	100	140	92.341900
13273	4429	100	140	92.341900
13274	4430	100	140	92.341900
13275	4431	100	140	92.341900
13276	4432	100	140	92.341900
13277	4433	100	140	92.341900
13278	4434	100	140	92.341900
13279	4435	100	140	92.341900
13280	4436	100	140	92.341900
13281	4437	100	140	92.341900
13282	4438	100	140	92.341900
13283	4439	100	140	92.341900
13284	4440	100	140	92.341900
13285	4441	100	140	92.341900
13286	4442	100	140	92.341900
13287	4443	100	140	92.341900
13288	4444	100	140	92.341900
13289	4445	100	140	92.341900
13290	4446	100	140	92.341900
13291	4447	100	140	92.341900
13292	4448	100	140	92.341900
13293	4449	100	140	92.341900
13294	4450	100	140	92.341900
13295	4451	100	140	92.341900
13296	4452	100	140	92.341900
13297	4453	100	140	92.341900
13298	4454	100	140	92.341900
13299	4455	100	140	92.341900
13300	4456	100	140	92.341900
13301	4457	100	140	92.341900
13302	4458	100	140	92.341900
13303	4459	100	140	92.341900
13304	4460	100	140	92.341900
13305	4461	100	140	92.341900
13306	4462	100	140	92.341900
13307	4463	100	140	92.341900
13308	4464	100	140	92.341900
13309	4465	100	140	92.341900
13310	4466	100	140	92.341900
13311	4467	100	140	92.341900
13312	4468	100	140	92.341900
13313	4469	100	140	92.341900
13314	4470	100	140	92.341900
13315	4471	100	140	92.341900
13316	4472	100	140	92.341900
13317	4473	100	140	92.341900
13318	4474	100	140	92.341900
13319	4475	100	140	92.341900
13320	4476	100	140	92.341900
13321	4477	100	140	92.341900
13322	4478	100	140	92.341900
13323	4479	100	140	92.341900
13324	4480	100	140	92.341900
13325	4481	100	140	92.341900
13326	4482	100	140	92.341900
13327	4483	100	140	92.341900
13328	4484	100	140	92.341900
13329	4485	100	140	92.341900
13330	4486	100	140	92.341900
13331	4487	100	140	92.341900
13332	4488	100	140	92.341900
13333	4357	100	139	14.154000
13334	4358	100	139	14.273000
13335	4359	100	139	18.450000
13336	4360	100	139	22.225000
13337	4361	100	139	24.776000
13338	4362	100	139	28.750000
13339	4363	100	139	29.526000
13340	4364	100	139	30.408000
13341	4365	100	139	29.554000
13342	4366	100	139	25.479000
13343	4367	100	139	20.151000
13344	4368	100	139	15.454000
13345	4369	100	139	14.706000
13346	4370	100	139	16.126000
13347	4371	100	139	17.050000
13348	4372	100	139	21.131000
13349	4373	100	139	26.005000
13350	4374	100	139	29.602000
13351	4375	100	139	30.055000
13352	4376	100	139	30.935000
13353	4377	100	139	29.554000
13354	4378	100	139	26.307000
13355	4379	100	139	20.454000
13356	4380	100	139	16.053000
13357	4381	100	139	14.776000
13358	4382	100	139	14.976000
13359	4383	100	139	18.375000
13360	4384	100	139	22.199000
13361	4385	100	139	26.126000
13362	4386	100	139	29.524000
13363	4387	100	139	30.055000
13364	4388	100	139	30.656000
13365	4389	100	139	29.954000
13366	4390	100	139	25.380000
13367	4391	100	139	20.151000
13368	4392	100	139	15.652000
13369	4393	100	139	13.682000
13370	4394	100	139	15.777000
13371	4395	100	139	17.173000
13372	4396	100	139	21.450000
13373	4397	100	139	27.201000
13374	4398	100	139	29.702000
13375	4399	100	139	29.953000
13376	4400	100	139	30.606000
13377	4401	100	139	29.330000
13378	4402	100	139	26.027000
13379	4403	100	139	21.232000
13380	4404	100	139	16.378000
13381	4405	100	139	14.502000
13382	4406	100	139	14.976000
13383	4407	100	139	18.276000
13384	4408	100	139	22.076000
13385	4409	100	139	26.330000
13386	4410	100	139	29.253000
13387	4411	100	139	29.876000
13388	4412	100	139	30.731000
13389	4413	100	139	29.430000
13390	4414	100	139	25.979000
13391	4415	100	139	20.330000
13392	4416	100	139	15.803000
13393	4417	100	139	14.080000
13394	4418	100	139	14.600000
13395	4419	100	139	17.651000
13396	4420	100	139	20.855000
13397	4421	100	139	25.427000
13398	4422	100	139	29.201000
13399	4423	100	139	30.055000
13400	4424	100	139	30.430000
13401	4425	100	139	29.155000
13402	4426	100	139	24.629000
13403	4427	100	139	20.255000
13404	4428	100	139	16.828000
13405	4429	100	139	14.528000
13406	4430	100	139	16.176000
13407	4431	100	139	17.501000
13408	4432	100	139	22.802000
13409	4433	100	139	26.201000
13410	4434	100	139	30.677000
13411	4435	100	139	30.154000
13412	4436	100	139	30.756000
13413	4437	100	139	29.830000
13414	4438	100	139	27.552000
13415	4439	100	139	21.855000
13416	4440	100	139	16.228000
13417	4441	100	139	14.579000
13418	4442	100	139	15.625000
13419	4443	100	139	17.727000
13420	4444	100	139	23.125000
13421	4445	100	139	26.999000
13422	4446	100	139	29.677000
13423	4447	100	139	30.154000
13424	4448	100	139	30.556000
13425	4449	100	139	29.830000
13426	4450	100	139	27.305000
13427	4451	100	139	20.330000
13428	4452	100	139	17.080000
13429	4453	100	139	14.528000
13430	4454	100	139	15.700000
13431	4455	100	139	17.876000
13432	4456	100	139	22.328000
13433	4457	100	139	25.948000
13434	4458	100	139	29.602000
13435	4459	100	139	30.979000
13436	4460	100	139	30.456000
13437	4461	100	139	29.554000
13438	4462	100	139	26.455000
13439	4463	100	139	19.828000
13440	4464	100	139	15.752000
13441	4465	100	139	14.629000
13442	4466	100	139	16.051000
13443	4467	100	139	17.376000
13444	4468	100	139	21.680000
13445	4469	100	139	26.529000
13446	4470	100	139	29.250000
13447	4471	100	139	30.629000
13448	4472	100	139	30.831000
13449	4473	100	139	29.856000
13450	4474	100	139	27.480000
13451	4475	100	139	21.352000
13452	4476	100	139	15.853000
13453	4477	100	139	14.802000
13454	4478	100	139	15.550000
13455	4479	100	139	17.823000
13456	4480	100	139	22.202000
13457	4481	100	139	26.226000
13458	4482	100	139	29.602000
13459	4483	100	139	31.177000
13460	4484	100	139	30.456000
13461	4485	100	139	29.255000
13462	4486	100	139	25.281000
13463	4487	100	139	20.350000
13464	4488	100	139	15.954000
13465	4489	100	144	34.553900
13466	4490	100	144	34.553900
13467	4491	100	144	34.553900
13468	4492	100	144	34.553900
13469	4493	100	144	34.553900
13470	4494	100	144	34.553900
13471	4495	100	144	34.553900
13472	4496	100	144	34.553900
13473	4497	100	144	34.553900
13474	4498	100	144	34.553900
13475	4499	100	144	34.553900
13476	4500	100	144	34.553900
13477	4501	100	144	34.553900
13478	4502	100	144	34.553900
13479	4503	100	144	34.553900
13480	4504	100	144	34.553900
13481	4505	100	144	34.553900
13482	4506	100	144	34.553900
13483	4507	100	144	34.553900
13484	4508	100	144	34.553900
13485	4509	100	144	34.553900
13486	4510	100	144	34.553900
13487	4511	100	144	34.553900
13488	4512	100	144	34.553900
13489	4513	100	144	34.553900
13490	4514	100	144	34.553900
13491	4515	100	144	34.553900
13492	4516	100	144	34.553900
13493	4517	100	144	34.553900
13494	4518	100	144	34.553900
13495	4519	100	144	34.553900
13496	4520	100	144	34.553900
13497	4521	100	144	34.553900
13498	4522	100	144	34.553900
13499	4523	100	144	34.553900
13500	4524	100	144	34.553900
13501	4525	100	144	34.553900
13502	4526	100	144	34.553900
13503	4527	100	144	34.553900
13504	4528	100	144	34.553900
13505	4529	100	144	34.553900
13506	4530	100	144	34.553900
13507	4531	100	144	34.553900
13508	4532	100	144	34.553900
13509	4533	100	144	34.553900
13510	4534	100	144	34.553900
13511	4535	100	144	34.553900
13512	4536	100	144	34.553900
13513	4537	100	144	34.553900
13514	4538	100	144	34.553900
13515	4539	100	144	34.553900
13516	4540	100	144	34.553900
13517	4541	100	144	34.553900
13518	4542	100	144	34.553900
13519	4543	100	144	34.553900
13520	4544	100	144	34.553900
13521	4545	100	144	34.553900
13522	4546	100	144	34.553900
13523	4547	100	144	34.553900
13524	4548	100	144	34.553900
13525	4549	100	144	34.553900
13526	4550	100	144	34.553900
13527	4551	100	144	34.553900
13528	4552	100	144	34.553900
13529	4553	100	144	34.553900
13530	4554	100	144	34.553900
13531	4555	100	144	34.553900
13532	4556	100	144	34.553900
13533	4557	100	144	34.553900
13534	4558	100	144	34.553900
13535	4559	100	144	34.553900
13536	4560	100	144	34.553900
13537	4561	100	144	34.553900
13538	4562	100	144	34.553900
13539	4563	100	144	34.553900
13540	4564	100	144	34.553900
13541	4565	100	144	34.553900
13542	4566	100	144	34.553900
13543	4567	100	144	34.553900
13544	4568	100	144	34.553900
13545	4569	100	144	34.553900
13546	4570	100	144	34.553900
13547	4571	100	144	34.553900
13548	4572	100	144	34.553900
13549	4573	100	144	34.553900
13550	4574	100	144	34.553900
13551	4575	100	144	34.553900
13552	4576	100	144	34.553900
13553	4577	100	144	34.553900
13554	4578	100	144	34.553900
13555	4579	100	144	34.553900
13556	4580	100	144	34.553900
13557	4581	100	144	34.553900
13558	4582	100	144	34.553900
13559	4583	100	144	34.553900
13560	4584	100	144	34.553900
13561	4585	100	144	34.553900
13562	4586	100	144	34.553900
13563	4587	100	144	34.553900
13564	4588	100	144	34.553900
13565	4589	100	144	34.553900
13566	4590	100	144	34.553900
13567	4591	100	144	34.553900
13568	4592	100	144	34.553900
13569	4593	100	144	34.553900
13570	4594	100	144	34.553900
13571	4595	100	144	34.553900
13572	4596	100	144	34.553900
13573	4597	100	144	34.553900
13574	4598	100	144	34.553900
13575	4599	100	144	34.553900
13576	4600	100	144	34.553900
13577	4601	100	144	34.553900
13578	4602	100	144	34.553900
13579	4603	100	144	34.553900
13580	4604	100	144	34.553900
13581	4605	100	144	34.553900
13582	4606	100	144	34.553900
13583	4607	100	144	34.553900
13584	4608	100	144	34.553900
13585	4609	100	144	34.553900
13586	4610	100	144	34.553900
13587	4611	100	144	34.553900
13588	4612	100	144	34.553900
13589	4613	100	144	34.553900
13590	4614	100	144	34.553900
13591	4615	100	144	34.553900
13592	4616	100	144	34.553900
13593	4617	100	144	34.553900
13594	4618	100	144	34.553900
13595	4619	100	144	34.553900
13596	4620	100	144	34.553900
13597	4489	100	143	76.134900
13598	4490	100	143	76.134900
13599	4491	100	143	76.134900
13600	4492	100	143	76.134900
13601	4493	100	143	76.134900
13602	4494	100	143	76.134900
13603	4495	100	143	76.134900
13604	4496	100	143	76.134900
13605	4497	100	143	76.134900
13606	4498	100	143	76.134900
13607	4499	100	143	76.134900
13608	4500	100	143	76.134900
13609	4501	100	143	76.134900
13610	4502	100	143	76.134900
13611	4503	100	143	76.134900
13612	4504	100	143	76.134900
13613	4505	100	143	76.134900
13614	4506	100	143	76.134900
13615	4507	100	143	76.134900
13616	4508	100	143	76.134900
13617	4509	100	143	76.134900
13618	4510	100	143	76.134900
13619	4511	100	143	76.134900
13620	4512	100	143	76.134900
13621	4513	100	143	76.134900
13622	4514	100	143	76.134900
13623	4515	100	143	76.134900
13624	4516	100	143	76.134900
13625	4517	100	143	76.134900
13626	4518	100	143	76.134900
13627	4519	100	143	76.134900
13628	4520	100	143	76.134900
13629	4521	100	143	76.134900
13630	4522	100	143	76.134900
13631	4523	100	143	76.134900
13632	4524	100	143	76.134900
13633	4525	100	143	76.134900
13634	4526	100	143	76.134900
13635	4527	100	143	76.134900
13636	4528	100	143	76.134900
13637	4529	100	143	76.134900
13638	4530	100	143	76.134900
13639	4531	100	143	76.134900
13640	4532	100	143	76.134900
13641	4533	100	143	76.134900
13642	4534	100	143	76.134900
13643	4535	100	143	76.134900
13644	4536	100	143	76.134900
13645	4537	100	143	76.134900
13646	4538	100	143	76.134900
13647	4539	100	143	76.134900
13648	4540	100	143	76.134900
13649	4541	100	143	76.134900
13650	4542	100	143	76.134900
13651	4543	100	143	76.134900
13652	4544	100	143	76.134900
13653	4545	100	143	76.134900
13654	4546	100	143	76.134900
13655	4547	100	143	76.134900
13656	4548	100	143	76.134900
13657	4549	100	143	76.134900
13658	4550	100	143	76.134900
13659	4551	100	143	76.134900
13660	4552	100	143	76.134900
13661	4553	100	143	76.134900
13662	4554	100	143	76.134900
13663	4555	100	143	76.134900
13664	4556	100	143	76.134900
13665	4557	100	143	76.134900
13666	4558	100	143	76.134900
13667	4559	100	143	76.134900
13668	4560	100	143	76.134900
13669	4561	100	143	76.134900
13670	4562	100	143	76.134900
13671	4563	100	143	76.134900
13672	4564	100	143	76.134900
13673	4565	100	143	76.134900
13674	4566	100	143	76.134900
13675	4567	100	143	76.134900
13676	4568	100	143	76.134900
13677	4569	100	143	76.134900
13678	4570	100	143	76.134900
13679	4571	100	143	76.134900
13680	4572	100	143	76.134900
13681	4573	100	143	76.134900
13682	4574	100	143	76.134900
13683	4575	100	143	76.134900
13684	4576	100	143	76.134900
13685	4577	100	143	76.134900
13686	4578	100	143	76.134900
13687	4579	100	143	76.134900
13688	4580	100	143	76.134900
13689	4581	100	143	76.134900
13690	4582	100	143	76.134900
13691	4583	100	143	76.134900
13692	4584	100	143	76.134900
13693	4585	100	143	76.134900
13694	4586	100	143	76.134900
13695	4587	100	143	76.134900
13696	4588	100	143	76.134900
13697	4589	100	143	76.134900
13698	4590	100	143	76.134900
13699	4591	100	143	76.134900
13700	4592	100	143	76.134900
13701	4593	100	143	76.134900
13702	4594	100	143	76.134900
13703	4595	100	143	76.134900
13704	4596	100	143	76.134900
13705	4597	100	143	76.134900
13706	4598	100	143	76.134900
13707	4599	100	143	76.134900
13708	4600	100	143	76.134900
13709	4601	100	143	76.134900
13710	4602	100	143	76.134900
13711	4603	100	143	76.134900
13712	4604	100	143	76.134900
13713	4605	100	143	76.134900
13714	4606	100	143	76.134900
13715	4607	100	143	76.134900
13716	4608	100	143	76.134900
13717	4609	100	143	76.134900
13718	4610	100	143	76.134900
13719	4611	100	143	76.134900
13720	4612	100	143	76.134900
13721	4613	100	143	76.134900
13722	4614	100	143	76.134900
13723	4615	100	143	76.134900
13724	4616	100	143	76.134900
13725	4617	100	143	76.134900
13726	4618	100	143	76.134900
13727	4619	100	143	76.134900
13728	4620	100	143	76.134900
13729	4489	100	142	1.607000
13730	4490	100	142	1.121000
13731	4491	100	142	1.891000
13732	4492	100	142	2.713000
13733	4493	100	142	2.798000
13734	4494	100	142	5.476000
13735	4495	100	142	8.935000
13736	4496	100	142	9.420000
13737	4497	100	142	6.221000
13738	4498	100	142	3.140000
13739	4499	100	142	1.881000
13740	4500	100	142	1.562000
13741	4501	100	142	1.299000
13742	4502	100	142	2.174000
13743	4503	100	142	1.466000
13744	4504	100	142	2.557000
13745	4505	100	142	3.427000
13746	4506	100	142	5.743000
13747	4507	100	142	9.002000
13748	4508	100	142	9.012000
13749	4509	100	142	5.498000
13750	4510	100	142	3.213000
13751	4511	100	142	2.194000
13752	4512	100	142	1.747000
13753	4513	100	142	1.595000
13754	4514	100	142	1.407000
13755	4515	100	142	2.458000
13756	4516	100	142	2.498000
13757	4517	100	142	3.789000
13758	4518	100	142	6.549000
13759	4519	100	142	9.653000
13760	4520	100	142	10.016000
13761	4521	100	142	5.472000
13762	4522	100	142	3.233000
13763	4523	100	142	2.187000
13764	4524	100	142	1.560000
13765	4525	100	142	1.113000
13766	4526	100	142	1.306000
13767	4527	100	142	2.039000
13768	4528	100	142	3.077000
13769	4529	100	142	4.210000
13770	4530	100	142	7.408000
13771	4531	100	142	9.694000
13772	4532	100	142	10.236000
13773	4533	100	142	6.386000
13774	4534	100	142	3.261000
13775	4535	100	142	1.480000
13776	4536	100	142	1.271000
13777	4537	100	142	1.323000
13778	4538	100	142	1.470000
13779	4539	100	142	2.285000
13780	4540	100	142	3.249000
13781	4541	100	142	3.238000
13782	4542	100	142	6.411000
13783	4543	100	142	8.094000
13784	4544	100	142	8.696000
13785	4545	100	142	6.534000
13786	4546	100	142	3.398000
13787	4547	100	142	1.938000
13788	4548	100	142	1.333000
13789	4549	100	142	1.651000
13790	4550	100	142	1.389000
13791	4551	100	142	2.217000
13792	4552	100	142	2.455000
13793	4553	100	142	2.983000
13794	4554	100	142	4.949000
13795	4555	100	142	9.039000
13796	4556	100	142	9.470000
13797	4557	100	142	5.639000
13798	4558	100	142	2.834000
13799	4559	100	142	1.879000
13800	4560	100	142	1.156000
13801	4561	100	142	0.991000
13802	4562	100	142	1.842000
13803	4563	100	142	1.675000
13804	4564	100	142	3.170000
13805	4565	100	142	3.823000
13806	4566	100	142	6.074000
13807	4567	100	142	9.543000
13808	4568	100	142	10.958000
13809	4569	100	142	5.923000
13810	4570	100	142	3.477000
13811	4571	100	142	1.919000
13812	4572	100	142	1.699000
13813	4573	100	142	1.490000
13814	4574	100	142	2.743000
13815	4575	100	142	2.534000
13816	4576	100	142	5.292000
13817	4577	100	142	3.651000
13818	4578	100	142	5.486000
13819	4579	100	142	10.814000
13820	4580	100	142	9.996000
13821	4581	100	142	6.323000
13822	4582	100	142	4.169000
13823	4583	100	142	2.443000
13824	4584	100	142	1.693000
13825	4585	100	142	1.644000
13826	4586	100	142	1.463000
13827	4587	100	142	2.034000
13828	4588	100	142	4.300000
13829	4589	100	142	5.217000
13830	4590	100	142	5.708000
13831	4591	100	142	9.132000
13832	4592	100	142	9.944000
13833	4593	100	142	6.041000
13834	4594	100	142	3.982000
13835	4595	100	142	2.840000
13836	4596	100	142	2.243000
13837	4597	100	142	1.488000
13838	4598	100	142	1.115000
13839	4599	100	142	2.190000
13840	4600	100	142	3.364000
13841	4601	100	142	3.566000
13842	4602	100	142	5.172000
13843	4603	100	142	9.342000
13844	4604	100	142	9.138000
13845	4605	100	142	5.769000
13846	4606	100	142	3.637000
13847	4607	100	142	2.564000
13848	4608	100	142	1.660000
13849	4609	100	142	1.838000
13850	4610	100	142	1.769000
13851	4611	100	142	2.538000
13852	4612	100	142	3.729000
13853	4613	100	142	4.025000
13854	4614	100	142	6.188000
13855	4615	100	142	9.405000
13856	4616	100	142	10.150000
13857	4617	100	142	5.278000
13858	4618	100	142	4.016000
13859	4619	100	142	2.322000
13860	4620	100	142	1.617000
13861	4621	100	147	26.120900
13862	4622	100	147	26.120900
13863	4623	100	147	26.120900
13864	4624	100	147	26.120900
13865	4625	100	147	26.120900
13866	4626	100	147	26.120900
13867	4627	100	147	26.120900
13868	4628	100	147	26.120900
13869	4629	100	147	26.120900
13870	4630	100	147	26.120900
13871	4631	100	147	26.120900
13872	4632	100	147	26.120900
13873	4633	100	147	26.120900
13874	4634	100	147	26.120900
13875	4635	100	147	26.120900
13876	4636	100	147	26.120900
13877	4637	100	147	26.120900
13878	4638	100	147	26.120900
13879	4639	100	147	26.120900
13880	4640	100	147	26.120900
13881	4641	100	147	26.120900
13882	4642	100	147	26.120900
13883	4643	100	147	26.120900
13884	4644	100	147	26.120900
13885	4645	100	147	26.120900
13886	4646	100	147	26.120900
13887	4647	100	147	26.120900
13888	4648	100	147	26.120900
13889	4649	100	147	26.120900
13890	4650	100	147	26.120900
13891	4651	100	147	26.120900
13892	4652	100	147	26.120900
13893	4653	100	147	26.120900
13894	4654	100	147	26.120900
13895	4655	100	147	26.120900
13896	4656	100	147	26.120900
13897	4657	100	147	26.120900
13898	4658	100	147	26.120900
13899	4659	100	147	26.120900
13900	4660	100	147	26.120900
13901	4661	100	147	26.120900
13902	4662	100	147	26.120900
13903	4663	100	147	26.120900
13904	4664	100	147	26.120900
13905	4665	100	147	26.120900
13906	4666	100	147	26.120900
13907	4667	100	147	26.120900
13908	4668	100	147	26.120900
13909	4669	100	147	26.120900
13910	4670	100	147	26.120900
13911	4671	100	147	26.120900
13912	4672	100	147	26.120900
13913	4673	100	147	26.120900
13914	4674	100	147	26.120900
13915	4675	100	147	26.120900
13916	4676	100	147	26.120900
13917	4677	100	147	26.120900
13918	4678	100	147	26.120900
13919	4679	100	147	26.120900
13920	4680	100	147	26.120900
13921	4681	100	147	26.120900
13922	4682	100	147	26.120900
13923	4683	100	147	26.120900
13924	4684	100	147	26.120900
13925	4685	100	147	26.120900
13926	4686	100	147	26.120900
13927	4687	100	147	26.120900
13928	4688	100	147	26.120900
13929	4689	100	147	26.120900
13930	4690	100	147	26.120900
13931	4691	100	147	26.120900
13932	4692	100	147	26.120900
13933	4693	100	147	26.120900
13934	4694	100	147	26.120900
13935	4695	100	147	26.120900
13936	4696	100	147	26.120900
13937	4697	100	147	26.120900
13938	4698	100	147	26.120900
13939	4699	100	147	26.120900
13940	4700	100	147	26.120900
13941	4701	100	147	26.120900
13942	4702	100	147	26.120900
13943	4703	100	147	26.120900
13944	4704	100	147	26.120900
13945	4705	100	147	26.120900
13946	4706	100	147	26.120900
13947	4707	100	147	26.120900
13948	4708	100	147	26.120900
13949	4709	100	147	26.120900
13950	4710	100	147	26.120900
13951	4711	100	147	26.120900
13952	4712	100	147	26.120900
13953	4713	100	147	26.120900
13954	4714	100	147	26.120900
13955	4715	100	147	26.120900
13956	4716	100	147	26.120900
13957	4717	100	147	26.120900
13958	4718	100	147	26.120900
13959	4719	100	147	26.120900
13960	4720	100	147	26.120900
13961	4721	100	147	26.120900
13962	4722	100	147	26.120900
13963	4723	100	147	26.120900
13964	4724	100	147	26.120900
13965	4725	100	147	26.120900
13966	4726	100	147	26.120900
13967	4727	100	147	26.120900
13968	4728	100	147	26.120900
13969	4729	100	147	26.120900
13970	4730	100	147	26.120900
13971	4731	100	147	26.120900
13972	4732	100	147	26.120900
13973	4733	100	147	26.120900
13974	4734	100	147	26.120900
13975	4735	100	147	26.120900
13976	4736	100	147	26.120900
13977	4737	100	147	26.120900
13978	4738	100	147	26.120900
13979	4739	100	147	26.120900
13980	4740	100	147	26.120900
13981	4741	100	147	26.120900
13982	4742	100	147	26.120900
13983	4743	100	147	26.120900
13984	4744	100	147	26.120900
13985	4745	100	147	26.120900
13986	4746	100	147	26.120900
13987	4747	100	147	26.120900
13988	4748	100	147	26.120900
13989	4749	100	147	26.120900
13990	4750	100	147	26.120900
13991	4751	100	147	26.120900
13992	4752	100	147	26.120900
13993	4621	100	146	85.364700
13994	4622	100	146	85.364700
13995	4623	100	146	85.364700
13996	4624	100	146	85.364700
13997	4625	100	146	85.364700
13998	4626	100	146	85.364700
13999	4627	100	146	85.364700
14000	4628	100	146	85.364700
14001	4629	100	146	85.364700
14002	4630	100	146	85.364700
14003	4631	100	146	85.364700
14004	4632	100	146	85.364700
14005	4633	100	146	85.364700
14006	4634	100	146	85.364700
14007	4635	100	146	85.364700
14008	4636	100	146	85.364700
14009	4637	100	146	85.364700
14010	4638	100	146	85.364700
14011	4639	100	146	85.364700
14012	4640	100	146	85.364700
14013	4641	100	146	85.364700
14014	4642	100	146	85.364700
14015	4643	100	146	85.364700
14016	4644	100	146	85.364700
14017	4645	100	146	85.364700
14018	4646	100	146	85.364700
14019	4647	100	146	85.364700
14020	4648	100	146	85.364700
14021	4649	100	146	85.364700
14022	4650	100	146	85.364700
14023	4651	100	146	85.364700
14024	4652	100	146	85.364700
14025	4653	100	146	85.364700
14026	4654	100	146	85.364700
14027	4655	100	146	85.364700
14028	4656	100	146	85.364700
14029	4657	100	146	85.364700
14030	4658	100	146	85.364700
14031	4659	100	146	85.364700
14032	4660	100	146	85.364700
14033	4661	100	146	85.364700
14034	4662	100	146	85.364700
14035	4663	100	146	85.364700
14036	4664	100	146	85.364700
14037	4665	100	146	85.364700
14038	4666	100	146	85.364700
14039	4667	100	146	85.364700
14040	4668	100	146	85.364700
14041	4669	100	146	85.364700
14042	4670	100	146	85.364700
14043	4671	100	146	85.364700
14044	4672	100	146	85.364700
14045	4673	100	146	85.364700
14046	4674	100	146	85.364700
14047	4675	100	146	85.364700
14048	4676	100	146	85.364700
14049	4677	100	146	85.364700
14050	4678	100	146	85.364700
14051	4679	100	146	85.364700
14052	4680	100	146	85.364700
14053	4681	100	146	85.364700
14054	4682	100	146	85.364700
14055	4683	100	146	85.364700
14056	4684	100	146	85.364700
14057	4685	100	146	85.364700
14058	4686	100	146	85.364700
14059	4687	100	146	85.364700
14060	4688	100	146	85.364700
14061	4689	100	146	85.364700
14062	4690	100	146	85.364700
14063	4691	100	146	85.364700
14064	4692	100	146	85.364700
14065	4693	100	146	85.364700
14066	4694	100	146	85.364700
14067	4695	100	146	85.364700
14068	4696	100	146	85.364700
14069	4697	100	146	85.364700
14070	4698	100	146	85.364700
14071	4699	100	146	85.364700
14072	4700	100	146	85.364700
14073	4701	100	146	85.364700
14074	4702	100	146	85.364700
14075	4703	100	146	85.364700
14076	4704	100	146	85.364700
14077	4705	100	146	85.364700
14078	4706	100	146	85.364700
14079	4707	100	146	85.364700
14080	4708	100	146	85.364700
14081	4709	100	146	85.364700
14082	4710	100	146	85.364700
14083	4711	100	146	85.364700
14084	4712	100	146	85.364700
14085	4713	100	146	85.364700
14086	4714	100	146	85.364700
14087	4715	100	146	85.364700
14088	4716	100	146	85.364700
14089	4717	100	146	85.364700
14090	4718	100	146	85.364700
14091	4719	100	146	85.364700
14092	4720	100	146	85.364700
14093	4721	100	146	85.364700
14094	4722	100	146	85.364700
14095	4723	100	146	85.364700
14096	4724	100	146	85.364700
14097	4725	100	146	85.364700
14098	4726	100	146	85.364700
14099	4727	100	146	85.364700
14100	4728	100	146	85.364700
14101	4729	100	146	85.364700
14102	4730	100	146	85.364700
14103	4731	100	146	85.364700
14104	4732	100	146	85.364700
14105	4733	100	146	85.364700
14106	4734	100	146	85.364700
14107	4735	100	146	85.364700
14108	4736	100	146	85.364700
14109	4737	100	146	85.364700
14110	4738	100	146	85.364700
14111	4739	100	146	85.364700
14112	4740	100	146	85.364700
14113	4741	100	146	85.364700
14114	4742	100	146	85.364700
14115	4743	100	146	85.364700
14116	4744	100	146	85.364700
14117	4745	100	146	85.364700
14118	4746	100	146	85.364700
14119	4747	100	146	85.364700
14120	4748	100	146	85.364700
14121	4749	100	146	85.364700
14122	4750	100	146	85.364700
14123	4751	100	146	85.364700
14124	4752	100	146	85.364700
14125	4621	100	145	9.555000
14126	4622	100	145	9.197000
14127	4623	100	145	9.987000
14128	4624	100	145	10.383000
14129	4625	100	145	13.397000
14130	4626	100	145	24.172000
14131	4627	100	145	29.651000
14132	4628	100	145	30.082000
14133	4629	100	145	25.582000
14134	4630	100	145	15.358000
14135	4631	100	145	10.373000
14136	4632	100	145	9.918000
14137	4633	100	145	9.562000
14138	4634	100	145	10.948000
14139	4635	100	145	9.046000
14140	4636	100	145	10.002000
14141	4637	100	145	14.425000
14142	4638	100	145	23.317000
14143	4639	100	145	29.651000
14144	4640	100	145	30.082000
14145	4641	100	145	24.503000
14146	4642	100	145	15.358000
14147	4643	100	145	10.432000
14148	4644	100	145	10.478000
14149	4645	100	145	9.920000
14150	4646	100	145	9.851000
14151	4647	100	145	10.727000
14152	4648	100	145	10.483000
14153	4649	100	145	15.123000
14154	4650	100	145	24.796000
14155	4651	100	145	29.283000
14156	4652	100	145	30.122000
14157	4653	100	145	25.255000
14158	4654	100	145	15.358000
14159	4655	100	145	10.353000
14160	4656	100	145	10.078000
14161	4657	100	145	9.220000
14162	4658	100	145	9.772000
14163	4659	100	145	9.850000
14164	4660	100	145	11.079000
14165	4661	100	145	15.783000
14166	4662	100	145	26.187000
14167	4663	100	145	29.908000
14168	4664	100	145	29.331000
14169	4665	100	145	26.075000
14170	4666	100	145	15.581000
14171	4667	100	145	10.294000
14172	4668	100	145	10.183000
14173	4669	100	145	9.278000
14174	4670	100	145	9.772000
14175	4671	100	145	10.629000
14176	4672	100	145	11.202000
14177	4673	100	145	14.061000
14178	4674	100	145	23.273000
14179	4675	100	145	28.761000
14180	4676	100	145	29.190000
14181	4677	100	145	25.319000
14182	4678	100	145	15.358000
14183	4679	100	145	10.294000
14184	4680	100	145	9.577000
14185	4681	100	145	9.537000
14186	4682	100	145	9.772000
14187	4683	100	145	10.027000
14188	4684	100	145	9.959000
14189	4685	100	145	13.278000
14190	4686	100	145	20.917000
14191	4687	100	145	29.933000
14192	4688	100	145	30.018000
14193	4689	100	145	25.156000
14194	4690	100	145	13.852000
14195	4691	100	145	10.294000
14196	4692	100	145	9.173000
14197	4693	100	145	7.763000
14198	4694	100	145	9.772000
14199	4695	100	145	9.428000
14200	4696	100	145	11.321000
14201	4697	100	145	15.440000
14202	4698	100	145	23.617000
14203	4699	100	145	29.651000
14204	4700	100	145	30.623000
14205	4701	100	145	25.220000
14206	4702	100	145	15.358000
14207	4703	100	145	10.658000
14208	4704	100	145	10.670000
14209	4705	100	145	9.478000
14210	4706	100	145	11.274000
14211	4707	100	145	10.775000
14212	4708	100	145	13.001000
14213	4709	100	145	15.118000
14214	4710	100	145	23.201000
14215	4711	100	145	30.165000
14216	4712	100	145	31.508000
14217	4713	100	145	25.357000
14218	4714	100	145	15.447000
14219	4715	100	145	11.168000
14220	4716	100	145	10.390000
14221	4717	100	145	10.070000
14222	4718	100	145	9.388000
14223	4719	100	145	10.027000
14224	4720	100	145	12.419000
14225	4721	100	145	14.755000
14226	4722	100	145	21.989000
14227	4723	100	145	29.651000
14228	4724	100	145	30.157000
14229	4725	100	145	26.209000
14230	4726	100	145	16.071000
14231	4727	100	145	11.225000
14232	4728	100	145	11.066000
14233	4729	100	145	9.495000
14234	4730	100	145	10.002000
14235	4731	100	145	10.225000
14236	4732	100	145	10.936000
14237	4733	100	145	14.153000
14238	4734	100	145	21.039000
14239	4735	100	145	30.632000
14240	4736	100	145	31.194000
14241	4737	100	145	26.621000
14242	4738	100	145	16.374000
14243	4739	100	145	11.017000
14244	4740	100	145	10.761000
14245	4741	100	145	9.596000
14246	4742	100	145	9.859000
14247	4743	100	145	10.693000
14248	4744	100	145	11.878000
14249	4745	100	145	15.292000
14250	4746	100	145	23.339000
14251	4747	100	145	31.649000
14252	4748	100	145	31.593000
14253	4749	100	145	23.857000
14254	4750	100	145	15.358000
14255	4751	100	145	10.294000
14256	4752	100	145	10.380000
14257	4753	100	153	31.104800
14258	4754	100	153	31.104800
14259	4755	100	153	31.104800
14260	4756	100	153	31.104800
14261	4757	100	153	31.104800
14262	4758	100	153	31.104800
14263	4759	100	153	31.104800
14264	4760	100	153	31.104800
14265	4761	100	153	31.104800
14266	4762	100	153	31.104800
14267	4763	100	153	31.104800
14268	4764	100	153	31.104800
14269	4765	100	153	31.104800
14270	4766	100	153	31.104800
14271	4767	100	153	31.104800
14272	4768	100	153	31.104800
14273	4769	100	153	31.104800
14274	4770	100	153	31.104800
14275	4771	100	153	31.104800
14276	4772	100	153	31.104800
14277	4773	100	153	31.104800
14278	4774	100	153	31.104800
14279	4775	100	153	31.104800
14280	4776	100	153	31.104800
14281	4777	100	153	31.104800
14282	4778	100	153	31.104800
14283	4779	100	153	31.104800
14284	4780	100	153	31.104800
14285	4781	100	153	31.104800
14286	4782	100	153	31.104800
14287	4783	100	153	31.104800
14288	4784	100	153	31.104800
14289	4785	100	153	31.104800
14290	4786	100	153	31.104800
14291	4787	100	153	31.104800
14292	4788	100	153	31.104800
14293	4789	100	153	31.104800
14294	4790	100	153	31.104800
14295	4791	100	153	31.104800
14296	4792	100	153	31.104800
14297	4793	100	153	31.104800
14298	4794	100	153	31.104800
14299	4795	100	153	31.104800
14300	4796	100	153	31.104800
14301	4797	100	153	31.104800
14302	4798	100	153	31.104800
14303	4799	100	153	31.104800
14304	4800	100	153	31.104800
14305	4801	100	153	31.104800
14306	4802	100	153	31.104800
14307	4803	100	153	31.104800
14308	4804	100	153	31.104800
14309	4805	100	153	31.104800
14310	4806	100	153	31.104800
14311	4807	100	153	31.104800
14312	4808	100	153	31.104800
14313	4809	100	153	31.104800
14314	4810	100	153	31.104800
14315	4811	100	153	31.104800
14316	4812	100	153	31.104800
14317	4813	100	153	31.104800
14318	4814	100	153	31.104800
14319	4815	100	153	31.104800
14320	4816	100	153	31.104800
14321	4817	100	153	31.104800
14322	4818	100	153	31.104800
14323	4819	100	153	31.104800
14324	4820	100	153	31.104800
14325	4821	100	153	31.104800
14326	4822	100	153	31.104800
14327	4823	100	153	31.104800
14328	4824	100	153	31.104800
14329	4825	100	153	31.104800
14330	4826	100	153	31.104800
14331	4827	100	153	31.104800
14332	4828	100	153	31.104800
14333	4829	100	153	31.104800
14334	4830	100	153	31.104800
14335	4831	100	153	31.104800
14336	4832	100	153	31.104800
14337	4833	100	153	31.104800
14338	4834	100	153	31.104800
14339	4835	100	153	31.104800
14340	4836	100	153	31.104800
14341	4837	100	153	31.104800
14342	4838	100	153	31.104800
14343	4839	100	153	31.104800
14344	4840	100	153	31.104800
14345	4841	100	153	31.104800
14346	4842	100	153	31.104800
14347	4843	100	153	31.104800
14348	4844	100	153	31.104800
14349	4845	100	153	31.104800
14350	4846	100	153	31.104800
14351	4847	100	153	31.104800
14352	4848	100	153	31.104800
14353	4849	100	153	31.104800
14354	4850	100	153	31.104800
14355	4851	100	153	31.104800
14356	4852	100	153	31.104800
14357	4853	100	153	31.104800
14358	4854	100	153	31.104800
14359	4855	100	153	31.104800
14360	4856	100	153	31.104800
14361	4857	100	153	31.104800
14362	4858	100	153	31.104800
14363	4859	100	153	31.104800
14364	4860	100	153	31.104800
14365	4861	100	153	31.104800
14366	4862	100	153	31.104800
14367	4863	100	153	31.104800
14368	4864	100	153	31.104800
14369	4865	100	153	31.104800
14370	4866	100	153	31.104800
14371	4867	100	153	31.104800
14372	4868	100	153	31.104800
14373	4869	100	153	31.104800
14374	4870	100	153	31.104800
14375	4871	100	153	31.104800
14376	4872	100	153	31.104800
14377	4873	100	153	31.104800
14378	4874	100	153	31.104800
14379	4875	100	153	31.104800
14380	4876	100	153	31.104800
14381	4877	100	153	31.104800
14382	4878	100	153	31.104800
14383	4879	100	153	31.104800
14384	4880	100	153	31.104800
14385	4881	100	153	31.104800
14386	4882	100	153	31.104800
14387	4883	100	153	31.104800
14388	4884	100	153	31.104800
14389	4753	100	152	77.173400
14390	4754	100	152	77.173400
14391	4755	100	152	77.173400
14392	4756	100	152	77.173400
14393	4757	100	152	77.173400
14394	4758	100	152	77.173400
14395	4759	100	152	77.173400
14396	4760	100	152	77.173400
14397	4761	100	152	77.173400
14398	4762	100	152	77.173400
14399	4763	100	152	77.173400
14400	4764	100	152	77.173400
14401	4765	100	152	77.173400
14402	4766	100	152	77.173400
14403	4767	100	152	77.173400
14404	4768	100	152	77.173400
14405	4769	100	152	77.173400
14406	4770	100	152	77.173400
14407	4771	100	152	77.173400
14408	4772	100	152	77.173400
14409	4773	100	152	77.173400
14410	4774	100	152	77.173400
14411	4775	100	152	77.173400
14412	4776	100	152	77.173400
14413	4777	100	152	77.173400
14414	4778	100	152	77.173400
14415	4779	100	152	77.173400
14416	4780	100	152	77.173400
14417	4781	100	152	77.173400
14418	4782	100	152	77.173400
14419	4783	100	152	77.173400
14420	4784	100	152	77.173400
14421	4785	100	152	77.173400
14422	4786	100	152	77.173400
14423	4787	100	152	77.173400
14424	4788	100	152	77.173400
14425	4789	100	152	77.173400
14426	4790	100	152	77.173400
14427	4791	100	152	77.173400
14428	4792	100	152	77.173400
14429	4793	100	152	77.173400
14430	4794	100	152	77.173400
14431	4795	100	152	77.173400
14432	4796	100	152	77.173400
14433	4797	100	152	77.173400
14434	4798	100	152	77.173400
14435	4799	100	152	77.173400
14436	4800	100	152	77.173400
14437	4801	100	152	77.173400
14438	4802	100	152	77.173400
14439	4803	100	152	77.173400
14440	4804	100	152	77.173400
14441	4805	100	152	77.173400
14442	4806	100	152	77.173400
14443	4807	100	152	77.173400
14444	4808	100	152	77.173400
14445	4809	100	152	77.173400
14446	4810	100	152	77.173400
14447	4811	100	152	77.173400
14448	4812	100	152	77.173400
14449	4813	100	152	77.173400
14450	4814	100	152	77.173400
14451	4815	100	152	77.173400
14452	4816	100	152	77.173400
14453	4817	100	152	77.173400
14454	4818	100	152	77.173400
14455	4819	100	152	77.173400
14456	4820	100	152	77.173400
14457	4821	100	152	77.173400
14458	4822	100	152	77.173400
14459	4823	100	152	77.173400
14460	4824	100	152	77.173400
14461	4825	100	152	77.173400
14462	4826	100	152	77.173400
14463	4827	100	152	77.173400
14464	4828	100	152	77.173400
14465	4829	100	152	77.173400
14466	4830	100	152	77.173400
14467	4831	100	152	77.173400
14468	4832	100	152	77.173400
14469	4833	100	152	77.173400
14470	4834	100	152	77.173400
14471	4835	100	152	77.173400
14472	4836	100	152	77.173400
14473	4837	100	152	77.173400
14474	4838	100	152	77.173400
14475	4839	100	152	77.173400
14476	4840	100	152	77.173400
14477	4841	100	152	77.173400
14478	4842	100	152	77.173400
14479	4843	100	152	77.173400
14480	4844	100	152	77.173400
14481	4845	100	152	77.173400
14482	4846	100	152	77.173400
14483	4847	100	152	77.173400
14484	4848	100	152	77.173400
14485	4849	100	152	77.173400
14486	4850	100	152	77.173400
14487	4851	100	152	77.173400
14488	4852	100	152	77.173400
14489	4853	100	152	77.173400
14490	4854	100	152	77.173400
14491	4855	100	152	77.173400
14492	4856	100	152	77.173400
14493	4857	100	152	77.173400
14494	4858	100	152	77.173400
14495	4859	100	152	77.173400
14496	4860	100	152	77.173400
14497	4861	100	152	77.173400
14498	4862	100	152	77.173400
14499	4863	100	152	77.173400
14500	4864	100	152	77.173400
14501	4865	100	152	77.173400
14502	4866	100	152	77.173400
14503	4867	100	152	77.173400
14504	4868	100	152	77.173400
14505	4869	100	152	77.173400
14506	4870	100	152	77.173400
14507	4871	100	152	77.173400
14508	4872	100	152	77.173400
14509	4873	100	152	77.173400
14510	4874	100	152	77.173400
14511	4875	100	152	77.173400
14512	4876	100	152	77.173400
14513	4877	100	152	77.173400
14514	4878	100	152	77.173400
14515	4879	100	152	77.173400
14516	4880	100	152	77.173400
14517	4881	100	152	77.173400
14518	4882	100	152	77.173400
14519	4883	100	152	77.173400
14520	4884	100	152	77.173400
14521	4753	100	151	8.575000
14522	4754	100	151	8.229000
14523	4755	100	151	9.497000
14524	4756	100	151	10.140000
14525	4757	100	151	12.467000
14526	4758	100	151	20.549000
14527	4759	100	151	26.157000
14528	4760	100	151	26.844000
14529	4761	100	151	22.598000
14530	4762	100	151	14.171000
14531	4763	100	151	9.796000
14532	4764	100	151	8.981000
14533	4765	100	151	8.364000
14534	4766	100	151	10.126000
14535	4767	100	151	8.534000
14536	4768	100	151	9.787000
14537	4769	100	151	13.340000
14538	4770	100	151	20.491000
14539	4771	100	151	26.171000
14540	4772	100	151	26.636000
14541	4773	100	151	21.520000
14542	4774	100	151	14.171000
14543	4775	100	151	9.932000
14544	4776	100	151	9.365000
14545	4777	100	151	8.733000
14546	4778	100	151	8.861000
14547	4779	100	151	10.198000
14548	4780	100	151	10.156000
14549	4781	100	151	14.121000
14550	4782	100	151	21.730000
14551	4783	100	151	26.405000
14552	4784	100	151	27.055000
14553	4785	100	151	22.172000
14554	4786	100	151	14.214000
14555	4787	100	151	9.991000
14556	4788	100	151	9.081000
14557	4789	100	151	7.939000
14558	4790	100	151	8.746000
14559	4791	100	151	9.554000
14560	4792	100	151	10.781000
14561	4793	100	151	14.799000
14562	4794	100	151	23.112000
14563	4795	100	151	26.588000
14564	4796	100	151	26.389000
14565	4797	100	151	22.966000
14566	4798	100	151	14.214000
14567	4799	100	151	9.649000
14568	4800	100	151	8.905000
14569	4801	100	151	8.215000
14570	4802	100	151	8.900000
14571	4803	100	151	10.041000
14572	4804	100	151	10.911000
14573	4805	100	151	13.154000
14574	4806	100	151	20.865000
14575	4807	100	151	24.824000
14576	4808	100	151	26.185000
14577	4809	100	151	22.580000
14578	4810	100	151	14.278000
14579	4811	100	151	9.796000
14580	4812	100	151	8.599000
14581	4813	100	151	8.518000
14582	4814	100	151	8.831000
14583	4815	100	151	9.694000
14584	4816	100	151	10.025000
14585	4817	100	151	12.437000
14586	4818	100	151	18.812000
14587	4819	100	151	26.469000
14588	4820	100	151	26.921000
14589	4821	100	151	22.178000
14590	4822	100	151	12.920000
14591	4823	100	151	9.796000
14592	4824	100	151	8.186000
14593	4825	100	151	7.441000
14594	4826	100	151	9.226000
14595	4827	100	151	8.997000
14596	4828	100	151	10.981000
14597	4829	100	151	14.373000
14598	4830	100	151	20.651000
14599	4831	100	151	26.214000
14600	4832	100	151	27.726000
14601	4833	100	151	22.474000
14602	4834	100	151	14.345000
14603	4835	100	151	10.075000
14604	4836	100	151	10.057000
14605	4837	100	151	8.418000
14606	4838	100	151	10.773000
14607	4839	100	151	10.298000
14608	4840	100	151	13.710000
14609	4841	100	151	14.047000
14610	4842	100	151	20.459000
14611	4843	100	151	27.234000
14612	4844	100	151	27.356000
14613	4845	100	151	22.536000
14614	4846	100	151	14.858000
14615	4847	100	151	10.395000
14616	4848	100	151	9.394000
14617	4849	100	151	8.933000
14618	4850	100	151	8.831000
14619	4851	100	151	9.596000
14620	4852	100	151	11.555000
14621	4853	100	151	14.193000
14622	4854	100	151	20.071000
14623	4855	100	151	26.230000
14624	4856	100	151	27.079000
14625	4857	100	151	22.620000
14626	4858	100	151	15.009000
14627	4859	100	151	10.569000
14628	4860	100	151	10.065000
14629	4861	100	151	8.491000
14630	4862	100	151	8.935000
14631	4863	100	151	9.778000
14632	4864	100	151	10.978000
14633	4865	100	151	13.388000
14634	4866	100	151	19.062000
14635	4867	100	151	26.690000
14636	4868	100	151	27.101000
14637	4869	100	151	23.153000
14638	4870	100	151	14.813000
14639	4871	100	151	10.291000
14640	4872	100	151	9.193000
14641	4873	100	151	8.617000
14642	4874	100	151	9.035000
14643	4875	100	151	10.198000
14644	4876	100	151	11.469000
14645	4877	100	151	13.957000
14646	4878	100	151	20.737000
14647	4879	100	151	27.121000
14648	4880	100	151	27.671000
14649	4881	100	151	21.182000
14650	4882	100	151	14.574000
14651	4883	100	151	9.901000
14652	4884	100	151	9.312000
14653	4885	100	156	16.506200
14654	4886	100	156	16.506200
14655	4887	100	156	16.506200
14656	4888	100	156	16.506200
14657	4889	100	156	16.506200
14658	4890	100	156	16.506200
14659	4891	100	156	16.506200
14660	4892	100	156	16.506200
14661	4893	100	156	16.506200
14662	4894	100	156	16.506200
14663	4895	100	156	16.506200
14664	4896	100	156	16.506200
14665	4897	100	156	16.506200
14666	4898	100	156	16.506200
14667	4899	100	156	16.506200
14668	4900	100	156	16.506200
14669	4901	100	156	16.506200
14670	4902	100	156	16.506200
14671	4903	100	156	16.506200
14672	4904	100	156	16.506200
14673	4905	100	156	16.506200
14674	4906	100	156	16.506200
14675	4907	100	156	16.506200
14676	4908	100	156	16.506200
14677	4909	100	156	16.506200
14678	4910	100	156	16.506200
14679	4911	100	156	16.506200
14680	4912	100	156	16.506200
14681	4913	100	156	16.506200
14682	4914	100	156	16.506200
14683	4915	100	156	16.506200
14684	4916	100	156	16.506200
14685	4917	100	156	16.506200
14686	4918	100	156	16.506200
14687	4919	100	156	16.506200
14688	4920	100	156	16.506200
14689	4921	100	156	16.506200
14690	4922	100	156	16.506200
14691	4923	100	156	16.506200
14692	4924	100	156	16.506200
14693	4925	100	156	16.506200
14694	4926	100	156	16.506200
14695	4927	100	156	16.506200
14696	4928	100	156	16.506200
14697	4929	100	156	16.506200
14698	4930	100	156	16.506200
14699	4931	100	156	16.506200
14700	4932	100	156	16.506200
14701	4933	100	156	16.506200
14702	4934	100	156	16.506200
14703	4935	100	156	16.506200
14704	4936	100	156	16.506200
14705	4937	100	156	16.506200
14706	4938	100	156	16.506200
14707	4939	100	156	16.506200
14708	4940	100	156	16.506200
14709	4941	100	156	16.506200
14710	4942	100	156	16.506200
14711	4943	100	156	16.506200
14712	4944	100	156	16.506200
14713	4945	100	156	16.506200
14714	4946	100	156	16.506200
14715	4947	100	156	16.506200
14716	4948	100	156	16.506200
14717	4949	100	156	16.506200
14718	4950	100	156	16.506200
14719	4951	100	156	16.506200
14720	4952	100	156	16.506200
14721	4953	100	156	16.506200
14722	4954	100	156	16.506200
14723	4955	100	156	16.506200
14724	4956	100	156	16.506200
14725	4957	100	156	16.506200
14726	4958	100	156	16.506200
14727	4959	100	156	16.506200
14728	4960	100	156	16.506200
14729	4961	100	156	16.506200
14730	4962	100	156	16.506200
14731	4963	100	156	16.506200
14732	4964	100	156	16.506200
14733	4965	100	156	16.506200
14734	4966	100	156	16.506200
14735	4967	100	156	16.506200
14736	4968	100	156	16.506200
14737	4969	100	156	16.506200
14738	4970	100	156	16.506200
14739	4971	100	156	16.506200
14740	4972	100	156	16.506200
14741	4973	100	156	16.506200
14742	4974	100	156	16.506200
14743	4975	100	156	16.506200
14744	4976	100	156	16.506200
14745	4977	100	156	16.506200
14746	4978	100	156	16.506200
14747	4979	100	156	16.506200
14748	4980	100	156	16.506200
14749	4981	100	156	16.506200
14750	4982	100	156	16.506200
14751	4983	100	156	16.506200
14752	4984	100	156	16.506200
14753	4985	100	156	16.506200
14754	4986	100	156	16.506200
14755	4987	100	156	16.506200
14756	4988	100	156	16.506200
14757	4989	100	156	16.506200
14758	4990	100	156	16.506200
14759	4991	100	156	16.506200
14760	4992	100	156	16.506200
14761	4993	100	156	16.506200
14762	4994	100	156	16.506200
14763	4995	100	156	16.506200
14764	4996	100	156	16.506200
14765	4997	100	156	16.506200
14766	4998	100	156	16.506200
14767	4999	100	156	16.506200
14768	5000	100	156	16.506200
14769	5001	100	156	16.506200
14770	5002	100	156	16.506200
14771	5003	100	156	16.506200
14772	5004	100	156	16.506200
14773	5005	100	156	16.506200
14774	5006	100	156	16.506200
14775	5007	100	156	16.506200
14776	5008	100	156	16.506200
14777	5009	100	156	16.506200
14778	5010	100	156	16.506200
14779	5011	100	156	16.506200
14780	5012	100	156	16.506200
14781	5013	100	156	16.506200
14782	5014	100	156	16.506200
14783	5015	100	156	16.506200
14784	5016	100	156	16.506200
14785	4885	100	155	80.648000
14786	4886	100	155	80.648000
14787	4887	100	155	80.648000
14788	4888	100	155	80.648000
14789	4889	100	155	80.648000
14790	4890	100	155	80.648000
14791	4891	100	155	80.648000
14792	4892	100	155	80.648000
14793	4893	100	155	80.648000
14794	4894	100	155	80.648000
14795	4895	100	155	80.648000
14796	4896	100	155	80.648000
14797	4897	100	155	80.648000
14798	4898	100	155	80.648000
14799	4899	100	155	80.648000
14800	4900	100	155	80.648000
14801	4901	100	155	80.648000
14802	4902	100	155	80.648000
14803	4903	100	155	80.648000
14804	4904	100	155	80.648000
14805	4905	100	155	80.648000
14806	4906	100	155	80.648000
14807	4907	100	155	80.648000
14808	4908	100	155	80.648000
14809	4909	100	155	80.648000
14810	4910	100	155	80.648000
14811	4911	100	155	80.648000
14812	4912	100	155	80.648000
14813	4913	100	155	80.648000
14814	4914	100	155	80.648000
14815	4915	100	155	80.648000
14816	4916	100	155	80.648000
14817	4917	100	155	80.648000
14818	4918	100	155	80.648000
14819	4919	100	155	80.648000
14820	4920	100	155	80.648000
14821	4921	100	155	80.648000
14822	4922	100	155	80.648000
14823	4923	100	155	80.648000
14824	4924	100	155	80.648000
14825	4925	100	155	80.648000
14826	4926	100	155	80.648000
14827	4927	100	155	80.648000
14828	4928	100	155	80.648000
14829	4929	100	155	80.648000
14830	4930	100	155	80.648000
14831	4931	100	155	80.648000
14832	4932	100	155	80.648000
14833	4933	100	155	80.648000
14834	4934	100	155	80.648000
14835	4935	100	155	80.648000
14836	4936	100	155	80.648000
14837	4937	100	155	80.648000
14838	4938	100	155	80.648000
14839	4939	100	155	80.648000
14840	4940	100	155	80.648000
14841	4941	100	155	80.648000
14842	4942	100	155	80.648000
14843	4943	100	155	80.648000
14844	4944	100	155	80.648000
14845	4945	100	155	80.648000
14846	4946	100	155	80.648000
14847	4947	100	155	80.648000
14848	4948	100	155	80.648000
14849	4949	100	155	80.648000
14850	4950	100	155	80.648000
14851	4951	100	155	80.648000
14852	4952	100	155	80.648000
14853	4953	100	155	80.648000
14854	4954	100	155	80.648000
14855	4955	100	155	80.648000
14856	4956	100	155	80.648000
14857	4957	100	155	80.648000
14858	4958	100	155	80.648000
14859	4959	100	155	80.648000
14860	4960	100	155	80.648000
14861	4961	100	155	80.648000
14862	4962	100	155	80.648000
14863	4963	100	155	80.648000
14864	4964	100	155	80.648000
14865	4965	100	155	80.648000
14866	4966	100	155	80.648000
14867	4967	100	155	80.648000
14868	4968	100	155	80.648000
14869	4969	100	155	80.648000
14870	4970	100	155	80.648000
14871	4971	100	155	80.648000
14872	4972	100	155	80.648000
14873	4973	100	155	80.648000
14874	4974	100	155	80.648000
14875	4975	100	155	80.648000
14876	4976	100	155	80.648000
14877	4977	100	155	80.648000
14878	4978	100	155	80.648000
14879	4979	100	155	80.648000
14880	4980	100	155	80.648000
14881	4981	100	155	80.648000
14882	4982	100	155	80.648000
14883	4983	100	155	80.648000
14884	4984	100	155	80.648000
14885	4985	100	155	80.648000
14886	4986	100	155	80.648000
14887	4987	100	155	80.648000
14888	4988	100	155	80.648000
14889	4989	100	155	80.648000
14890	4990	100	155	80.648000
14891	4991	100	155	80.648000
14892	4992	100	155	80.648000
14893	4993	100	155	80.648000
14894	4994	100	155	80.648000
14895	4995	100	155	80.648000
14896	4996	100	155	80.648000
14897	4997	100	155	80.648000
14898	4998	100	155	80.648000
14899	4999	100	155	80.648000
14900	5000	100	155	80.648000
14901	5001	100	155	80.648000
14902	5002	100	155	80.648000
14903	5003	100	155	80.648000
14904	5004	100	155	80.648000
14905	5005	100	155	80.648000
14906	5006	100	155	80.648000
14907	5007	100	155	80.648000
14908	5008	100	155	80.648000
14909	5009	100	155	80.648000
14910	5010	100	155	80.648000
14911	5011	100	155	80.648000
14912	5012	100	155	80.648000
14913	5013	100	155	80.648000
14914	5014	100	155	80.648000
14915	5015	100	155	80.648000
14916	5016	100	155	80.648000
14917	4885	100	154	17.397000
14918	4886	100	154	20.279000
14919	4887	100	154	23.056000
14920	4888	100	154	26.851000
14921	4889	100	154	28.942000
14922	4890	100	154	29.605000
14923	4891	100	154	28.997000
14924	4892	100	154	27.835000
14925	4893	100	154	28.144000
14926	4894	100	154	25.201000
14927	4895	100	154	19.991000
14928	4896	100	154	15.924000
14929	4897	100	154	18.511000
14930	4898	100	154	20.083000
14931	4899	100	154	23.022000
14932	4900	100	154	26.806000
14933	4901	100	154	29.069000
14934	4902	100	154	29.380000
14935	4903	100	154	28.710000
14936	4904	100	154	28.019000
14937	4905	100	154	28.151000
14938	4906	100	154	25.504000
14939	4907	100	154	19.613000
14940	4908	100	154	16.523000
14941	4909	100	154	17.681000
14942	4910	100	154	20.279000
14943	4911	100	154	23.807000
14944	4912	100	154	26.800000
14945	4913	100	154	28.905000
14946	4914	100	154	29.364000
14947	4915	100	154	28.008000
14948	4916	100	154	27.917000
14949	4917	100	154	28.093000
14950	4918	100	154	25.201000
14951	4919	100	154	19.643000
14952	4920	100	154	16.964000
14953	4921	100	154	17.243000
14954	4922	100	154	20.279000
14955	4923	100	154	23.020000
14956	4924	100	154	26.806000
14957	4925	100	154	28.136000
14958	4926	100	154	30.728000
14959	4927	100	154	28.016000
14960	4928	100	154	28.014000
14961	4929	100	154	28.182000
14962	4930	100	154	25.201000
14963	4931	100	154	20.177000
14964	4932	100	154	16.971000
14965	4933	100	154	18.301000
14966	4934	100	154	20.279000
14967	4935	100	154	23.150000
14968	4936	100	154	26.820000
14969	4937	100	154	29.460000
14970	4938	100	154	28.700000
14971	4939	100	154	27.929000
14972	4940	100	154	27.873000
14973	4941	100	154	28.130000
14974	4942	100	154	25.201000
14975	4943	100	154	19.643000
14976	4944	100	154	17.015000
14977	4945	100	154	17.148000
14978	4946	100	154	19.764000
14979	4947	100	154	23.133000
14980	4948	100	154	25.282000
14981	4949	100	154	29.041000
14982	4950	100	154	31.266000
14983	4951	100	154	29.295000
14984	4952	100	154	28.181000
14985	4953	100	154	28.144000
14986	4954	100	154	25.201000
14987	4955	100	154	20.909000
14988	4956	100	154	18.561000
14989	4957	100	154	19.271000
14990	4958	100	154	20.852000
14991	4959	100	154	23.040000
14992	4960	100	154	26.851000
14993	4961	100	154	28.996000
14994	4962	100	154	30.358000
14995	4963	100	154	29.256000
14996	4964	100	154	28.234000
14997	4965	100	154	28.151000
14998	4966	100	154	26.228000
14999	4967	100	154	21.268000
15000	4968	100	154	16.899000
15001	4969	100	154	17.534000
15002	4970	100	154	21.412000
15003	4971	100	154	24.383000
15004	4972	100	154	28.100000
15005	4973	100	154	28.935000
15006	4974	100	154	29.361000
15007	4975	100	154	27.936000
15008	4976	100	154	27.880000
15009	4977	100	154	28.144000
15010	4978	100	154	25.201000
15011	4979	100	154	19.650000
15012	4980	100	154	17.494000
15013	4981	100	154	18.597000
15014	4982	100	154	20.205000
15015	4983	100	154	23.200000
15016	4984	100	154	27.318000
15017	4985	100	154	28.905000
15018	4986	100	154	28.625000
15019	4987	100	154	27.910000
15020	4988	100	154	27.880000
15021	4989	100	154	28.151000
15022	4990	100	154	26.489000
15023	4991	100	154	19.637000
15024	4992	100	154	16.964000
15025	4993	100	154	17.681000
15026	4994	100	154	20.472000
15027	4995	100	154	23.072000
15028	4996	100	154	25.845000
15029	4997	100	154	29.350000
15030	4998	100	154	28.905000
15031	4999	100	154	28.160000
15032	5000	100	154	27.873000
15033	5001	100	154	29.982000
15034	5002	100	154	25.225000
15035	5003	100	154	21.356000
15036	5004	100	154	16.964000
15037	5005	100	154	18.184000
15038	5006	100	154	20.279000
15039	5007	100	154	24.246000
15040	5008	100	154	26.858000
15041	5009	100	154	30.694000
15042	5010	100	154	29.380000
15043	5011	100	154	29.302000
15044	5012	100	154	27.880000
15045	5013	100	154	28.794000
15046	5014	100	154	25.201000
15047	5015	100	154	19.650000
15048	5016	100	154	17.165000
15049	5017	100	159	20.117000
15050	5018	100	159	20.117000
15051	5019	100	159	20.117000
15052	5020	100	159	20.117000
15053	5021	100	159	20.117000
15054	5022	100	159	20.117000
15055	5023	100	159	20.117000
15056	5024	100	159	20.117000
15057	5025	100	159	20.117000
15058	5026	100	159	20.117000
15059	5027	100	159	20.117000
15060	5028	100	159	20.117000
15061	5029	100	159	20.117000
15062	5030	100	159	20.117000
15063	5031	100	159	20.117000
15064	5032	100	159	20.117000
15065	5033	100	159	20.117000
15066	5034	100	159	20.117000
15067	5035	100	159	20.117000
15068	5036	100	159	20.117000
15069	5037	100	159	20.117000
15070	5038	100	159	20.117000
15071	5039	100	159	20.117000
15072	5040	100	159	20.117000
15073	5041	100	159	20.117000
15074	5042	100	159	20.117000
15075	5043	100	159	20.117000
15076	5044	100	159	20.117000
15077	5045	100	159	20.117000
15078	5046	100	159	20.117000
15079	5047	100	159	20.117000
15080	5048	100	159	20.117000
15081	5049	100	159	20.117000
15082	5050	100	159	20.117000
15083	5051	100	159	20.117000
15084	5052	100	159	20.117000
15085	5053	100	159	20.117000
15086	5054	100	159	20.117000
15087	5055	100	159	20.117000
15088	5056	100	159	20.117000
15089	5057	100	159	20.117000
15090	5058	100	159	20.117000
15091	5059	100	159	20.117000
15092	5060	100	159	20.117000
15093	5061	100	159	20.117000
15094	5062	100	159	20.117000
15095	5063	100	159	20.117000
15096	5064	100	159	20.117000
15097	5065	100	159	20.117000
15098	5066	100	159	20.117000
15099	5067	100	159	20.117000
15100	5068	100	159	20.117000
15101	5069	100	159	20.117000
15102	5070	100	159	20.117000
15103	5071	100	159	20.117000
15104	5072	100	159	20.117000
15105	5073	100	159	20.117000
15106	5074	100	159	20.117000
15107	5075	100	159	20.117000
15108	5076	100	159	20.117000
15109	5077	100	159	20.117000
15110	5078	100	159	20.117000
15111	5079	100	159	20.117000
15112	5080	100	159	20.117000
15113	5081	100	159	20.117000
15114	5082	100	159	20.117000
15115	5083	100	159	20.117000
15116	5084	100	159	20.117000
15117	5085	100	159	20.117000
15118	5086	100	159	20.117000
15119	5087	100	159	20.117000
15120	5088	100	159	20.117000
15121	5089	100	159	20.117000
15122	5090	100	159	20.117000
15123	5091	100	159	20.117000
15124	5092	100	159	20.117000
15125	5093	100	159	20.117000
15126	5094	100	159	20.117000
15127	5095	100	159	20.117000
15128	5096	100	159	20.117000
15129	5097	100	159	20.117000
15130	5098	100	159	20.117000
15131	5099	100	159	20.117000
15132	5100	100	159	20.117000
15133	5101	100	159	20.117000
15134	5102	100	159	20.117000
15135	5103	100	159	20.117000
15136	5104	100	159	20.117000
15137	5105	100	159	20.117000
15138	5106	100	159	20.117000
15139	5107	100	159	20.117000
15140	5108	100	159	20.117000
15141	5109	100	159	20.117000
15142	5110	100	159	20.117000
15143	5111	100	159	20.117000
15144	5112	100	159	20.117000
15145	5113	100	159	20.117000
15146	5114	100	159	20.117000
15147	5115	100	159	20.117000
15148	5116	100	159	20.117000
15149	5117	100	159	20.117000
15150	5118	100	159	20.117000
15151	5119	100	159	20.117000
15152	5120	100	159	20.117000
15153	5121	100	159	20.117000
15154	5122	100	159	20.117000
15155	5123	100	159	20.117000
15156	5124	100	159	20.117000
15157	5125	100	159	20.117000
15158	5126	100	159	20.117000
15159	5127	100	159	20.117000
15160	5128	100	159	20.117000
15161	5129	100	159	20.117000
15162	5130	100	159	20.117000
15163	5131	100	159	20.117000
15164	5132	100	159	20.117000
15165	5133	100	159	20.117000
15166	5134	100	159	20.117000
15167	5135	100	159	20.117000
15168	5136	100	159	20.117000
15169	5137	100	159	20.117000
15170	5138	100	159	20.117000
15171	5139	100	159	20.117000
15172	5140	100	159	20.117000
15173	5141	100	159	20.117000
15174	5142	100	159	20.117000
15175	5143	100	159	20.117000
15176	5144	100	159	20.117000
15177	5145	100	159	20.117000
15178	5146	100	159	20.117000
15179	5147	100	159	20.117000
15180	5148	100	159	20.117000
15181	5017	100	158	78.110800
15182	5018	100	158	78.110800
15183	5019	100	158	78.110800
15184	5020	100	158	78.110800
15185	5021	100	158	78.110800
15186	5022	100	158	78.110800
15187	5023	100	158	78.110800
15188	5024	100	158	78.110800
15189	5025	100	158	78.110800
15190	5026	100	158	78.110800
15191	5027	100	158	78.110800
15192	5028	100	158	78.110800
15193	5029	100	158	78.110800
15194	5030	100	158	78.110800
15195	5031	100	158	78.110800
15196	5032	100	158	78.110800
15197	5033	100	158	78.110800
15198	5034	100	158	78.110800
15199	5035	100	158	78.110800
15200	5036	100	158	78.110800
15201	5037	100	158	78.110800
15202	5038	100	158	78.110800
15203	5039	100	158	78.110800
15204	5040	100	158	78.110800
15205	5041	100	158	78.110800
15206	5042	100	158	78.110800
15207	5043	100	158	78.110800
15208	5044	100	158	78.110800
15209	5045	100	158	78.110800
15210	5046	100	158	78.110800
15211	5047	100	158	78.110800
15212	5048	100	158	78.110800
15213	5049	100	158	78.110800
15214	5050	100	158	78.110800
15215	5051	100	158	78.110800
15216	5052	100	158	78.110800
15217	5053	100	158	78.110800
15218	5054	100	158	78.110800
15219	5055	100	158	78.110800
15220	5056	100	158	78.110800
15221	5057	100	158	78.110800
15222	5058	100	158	78.110800
15223	5059	100	158	78.110800
15224	5060	100	158	78.110800
15225	5061	100	158	78.110800
15226	5062	100	158	78.110800
15227	5063	100	158	78.110800
15228	5064	100	158	78.110800
15229	5065	100	158	78.110800
15230	5066	100	158	78.110800
15231	5067	100	158	78.110800
15232	5068	100	158	78.110800
15233	5069	100	158	78.110800
15234	5070	100	158	78.110800
15235	5071	100	158	78.110800
15236	5072	100	158	78.110800
15237	5073	100	158	78.110800
15238	5074	100	158	78.110800
15239	5075	100	158	78.110800
15240	5076	100	158	78.110800
15241	5077	100	158	78.110800
15242	5078	100	158	78.110800
15243	5079	100	158	78.110800
15244	5080	100	158	78.110800
15245	5081	100	158	78.110800
15246	5082	100	158	78.110800
15247	5083	100	158	78.110800
15248	5084	100	158	78.110800
15249	5085	100	158	78.110800
15250	5086	100	158	78.110800
15251	5087	100	158	78.110800
15252	5088	100	158	78.110800
15253	5089	100	158	78.110800
15254	5090	100	158	78.110800
15255	5091	100	158	78.110800
15256	5092	100	158	78.110800
15257	5093	100	158	78.110800
15258	5094	100	158	78.110800
15259	5095	100	158	78.110800
15260	5096	100	158	78.110800
15261	5097	100	158	78.110800
15262	5098	100	158	78.110800
15263	5099	100	158	78.110800
15264	5100	100	158	78.110800
15265	5101	100	158	78.110800
15266	5102	100	158	78.110800
15267	5103	100	158	78.110800
15268	5104	100	158	78.110800
15269	5105	100	158	78.110800
15270	5106	100	158	78.110800
15271	5107	100	158	78.110800
15272	5108	100	158	78.110800
15273	5109	100	158	78.110800
15274	5110	100	158	78.110800
15275	5111	100	158	78.110800
15276	5112	100	158	78.110800
15277	5113	100	158	78.110800
15278	5114	100	158	78.110800
15279	5115	100	158	78.110800
15280	5116	100	158	78.110800
15281	5117	100	158	78.110800
15282	5118	100	158	78.110800
15283	5119	100	158	78.110800
15284	5120	100	158	78.110800
15285	5121	100	158	78.110800
15286	5122	100	158	78.110800
15287	5123	100	158	78.110800
15288	5124	100	158	78.110800
15289	5125	100	158	78.110800
15290	5126	100	158	78.110800
15291	5127	100	158	78.110800
15292	5128	100	158	78.110800
15293	5129	100	158	78.110800
15294	5130	100	158	78.110800
15295	5131	100	158	78.110800
15296	5132	100	158	78.110800
15297	5133	100	158	78.110800
15298	5134	100	158	78.110800
15299	5135	100	158	78.110800
15300	5136	100	158	78.110800
15301	5137	100	158	78.110800
15302	5138	100	158	78.110800
15303	5139	100	158	78.110800
15304	5140	100	158	78.110800
15305	5141	100	158	78.110800
15306	5142	100	158	78.110800
15307	5143	100	158	78.110800
15308	5144	100	158	78.110800
15309	5145	100	158	78.110800
15310	5146	100	158	78.110800
15311	5147	100	158	78.110800
15312	5148	100	158	78.110800
15313	5017	100	157	12.793000
15314	5018	100	157	12.129000
15315	5019	100	157	12.346000
15316	5020	100	157	14.866000
15317	5021	100	157	17.193000
15318	5022	100	157	18.852000
15319	5023	100	157	30.993000
15320	5024	100	157	27.446000
15321	5025	100	157	26.750000
15322	5026	100	157	18.626000
15323	5027	100	157	15.347000
15324	5028	100	157	12.420000
15325	5029	100	157	13.386000
15326	5030	100	157	12.369000
15327	5031	100	157	11.312000
15328	5032	100	157	14.961000
15329	5033	100	157	17.381000
15330	5034	100	157	18.958000
15331	5035	100	157	29.106000
15332	5036	100	157	27.517000
15333	5037	100	157	26.750000
15334	5038	100	157	18.621000
15335	5039	100	157	14.893000
15336	5040	100	157	12.276000
15337	5041	100	157	13.574000
15338	5042	100	157	12.267000
15339	5043	100	157	12.764000
15340	5044	100	157	14.331000
15341	5045	100	157	17.355000
15342	5046	100	157	16.459000
15343	5047	100	157	28.093000
15344	5048	100	157	27.423000
15345	5049	100	157	26.770000
15346	5050	100	157	18.657000
15347	5051	100	157	14.993000
15348	5052	100	157	12.881000
15349	5053	100	157	11.474000
15350	5054	100	157	12.258000
15351	5055	100	157	11.324000
15352	5056	100	157	14.787000
15353	5057	100	157	15.384000
15354	5058	100	157	20.294000
15355	5059	100	157	29.106000
15356	5060	100	157	28.538000
15357	5061	100	157	26.750000
15358	5062	100	157	18.562000
15359	5063	100	157	15.113000
15360	5064	100	157	13.938000
15361	5065	100	157	14.851000
15362	5066	100	157	12.895000
15363	5067	100	157	12.732000
15364	5068	100	157	14.884000
15365	5069	100	157	18.038000
15366	5070	100	157	19.234000
15367	5071	100	157	29.207000
15368	5072	100	157	27.446000
15369	5073	100	157	26.750000
15370	5074	100	157	18.618000
15371	5075	100	157	14.954000
15372	5076	100	157	13.049000
15373	5077	100	157	12.265000
15374	5078	100	157	11.729000
15375	5079	100	157	11.929000
15376	5080	100	157	13.008000
15377	5081	100	157	15.538000
15378	5082	100	157	18.446000
15379	5083	100	157	29.108000
15380	5084	100	157	27.994000
15381	5085	100	157	26.752000
15382	5086	100	157	18.629000
15383	5087	100	157	16.434000
15384	5088	100	157	13.815000
15385	5089	100	157	13.651000
15386	5090	100	157	12.427000
15387	5091	100	157	11.809000
15388	5092	100	157	15.382000
15389	5093	100	157	17.286000
15390	5094	100	157	19.841000
15391	5095	100	157	30.234000
15392	5096	100	157	29.162000
15393	5097	100	157	26.750000
15394	5098	100	157	18.846000
15395	5099	100	157	15.119000
15396	5100	100	157	13.042000
15397	5101	100	157	12.693000
15398	5102	100	157	12.587000
15399	5103	100	157	12.494000
15400	5104	100	157	15.717000
15401	5105	100	157	16.168000
15402	5106	100	157	16.600000
15403	5107	100	157	29.106000
15404	5108	100	157	27.463000
15405	5109	100	157	26.750000
15406	5110	100	157	18.616000
15407	5111	100	157	14.988000
15408	5112	100	157	13.084000
15409	5113	100	157	13.568000
15410	5114	100	157	11.857000
15411	5115	100	157	11.671000
15412	5116	100	157	15.840000
15413	5117	100	157	15.559000
15414	5118	100	157	16.414000
15415	5119	100	157	29.106000
15416	5120	100	157	28.525000
15417	5121	100	157	26.750000
15418	5122	100	157	19.741000
15419	5123	100	157	15.911000
15420	5124	100	157	13.084000
15421	5125	100	157	13.150000
15422	5126	100	157	13.065000
15423	5127	100	157	11.929000
15424	5128	100	157	14.833000
15425	5129	100	157	17.065000
15426	5130	100	157	16.324000
15427	5131	100	157	29.106000
15428	5132	100	157	27.368000
15429	5133	100	157	28.449000
15430	5134	100	157	18.627000
15431	5135	100	157	15.443000
15432	5136	100	157	13.789000
15433	5137	100	157	13.150000
15434	5138	100	157	12.420000
15435	5139	100	157	12.717000
15436	5140	100	157	15.887000
15437	5141	100	157	17.317000
15438	5142	100	157	17.711000
15439	5143	100	157	29.615000
15440	5144	100	157	27.460000
15441	5145	100	157	26.750000
15442	5146	100	157	18.588000
15443	5147	100	157	14.954000
15444	5148	100	157	13.830000
15445	5149	100	4	23.022500
15446	5150	100	4	23.022500
15447	5151	100	4	23.022500
15448	5152	100	4	23.022500
15449	5153	100	4	23.022500
15450	5154	100	4	23.022500
15451	5155	100	4	23.022500
15452	5156	100	4	23.022500
15453	5157	100	4	23.022500
15454	5158	100	4	23.022500
15455	5159	100	4	23.022500
15456	5160	100	4	23.022500
15457	5161	100	4	23.022500
15458	5162	100	4	23.022500
15459	5163	100	4	23.022500
15460	5164	100	4	23.022500
15461	5165	100	4	23.022500
15462	5166	100	4	23.022500
15463	5167	100	4	23.022500
15464	5168	100	4	23.022500
15465	5169	100	4	23.022500
15466	5170	100	4	23.022500
15467	5171	100	4	23.022500
15468	5172	100	4	23.022500
15469	5173	100	4	23.022500
15470	5174	100	4	23.022500
15471	5175	100	4	23.022500
15472	5176	100	4	23.022500
15473	5177	100	4	23.022500
15474	5178	100	4	23.022500
15475	5179	100	4	23.022500
15476	5180	100	4	23.022500
15477	5181	100	4	23.022500
15478	5182	100	4	23.022500
15479	5183	100	4	23.022500
15480	5184	100	4	23.022500
15481	5185	100	4	23.022500
15482	5186	100	4	23.022500
15483	5187	100	4	23.022500
15484	5188	100	4	23.022500
15485	5189	100	4	23.022500
15486	5190	100	4	23.022500
15487	5191	100	4	23.022500
15488	5192	100	4	23.022500
15489	5193	100	4	23.022500
15490	5194	100	4	23.022500
15491	5195	100	4	23.022500
15492	5196	100	4	23.022500
15493	5197	100	4	23.022500
15494	5198	100	4	23.022500
15495	5199	100	4	23.022500
15496	5200	100	4	23.022500
15497	5201	100	4	23.022500
15498	5202	100	4	23.022500
15499	5203	100	4	23.022500
15500	5204	100	4	23.022500
15501	5205	100	4	23.022500
15502	5206	100	4	23.022500
15503	5207	100	4	23.022500
15504	5208	100	4	23.022500
15505	5209	100	4	23.022500
15506	5210	100	4	23.022500
15507	5211	100	4	23.022500
15508	5212	100	4	23.022500
15509	5213	100	4	23.022500
15510	5214	100	4	23.022500
15511	5215	100	4	23.022500
15512	5216	100	4	23.022500
15513	5217	100	4	23.022500
15514	5218	100	4	23.022500
15515	5219	100	4	23.022500
15516	5220	100	4	23.022500
15517	5221	100	4	23.022500
15518	5222	100	4	23.022500
15519	5223	100	4	23.022500
15520	5224	100	4	23.022500
15521	5225	100	4	23.022500
15522	5226	100	4	23.022500
15523	5227	100	4	23.022500
15524	5228	100	4	23.022500
15525	5229	100	4	23.022500
15526	5230	100	4	23.022500
15527	5231	100	4	23.022500
15528	5232	100	4	23.022500
15529	5233	100	4	23.022500
15530	5234	100	4	23.022500
15531	5235	100	4	23.022500
15532	5236	100	4	23.022500
15533	5237	100	4	23.022500
15534	5238	100	4	23.022500
15535	5239	100	4	23.022500
15536	5240	100	4	23.022500
15537	5241	100	4	23.022500
15538	5242	100	4	23.022500
15539	5243	100	4	23.022500
15540	5244	100	4	23.022500
15541	5245	100	4	23.022500
15542	5246	100	4	23.022500
15543	5247	100	4	23.022500
15544	5248	100	4	23.022500
15545	5249	100	4	23.022500
15546	5250	100	4	23.022500
15547	5251	100	4	23.022500
15548	5252	100	4	23.022500
15549	5253	100	4	23.022500
15550	5254	100	4	23.022500
15551	5255	100	4	23.022500
15552	5256	100	4	23.022500
15553	5257	100	4	23.022500
15554	5258	100	4	23.022500
15555	5259	100	4	23.022500
15556	5260	100	4	23.022500
15557	5261	100	4	23.022500
15558	5262	100	4	23.022500
15559	5263	100	4	23.022500
15560	5264	100	4	23.022500
15561	5265	100	4	23.022500
15562	5266	100	4	23.022500
15563	5267	100	4	23.022500
15564	5268	100	4	23.022500
15565	5269	100	4	23.022500
15566	5270	100	4	23.022500
15567	5271	100	4	23.022500
15568	5272	100	4	23.022500
15569	5273	100	4	23.022500
15570	5274	100	4	23.022500
15571	5275	100	4	23.022500
15572	5276	100	4	23.022500
15573	5277	100	4	23.022500
15574	5278	100	4	23.022500
15575	5279	100	4	23.022500
15576	5280	100	4	23.022500
15577	5149	200	6	20.194000
15578	5150	200	6	20.194000
15579	5151	200	6	26.234000
15580	5152	200	6	29.050000
15581	5153	200	6	32.768000
15582	5154	200	6	33.005000
15583	5155	200	6	29.876000
15584	5156	200	6	28.165000
15585	5157	200	6	27.528000
15586	5158	200	6	27.998000
15587	5159	200	6	24.750000
15588	5160	200	6	22.431000
15589	5161	200	6	20.893000
15590	5162	200	6	23.171000
15591	5163	200	6	26.168000
15592	5164	200	6	30.286000
15593	5165	200	6	33.099000
15594	5166	200	6	32.898000
15595	5167	200	6	29.377000
15596	5168	200	6	29.527000
15597	5169	200	6	28.883000
15598	5170	200	6	29.321000
15599	5171	200	6	26.181000
15600	5172	200	6	22.732000
15601	5173	200	6	21.430000
15602	5174	200	6	21.650000
15603	5175	200	6	28.272000
15604	5176	200	6	30.177000
15605	5177	200	6	33.080000
15606	5178	200	6	31.308000
15607	5179	200	6	27.812000
15608	5180	200	6	28.519000
15609	5181	200	6	28.262000
15610	5182	200	6	28.089000
15611	5183	200	6	25.216000
15612	5184	200	6	20.928000
15613	5185	200	6	19.262000
15614	5186	200	6	22.238000
15615	5187	200	6	25.594000
15616	5188	200	6	29.843000
15617	5189	200	6	33.176000
15618	5190	200	6	33.619000
15619	5191	200	6	30.055000
15620	5192	200	6	29.053000
15621	5193	200	6	29.122000
15622	5194	200	6	29.887000
15623	5195	200	6	24.793000
15624	5196	200	6	22.100000
15625	5197	200	6	20.488000
15626	5198	200	6	23.155000
15627	5199	200	6	28.607000
15628	5200	200	6	30.464000
15629	5201	200	6	32.838000
15630	5202	200	6	32.226000
15631	5203	200	6	29.515000
15632	5204	200	6	27.684000
15633	5205	200	6	27.960000
15634	5206	200	6	28.094000
15635	5207	200	6	24.368000
15636	5208	200	6	21.771000
15637	5209	200	6	19.591000
15638	5210	200	6	21.546000
15639	5211	200	6	27.106000
15640	5212	200	6	29.048000
15641	5213	200	6	31.695000
15642	5214	200	6	31.345000
15643	5215	200	6	29.322000
15644	5216	200	6	27.923000
15645	5217	200	6	28.403000
15646	5218	200	6	27.834000
15647	5219	200	6	26.119000
15648	5220	200	6	20.945000
15649	5221	200	6	20.103000
15650	5222	200	6	21.675000
15651	5223	200	6	26.144000
15652	5224	200	6	31.286000
15653	5225	200	6	33.792000
15654	5226	200	6	32.623000
15655	5227	200	6	29.315000
15656	5228	200	6	29.005000
15657	5229	200	6	28.352000
15658	5230	200	6	30.246000
15659	5231	200	6	24.580000
15660	5232	200	6	20.962000
15661	5233	200	6	19.304000
15662	5234	200	6	23.199000
15663	5235	200	6	26.686000
15664	5236	200	6	30.845000
15665	5237	200	6	32.084000
15666	5238	200	6	31.107000
15667	5239	200	6	29.170000
15668	5240	200	6	28.159000
15669	5241	200	6	29.081000
15670	5242	200	6	27.791000
15671	5243	200	6	25.049000
15672	5244	200	6	21.128000
15673	5245	200	6	20.681000
15674	5246	200	6	20.870000
15675	5247	200	6	25.956000
15676	5248	200	6	31.183000
15677	5249	200	6	31.984000
15678	5250	200	6	32.178000
15679	5251	200	6	28.688000
15680	5252	200	6	28.666000
15681	5253	200	6	28.881000
15682	5254	200	6	29.498000
15683	5255	200	6	25.840000
15684	5256	200	6	22.206000
15685	5257	200	6	19.812000
15686	5258	200	6	21.829000
15687	5259	200	6	26.792000
15688	5260	200	6	30.457000
15689	5261	200	6	32.568000
15690	5262	200	6	29.960000
15691	5263	200	6	27.904000
15692	5264	200	6	28.177000
15693	5265	200	6	29.499000
15694	5266	200	6	29.384000
15695	5267	200	6	25.556000
15696	5268	200	6	21.893000
15697	5269	200	6	19.704000
15698	5270	200	6	21.995000
15699	5271	200	6	27.376000
15700	5272	200	6	31.222000
15701	5273	200	6	33.466000
15702	5274	200	6	32.057000
15703	5275	200	6	29.678000
15704	5276	200	6	27.872000
15705	5277	200	6	28.405000
15706	5278	200	6	29.839000
15707	5279	200	6	25.562000
15708	5280	200	6	22.445000
15709	5149	100	5	72.571400
15710	5150	100	5	72.571400
15711	5151	100	5	72.571400
15712	5152	100	5	72.571400
15713	5153	100	5	72.571400
15714	5154	100	5	72.571400
15715	5155	100	5	72.571400
15716	5156	100	5	72.571400
15717	5157	100	5	72.571400
15718	5158	100	5	72.571400
15719	5159	100	5	72.571400
15720	5160	100	5	72.571400
15721	5161	100	5	72.571400
15722	5162	100	5	72.571400
15723	5163	100	5	72.571400
15724	5164	100	5	72.571400
15725	5165	100	5	72.571400
15726	5166	100	5	72.571400
15727	5167	100	5	72.571400
15728	5168	100	5	72.571400
15729	5169	100	5	72.571400
15730	5170	100	5	72.571400
15731	5171	100	5	72.571400
15732	5172	100	5	72.571400
15733	5173	100	5	72.571400
15734	5174	100	5	72.571400
15735	5175	100	5	72.571400
15736	5176	100	5	72.571400
15737	5177	100	5	72.571400
15738	5178	100	5	72.571400
15739	5179	100	5	72.571400
15740	5180	100	5	72.571400
15741	5181	100	5	72.571400
15742	5182	100	5	72.571400
15743	5183	100	5	72.571400
15744	5184	100	5	72.571400
15745	5185	100	5	72.571400
15746	5186	100	5	72.571400
15747	5187	100	5	72.571400
15748	5188	100	5	72.571400
15749	5189	100	5	72.571400
15750	5190	100	5	72.571400
15751	5191	100	5	72.571400
15752	5192	100	5	72.571400
15753	5193	100	5	72.571400
15754	5194	100	5	72.571400
15755	5195	100	5	72.571400
15756	5196	100	5	72.571400
15757	5197	100	5	72.571400
15758	5198	100	5	72.571400
15759	5199	100	5	72.571400
15760	5200	100	5	72.571400
15761	5201	100	5	72.571400
15762	5202	100	5	72.571400
15763	5203	100	5	72.571400
15764	5204	100	5	72.571400
15765	5205	100	5	72.571400
15766	5206	100	5	72.571400
15767	5207	100	5	72.571400
15768	5208	100	5	72.571400
15769	5209	100	5	72.571400
15770	5210	100	5	72.571400
15771	5211	100	5	72.571400
15772	5212	100	5	72.571400
15773	5213	100	5	72.571400
15774	5214	100	5	72.571400
15775	5215	100	5	72.571400
15776	5216	100	5	72.571400
15777	5217	100	5	72.571400
15778	5218	100	5	72.571400
15779	5219	100	5	72.571400
15780	5220	100	5	72.571400
15781	5221	100	5	72.571400
15782	5222	100	5	72.571400
15783	5223	100	5	72.571400
15784	5224	100	5	72.571400
15785	5225	100	5	72.571400
15786	5226	100	5	72.571400
15787	5227	100	5	72.571400
15788	5228	100	5	72.571400
15789	5229	100	5	72.571400
15790	5230	100	5	72.571400
15791	5231	100	5	72.571400
15792	5232	100	5	72.571400
15793	5233	100	5	72.571400
15794	5234	100	5	72.571400
15795	5235	100	5	72.571400
15796	5236	100	5	72.571400
15797	5237	100	5	72.571400
15798	5238	100	5	72.571400
15799	5239	100	5	72.571400
15800	5240	100	5	72.571400
15801	5241	100	5	72.571400
15802	5242	100	5	72.571400
15803	5243	100	5	72.571400
15804	5244	100	5	72.571400
15805	5245	100	5	72.571400
15806	5246	100	5	72.571400
15807	5247	100	5	72.571400
15808	5248	100	5	72.571400
15809	5249	100	5	72.571400
15810	5250	100	5	72.571400
15811	5251	100	5	72.571400
15812	5252	100	5	72.571400
15813	5253	100	5	72.571400
15814	5254	100	5	72.571400
15815	5255	100	5	72.571400
15816	5256	100	5	72.571400
15817	5257	100	5	72.571400
15818	5258	100	5	72.571400
15819	5259	100	5	72.571400
15820	5260	100	5	72.571400
15821	5261	100	5	72.571400
15822	5262	100	5	72.571400
15823	5263	100	5	72.571400
15824	5264	100	5	72.571400
15825	5265	100	5	72.571400
15826	5266	100	5	72.571400
15827	5267	100	5	72.571400
15828	5268	100	5	72.571400
15829	5269	100	5	72.571400
15830	5270	100	5	72.571400
15831	5271	100	5	72.571400
15832	5272	100	5	72.571400
15833	5273	100	5	72.571400
15834	5274	100	5	72.571400
15835	5275	100	5	72.571400
15836	5276	100	5	72.571400
15837	5277	100	5	72.571400
15838	5278	100	5	72.571400
15839	5279	100	5	72.571400
15840	5280	100	5	72.571400
15841	5281	100	9	23.727100
15842	5282	100	9	23.727100
15843	5283	100	9	23.727100
15844	5284	100	9	23.727100
15845	5285	100	9	23.727100
15846	5286	100	9	23.727100
15847	5287	100	9	23.727100
15848	5288	100	9	23.727100
15849	5289	100	9	23.727100
15850	5290	100	9	23.727100
15851	5291	100	9	23.727100
15852	5292	100	9	23.727100
15853	5293	100	9	23.727100
15854	5294	100	9	23.727100
15855	5295	100	9	23.727100
15856	5296	100	9	23.727100
15857	5297	100	9	23.727100
15858	5298	100	9	23.727100
15859	5299	100	9	23.727100
15860	5300	100	9	23.727100
15861	5301	100	9	23.727100
15862	5302	100	9	23.727100
15863	5303	100	9	23.727100
15864	5304	100	9	23.727100
15865	5305	100	9	23.727100
15866	5306	100	9	23.727100
15867	5307	100	9	23.727100
15868	5308	100	9	23.727100
15869	5309	100	9	23.727100
15870	5310	100	9	23.727100
15871	5311	100	9	23.727100
15872	5312	100	9	23.727100
15873	5313	100	9	23.727100
15874	5314	100	9	23.727100
15875	5315	100	9	23.727100
15876	5316	100	9	23.727100
15877	5317	100	9	23.727100
15878	5318	100	9	23.727100
15879	5319	100	9	23.727100
15880	5320	100	9	23.727100
15881	5321	100	9	23.727100
15882	5322	100	9	23.727100
15883	5323	100	9	23.727100
15884	5324	100	9	23.727100
15885	5325	100	9	23.727100
15886	5326	100	9	23.727100
15887	5327	100	9	23.727100
15888	5328	100	9	23.727100
15889	5329	100	9	23.727100
15890	5330	100	9	23.727100
15891	5331	100	9	23.727100
15892	5332	100	9	23.727100
15893	5333	100	9	23.727100
15894	5334	100	9	23.727100
15895	5335	100	9	23.727100
15896	5336	100	9	23.727100
15897	5337	100	9	23.727100
15898	5338	100	9	23.727100
15899	5339	100	9	23.727100
15900	5340	100	9	23.727100
15901	5341	100	9	23.727100
15902	5342	100	9	23.727100
15903	5343	100	9	23.727100
15904	5344	100	9	23.727100
15905	5345	100	9	23.727100
15906	5346	100	9	23.727100
15907	5347	100	9	23.727100
15908	5348	100	9	23.727100
15909	5349	100	9	23.727100
15910	5350	100	9	23.727100
15911	5351	100	9	23.727100
15912	5352	100	9	23.727100
15913	5353	100	9	23.727100
15914	5354	100	9	23.727100
15915	5355	100	9	23.727100
15916	5356	100	9	23.727100
15917	5357	100	9	23.727100
15918	5358	100	9	23.727100
15919	5359	100	9	23.727100
15920	5360	100	9	23.727100
15921	5361	100	9	23.727100
15922	5362	100	9	23.727100
15923	5363	100	9	23.727100
15924	5364	100	9	23.727100
15925	5365	100	9	23.727100
15926	5366	100	9	23.727100
15927	5367	100	9	23.727100
15928	5368	100	9	23.727100
15929	5369	100	9	23.727100
15930	5370	100	9	23.727100
15931	5371	100	9	23.727100
15932	5372	100	9	23.727100
15933	5373	100	9	23.727100
15934	5374	100	9	23.727100
15935	5375	100	9	23.727100
15936	5376	100	9	23.727100
15937	5377	100	9	23.727100
15938	5378	100	9	23.727100
15939	5379	100	9	23.727100
15940	5380	100	9	23.727100
15941	5381	100	9	23.727100
15942	5382	100	9	23.727100
15943	5383	100	9	23.727100
15944	5384	100	9	23.727100
15945	5385	100	9	23.727100
15946	5386	100	9	23.727100
15947	5387	100	9	23.727100
15948	5388	100	9	23.727100
15949	5389	100	9	23.727100
15950	5390	100	9	23.727100
15951	5391	100	9	23.727100
15952	5392	100	9	23.727100
15953	5393	100	9	23.727100
15954	5394	100	9	23.727100
15955	5395	100	9	23.727100
15956	5396	100	9	23.727100
15957	5397	100	9	23.727100
15958	5398	100	9	23.727100
15959	5399	100	9	23.727100
15960	5400	100	9	23.727100
15961	5401	100	9	23.727100
15962	5402	100	9	23.727100
15963	5403	100	9	23.727100
15964	5404	100	9	23.727100
15965	5405	100	9	23.727100
15966	5406	100	9	23.727100
15967	5407	100	9	23.727100
15968	5408	100	9	23.727100
15969	5409	100	9	23.727100
15970	5410	100	9	23.727100
15971	5411	100	9	23.727100
15972	5412	100	9	23.727100
15973	5281	200	7	18.365000
15974	5282	200	7	18.914000
15975	5283	200	7	25.954000
15976	5284	200	7	28.030000
15977	5285	200	7	26.911000
15978	5286	200	7	27.812000
15979	5287	200	7	26.976000
15980	5288	200	7	27.451000
15981	5289	200	7	27.556000
15982	5290	200	7	26.212000
15983	5291	200	7	23.511000
15984	5292	200	7	18.772000
15985	5293	200	7	18.242000
15986	5294	200	7	20.683000
15987	5295	200	7	23.628000
15988	5296	200	7	25.492000
15989	5297	200	7	26.013000
15990	5298	200	7	26.277000
15991	5299	200	7	27.188000
15992	5300	200	7	26.775000
15993	5301	200	7	27.104000
15994	5302	200	7	27.152000
15995	5303	200	7	23.818000
15996	5304	200	7	21.098000
15997	5305	200	7	19.576000
15998	5306	200	7	20.272000
15999	5307	200	7	25.134000
16000	5308	200	7	26.441000
16001	5309	200	7	27.676000
16002	5310	200	7	27.120000
16003	5311	200	7	27.402000
16004	5312	200	7	27.367000
16005	5313	200	7	28.389000
16006	5314	200	7	25.862000
16007	5315	200	7	23.957000
16008	5316	200	7	20.095000
16009	5317	200	7	18.814000
16010	5318	200	7	20.927000
16011	5319	200	7	25.636000
16012	5320	200	7	27.839000
16013	5321	200	7	28.548000
16014	5322	200	7	27.385000
16015	5323	200	7	27.063000
16016	5324	200	7	27.295000
16017	5325	200	7	27.569000
16018	5326	200	7	27.274000
16019	5327	200	7	24.594000
16020	5328	200	7	20.019000
16021	5329	200	7	18.792000
16022	5330	200	7	21.144000
16023	5331	200	7	24.798000
16024	5332	200	7	27.623000
16025	5333	200	7	27.232000
16026	5334	200	7	27.132000
16027	5335	200	7	27.151000
16028	5336	200	7	26.692000
16029	5337	200	7	27.947000
16030	5338	200	7	26.512000
16031	5339	200	7	24.170000
16032	5340	200	7	21.789000
16033	5341	200	7	18.680000
16034	5342	200	7	19.865000
16035	5343	200	7	24.545000
16036	5344	200	7	25.540000
16037	5345	200	7	27.600000
16038	5346	200	7	27.633000
16039	5347	200	7	26.740000
16040	5348	200	7	27.531000
16041	5349	200	7	27.204000
16042	5350	200	7	25.990000
16043	5351	200	7	24.258000
16044	5352	200	7	20.771000
16045	5353	200	7	18.711000
16046	5354	200	7	20.890000
16047	5355	200	7	23.306000
16048	5356	200	7	27.000000
16049	5357	200	7	28.155000
16050	5358	200	7	28.067000
16051	5359	200	7	27.648000
16052	5360	200	7	27.170000
16053	5361	200	7	28.029000
16054	5362	200	7	27.694000
16055	5363	200	7	24.649000
16056	5364	200	7	21.144000
16057	5365	200	7	19.894000
16058	5366	200	7	24.057000
16059	5367	200	7	26.083000
16060	5368	200	7	28.464000
16061	5369	200	7	27.370000
16062	5370	200	7	27.637000
16063	5371	200	7	27.648000
16064	5372	200	7	26.962000
16065	5373	200	7	27.448000
16066	5374	200	7	27.155000
16067	5375	200	7	24.150000
16068	5376	200	7	20.612000
16069	5377	200	7	17.861000
16070	5378	200	7	20.728000
16071	5379	200	7	23.739000
16072	5380	200	7	26.736000
16073	5381	200	7	26.883000
16074	5382	200	7	26.966000
16075	5383	200	7	28.034000
16076	5384	200	7	26.598000
16077	5385	200	7	26.804000
16078	5386	200	7	26.327000
16079	5387	200	7	23.346000
16080	5388	200	7	20.298000
16081	5389	200	7	19.214000
16082	5390	200	7	21.772000
16083	5391	200	7	25.175000
16084	5392	200	7	27.598000
16085	5393	200	7	27.457000
16086	5394	200	7	27.437000
16087	5395	200	7	27.747000
16088	5396	200	7	27.493000
16089	5397	200	7	28.646000
16090	5398	200	7	26.872000
16091	5399	200	7	23.606000
16092	5400	200	7	20.497000
16093	5401	200	7	19.377000
16094	5402	200	7	21.967000
16095	5403	200	7	25.499000
16096	5404	200	7	26.956000
16097	5405	200	7	27.214000
16098	5406	200	7	26.940000
16099	5407	200	7	27.654000
16100	5408	200	7	27.046000
16101	5409	200	7	27.257000
16102	5410	200	7	26.472000
16103	5411	200	7	23.634000
16104	5412	200	7	20.977000
16105	5281	100	8	92.717600
16106	5282	100	8	92.717600
16107	5283	100	8	92.717600
16108	5284	100	8	92.717600
16109	5285	100	8	92.717600
16110	5286	100	8	92.717600
16111	5287	100	8	92.717600
16112	5288	100	8	92.717600
16113	5289	100	8	92.717600
16114	5290	100	8	92.717600
16115	5291	100	8	92.717600
16116	5292	100	8	92.717600
16117	5293	100	8	92.717600
16118	5294	100	8	92.717600
16119	5295	100	8	92.717600
16120	5296	100	8	92.717600
16121	5297	100	8	92.717600
16122	5298	100	8	92.717600
16123	5299	100	8	92.717600
16124	5300	100	8	92.717600
16125	5301	100	8	92.717600
16126	5302	100	8	92.717600
16127	5303	100	8	92.717600
16128	5304	100	8	92.717600
16129	5305	100	8	92.717600
16130	5306	100	8	92.717600
16131	5307	100	8	92.717600
16132	5308	100	8	92.717600
16133	5309	100	8	92.717600
16134	5310	100	8	92.717600
16135	5311	100	8	92.717600
16136	5312	100	8	92.717600
16137	5313	100	8	92.717600
16138	5314	100	8	92.717600
16139	5315	100	8	92.717600
16140	5316	100	8	92.717600
16141	5317	100	8	92.717600
16142	5318	100	8	92.717600
16143	5319	100	8	92.717600
16144	5320	100	8	92.717600
16145	5321	100	8	92.717600
16146	5322	100	8	92.717600
16147	5323	100	8	92.717600
16148	5324	100	8	92.717600
16149	5325	100	8	92.717600
16150	5326	100	8	92.717600
16151	5327	100	8	92.717600
16152	5328	100	8	92.717600
16153	5329	100	8	92.717600
16154	5330	100	8	92.717600
16155	5331	100	8	92.717600
16156	5332	100	8	92.717600
16157	5333	100	8	92.717600
16158	5334	100	8	92.717600
16159	5335	100	8	92.717600
16160	5336	100	8	92.717600
16161	5337	100	8	92.717600
16162	5338	100	8	92.717600
16163	5339	100	8	92.717600
16164	5340	100	8	92.717600
16165	5341	100	8	92.717600
16166	5342	100	8	92.717600
16167	5343	100	8	92.717600
16168	5344	100	8	92.717600
16169	5345	100	8	92.717600
16170	5346	100	8	92.717600
16171	5347	100	8	92.717600
16172	5348	100	8	92.717600
16173	5349	100	8	92.717600
16174	5350	100	8	92.717600
16175	5351	100	8	92.717600
16176	5352	100	8	92.717600
16177	5353	100	8	92.717600
16178	5354	100	8	92.717600
16179	5355	100	8	92.717600
16180	5356	100	8	92.717600
16181	5357	100	8	92.717600
16182	5358	100	8	92.717600
16183	5359	100	8	92.717600
16184	5360	100	8	92.717600
16185	5361	100	8	92.717600
16186	5362	100	8	92.717600
16187	5363	100	8	92.717600
16188	5364	100	8	92.717600
16189	5365	100	8	92.717600
16190	5366	100	8	92.717600
16191	5367	100	8	92.717600
16192	5368	100	8	92.717600
16193	5369	100	8	92.717600
16194	5370	100	8	92.717600
16195	5371	100	8	92.717600
16196	5372	100	8	92.717600
16197	5373	100	8	92.717600
16198	5374	100	8	92.717600
16199	5375	100	8	92.717600
16200	5376	100	8	92.717600
16201	5377	100	8	92.717600
16202	5378	100	8	92.717600
16203	5379	100	8	92.717600
16204	5380	100	8	92.717600
16205	5381	100	8	92.717600
16206	5382	100	8	92.717600
16207	5383	100	8	92.717600
16208	5384	100	8	92.717600
16209	5385	100	8	92.717600
16210	5386	100	8	92.717600
16211	5387	100	8	92.717600
16212	5388	100	8	92.717600
16213	5389	100	8	92.717600
16214	5390	100	8	92.717600
16215	5391	100	8	92.717600
16216	5392	100	8	92.717600
16217	5393	100	8	92.717600
16218	5394	100	8	92.717600
16219	5395	100	8	92.717600
16220	5396	100	8	92.717600
16221	5397	100	8	92.717600
16222	5398	100	8	92.717600
16223	5399	100	8	92.717600
16224	5400	100	8	92.717600
16225	5401	100	8	92.717600
16226	5402	100	8	92.717600
16227	5403	100	8	92.717600
16228	5404	100	8	92.717600
16229	5405	100	8	92.717600
16230	5406	100	8	92.717600
16231	5407	100	8	92.717600
16232	5408	100	8	92.717600
16233	5409	100	8	92.717600
16234	5410	100	8	92.717600
16235	5411	100	8	92.717600
16236	5412	100	8	92.717600
16779	5677	100	15	30.211000
16780	5678	100	15	30.211000
16781	5679	100	15	30.211000
16782	5680	100	15	30.211000
16783	5681	100	15	30.211000
16784	5682	100	15	30.211000
16785	5683	100	15	30.211000
16786	5684	100	15	30.211000
16787	5685	100	15	30.211000
16788	5686	100	15	30.211000
16789	5687	100	15	30.211000
16790	5688	100	15	30.211000
16791	5689	100	15	30.211000
16792	5690	100	15	30.211000
16793	5691	100	15	30.211000
16794	5692	100	15	30.211000
16795	5693	100	15	30.211000
16796	5694	100	15	30.211000
16797	5695	100	15	30.211000
16798	5696	100	15	30.211000
16799	5697	100	15	30.211000
16800	5698	100	15	30.211000
16801	5699	100	15	30.211000
16802	5700	100	15	30.211000
16803	5701	100	15	30.211000
16804	5702	100	15	30.211000
16805	5703	100	15	30.211000
16806	5704	100	15	30.211000
16807	5705	100	15	30.211000
16808	5706	100	15	30.211000
16809	5707	100	15	30.211000
16810	5708	100	15	30.211000
16811	5709	100	15	30.211000
16812	5710	100	15	30.211000
16813	5711	100	15	30.211000
16814	5712	100	15	30.211000
16815	5713	100	15	30.211000
16816	5714	100	15	30.211000
16817	5715	100	15	30.211000
16818	5716	100	15	30.211000
16819	5717	100	15	30.211000
16820	5718	100	15	30.211000
16821	5719	100	15	30.211000
16822	5720	100	15	30.211000
16823	5721	100	15	30.211000
16824	5722	100	15	30.211000
16825	5723	100	15	30.211000
16826	5724	100	15	30.211000
16827	5725	100	15	30.211000
16828	5726	100	15	30.211000
16829	5727	100	15	30.211000
16830	5728	100	15	30.211000
16831	5729	100	15	30.211000
16832	5730	100	15	30.211000
16833	5731	100	15	30.211000
16834	5732	100	15	30.211000
16835	5733	100	15	30.211000
16836	5734	100	15	30.211000
16837	5735	100	15	30.211000
16838	5736	100	15	30.211000
16839	5737	100	15	30.211000
16840	5738	100	15	30.211000
16841	5739	100	15	30.211000
16842	5740	100	15	30.211000
16843	5741	100	15	30.211000
16844	5742	100	15	30.211000
16845	5743	100	15	30.211000
16846	5744	100	15	30.211000
16847	5745	100	15	30.211000
16848	5746	100	15	30.211000
16849	5747	100	15	30.211000
16850	5748	100	15	30.211000
16851	5749	100	15	30.211000
16852	5750	100	15	30.211000
16853	5751	100	15	30.211000
16854	5752	100	15	30.211000
16855	5753	100	15	30.211000
16856	5754	100	15	30.211000
16857	5755	100	15	30.211000
16858	5756	100	15	30.211000
16859	5757	100	15	30.211000
16860	5758	100	15	30.211000
16861	5759	100	15	30.211000
16862	5760	100	15	30.211000
16863	5761	100	15	30.211000
16864	5762	100	15	30.211000
16865	5763	100	15	30.211000
16866	5764	100	15	30.211000
16867	5765	100	15	30.211000
16868	5766	100	15	30.211000
16869	5767	100	15	30.211000
16870	5768	100	15	30.211000
16871	5769	100	15	30.211000
16872	5770	100	15	30.211000
16873	5771	100	15	30.211000
16874	5772	100	15	30.211000
16875	5773	100	15	30.211000
16876	5774	100	15	30.211000
16877	5775	100	15	30.211000
16878	5776	100	15	30.211000
16879	5777	100	15	30.211000
16880	5778	100	15	30.211000
16881	5779	100	15	30.211000
16882	5780	100	15	30.211000
16883	5781	100	15	30.211000
16884	5782	100	15	30.211000
16885	5783	100	15	30.211000
16886	5784	100	15	30.211000
16887	5785	100	15	30.211000
16888	5786	100	15	30.211000
16889	5787	100	15	30.211000
16890	5788	100	15	30.211000
16891	5789	100	15	30.211000
16892	5790	100	15	30.211000
16893	5791	100	15	30.211000
16894	5792	100	15	30.211000
16895	5793	100	15	30.211000
16896	5794	100	15	30.211000
16897	5795	100	15	30.211000
16898	5796	100	15	30.211000
16899	5797	100	15	30.211000
16900	5798	100	15	30.211000
16901	5799	100	15	30.211000
16902	5800	100	15	30.211000
16903	5801	100	15	30.211000
16904	5802	100	15	30.211000
16905	5803	100	15	30.211000
16906	5804	100	15	30.211000
16907	5805	100	15	30.211000
16908	5806	100	15	30.211000
16909	5807	100	15	30.211000
16910	5808	100	15	30.211000
16911	5677	200	13	14.803000
16912	5678	200	13	15.784000
16913	5679	200	13	21.532000
16914	5680	200	13	27.651000
16915	5681	200	13	31.820000
16916	5682	200	13	35.284000
16917	5683	200	13	31.387000
16918	5684	200	13	30.888000
16919	5685	200	13	29.765000
16920	5686	200	13	26.263000
16921	5687	200	13	20.349000
16922	5688	200	13	17.391000
16923	5689	200	13	13.751000
16924	5690	200	13	18.581000
16925	5691	200	13	20.742000
16926	5692	200	13	28.532000
16927	5693	200	13	34.507000
16928	5694	200	13	35.522000
16929	5695	200	13	31.618000
16930	5696	200	13	33.265000
16931	5697	200	13	29.429000
16932	5698	200	13	26.555000
16933	5699	200	13	21.462000
16934	5700	200	13	16.056000
16935	5701	200	13	15.037000
16936	5702	200	13	16.239000
16937	5703	200	13	23.711000
16938	5704	200	13	27.217000
16939	5705	200	13	33.950000
16940	5706	200	13	35.889000
16941	5707	200	13	31.565000
16942	5708	200	13	30.586000
16943	5709	200	13	29.305000
16944	5710	200	13	25.825000
16945	5711	200	13	20.999000
16946	5712	200	13	16.372000
16947	5713	200	13	13.592000
16948	5714	200	13	16.538000
16949	5715	200	13	20.925000
16950	5716	200	13	26.997000
16951	5717	200	13	34.269000
16952	5718	200	13	36.579000
16953	5719	200	13	32.820000
16954	5720	200	13	29.630000
16955	5721	200	13	30.324000
16956	5722	200	13	27.124000
16957	5723	200	13	20.870000
16958	5724	200	13	16.100000
16959	5725	200	13	14.103000
16960	5726	200	13	17.235000
16961	5727	200	13	22.950000
16962	5728	200	13	28.897000
16963	5729	200	13	32.632000
16964	5730	200	13	32.626000
16965	5731	200	13	32.733000
16966	5732	200	13	30.676000
16967	5733	200	13	29.913000
16968	5734	200	13	26.202000
16969	5735	200	13	20.264000
16970	5736	200	13	15.108000
16971	5737	200	13	13.449000
16972	5738	200	13	16.335000
16973	5739	200	13	21.558000
16974	5740	200	13	26.934000
16975	5741	200	13	30.299000
16976	5742	200	13	32.650000
16977	5743	200	13	32.725000
16978	5744	200	13	30.511000
16979	5745	200	13	30.483000
16980	5746	200	13	24.473000
16981	5747	200	13	19.766000
16982	5748	200	13	13.284000
16983	5749	200	13	13.733000
16984	5750	200	13	16.942000
16985	5751	200	13	20.460000
16986	5752	200	13	28.711000
16987	5753	200	13	33.837000
16988	5754	200	13	34.937000
16989	5755	200	13	32.172000
16990	5756	200	13	31.790000
16991	5757	200	13	30.150000
16992	5758	200	13	26.777000
16993	5759	200	13	21.259000
16994	5760	200	13	15.241000
16995	5761	200	13	13.245000
16996	5762	200	13	17.332000
16997	5763	200	13	22.919000
16998	5764	200	13	30.444000
16999	5765	200	13	33.724000
17000	5766	200	13	33.623000
17001	5767	200	13	32.833000
17002	5768	200	13	31.618000
17003	5769	200	13	31.310000
17004	5770	200	13	27.468000
17005	5771	200	13	22.021000
17006	5772	200	13	16.074000
17007	5773	200	13	13.911000
17008	5774	200	13	15.634000
17009	5775	200	13	21.850000
17010	5776	200	13	30.601000
17011	5777	200	13	35.180000
17012	5778	200	13	33.788000
17013	5779	200	13	31.423000
17014	5780	200	13	31.456000
17015	5781	200	13	30.235000
17016	5782	200	13	27.664000
17017	5783	200	13	21.434000
17018	5784	200	13	16.233000
17019	5785	200	13	13.110000
17020	5786	200	13	17.531000
17021	5787	200	13	22.798000
17022	5788	200	13	28.297000
17023	5789	200	13	33.565000
17024	5790	200	13	32.589000
17025	5791	200	13	31.733000
17026	5792	200	13	32.038000
17027	5793	200	13	31.268000
17028	5794	200	13	27.927000
17029	5795	200	13	21.758000
17030	5796	200	13	16.431000
17031	5797	200	13	15.459000
17032	5798	200	13	15.886000
17033	5799	200	13	20.905000
17034	5800	200	13	30.734000
17035	5801	200	13	34.513000
17036	5802	200	13	34.655000
17037	5803	200	13	33.668000
17038	5804	200	13	32.146000
17039	5805	200	13	29.238000
17040	5806	200	13	26.616000
17041	5807	200	13	21.945000
17042	5808	200	13	16.566000
17043	5677	100	14	74.945500
17044	5678	100	14	74.945500
17045	5679	100	14	74.945500
17046	5680	100	14	74.945500
17047	5681	100	14	74.945500
17048	5682	100	14	74.945500
17049	5683	100	14	74.945500
17050	5684	100	14	74.945500
17051	5685	100	14	74.945500
17052	5686	100	14	74.945500
17053	5687	100	14	74.945500
17054	5688	100	14	74.945500
17055	5689	100	14	74.945500
17056	5690	100	14	74.945500
17057	5691	100	14	74.945500
17058	5692	100	14	74.945500
17059	5693	100	14	74.945500
17060	5694	100	14	74.945500
17061	5695	100	14	74.945500
17062	5696	100	14	74.945500
17063	5697	100	14	74.945500
17064	5698	100	14	74.945500
17065	5699	100	14	74.945500
17066	5700	100	14	74.945500
17067	5701	100	14	74.945500
17068	5702	100	14	74.945500
17069	5703	100	14	74.945500
17070	5704	100	14	74.945500
17071	5705	100	14	74.945500
17072	5706	100	14	74.945500
17073	5707	100	14	74.945500
17074	5708	100	14	74.945500
17075	5709	100	14	74.945500
17076	5710	100	14	74.945500
17077	5711	100	14	74.945500
17078	5712	100	14	74.945500
17079	5713	100	14	74.945500
17080	5714	100	14	74.945500
17081	5715	100	14	74.945500
17082	5716	100	14	74.945500
17083	5717	100	14	74.945500
17084	5718	100	14	74.945500
17085	5719	100	14	74.945500
17086	5720	100	14	74.945500
17087	5721	100	14	74.945500
17088	5722	100	14	74.945500
17089	5723	100	14	74.945500
17090	5724	100	14	74.945500
17091	5725	100	14	74.945500
17092	5726	100	14	74.945500
17093	5727	100	14	74.945500
17094	5728	100	14	74.945500
17095	5729	100	14	74.945500
17096	5730	100	14	74.945500
17097	5731	100	14	74.945500
17098	5732	100	14	74.945500
17099	5733	100	14	74.945500
17100	5734	100	14	74.945500
17101	5735	100	14	74.945500
17102	5736	100	14	74.945500
17103	5737	100	14	74.945500
17104	5738	100	14	74.945500
17105	5739	100	14	74.945500
17106	5740	100	14	74.945500
17107	5741	100	14	74.945500
17108	5742	100	14	74.945500
17109	5743	100	14	74.945500
17110	5744	100	14	74.945500
17111	5745	100	14	74.945500
17112	5746	100	14	74.945500
17113	5747	100	14	74.945500
17114	5748	100	14	74.945500
17115	5749	100	14	74.945500
17116	5750	100	14	74.945500
17117	5751	100	14	74.945500
17118	5752	100	14	74.945500
17119	5753	100	14	74.945500
17120	5754	100	14	74.945500
17121	5755	100	14	74.945500
17122	5756	100	14	74.945500
17123	5757	100	14	74.945500
17124	5758	100	14	74.945500
17125	5759	100	14	74.945500
17126	5760	100	14	74.945500
17127	5761	100	14	74.945500
17128	5762	100	14	74.945500
17129	5763	100	14	74.945500
17130	5764	100	14	74.945500
17131	5765	100	14	74.945500
17132	5766	100	14	74.945500
17133	5767	100	14	74.945500
17134	5768	100	14	74.945500
17135	5769	100	14	74.945500
17136	5770	100	14	74.945500
17137	5771	100	14	74.945500
17138	5772	100	14	74.945500
17139	5773	100	14	74.945500
17140	5774	100	14	74.945500
17141	5775	100	14	74.945500
17142	5776	100	14	74.945500
17143	5777	100	14	74.945500
17144	5778	100	14	74.945500
17145	5779	100	14	74.945500
17146	5780	100	14	74.945500
17147	5781	100	14	74.945500
17148	5782	100	14	74.945500
17149	5783	100	14	74.945500
17150	5784	100	14	74.945500
17151	5785	100	14	74.945500
17152	5786	100	14	74.945500
17153	5787	100	14	74.945500
17154	5788	100	14	74.945500
17155	5789	100	14	74.945500
17156	5790	100	14	74.945500
17157	5791	100	14	74.945500
17158	5792	100	14	74.945500
17159	5793	100	14	74.945500
17160	5794	100	14	74.945500
17161	5795	100	14	74.945500
17162	5796	100	14	74.945500
17163	5797	100	14	74.945500
17164	5798	100	14	74.945500
17165	5799	100	14	74.945500
17166	5800	100	14	74.945500
17167	5801	100	14	74.945500
17168	5802	100	14	74.945500
17169	5803	100	14	74.945500
17170	5804	100	14	74.945500
17171	5805	100	14	74.945500
17172	5806	100	14	74.945500
17173	5807	100	14	74.945500
17174	5808	100	14	74.945500
17175	5809	100	18	12.971600
17176	5810	100	18	12.971600
17177	5811	100	18	12.971600
17178	5812	100	18	12.971600
17179	5813	100	18	12.971600
17180	5814	100	18	12.971600
17181	5815	100	18	12.971600
17182	5816	100	18	12.971600
17183	5817	100	18	12.971600
17184	5818	100	18	12.971600
17185	5819	100	18	12.971600
17186	5820	100	18	12.971600
17187	5821	100	18	12.971600
17188	5822	100	18	12.971600
17189	5823	100	18	12.971600
17190	5824	100	18	12.971600
17191	5825	100	18	12.971600
17192	5826	100	18	12.971600
17193	5827	100	18	12.971600
17194	5828	100	18	12.971600
17195	5829	100	18	12.971600
17196	5830	100	18	12.971600
17197	5831	100	18	12.971600
17198	5832	100	18	12.971600
17199	5833	100	18	12.971600
17200	5834	100	18	12.971600
17201	5835	100	18	12.971600
17202	5836	100	18	12.971600
17203	5837	100	18	12.971600
17204	5838	100	18	12.971600
17205	5839	100	18	12.971600
17206	5840	100	18	12.971600
17207	5841	100	18	12.971600
17208	5842	100	18	12.971600
17209	5843	100	18	12.971600
17210	5844	100	18	12.971600
17211	5845	100	18	12.971600
17212	5846	100	18	12.971600
17213	5847	100	18	12.971600
17214	5848	100	18	12.971600
17215	5849	100	18	12.971600
17216	5850	100	18	12.971600
17217	5851	100	18	12.971600
17218	5852	100	18	12.971600
17219	5853	100	18	12.971600
17220	5854	100	18	12.971600
17221	5855	100	18	12.971600
17222	5856	100	18	12.971600
17223	5857	100	18	12.971600
17224	5858	100	18	12.971600
17225	5859	100	18	12.971600
17226	5860	100	18	12.971600
17227	5861	100	18	12.971600
17228	5862	100	18	12.971600
17229	5863	100	18	12.971600
17230	5864	100	18	12.971600
17231	5865	100	18	12.971600
17232	5866	100	18	12.971600
17233	5867	100	18	12.971600
17234	5868	100	18	12.971600
17235	5869	100	18	12.971600
17236	5870	100	18	12.971600
17237	5871	100	18	12.971600
17238	5872	100	18	12.971600
17239	5873	100	18	12.971600
17240	5874	100	18	12.971600
17241	5875	100	18	12.971600
17242	5876	100	18	12.971600
17243	5877	100	18	12.971600
17244	5878	100	18	12.971600
17245	5879	100	18	12.971600
17246	5880	100	18	12.971600
17247	5881	100	18	12.971600
17248	5882	100	18	12.971600
17249	5883	100	18	12.971600
17250	5884	100	18	12.971600
17251	5885	100	18	12.971600
17252	5886	100	18	12.971600
17253	5887	100	18	12.971600
17254	5888	100	18	12.971600
17255	5889	100	18	12.971600
17256	5890	100	18	12.971600
17257	5891	100	18	12.971600
17258	5892	100	18	12.971600
17259	5893	100	18	12.971600
17260	5894	100	18	12.971600
17261	5895	100	18	12.971600
17262	5896	100	18	12.971600
17263	5897	100	18	12.971600
17264	5898	100	18	12.971600
17265	5899	100	18	12.971600
17266	5900	100	18	12.971600
17267	5901	100	18	12.971600
17268	5902	100	18	12.971600
17269	5903	100	18	12.971600
17270	5904	100	18	12.971600
17271	5905	100	18	12.971600
17272	5906	100	18	12.971600
17273	5907	100	18	12.971600
17274	5908	100	18	12.971600
17275	5909	100	18	12.971600
17276	5910	100	18	12.971600
17277	5911	100	18	12.971600
17278	5912	100	18	12.971600
17279	5913	100	18	12.971600
17280	5914	100	18	12.971600
17281	5915	100	18	12.971600
17282	5916	100	18	12.971600
17283	5917	100	18	12.971600
17284	5918	100	18	12.971600
17285	5919	100	18	12.971600
17286	5920	100	18	12.971600
17287	5921	100	18	12.971600
17288	5922	100	18	12.971600
17289	5923	100	18	12.971600
17290	5924	100	18	12.971600
17291	5925	100	18	12.971600
17292	5926	100	18	12.971600
17293	5927	100	18	12.971600
17294	5928	100	18	12.971600
17295	5929	100	18	12.971600
17296	5930	100	18	12.971600
17297	5931	100	18	12.971600
17298	5932	100	18	12.971600
17299	5933	100	18	12.971600
17300	5934	100	18	12.971600
17301	5935	100	18	12.971600
17302	5936	100	18	12.971600
17303	5937	100	18	12.971600
17304	5938	100	18	12.971600
17305	5939	100	18	12.971600
17306	5940	100	18	12.971600
17307	5809	200	16	21.389000
17308	5810	200	16	24.735000
17309	5811	200	16	26.484000
17310	5812	200	16	28.103000
17311	5813	200	16	26.869000
17312	5814	200	16	24.811000
17313	5815	200	16	24.261000
17314	5816	200	16	24.085000
17315	5817	200	16	24.627000
17316	5818	200	16	24.391000
17317	5819	200	16	23.536000
17318	5820	200	16	21.444000
17319	5821	200	16	22.218000
17320	5822	200	16	24.155000
17321	5823	200	16	26.692000
17322	5824	200	16	28.203000
17323	5825	200	16	27.816000
17324	5826	200	16	25.299000
17325	5827	200	16	24.277000
17326	5828	200	16	24.456000
17327	5829	200	16	24.127000
17328	5830	200	16	24.201000
17329	5831	200	16	23.140000
17330	5832	200	16	21.668000
17331	5833	200	16	22.504000
17332	5834	200	16	24.586000
17333	5835	200	16	26.980000
17334	5836	200	16	27.738000
17335	5837	200	16	27.685000
17336	5838	200	16	25.072000
17337	5839	200	16	23.752000
17338	5840	200	16	24.586000
17339	5841	200	16	24.820000
17340	5842	200	16	24.273000
17341	5843	200	16	22.466000
17342	5844	200	16	21.247000
17343	5845	200	16	22.372000
17344	5846	200	16	24.975000
17345	5847	200	16	26.471000
17346	5848	200	16	28.069000
17347	5849	200	16	26.253000
17348	5850	200	16	25.948000
17349	5851	200	16	24.167000
17350	5852	200	16	24.607000
17351	5853	200	16	24.732000
17352	5854	200	16	24.523000
17353	5855	200	16	24.478000
17354	5856	200	16	22.225000
17355	5857	200	16	22.982000
17356	5858	200	16	24.345000
17357	5859	200	16	27.077000
17358	5860	200	16	27.685000
17359	5861	200	16	28.268000
17360	5862	200	16	25.045000
17361	5863	200	16	24.578000
17362	5864	200	16	24.171000
17363	5865	200	16	24.443000
17364	5866	200	16	24.139000
17365	5867	200	16	23.748000
17366	5868	200	16	21.863000
17367	5869	200	16	22.614000
17368	5870	200	16	24.661000
17369	5871	200	16	26.584000
17370	5872	200	16	26.850000
17371	5873	200	16	27.599000
17372	5874	200	16	26.427000
17373	5875	200	16	24.837000
17374	5876	200	16	24.521000
17375	5877	200	16	25.207000
17376	5878	200	16	24.902000
17377	5879	200	16	24.349000
17378	5880	200	16	23.124000
17379	5881	200	16	23.530000
17380	5882	200	16	25.724000
17381	5883	200	16	27.917000
17382	5884	200	16	28.908000
17383	5885	200	16	28.075000
17384	5886	200	16	26.259000
17385	5887	200	16	24.553000
17386	5888	200	16	24.761000
17387	5889	200	16	24.589000
17388	5890	200	16	24.509000
17389	5891	200	16	23.909000
17390	5892	200	16	22.483000
17391	5893	200	16	22.705000
17392	5894	200	16	24.466000
17393	5895	200	16	27.490000
17394	5896	200	16	27.890000
17395	5897	200	16	25.822000
17396	5898	200	16	24.771000
17397	5899	200	16	24.242000
17398	5900	200	16	24.562000
17399	5901	200	16	25.224000
17400	5902	200	16	24.696000
17401	5903	200	16	23.533000
17402	5904	200	16	22.087000
17403	5905	200	16	23.174000
17404	5906	200	16	25.028000
17405	5907	200	16	26.542000
17406	5908	200	16	28.090000
17407	5909	200	16	26.859000
17408	5910	200	16	24.388000
17409	5911	200	16	24.063000
17410	5912	200	16	24.067000
17411	5913	200	16	24.906000
17412	5914	200	16	24.339000
17413	5915	200	16	23.752000
17414	5916	200	16	21.900000
17415	5917	200	16	23.196000
17416	5918	200	16	26.063000
17417	5919	200	16	27.427000
17418	5920	200	16	28.128000
17419	5921	200	16	27.404000
17420	5922	200	16	25.160000
17421	5923	200	16	24.729000
17422	5924	200	16	24.162000
17423	5925	200	16	25.323000
17424	5926	200	16	24.208000
17425	5927	200	16	23.774000
17426	5928	200	16	22.207000
17427	5929	200	16	23.349000
17428	5930	200	16	24.130000
17429	5931	200	16	27.284000
17430	5932	200	16	28.559000
17431	5933	200	16	27.501000
17432	5934	200	16	25.285000
17433	5935	200	16	24.931000
17434	5936	200	16	24.718000
17435	5937	200	16	25.869000
17436	5938	200	16	25.093000
17437	5939	200	16	23.670000
17438	5940	200	16	22.776000
17439	5809	100	17	77.594600
17440	5810	100	17	77.594600
17441	5811	100	17	77.594600
17442	5812	100	17	77.594600
17443	5813	100	17	77.594600
17444	5814	100	17	77.594600
17445	5815	100	17	77.594600
17446	5816	100	17	77.594600
17447	5817	100	17	77.594600
17448	5818	100	17	77.594600
17449	5819	100	17	77.594600
17450	5820	100	17	77.594600
17451	5821	100	17	77.594600
17452	5822	100	17	77.594600
17453	5823	100	17	77.594600
17454	5824	100	17	77.594600
17455	5825	100	17	77.594600
17456	5826	100	17	77.594600
17457	5827	100	17	77.594600
17458	5828	100	17	77.594600
17459	5829	100	17	77.594600
17460	5830	100	17	77.594600
17461	5831	100	17	77.594600
17462	5832	100	17	77.594600
17463	5833	100	17	77.594600
17464	5834	100	17	77.594600
17465	5835	100	17	77.594600
17466	5836	100	17	77.594600
17467	5837	100	17	77.594600
17468	5838	100	17	77.594600
17469	5839	100	17	77.594600
17470	5840	100	17	77.594600
17471	5841	100	17	77.594600
17472	5842	100	17	77.594600
17473	5843	100	17	77.594600
17474	5844	100	17	77.594600
17475	5845	100	17	77.594600
17476	5846	100	17	77.594600
17477	5847	100	17	77.594600
17478	5848	100	17	77.594600
17479	5849	100	17	77.594600
17480	5850	100	17	77.594600
17481	5851	100	17	77.594600
17482	5852	100	17	77.594600
17483	5853	100	17	77.594600
17484	5854	100	17	77.594600
17485	5855	100	17	77.594600
17486	5856	100	17	77.594600
17487	5857	100	17	77.594600
17488	5858	100	17	77.594600
17489	5859	100	17	77.594600
17490	5860	100	17	77.594600
17491	5861	100	17	77.594600
17492	5862	100	17	77.594600
17493	5863	100	17	77.594600
17494	5864	100	17	77.594600
17495	5865	100	17	77.594600
17496	5866	100	17	77.594600
17497	5867	100	17	77.594600
17498	5868	100	17	77.594600
17499	5869	100	17	77.594600
17500	5870	100	17	77.594600
17501	5871	100	17	77.594600
17502	5872	100	17	77.594600
17503	5873	100	17	77.594600
17504	5874	100	17	77.594600
17505	5875	100	17	77.594600
17506	5876	100	17	77.594600
17507	5877	100	17	77.594600
17508	5878	100	17	77.594600
17509	5879	100	17	77.594600
17510	5880	100	17	77.594600
17511	5881	100	17	77.594600
17512	5882	100	17	77.594600
17513	5883	100	17	77.594600
17514	5884	100	17	77.594600
17515	5885	100	17	77.594600
17516	5886	100	17	77.594600
17517	5887	100	17	77.594600
17518	5888	100	17	77.594600
17519	5889	100	17	77.594600
17520	5890	100	17	77.594600
17521	5891	100	17	77.594600
17522	5892	100	17	77.594600
17523	5893	100	17	77.594600
17524	5894	100	17	77.594600
17525	5895	100	17	77.594600
17526	5896	100	17	77.594600
17527	5897	100	17	77.594600
17528	5898	100	17	77.594600
17529	5899	100	17	77.594600
17530	5900	100	17	77.594600
17531	5901	100	17	77.594600
17532	5902	100	17	77.594600
17533	5903	100	17	77.594600
17534	5904	100	17	77.594600
17535	5905	100	17	77.594600
17536	5906	100	17	77.594600
17537	5907	100	17	77.594600
17538	5908	100	17	77.594600
17539	5909	100	17	77.594600
17540	5910	100	17	77.594600
17541	5911	100	17	77.594600
17542	5912	100	17	77.594600
17543	5913	100	17	77.594600
17544	5914	100	17	77.594600
17545	5915	100	17	77.594600
17546	5916	100	17	77.594600
17547	5917	100	17	77.594600
17548	5918	100	17	77.594600
17549	5919	100	17	77.594600
17550	5920	100	17	77.594600
17551	5921	100	17	77.594600
17552	5922	100	17	77.594600
17553	5923	100	17	77.594600
17554	5924	100	17	77.594600
17555	5925	100	17	77.594600
17556	5926	100	17	77.594600
17557	5927	100	17	77.594600
17558	5928	100	17	77.594600
17559	5929	100	17	77.594600
17560	5930	100	17	77.594600
17561	5931	100	17	77.594600
17562	5932	100	17	77.594600
17563	5933	100	17	77.594600
17564	5934	100	17	77.594600
17565	5935	100	17	77.594600
17566	5936	100	17	77.594600
17567	5937	100	17	77.594600
17568	5938	100	17	77.594600
17569	5939	100	17	77.594600
17570	5940	100	17	77.594600
17571	5941	100	21	28.022900
17572	5942	100	21	28.022900
17573	5943	100	21	28.022900
17574	5944	100	21	28.022900
17575	5945	100	21	28.022900
17576	5946	100	21	28.022900
17577	5947	100	21	28.022900
17578	5948	100	21	28.022900
17579	5949	100	21	28.022900
17580	5950	100	21	28.022900
17581	5951	100	21	28.022900
17582	5952	100	21	28.022900
17583	5953	100	21	28.022900
17584	5954	100	21	28.022900
17585	5955	100	21	28.022900
17586	5956	100	21	28.022900
17587	5957	100	21	28.022900
17588	5958	100	21	28.022900
17589	5959	100	21	28.022900
17590	5960	100	21	28.022900
17591	5961	100	21	28.022900
17592	5962	100	21	28.022900
17593	5963	100	21	28.022900
17594	5964	100	21	28.022900
17595	5965	100	21	28.022900
17596	5966	100	21	28.022900
17597	5967	100	21	28.022900
17598	5968	100	21	28.022900
17599	5969	100	21	28.022900
17600	5970	100	21	28.022900
17601	5971	100	21	28.022900
17602	5972	100	21	28.022900
17603	5973	100	21	28.022900
17604	5974	100	21	28.022900
17605	5975	100	21	28.022900
17606	5976	100	21	28.022900
17607	5977	100	21	28.022900
17608	5978	100	21	28.022900
17609	5979	100	21	28.022900
17610	5980	100	21	28.022900
17611	5981	100	21	28.022900
17612	5982	100	21	28.022900
17613	5983	100	21	28.022900
17614	5984	100	21	28.022900
17615	5985	100	21	28.022900
17616	5986	100	21	28.022900
17617	5987	100	21	28.022900
17618	5988	100	21	28.022900
17619	5989	100	21	28.022900
17620	5990	100	21	28.022900
17621	5991	100	21	28.022900
17622	5992	100	21	28.022900
17623	5993	100	21	28.022900
17624	5994	100	21	28.022900
17625	5995	100	21	28.022900
17626	5996	100	21	28.022900
17627	5997	100	21	28.022900
17628	5998	100	21	28.022900
17629	5999	100	21	28.022900
17630	6000	100	21	28.022900
17631	6001	100	21	28.022900
17632	6002	100	21	28.022900
17633	6003	100	21	28.022900
17634	6004	100	21	28.022900
17635	6005	100	21	28.022900
17636	6006	100	21	28.022900
17637	6007	100	21	28.022900
17638	6008	100	21	28.022900
17639	6009	100	21	28.022900
17640	6010	100	21	28.022900
17641	6011	100	21	28.022900
17642	6012	100	21	28.022900
17643	6013	100	21	28.022900
17644	6014	100	21	28.022900
17645	6015	100	21	28.022900
17646	6016	100	21	28.022900
17647	6017	100	21	28.022900
17648	6018	100	21	28.022900
17649	6019	100	21	28.022900
17650	6020	100	21	28.022900
17651	6021	100	21	28.022900
17652	6022	100	21	28.022900
17653	6023	100	21	28.022900
17654	6024	100	21	28.022900
17655	6025	100	21	28.022900
17656	6026	100	21	28.022900
17657	6027	100	21	28.022900
17658	6028	100	21	28.022900
17659	6029	100	21	28.022900
17660	6030	100	21	28.022900
17661	6031	100	21	28.022900
17662	6032	100	21	28.022900
17663	6033	100	21	28.022900
17664	6034	100	21	28.022900
17665	6035	100	21	28.022900
17666	6036	100	21	28.022900
17667	6037	100	21	28.022900
17668	6038	100	21	28.022900
17669	6039	100	21	28.022900
17670	6040	100	21	28.022900
17671	6041	100	21	28.022900
17672	6042	100	21	28.022900
17673	6043	100	21	28.022900
17674	6044	100	21	28.022900
17675	6045	100	21	28.022900
17676	6046	100	21	28.022900
17677	6047	100	21	28.022900
17678	6048	100	21	28.022900
17679	6049	100	21	28.022900
17680	6050	100	21	28.022900
17681	6051	100	21	28.022900
17682	6052	100	21	28.022900
17683	6053	100	21	28.022900
17684	6054	100	21	28.022900
17685	6055	100	21	28.022900
17686	6056	100	21	28.022900
17687	6057	100	21	28.022900
17688	6058	100	21	28.022900
17689	6059	100	21	28.022900
17690	6060	100	21	28.022900
17691	6061	100	21	28.022900
17692	6062	100	21	28.022900
17693	6063	100	21	28.022900
17694	6064	100	21	28.022900
17695	6065	100	21	28.022900
17696	6066	100	21	28.022900
17697	6067	100	21	28.022900
17698	6068	100	21	28.022900
17699	6069	100	21	28.022900
17700	6070	100	21	28.022900
17701	6071	100	21	28.022900
17702	6072	100	21	28.022900
17703	5941	200	19	15.279000
17704	5942	200	19	17.212000
17705	5943	200	19	22.592000
17706	5944	200	19	28.895000
17707	5945	200	19	33.999000
17708	5946	200	19	37.230000
17709	5947	200	19	32.103000
17710	5948	200	19	30.151000
17711	5949	200	19	28.978000
17712	5950	200	19	26.823000
17713	5951	200	19	20.791000
17714	5952	200	19	17.447000
17715	5953	200	19	15.634000
17716	5954	200	19	19.835000
17717	5955	200	19	21.615000
17718	5956	200	19	29.652000
17719	5957	200	19	34.888000
17720	5958	200	19	35.411000
17721	5959	200	19	32.424000
17722	5960	200	19	31.154000
17723	5961	200	19	30.610000
17724	5962	200	19	28.063000
17725	5963	200	19	22.870000
17726	5964	200	19	17.583000
17727	5965	200	19	16.282000
17728	5966	200	19	17.794000
17729	5967	200	19	25.450000
17730	5968	200	19	28.452000
17731	5969	200	19	35.974000
17732	5970	200	19	36.091000
17733	5971	200	19	31.684000
17734	5972	200	19	30.264000
17735	5973	200	19	29.014000
17736	5974	200	19	26.034000
17737	5975	200	19	22.127000
17738	5976	200	19	16.853000
17739	5977	200	19	14.855000
17740	5978	200	19	18.655000
17741	5979	200	19	21.854000
17742	5980	200	19	28.625000
17743	5981	200	19	34.569000
17744	5982	200	19	37.076000
17745	5983	200	19	32.819000
17746	5984	200	19	30.712000
17747	5985	200	19	31.106000
17748	5986	200	19	28.309000
17749	5987	200	19	21.356000
17750	5988	200	19	16.862000
17751	5989	200	19	15.080000
17752	5990	200	19	18.503000
17753	5991	200	19	26.076000
17754	5992	200	19	29.766000
17755	5993	200	19	32.607000
17756	5994	200	19	32.917000
17757	5995	200	19	32.838000
17758	5996	200	19	30.395000
17759	5997	200	19	30.765000
17760	5998	200	19	27.422000
17761	5999	200	19	20.365000
17762	6000	200	19	15.711000
17763	6001	200	19	13.963000
17764	6002	200	19	18.138000
17765	6003	200	19	22.609000
17766	6004	200	19	27.477000
17767	6005	200	19	31.105000
17768	6006	200	19	32.752000
17769	6007	200	19	33.402000
17770	6008	200	19	30.908000
17771	6009	200	19	30.193000
17772	6010	200	19	24.081000
17773	6011	200	19	19.796000
17774	6012	200	19	13.862000
17775	6013	200	19	14.636000
17776	6014	200	19	18.144000
17777	6015	200	19	21.994000
17778	6016	200	19	30.108000
17779	6017	200	19	34.683000
17780	6018	200	19	34.754000
17781	6019	200	19	32.561000
17782	6020	200	19	32.704000
17783	6021	200	19	30.680000
17784	6022	200	19	26.912000
17785	6023	200	19	21.626000
17786	6024	200	19	16.359000
17787	6025	200	19	14.003000
17788	6026	200	19	18.239000
17789	6027	200	19	23.786000
17790	6028	200	19	30.749000
17791	6029	200	19	34.093000
17792	6030	200	19	33.887000
17793	6031	200	19	32.746000
17794	6032	200	19	30.791000
17795	6033	200	19	31.591000
17796	6034	200	19	28.133000
17797	6035	200	19	23.878000
17798	6036	200	19	16.494000
17799	6037	200	19	14.946000
17800	6038	200	19	17.697000
17801	6039	200	19	23.679000
17802	6040	200	19	31.835000
17803	6041	200	19	35.696000
17804	6042	200	19	34.523000
17805	6043	200	19	32.390000
17806	6044	200	19	31.120000
17807	6045	200	19	30.372000
17808	6046	200	19	27.904000
17809	6047	200	19	21.870000
17810	6048	200	19	16.510000
17811	6049	200	19	14.129000
17812	6050	200	19	18.339000
17813	6051	200	19	24.151000
17814	6052	200	19	29.321000
17815	6053	200	19	34.333000
17816	6054	200	19	33.283000
17817	6055	200	19	31.394000
17818	6056	200	19	30.136000
17819	6057	200	19	33.039000
17820	6058	200	19	28.025000
17821	6059	200	19	22.334000
17822	6060	200	19	16.502000
17823	6061	200	19	14.828000
17824	6062	200	19	17.807000
17825	6063	200	19	24.634000
17826	6064	200	19	30.830000
17827	6065	200	19	34.836000
17828	6066	200	19	35.911000
17829	6067	200	19	32.694000
17830	6068	200	19	32.234000
17831	6069	200	19	30.768000
17832	6070	200	19	27.418000
17833	6071	200	19	22.037000
17834	6072	200	19	16.486000
17835	5941	100	20	73.311900
17836	5942	100	20	73.311900
17837	5943	100	20	73.311900
17838	5944	100	20	73.311900
17839	5945	100	20	73.311900
17840	5946	100	20	73.311900
17841	5947	100	20	73.311900
17842	5948	100	20	73.311900
17843	5949	100	20	73.311900
17844	5950	100	20	73.311900
17845	5951	100	20	73.311900
17846	5952	100	20	73.311900
17847	5953	100	20	73.311900
17848	5954	100	20	73.311900
17849	5955	100	20	73.311900
17850	5956	100	20	73.311900
17851	5957	100	20	73.311900
17852	5958	100	20	73.311900
17853	5959	100	20	73.311900
17854	5960	100	20	73.311900
17855	5961	100	20	73.311900
17856	5962	100	20	73.311900
17857	5963	100	20	73.311900
17858	5964	100	20	73.311900
17859	5965	100	20	73.311900
17860	5966	100	20	73.311900
17861	5967	100	20	73.311900
17862	5968	100	20	73.311900
17863	5969	100	20	73.311900
17864	5970	100	20	73.311900
17865	5971	100	20	73.311900
17866	5972	100	20	73.311900
17867	5973	100	20	73.311900
17868	5974	100	20	73.311900
17869	5975	100	20	73.311900
17870	5976	100	20	73.311900
17871	5977	100	20	73.311900
17872	5978	100	20	73.311900
17873	5979	100	20	73.311900
17874	5980	100	20	73.311900
17875	5981	100	20	73.311900
17876	5982	100	20	73.311900
17877	5983	100	20	73.311900
17878	5984	100	20	73.311900
17879	5985	100	20	73.311900
17880	5986	100	20	73.311900
17881	5987	100	20	73.311900
17882	5988	100	20	73.311900
17883	5989	100	20	73.311900
17884	5990	100	20	73.311900
17885	5991	100	20	73.311900
17886	5992	100	20	73.311900
17887	5993	100	20	73.311900
17888	5994	100	20	73.311900
17889	5995	100	20	73.311900
17890	5996	100	20	73.311900
17891	5997	100	20	73.311900
17892	5998	100	20	73.311900
17893	5999	100	20	73.311900
17894	6000	100	20	73.311900
17895	6001	100	20	73.311900
17896	6002	100	20	73.311900
17897	6003	100	20	73.311900
17898	6004	100	20	73.311900
17899	6005	100	20	73.311900
17900	6006	100	20	73.311900
17901	6007	100	20	73.311900
17902	6008	100	20	73.311900
17903	6009	100	20	73.311900
17904	6010	100	20	73.311900
17905	6011	100	20	73.311900
17906	6012	100	20	73.311900
17907	6013	100	20	73.311900
17908	6014	100	20	73.311900
17909	6015	100	20	73.311900
17910	6016	100	20	73.311900
17911	6017	100	20	73.311900
17912	6018	100	20	73.311900
17913	6019	100	20	73.311900
17914	6020	100	20	73.311900
17915	6021	100	20	73.311900
17916	6022	100	20	73.311900
17917	6023	100	20	73.311900
17918	6024	100	20	73.311900
17919	6025	100	20	73.311900
17920	6026	100	20	73.311900
17921	6027	100	20	73.311900
17922	6028	100	20	73.311900
17923	6029	100	20	73.311900
17924	6030	100	20	73.311900
17925	6031	100	20	73.311900
17926	6032	100	20	73.311900
17927	6033	100	20	73.311900
17928	6034	100	20	73.311900
17929	6035	100	20	73.311900
17930	6036	100	20	73.311900
17931	6037	100	20	73.311900
17932	6038	100	20	73.311900
17933	6039	100	20	73.311900
17934	6040	100	20	73.311900
17935	6041	100	20	73.311900
17936	6042	100	20	73.311900
17937	6043	100	20	73.311900
17938	6044	100	20	73.311900
17939	6045	100	20	73.311900
17940	6046	100	20	73.311900
17941	6047	100	20	73.311900
17942	6048	100	20	73.311900
17943	6049	100	20	73.311900
17944	6050	100	20	73.311900
17945	6051	100	20	73.311900
17946	6052	100	20	73.311900
17947	6053	100	20	73.311900
17948	6054	100	20	73.311900
17949	6055	100	20	73.311900
17950	6056	100	20	73.311900
17951	6057	100	20	73.311900
17952	6058	100	20	73.311900
17953	6059	100	20	73.311900
17954	6060	100	20	73.311900
17955	6061	100	20	73.311900
17956	6062	100	20	73.311900
17957	6063	100	20	73.311900
17958	6064	100	20	73.311900
17959	6065	100	20	73.311900
17960	6066	100	20	73.311900
17961	6067	100	20	73.311900
17962	6068	100	20	73.311900
17963	6069	100	20	73.311900
17964	6070	100	20	73.311900
17965	6071	100	20	73.311900
17966	6072	100	20	73.311900
17967	6073	100	24	23.669300
17968	6074	100	24	23.669300
17969	6075	100	24	23.669300
17970	6076	100	24	23.669300
17971	6077	100	24	23.669300
17972	6078	100	24	23.669300
17973	6079	100	24	23.669300
17974	6080	100	24	23.669300
17975	6081	100	24	23.669300
17976	6082	100	24	23.669300
17977	6083	100	24	23.669300
17978	6084	100	24	23.669300
17979	6085	100	24	23.669300
17980	6086	100	24	23.669300
17981	6087	100	24	23.669300
17982	6088	100	24	23.669300
17983	6089	100	24	23.669300
17984	6090	100	24	23.669300
17985	6091	100	24	23.669300
17986	6092	100	24	23.669300
17987	6093	100	24	23.669300
17988	6094	100	24	23.669300
17989	6095	100	24	23.669300
17990	6096	100	24	23.669300
17991	6097	100	24	23.669300
17992	6098	100	24	23.669300
17993	6099	100	24	23.669300
17994	6100	100	24	23.669300
17995	6101	100	24	23.669300
17996	6102	100	24	23.669300
17997	6103	100	24	23.669300
17998	6104	100	24	23.669300
17999	6105	100	24	23.669300
18000	6106	100	24	23.669300
18001	6107	100	24	23.669300
18002	6108	100	24	23.669300
18003	6109	100	24	23.669300
18004	6110	100	24	23.669300
18005	6111	100	24	23.669300
18006	6112	100	24	23.669300
18007	6113	100	24	23.669300
18008	6114	100	24	23.669300
18009	6115	100	24	23.669300
18010	6116	100	24	23.669300
18011	6117	100	24	23.669300
18012	6118	100	24	23.669300
18013	6119	100	24	23.669300
18014	6120	100	24	23.669300
18015	6121	100	24	23.669300
18016	6122	100	24	23.669300
18017	6123	100	24	23.669300
18018	6124	100	24	23.669300
18019	6125	100	24	23.669300
18020	6126	100	24	23.669300
18021	6127	100	24	23.669300
18022	6128	100	24	23.669300
18023	6129	100	24	23.669300
18024	6130	100	24	23.669300
18025	6131	100	24	23.669300
18026	6132	100	24	23.669300
18027	6133	100	24	23.669300
18028	6134	100	24	23.669300
18029	6135	100	24	23.669300
18030	6136	100	24	23.669300
18031	6137	100	24	23.669300
18032	6138	100	24	23.669300
18033	6139	100	24	23.669300
18034	6140	100	24	23.669300
18035	6141	100	24	23.669300
18036	6142	100	24	23.669300
18037	6143	100	24	23.669300
18038	6144	100	24	23.669300
18039	6145	100	24	23.669300
18040	6146	100	24	23.669300
18041	6147	100	24	23.669300
18042	6148	100	24	23.669300
18043	6149	100	24	23.669300
18044	6150	100	24	23.669300
18045	6151	100	24	23.669300
18046	6152	100	24	23.669300
18047	6153	100	24	23.669300
18048	6154	100	24	23.669300
18049	6155	100	24	23.669300
18050	6156	100	24	23.669300
18051	6157	100	24	23.669300
18052	6158	100	24	23.669300
18053	6159	100	24	23.669300
18054	6160	100	24	23.669300
18055	6161	100	24	23.669300
18056	6162	100	24	23.669300
18057	6163	100	24	23.669300
18058	6164	100	24	23.669300
18059	6165	100	24	23.669300
18060	6166	100	24	23.669300
18061	6167	100	24	23.669300
18062	6168	100	24	23.669300
18063	6169	100	24	23.669300
18064	6170	100	24	23.669300
18065	6171	100	24	23.669300
18066	6172	100	24	23.669300
18067	6173	100	24	23.669300
18068	6174	100	24	23.669300
18069	6175	100	24	23.669300
18070	6176	100	24	23.669300
18071	6177	100	24	23.669300
18072	6178	100	24	23.669300
18073	6179	100	24	23.669300
18074	6180	100	24	23.669300
18075	6181	100	24	23.669300
18076	6182	100	24	23.669300
18077	6183	100	24	23.669300
18078	6184	100	24	23.669300
18079	6185	100	24	23.669300
18080	6186	100	24	23.669300
18081	6187	100	24	23.669300
18082	6188	100	24	23.669300
18083	6189	100	24	23.669300
18084	6190	100	24	23.669300
18085	6191	100	24	23.669300
18086	6192	100	24	23.669300
18087	6193	100	24	23.669300
18088	6194	100	24	23.669300
18089	6195	100	24	23.669300
18090	6196	100	24	23.669300
18091	6197	100	24	23.669300
18092	6198	100	24	23.669300
18093	6199	100	24	23.669300
18094	6200	100	24	23.669300
18095	6201	100	24	23.669300
18096	6202	100	24	23.669300
18097	6203	100	24	23.669300
18098	6204	100	24	23.669300
18099	6073	200	22	16.585000
18100	6074	200	22	18.439000
18101	6075	200	22	25.670000
18102	6076	200	22	29.728000
18103	6077	200	22	30.482000
18104	6078	200	22	29.818000
18105	6079	200	22	27.956000
18106	6080	200	22	26.814000
18107	6081	200	22	26.762000
18108	6082	200	22	24.968000
18109	6083	200	22	21.412000
18110	6084	200	22	17.517000
18111	6085	200	22	18.177000
18112	6086	200	22	21.365000
18113	6087	200	22	24.619000
18114	6088	200	22	28.728000
18115	6089	200	22	31.864000
18116	6090	200	22	31.000000
18117	6091	200	22	27.708000
18118	6092	200	22	26.767000
18119	6093	200	22	26.362000
18120	6094	200	22	25.064000
18121	6095	200	22	19.922000
18122	6096	200	22	17.280000
18123	6097	200	22	18.377000
18124	6098	200	22	19.630000
18125	6099	200	22	25.825000
18126	6100	200	22	28.530000
18127	6101	200	22	31.971000
18128	6102	200	22	29.813000
18129	6103	200	22	26.514000
18130	6104	200	22	26.218000
18131	6105	200	22	26.367000
18132	6106	200	22	25.163000
18133	6107	200	22	21.111000
18134	6108	200	22	17.774000
18135	6109	200	22	16.187000
18136	6110	200	22	19.777000
18137	6111	200	22	24.482000
18138	6112	200	22	29.679000
18139	6113	200	22	31.121000
18140	6114	200	22	31.410000
18141	6115	200	22	26.964000
18142	6116	200	22	26.529000
18143	6117	200	22	26.274000
18144	6118	200	22	24.864000
18145	6119	200	22	21.011000
18146	6120	200	22	17.881000
18147	6121	200	22	17.986000
18148	6122	200	22	19.037000
18149	6123	200	22	26.223000
18150	6124	200	22	28.187000
18151	6125	200	22	32.573000
18152	6126	200	22	28.681000
18153	6127	200	22	27.122000
18154	6128	200	22	26.023000
18155	6129	200	22	27.072000
18156	6130	200	22	24.562000
18157	6131	200	22	20.815000
18158	6132	200	22	16.887000
18159	6133	200	22	16.632000
18160	6134	200	22	18.732000
18161	6135	200	22	25.227000
18162	6136	200	22	27.027000
18163	6137	200	22	31.122000
18164	6138	200	22	31.515000
18165	6139	200	22	26.569000
18166	6140	200	22	26.371000
18167	6141	200	22	26.068000
18168	6142	200	22	25.165000
18169	6143	200	22	21.721000
18170	6144	200	22	18.182000
18171	6145	200	22	16.584000
18172	6146	200	22	20.081000
18173	6147	200	22	22.487000
18174	6148	200	22	28.238000
18175	6149	200	22	30.785000
18176	6150	200	22	32.256000
18177	6151	200	22	26.621000
18178	6152	200	22	26.974000
18179	6153	200	22	26.767000
18180	6154	200	22	26.510000
18181	6155	200	22	21.569000
18182	6156	200	22	18.468000
18183	6157	200	22	16.630000
18184	6158	200	22	20.833000
18185	6159	200	22	25.927000
18186	6160	200	22	31.076000
18187	6161	200	22	31.172000
18188	6162	200	22	29.718000
18189	6163	200	22	26.664000
18190	6164	200	22	26.562000
18191	6165	200	22	26.115000
18192	6166	200	22	25.611000
18193	6167	200	22	21.607000
18194	6168	200	22	18.723000
18195	6169	200	22	17.491000
18196	6170	200	22	19.133000
18197	6171	200	22	24.579000
18198	6172	200	22	30.373000
18199	6173	200	22	31.172000
18200	6174	200	22	28.868000
18201	6175	200	22	27.507000
18202	6176	200	22	27.072000
18203	6177	200	22	26.073000
18204	6178	200	22	25.807000
18205	6179	200	22	22.454000
18206	6180	200	22	17.517000
18207	6181	200	22	16.728000
18208	6182	200	22	19.890000
18209	6183	200	22	25.129000
18210	6184	200	22	29.721000
18211	6185	200	22	31.767000
18212	6186	200	22	27.925000
18213	6187	200	22	26.016000
18214	6188	200	22	27.119000
18215	6189	200	22	27.220000
18216	6190	200	22	26.305000
18217	6191	200	22	22.760000
18218	6192	200	22	18.913000
18219	6193	200	22	17.484000
18220	6194	200	22	20.879000
18221	6195	200	22	25.926000
18222	6196	200	22	29.572000
18223	6197	200	22	32.322000
18224	6198	200	22	30.460000
18225	6199	200	22	27.960000
18226	6200	200	22	26.468000
18227	6201	200	22	26.367000
18228	6202	200	22	24.768000
18229	6203	200	22	20.918000
18230	6204	200	22	18.524000
18231	6073	100	23	86.151100
18232	6074	100	23	86.151100
18233	6075	100	23	86.151100
18234	6076	100	23	86.151100
18235	6077	100	23	86.151100
18236	6078	100	23	86.151100
18237	6079	100	23	86.151100
18238	6080	100	23	86.151100
18239	6081	100	23	86.151100
18240	6082	100	23	86.151100
18241	6083	100	23	86.151100
18242	6084	100	23	86.151100
18243	6085	100	23	86.151100
18244	6086	100	23	86.151100
18245	6087	100	23	86.151100
18246	6088	100	23	86.151100
18247	6089	100	23	86.151100
18248	6090	100	23	86.151100
18249	6091	100	23	86.151100
18250	6092	100	23	86.151100
18251	6093	100	23	86.151100
18252	6094	100	23	86.151100
18253	6095	100	23	86.151100
18254	6096	100	23	86.151100
18255	6097	100	23	86.151100
18256	6098	100	23	86.151100
18257	6099	100	23	86.151100
18258	6100	100	23	86.151100
18259	6101	100	23	86.151100
18260	6102	100	23	86.151100
18261	6103	100	23	86.151100
18262	6104	100	23	86.151100
18263	6105	100	23	86.151100
18264	6106	100	23	86.151100
18265	6107	100	23	86.151100
18266	6108	100	23	86.151100
18267	6109	100	23	86.151100
18268	6110	100	23	86.151100
18269	6111	100	23	86.151100
18270	6112	100	23	86.151100
18271	6113	100	23	86.151100
18272	6114	100	23	86.151100
18273	6115	100	23	86.151100
18274	6116	100	23	86.151100
18275	6117	100	23	86.151100
18276	6118	100	23	86.151100
18277	6119	100	23	86.151100
18278	6120	100	23	86.151100
18279	6121	100	23	86.151100
18280	6122	100	23	86.151100
18281	6123	100	23	86.151100
18282	6124	100	23	86.151100
18283	6125	100	23	86.151100
18284	6126	100	23	86.151100
18285	6127	100	23	86.151100
18286	6128	100	23	86.151100
18287	6129	100	23	86.151100
18288	6130	100	23	86.151100
18289	6131	100	23	86.151100
18290	6132	100	23	86.151100
18291	6133	100	23	86.151100
18292	6134	100	23	86.151100
18293	6135	100	23	86.151100
18294	6136	100	23	86.151100
18295	6137	100	23	86.151100
18296	6138	100	23	86.151100
18297	6139	100	23	86.151100
18298	6140	100	23	86.151100
18299	6141	100	23	86.151100
18300	6142	100	23	86.151100
18301	6143	100	23	86.151100
18302	6144	100	23	86.151100
18303	6145	100	23	86.151100
18304	6146	100	23	86.151100
18305	6147	100	23	86.151100
18306	6148	100	23	86.151100
18307	6149	100	23	86.151100
18308	6150	100	23	86.151100
18309	6151	100	23	86.151100
18310	6152	100	23	86.151100
18311	6153	100	23	86.151100
18312	6154	100	23	86.151100
18313	6155	100	23	86.151100
18314	6156	100	23	86.151100
18315	6157	100	23	86.151100
18316	6158	100	23	86.151100
18317	6159	100	23	86.151100
18318	6160	100	23	86.151100
18319	6161	100	23	86.151100
18320	6162	100	23	86.151100
18321	6163	100	23	86.151100
18322	6164	100	23	86.151100
18323	6165	100	23	86.151100
18324	6166	100	23	86.151100
18325	6167	100	23	86.151100
18326	6168	100	23	86.151100
18327	6169	100	23	86.151100
18328	6170	100	23	86.151100
18329	6171	100	23	86.151100
18330	6172	100	23	86.151100
18331	6173	100	23	86.151100
18332	6174	100	23	86.151100
18333	6175	100	23	86.151100
18334	6176	100	23	86.151100
18335	6177	100	23	86.151100
18336	6178	100	23	86.151100
18337	6179	100	23	86.151100
18338	6180	100	23	86.151100
18339	6181	100	23	86.151100
18340	6182	100	23	86.151100
18341	6183	100	23	86.151100
18342	6184	100	23	86.151100
18343	6185	100	23	86.151100
18344	6186	100	23	86.151100
18345	6187	100	23	86.151100
18346	6188	100	23	86.151100
18347	6189	100	23	86.151100
18348	6190	100	23	86.151100
18349	6191	100	23	86.151100
18350	6192	100	23	86.151100
18351	6193	100	23	86.151100
18352	6194	100	23	86.151100
18353	6195	100	23	86.151100
18354	6196	100	23	86.151100
18355	6197	100	23	86.151100
18356	6198	100	23	86.151100
18357	6199	100	23	86.151100
18358	6200	100	23	86.151100
18359	6201	100	23	86.151100
18360	6202	100	23	86.151100
18361	6203	100	23	86.151100
18362	6204	100	23	86.151100
18363	6205	100	27	30.733300
18364	6206	100	27	30.733300
18365	6207	100	27	30.733300
18366	6208	100	27	30.733300
18367	6209	100	27	30.733300
18368	6210	100	27	30.733300
18369	6211	100	27	30.733300
18370	6212	100	27	30.733300
18371	6213	100	27	30.733300
18372	6214	100	27	30.733300
18373	6215	100	27	30.733300
18374	6216	100	27	30.733300
18375	6217	100	27	30.733300
18376	6218	100	27	30.733300
18377	6219	100	27	30.733300
18378	6220	100	27	30.733300
18379	6221	100	27	30.733300
18380	6222	100	27	30.733300
18381	6223	100	27	30.733300
18382	6224	100	27	30.733300
18383	6225	100	27	30.733300
18384	6226	100	27	30.733300
18385	6227	100	27	30.733300
18386	6228	100	27	30.733300
18387	6229	100	27	30.733300
18388	6230	100	27	30.733300
18389	6231	100	27	30.733300
18390	6232	100	27	30.733300
18391	6233	100	27	30.733300
18392	6234	100	27	30.733300
18393	6235	100	27	30.733300
18394	6236	100	27	30.733300
18395	6237	100	27	30.733300
18396	6238	100	27	30.733300
18397	6239	100	27	30.733300
18398	6240	100	27	30.733300
18399	6241	100	27	30.733300
18400	6242	100	27	30.733300
18401	6243	100	27	30.733300
18402	6244	100	27	30.733300
18403	6245	100	27	30.733300
18404	6246	100	27	30.733300
18405	6247	100	27	30.733300
18406	6248	100	27	30.733300
18407	6249	100	27	30.733300
18408	6250	100	27	30.733300
18409	6251	100	27	30.733300
18410	6252	100	27	30.733300
18411	6253	100	27	30.733300
18412	6254	100	27	30.733300
18413	6255	100	27	30.733300
18414	6256	100	27	30.733300
18415	6257	100	27	30.733300
18416	6258	100	27	30.733300
18417	6259	100	27	30.733300
18418	6260	100	27	30.733300
18419	6261	100	27	30.733300
18420	6262	100	27	30.733300
18421	6263	100	27	30.733300
18422	6264	100	27	30.733300
18423	6265	100	27	30.733300
18424	6266	100	27	30.733300
18425	6267	100	27	30.733300
18426	6268	100	27	30.733300
18427	6269	100	27	30.733300
18428	6270	100	27	30.733300
18429	6271	100	27	30.733300
18430	6272	100	27	30.733300
18431	6273	100	27	30.733300
18432	6274	100	27	30.733300
18433	6275	100	27	30.733300
18434	6276	100	27	30.733300
18435	6277	100	27	30.733300
18436	6278	100	27	30.733300
18437	6279	100	27	30.733300
18438	6280	100	27	30.733300
18439	6281	100	27	30.733300
18440	6282	100	27	30.733300
18441	6283	100	27	30.733300
18442	6284	100	27	30.733300
18443	6285	100	27	30.733300
18444	6286	100	27	30.733300
18445	6287	100	27	30.733300
18446	6288	100	27	30.733300
18447	6289	100	27	30.733300
18448	6290	100	27	30.733300
18449	6291	100	27	30.733300
18450	6292	100	27	30.733300
18451	6293	100	27	30.733300
18452	6294	100	27	30.733300
18453	6295	100	27	30.733300
18454	6296	100	27	30.733300
18455	6297	100	27	30.733300
18456	6298	100	27	30.733300
18457	6299	100	27	30.733300
18458	6300	100	27	30.733300
18459	6301	100	27	30.733300
18460	6302	100	27	30.733300
18461	6303	100	27	30.733300
18462	6304	100	27	30.733300
18463	6305	100	27	30.733300
18464	6306	100	27	30.733300
18465	6307	100	27	30.733300
18466	6308	100	27	30.733300
18467	6309	100	27	30.733300
18468	6310	100	27	30.733300
18469	6311	100	27	30.733300
18470	6312	100	27	30.733300
18471	6313	100	27	30.733300
18472	6314	100	27	30.733300
18473	6315	100	27	30.733300
18474	6316	100	27	30.733300
18475	6317	100	27	30.733300
18476	6318	100	27	30.733300
18477	6319	100	27	30.733300
18478	6320	100	27	30.733300
18479	6321	100	27	30.733300
18480	6322	100	27	30.733300
18481	6323	100	27	30.733300
18482	6324	100	27	30.733300
18483	6325	100	27	30.733300
18484	6326	100	27	30.733300
18485	6327	100	27	30.733300
18486	6328	100	27	30.733300
18487	6329	100	27	30.733300
18488	6330	100	27	30.733300
18489	6331	100	27	30.733300
18490	6332	100	27	30.733300
18491	6333	100	27	30.733300
18492	6334	100	27	30.733300
18493	6335	100	27	30.733300
18494	6336	100	27	30.733300
18495	6205	200	25	14.400000
18496	6206	200	25	15.300000
18497	6207	200	25	21.200000
18498	6208	200	25	27.600000
18499	6209	200	25	31.300000
18500	6210	200	25	34.200000
18501	6211	200	25	30.300000
18502	6212	200	25	29.600000
18503	6213	200	25	28.900000
18504	6214	200	25	25.400000
18505	6215	200	25	20.200000
18506	6216	200	25	16.100000
18507	6217	200	25	13.700000
18508	6218	200	25	17.900000
18509	6219	200	25	19.800000
18510	6220	200	25	27.400000
18511	6221	200	25	33.500000
18512	6222	200	25	33.900000
18513	6223	200	25	31.000000
18514	6224	200	25	31.400000
18515	6225	200	25	28.400000
18516	6226	200	25	25.300000
18517	6227	200	25	20.600000
18518	6228	200	25	15.300000
18519	6229	200	25	14.300000
18520	6230	200	25	16.500000
18521	6231	200	25	23.200000
18522	6232	200	25	26.300000
18523	6233	200	25	33.000000
18524	6234	200	25	34.900000
18525	6235	200	25	30.600000
18526	6236	200	25	29.900000
18527	6237	200	25	28.700000
18528	6238	200	25	25.000000
18529	6239	200	25	20.200000
18530	6240	200	25	16.100000
18531	6241	200	25	13.400000
18532	6242	200	25	16.300000
18533	6243	200	25	20.400000
18534	6244	200	25	26.600000
18535	6245	200	25	34.100000
18536	6246	200	25	35.600000
18537	6247	200	25	31.000000
18538	6248	200	25	28.700000
18539	6249	200	25	29.200000
18540	6250	200	25	26.500000
18541	6251	200	25	20.500000
18542	6252	200	25	16.200000
18543	6253	200	25	14.100000
18544	6254	200	25	17.200000
18545	6255	200	25	22.500000
18546	6256	200	25	28.500000
18547	6257	200	25	31.800000
18548	6258	200	25	32.700000
18549	6259	200	25	31.100000
18550	6260	200	25	28.800000
18551	6261	200	25	28.800000
18552	6262	200	25	25.500000
18553	6263	200	25	19.400000
18554	6264	200	25	14.300000
18555	6265	200	25	13.800000
18556	6266	200	25	16.400000
18557	6267	200	25	21.300000
18558	6268	200	25	26.900000
18559	6269	200	25	30.500000
18560	6270	200	25	32.200000
18561	6271	200	25	31.800000
18562	6272	200	25	29.700000
18563	6273	200	25	30.000000
18564	6274	200	25	23.700000
18565	6275	200	25	19.400000
18566	6276	200	25	13.400000
18567	6277	200	25	11.200000
18568	6278	200	25	17.000000
18569	6279	200	25	19.900000
18570	6280	200	25	28.000000
18571	6281	200	25	33.500000
18572	6282	200	25	35.100000
18573	6283	200	25	31.100000
18574	6284	200	25	30.300000
18575	6285	200	25	29.800000
18576	6286	200	25	26.300000
18577	6287	200	25	21.300000
18578	6288	200	25	16.500000
18579	6289	200	25	13.500000
18580	6290	200	25	19.000000
18581	6291	200	25	23.900000
18582	6292	200	25	32.100000
18583	6293	200	25	33.600000
18584	6294	200	25	32.800000
18585	6295	200	25	32.100000
18586	6296	200	25	30.800000
18587	6297	200	25	30.500000
18588	6298	200	25	27.000000
18589	6299	200	25	21.800000
18590	6300	200	25	16.400000
18591	6301	200	25	14.800000
18592	6302	200	25	15.200000
18593	6303	200	25	21.100000
18594	6304	200	25	30.300000
18595	6305	200	25	34.000000
18596	6306	200	25	32.900000
18597	6307	200	25	30.700000
18598	6308	200	25	30.600000
18599	6309	200	25	30.200000
18600	6310	200	25	27.800000
18601	6311	200	25	21.700000
18602	6312	200	25	16.800000
18603	6313	200	25	13.900000
18604	6314	200	25	17.400000
18605	6315	200	25	22.700000
18606	6316	200	25	27.600000
18607	6317	200	25	33.400000
18608	6318	200	25	32.400000
18609	6319	200	25	31.400000
18610	6320	200	25	31.500000
18611	6321	200	25	30.600000
18612	6322	200	25	27.700000
18613	6323	200	25	22.000000
18614	6324	200	25	16.700000
18615	6325	200	25	16.000000
18616	6326	200	25	16.300000
18617	6327	200	25	20.900000
18618	6328	200	25	30.000000
18619	6329	200	25	34.800000
18620	6330	200	25	34.200000
18621	6331	200	25	33.200000
18622	6332	200	25	31.000000
18623	6333	200	25	28.300000
18624	6334	200	25	26.400000
18625	6335	200	25	21.300000
18626	6336	200	25	16.000000
18627	6205	100	26	76.779400
18628	6206	100	26	76.779400
18629	6207	100	26	76.779400
18630	6208	100	26	76.779400
18631	6209	100	26	76.779400
18632	6210	100	26	76.779400
18633	6211	100	26	76.779400
18634	6212	100	26	76.779400
18635	6213	100	26	76.779400
18636	6214	100	26	76.779400
18637	6215	100	26	76.779400
18638	6216	100	26	76.779400
18639	6217	100	26	76.779400
18640	6218	100	26	76.779400
18641	6219	100	26	76.779400
18642	6220	100	26	76.779400
18643	6221	100	26	76.779400
18644	6222	100	26	76.779400
18645	6223	100	26	76.779400
18646	6224	100	26	76.779400
18647	6225	100	26	76.779400
18648	6226	100	26	76.779400
18649	6227	100	26	76.779400
18650	6228	100	26	76.779400
18651	6229	100	26	76.779400
18652	6230	100	26	76.779400
18653	6231	100	26	76.779400
18654	6232	100	26	76.779400
18655	6233	100	26	76.779400
18656	6234	100	26	76.779400
18657	6235	100	26	76.779400
18658	6236	100	26	76.779400
18659	6237	100	26	76.779400
18660	6238	100	26	76.779400
18661	6239	100	26	76.779400
18662	6240	100	26	76.779400
18663	6241	100	26	76.779400
18664	6242	100	26	76.779400
18665	6243	100	26	76.779400
18666	6244	100	26	76.779400
18667	6245	100	26	76.779400
18668	6246	100	26	76.779400
18669	6247	100	26	76.779400
18670	6248	100	26	76.779400
18671	6249	100	26	76.779400
18672	6250	100	26	76.779400
18673	6251	100	26	76.779400
18674	6252	100	26	76.779400
18675	6253	100	26	76.779400
18676	6254	100	26	76.779400
18677	6255	100	26	76.779400
18678	6256	100	26	76.779400
18679	6257	100	26	76.779400
18680	6258	100	26	76.779400
18681	6259	100	26	76.779400
18682	6260	100	26	76.779400
18683	6261	100	26	76.779400
18684	6262	100	26	76.779400
18685	6263	100	26	76.779400
18686	6264	100	26	76.779400
18687	6265	100	26	76.779400
18688	6266	100	26	76.779400
18689	6267	100	26	76.779400
18690	6268	100	26	76.779400
18691	6269	100	26	76.779400
18692	6270	100	26	76.779400
18693	6271	100	26	76.779400
18694	6272	100	26	76.779400
18695	6273	100	26	76.779400
18696	6274	100	26	76.779400
18697	6275	100	26	76.779400
18698	6276	100	26	76.779400
18699	6277	100	26	76.779400
18700	6278	100	26	76.779400
18701	6279	100	26	76.779400
18702	6280	100	26	76.779400
18703	6281	100	26	76.779400
18704	6282	100	26	76.779400
18705	6283	100	26	76.779400
18706	6284	100	26	76.779400
18707	6285	100	26	76.779400
18708	6286	100	26	76.779400
18709	6287	100	26	76.779400
18710	6288	100	26	76.779400
18711	6289	100	26	76.779400
18712	6290	100	26	76.779400
18713	6291	100	26	76.779400
18714	6292	100	26	76.779400
18715	6293	100	26	76.779400
18716	6294	100	26	76.779400
18717	6295	100	26	76.779400
18718	6296	100	26	76.779400
18719	6297	100	26	76.779400
18720	6298	100	26	76.779400
18721	6299	100	26	76.779400
18722	6300	100	26	76.779400
18723	6301	100	26	76.779400
18724	6302	100	26	76.779400
18725	6303	100	26	76.779400
18726	6304	100	26	76.779400
18727	6305	100	26	76.779400
18728	6306	100	26	76.779400
18729	6307	100	26	76.779400
18730	6308	100	26	76.779400
18731	6309	100	26	76.779400
18732	6310	100	26	76.779400
18733	6311	100	26	76.779400
18734	6312	100	26	76.779400
18735	6313	100	26	76.779400
18736	6314	100	26	76.779400
18737	6315	100	26	76.779400
18738	6316	100	26	76.779400
18739	6317	100	26	76.779400
18740	6318	100	26	76.779400
18741	6319	100	26	76.779400
18742	6320	100	26	76.779400
18743	6321	100	26	76.779400
18744	6322	100	26	76.779400
18745	6323	100	26	76.779400
18746	6324	100	26	76.779400
18747	6325	100	26	76.779400
18748	6326	100	26	76.779400
18749	6327	100	26	76.779400
18750	6328	100	26	76.779400
18751	6329	100	26	76.779400
18752	6330	100	26	76.779400
18753	6331	100	26	76.779400
18754	6332	100	26	76.779400
18755	6333	100	26	76.779400
18756	6334	100	26	76.779400
18757	6335	100	26	76.779400
18758	6336	100	26	76.779400
18759	6337	100	30	13.082700
18760	6338	100	30	13.082700
18761	6339	100	30	13.082700
18762	6340	100	30	13.082700
18763	6341	100	30	13.082700
18764	6342	100	30	13.082700
18765	6343	100	30	13.082700
18766	6344	100	30	13.082700
18767	6345	100	30	13.082700
18768	6346	100	30	13.082700
18769	6347	100	30	13.082700
18770	6348	100	30	13.082700
18771	6349	100	30	13.082700
18772	6350	100	30	13.082700
18773	6351	100	30	13.082700
18774	6352	100	30	13.082700
18775	6353	100	30	13.082700
18776	6354	100	30	13.082700
18777	6355	100	30	13.082700
18778	6356	100	30	13.082700
18779	6357	100	30	13.082700
18780	6358	100	30	13.082700
18781	6359	100	30	13.082700
18782	6360	100	30	13.082700
18783	6361	100	30	13.082700
18784	6362	100	30	13.082700
18785	6363	100	30	13.082700
18786	6364	100	30	13.082700
18787	6365	100	30	13.082700
18788	6366	100	30	13.082700
18789	6367	100	30	13.082700
18790	6368	100	30	13.082700
18791	6369	100	30	13.082700
18792	6370	100	30	13.082700
18793	6371	100	30	13.082700
18794	6372	100	30	13.082700
18795	6373	100	30	13.082700
18796	6374	100	30	13.082700
18797	6375	100	30	13.082700
18798	6376	100	30	13.082700
18799	6377	100	30	13.082700
18800	6378	100	30	13.082700
18801	6379	100	30	13.082700
18802	6380	100	30	13.082700
18803	6381	100	30	13.082700
18804	6382	100	30	13.082700
18805	6383	100	30	13.082700
18806	6384	100	30	13.082700
18807	6385	100	30	13.082700
18808	6386	100	30	13.082700
18809	6387	100	30	13.082700
18810	6388	100	30	13.082700
18811	6389	100	30	13.082700
18812	6390	100	30	13.082700
18813	6391	100	30	13.082700
18814	6392	100	30	13.082700
18815	6393	100	30	13.082700
18816	6394	100	30	13.082700
18817	6395	100	30	13.082700
18818	6396	100	30	13.082700
18819	6397	100	30	13.082700
18820	6398	100	30	13.082700
18821	6399	100	30	13.082700
18822	6400	100	30	13.082700
18823	6401	100	30	13.082700
18824	6402	100	30	13.082700
18825	6403	100	30	13.082700
18826	6404	100	30	13.082700
18827	6405	100	30	13.082700
18828	6406	100	30	13.082700
18829	6407	100	30	13.082700
18830	6408	100	30	13.082700
18831	6409	100	30	13.082700
18832	6410	100	30	13.082700
18833	6411	100	30	13.082700
18834	6412	100	30	13.082700
18835	6413	100	30	13.082700
18836	6414	100	30	13.082700
18837	6415	100	30	13.082700
18838	6416	100	30	13.082700
18839	6417	100	30	13.082700
18840	6418	100	30	13.082700
18841	6419	100	30	13.082700
18842	6420	100	30	13.082700
18843	6421	100	30	13.082700
18844	6422	100	30	13.082700
18845	6423	100	30	13.082700
18846	6424	100	30	13.082700
18847	6425	100	30	13.082700
18848	6426	100	30	13.082700
18849	6427	100	30	13.082700
18850	6428	100	30	13.082700
18851	6429	100	30	13.082700
18852	6430	100	30	13.082700
18853	6431	100	30	13.082700
18854	6432	100	30	13.082700
18855	6433	100	30	13.082700
18856	6434	100	30	13.082700
18857	6435	100	30	13.082700
18858	6436	100	30	13.082700
18859	6437	100	30	13.082700
18860	6438	100	30	13.082700
18861	6439	100	30	13.082700
18862	6440	100	30	13.082700
18863	6441	100	30	13.082700
18864	6442	100	30	13.082700
18865	6443	100	30	13.082700
18866	6444	100	30	13.082700
18867	6445	100	30	13.082700
18868	6446	100	30	13.082700
18869	6447	100	30	13.082700
18870	6448	100	30	13.082700
18871	6449	100	30	13.082700
18872	6450	100	30	13.082700
18873	6451	100	30	13.082700
18874	6452	100	30	13.082700
18875	6453	100	30	13.082700
18876	6454	100	30	13.082700
18877	6455	100	30	13.082700
18878	6456	100	30	13.082700
18879	6457	100	30	13.082700
18880	6458	100	30	13.082700
18881	6459	100	30	13.082700
18882	6460	100	30	13.082700
18883	6461	100	30	13.082700
18884	6462	100	30	13.082700
18885	6463	100	30	13.082700
18886	6464	100	30	13.082700
18887	6465	100	30	13.082700
18888	6466	100	30	13.082700
18889	6467	100	30	13.082700
18890	6468	100	30	13.082700
18891	6337	200	28	23.923000
18892	6338	200	28	25.976000
18893	6339	200	28	27.453000
18894	6340	200	28	30.453000
18895	6341	200	28	32.353000
18896	6342	200	28	32.400000
18897	6343	200	28	31.124000
18898	6344	200	28	30.012000
18899	6345	200	28	29.688000
18900	6346	200	28	27.812000
18901	6347	200	28	26.035000
18902	6348	200	28	24.324000
18903	6349	200	28	24.000000
18904	6350	200	28	25.588000
18905	6351	200	28	28.265000
18906	6352	200	28	30.565000
18907	6353	200	28	32.453000
18908	6354	200	28	31.700000
18909	6355	200	28	30.935000
18910	6356	200	28	29.911000
18911	6357	200	28	29.589000
18912	6358	200	28	27.600000
18913	6359	200	28	25.912000
18914	6360	200	28	24.512000
18915	6361	200	28	24.912000
18916	6362	200	28	26.076000
18917	6363	200	28	28.065000
18918	6364	200	28	30.865000
18919	6365	200	28	32.953000
18920	6366	200	28	32.312000
18921	6367	200	28	30.435000
18922	6368	200	28	29.911000
18923	6369	200	28	30.200000
18924	6370	200	28	27.724000
18925	6371	200	28	25.323000
18926	6372	200	28	24.135000
18927	6373	200	28	24.211000
18928	6374	200	28	25.988000
18929	6375	200	28	27.876000
18930	6376	200	28	30.665000
18931	6377	200	28	31.276000
18932	6378	200	28	32.400000
18933	6379	200	28	30.311000
18934	6380	200	28	29.600000
18935	6381	200	28	29.600000
18936	6382	200	28	27.923000
18937	6383	200	28	26.624000
18938	6384	200	28	24.623000
18939	6385	200	28	24.812000
18940	6386	200	28	25.988000
18941	6387	200	28	27.765000
18942	6388	200	28	30.665000
18943	6389	200	28	33.654000
18944	6390	200	28	30.888000
18945	6391	200	28	30.323000
18946	6392	200	28	30.088000
18947	6393	200	28	28.988000
18948	6394	200	28	27.724000
18949	6395	200	28	26.212000
18950	6396	200	28	24.512000
18951	6397	200	28	24.223000
18952	6398	200	28	25.376000
18953	6399	200	28	28.577000
18954	6400	200	28	30.365000
18955	6401	200	28	32.765000
18956	6402	200	28	32.212000
18957	6403	200	28	31.624000
18958	6404	200	28	30.600000
18959	6405	200	28	29.788000
18960	6406	200	28	27.912000
18961	6407	200	28	25.912000
18962	6408	200	28	24.847000
18963	6409	200	28	26.000000
18964	6410	200	28	27.277000
18965	6411	200	28	29.265000
18966	6412	200	28	31.065000
18967	6413	200	28	33.165000
18968	6414	200	28	33.300000
18969	6415	200	28	31.023000
18970	6416	200	28	29.812000
18971	6417	200	28	29.888000
18972	6418	200	28	27.824000
18973	6419	200	28	26.236000
18974	6420	200	28	24.535000
18975	6421	200	28	24.312000
18976	6422	200	28	26.177000
18977	6423	200	28	29.065000
18978	6424	200	28	30.953000
18979	6425	200	28	31.865000
18980	6426	200	28	31.500000
18981	6427	200	28	29.347000
18982	6428	200	28	30.012000
18983	6429	200	28	29.400000
18984	6430	200	28	27.824000
18985	6431	200	28	26.023000
18986	6432	200	28	24.523000
18987	6433	200	28	25.200000
18988	6434	200	28	26.577000
18989	6435	200	28	27.777000
18990	6436	200	28	31.153000
18991	6437	200	28	32.765000
18992	6438	200	28	31.323000
18993	6439	200	28	30.135000
18994	6440	200	28	29.612000
18995	6441	200	28	29.688000
18996	6442	200	28	27.611000
18997	6443	200	28	26.123000
18998	6444	200	28	24.523000
18999	6445	200	28	25.300000
19000	6446	200	28	26.165000
19001	6447	200	28	29.353000
19002	6448	200	28	30.453000
19003	6449	200	28	33.365000
19004	6450	200	28	31.988000
19005	6451	200	28	31.411000
19006	6452	200	28	30.300000
19007	6453	200	28	29.888000
19008	6454	200	28	27.424000
19009	6455	200	28	26.324000
19010	6456	200	28	24.523000
19011	6457	200	28	25.400000
19012	6458	200	28	25.500000
19013	6459	200	28	28.465000
19014	6460	200	28	30.953000
19015	6461	200	28	33.453000
19016	6462	200	28	31.912000
19017	6463	200	28	32.012000
19018	6464	200	28	30.288000
19019	6465	200	28	30.576000
19020	6466	200	28	27.912000
19021	6467	200	28	25.623000
19022	6468	200	28	24.523000
19023	6337	100	29	80.270700
19024	6338	100	29	80.270700
19025	6339	100	29	80.270700
19026	6340	100	29	80.270700
19027	6341	100	29	80.270700
19028	6342	100	29	80.270700
19029	6343	100	29	80.270700
19030	6344	100	29	80.270700
19031	6345	100	29	80.270700
19032	6346	100	29	80.270700
19033	6347	100	29	80.270700
19034	6348	100	29	80.270700
19035	6349	100	29	80.270700
19036	6350	100	29	80.270700
19037	6351	100	29	80.270700
19038	6352	100	29	80.270700
19039	6353	100	29	80.270700
19040	6354	100	29	80.270700
19041	6355	100	29	80.270700
19042	6356	100	29	80.270700
19043	6357	100	29	80.270700
19044	6358	100	29	80.270700
19045	6359	100	29	80.270700
19046	6360	100	29	80.270700
19047	6361	100	29	80.270700
19048	6362	100	29	80.270700
19049	6363	100	29	80.270700
19050	6364	100	29	80.270700
19051	6365	100	29	80.270700
19052	6366	100	29	80.270700
19053	6367	100	29	80.270700
19054	6368	100	29	80.270700
19055	6369	100	29	80.270700
19056	6370	100	29	80.270700
19057	6371	100	29	80.270700
19058	6372	100	29	80.270700
19059	6373	100	29	80.270700
19060	6374	100	29	80.270700
19061	6375	100	29	80.270700
19062	6376	100	29	80.270700
19063	6377	100	29	80.270700
19064	6378	100	29	80.270700
19065	6379	100	29	80.270700
19066	6380	100	29	80.270700
19067	6381	100	29	80.270700
19068	6382	100	29	80.270700
19069	6383	100	29	80.270700
19070	6384	100	29	80.270700
19071	6385	100	29	80.270700
19072	6386	100	29	80.270700
19073	6387	100	29	80.270700
19074	6388	100	29	80.270700
19075	6389	100	29	80.270700
19076	6390	100	29	80.270700
19077	6391	100	29	80.270700
19078	6392	100	29	80.270700
19079	6393	100	29	80.270700
19080	6394	100	29	80.270700
19081	6395	100	29	80.270700
19082	6396	100	29	80.270700
19083	6397	100	29	80.270700
19084	6398	100	29	80.270700
19085	6399	100	29	80.270700
19086	6400	100	29	80.270700
19087	6401	100	29	80.270700
19088	6402	100	29	80.270700
19089	6403	100	29	80.270700
19090	6404	100	29	80.270700
19091	6405	100	29	80.270700
19092	6406	100	29	80.270700
19093	6407	100	29	80.270700
19094	6408	100	29	80.270700
19095	6409	100	29	80.270700
19096	6410	100	29	80.270700
19097	6411	100	29	80.270700
19098	6412	100	29	80.270700
19099	6413	100	29	80.270700
19100	6414	100	29	80.270700
19101	6415	100	29	80.270700
19102	6416	100	29	80.270700
19103	6417	100	29	80.270700
19104	6418	100	29	80.270700
19105	6419	100	29	80.270700
19106	6420	100	29	80.270700
19107	6421	100	29	80.270700
19108	6422	100	29	80.270700
19109	6423	100	29	80.270700
19110	6424	100	29	80.270700
19111	6425	100	29	80.270700
19112	6426	100	29	80.270700
19113	6427	100	29	80.270700
19114	6428	100	29	80.270700
19115	6429	100	29	80.270700
19116	6430	100	29	80.270700
19117	6431	100	29	80.270700
19118	6432	100	29	80.270700
19119	6433	100	29	80.270700
19120	6434	100	29	80.270700
19121	6435	100	29	80.270700
19122	6436	100	29	80.270700
19123	6437	100	29	80.270700
19124	6438	100	29	80.270700
19125	6439	100	29	80.270700
19126	6440	100	29	80.270700
19127	6441	100	29	80.270700
19128	6442	100	29	80.270700
19129	6443	100	29	80.270700
19130	6444	100	29	80.270700
19131	6445	100	29	80.270700
19132	6446	100	29	80.270700
19133	6447	100	29	80.270700
19134	6448	100	29	80.270700
19135	6449	100	29	80.270700
19136	6450	100	29	80.270700
19137	6451	100	29	80.270700
19138	6452	100	29	80.270700
19139	6453	100	29	80.270700
19140	6454	100	29	80.270700
19141	6455	100	29	80.270700
19142	6456	100	29	80.270700
19143	6457	100	29	80.270700
19144	6458	100	29	80.270700
19145	6459	100	29	80.270700
19146	6460	100	29	80.270700
19147	6461	100	29	80.270700
19148	6462	100	29	80.270700
19149	6463	100	29	80.270700
19150	6464	100	29	80.270700
19151	6465	100	29	80.270700
19152	6466	100	29	80.270700
19153	6467	100	29	80.270700
19154	6468	100	29	80.270700
19155	6469	100	33	20.180900
19156	6470	100	33	20.180900
19157	6471	100	33	20.180900
19158	6472	100	33	20.180900
19159	6473	100	33	20.180900
19160	6474	100	33	20.180900
19161	6475	100	33	20.180900
19162	6476	100	33	20.180900
19163	6477	100	33	20.180900
19164	6478	100	33	20.180900
19165	6479	100	33	20.180900
19166	6480	100	33	20.180900
19167	6481	100	33	20.180900
19168	6482	100	33	20.180900
19169	6483	100	33	20.180900
19170	6484	100	33	20.180900
19171	6485	100	33	20.180900
19172	6486	100	33	20.180900
19173	6487	100	33	20.180900
19174	6488	100	33	20.180900
19175	6489	100	33	20.180900
19176	6490	100	33	20.180900
19177	6491	100	33	20.180900
19178	6492	100	33	20.180900
19179	6493	100	33	20.180900
19180	6494	100	33	20.180900
19181	6495	100	33	20.180900
19182	6496	100	33	20.180900
19183	6497	100	33	20.180900
19184	6498	100	33	20.180900
19185	6499	100	33	20.180900
19186	6500	100	33	20.180900
19187	6501	100	33	20.180900
19188	6502	100	33	20.180900
19189	6503	100	33	20.180900
19190	6504	100	33	20.180900
19191	6505	100	33	20.180900
19192	6506	100	33	20.180900
19193	6507	100	33	20.180900
19194	6508	100	33	20.180900
19195	6509	100	33	20.180900
19196	6510	100	33	20.180900
19197	6511	100	33	20.180900
19198	6512	100	33	20.180900
19199	6513	100	33	20.180900
19200	6514	100	33	20.180900
19201	6515	100	33	20.180900
19202	6516	100	33	20.180900
19203	6517	100	33	20.180900
19204	6518	100	33	20.180900
19205	6519	100	33	20.180900
19206	6520	100	33	20.180900
19207	6521	100	33	20.180900
19208	6522	100	33	20.180900
19209	6523	100	33	20.180900
19210	6524	100	33	20.180900
19211	6525	100	33	20.180900
19212	6526	100	33	20.180900
19213	6527	100	33	20.180900
19214	6528	100	33	20.180900
19215	6529	100	33	20.180900
19216	6530	100	33	20.180900
19217	6531	100	33	20.180900
19218	6532	100	33	20.180900
19219	6533	100	33	20.180900
19220	6534	100	33	20.180900
19221	6535	100	33	20.180900
19222	6536	100	33	20.180900
19223	6537	100	33	20.180900
19224	6538	100	33	20.180900
19225	6539	100	33	20.180900
19226	6540	100	33	20.180900
19227	6541	100	33	20.180900
19228	6542	100	33	20.180900
19229	6543	100	33	20.180900
19230	6544	100	33	20.180900
19231	6545	100	33	20.180900
19232	6546	100	33	20.180900
19233	6547	100	33	20.180900
19234	6548	100	33	20.180900
19235	6549	100	33	20.180900
19236	6550	100	33	20.180900
19237	6551	100	33	20.180900
19238	6552	100	33	20.180900
19239	6553	100	33	20.180900
19240	6554	100	33	20.180900
19241	6555	100	33	20.180900
19242	6556	100	33	20.180900
19243	6557	100	33	20.180900
19244	6558	100	33	20.180900
19245	6559	100	33	20.180900
19246	6560	100	33	20.180900
19247	6561	100	33	20.180900
19248	6562	100	33	20.180900
19249	6563	100	33	20.180900
19250	6564	100	33	20.180900
19251	6565	100	33	20.180900
19252	6566	100	33	20.180900
19253	6567	100	33	20.180900
19254	6568	100	33	20.180900
19255	6569	100	33	20.180900
19256	6570	100	33	20.180900
19257	6571	100	33	20.180900
19258	6572	100	33	20.180900
19259	6573	100	33	20.180900
19260	6574	100	33	20.180900
19261	6575	100	33	20.180900
19262	6576	100	33	20.180900
19263	6577	100	33	20.180900
19264	6578	100	33	20.180900
19265	6579	100	33	20.180900
19266	6580	100	33	20.180900
19267	6581	100	33	20.180900
19268	6582	100	33	20.180900
19269	6583	100	33	20.180900
19270	6584	100	33	20.180900
19271	6585	100	33	20.180900
19272	6586	100	33	20.180900
19273	6587	100	33	20.180900
19274	6588	100	33	20.180900
19275	6589	100	33	20.180900
19276	6590	100	33	20.180900
19277	6591	100	33	20.180900
19278	6592	100	33	20.180900
19279	6593	100	33	20.180900
19280	6594	100	33	20.180900
19281	6595	100	33	20.180900
19282	6596	100	33	20.180900
19283	6597	100	33	20.180900
19284	6598	100	33	20.180900
19285	6599	100	33	20.180900
19286	6600	100	33	20.180900
19287	6469	200	31	19.326000
19288	6470	200	31	19.080000
19289	6471	200	31	22.110000
19290	6472	200	31	23.093000
19291	6473	200	31	24.731000
19292	6474	200	31	24.895000
19293	6475	200	31	23.584000
19294	6476	200	31	22.520000
19295	6477	200	31	22.929000
19296	6478	200	31	23.175000
19297	6479	200	31	22.684000
19298	6480	200	31	20.718000
19299	6481	200	31	19.408000
19300	6482	200	31	20.309000
19301	6483	200	31	21.865000
19302	6484	200	31	23.257000
19303	6485	200	31	25.140000
19304	6486	200	31	24.567000
19305	6487	200	31	23.011000
19306	6488	200	31	22.929000
19307	6489	200	31	22.438000
19308	6490	200	31	23.748000
19309	6491	200	31	22.684000
19310	6492	200	31	20.636000
19311	6493	200	31	19.899000
19312	6494	200	31	19.408000
19313	6495	200	31	22.602000
19314	6496	200	31	23.502000
19315	6497	200	31	25.140000
19316	6498	200	31	23.830000
19317	6499	200	31	22.274000
19318	6500	200	31	22.356000
19319	6501	200	31	22.028000
19320	6502	200	31	23.666000
19321	6503	200	31	22.520000
19322	6504	200	31	19.654000
19323	6505	200	31	18.261000
19324	6506	200	31	19.981000
19325	6507	200	31	21.783000
19326	6508	200	31	23.912000
19327	6509	200	31	25.468000
19328	6510	200	31	25.795000
19329	6511	200	31	23.257000
19330	6512	200	31	23.421000
19331	6513	200	31	23.175000
19332	6514	200	31	23.994000
19333	6515	200	31	21.947000
19334	6516	200	31	20.472000
19335	6517	200	31	19.490000
19336	6518	200	31	20.472000
19337	6519	200	31	23.257000
19338	6520	200	31	23.830000
19339	6521	200	31	25.058000
19340	6522	200	31	24.813000
19341	6523	200	31	22.929000
19342	6524	200	31	22.438000
19343	6525	200	31	22.847000
19344	6526	200	31	23.175000
19345	6527	200	31	21.947000
19346	6528	200	31	20.718000
19347	6529	200	31	18.507000
19348	6530	200	31	18.835000
19349	6531	200	31	22.192000
19350	6532	200	31	22.356000
19351	6533	200	31	24.158000
19352	6534	200	31	23.666000
19353	6535	200	31	22.847000
19354	6536	200	31	22.274000
19355	6537	200	31	22.684000
19356	6538	200	31	23.421000
19357	6539	200	31	23.994000
19358	6540	200	31	21.373000
19359	6541	200	31	19.654000
19360	6542	200	31	19.408000
19361	6543	200	31	21.701000
19362	6544	200	31	24.321000
19363	6545	200	31	26.041000
19364	6546	200	31	24.895000
19365	6547	200	31	22.847000
19366	6548	200	31	23.175000
19367	6549	200	31	22.929000
19368	6550	200	31	24.076000
19369	6551	200	31	22.356000
19370	6552	200	31	19.899000
19371	6553	200	31	18.343000
19372	6554	200	31	20.718000
19373	6555	200	31	22.356000
19374	6556	200	31	24.158000
19375	6557	200	31	24.239000
19376	6558	200	31	23.421000
19377	6559	200	31	22.520000
19378	6560	200	31	22.438000
19379	6561	200	31	22.438000
19380	6562	200	31	22.929000
19381	6563	200	31	22.028000
19382	6564	200	31	20.145000
19383	6565	200	31	19.654000
19384	6566	200	31	19.080000
19385	6567	200	31	21.128000
19386	6568	200	31	24.567000
19387	6569	200	31	24.158000
19388	6570	200	31	23.912000
19389	6571	200	31	22.274000
19390	6572	200	31	22.929000
19391	6573	200	31	23.093000
19392	6574	200	31	24.239000
19393	6575	200	31	22.602000
19394	6576	200	31	20.718000
19395	6577	200	31	19.490000
19396	6578	200	31	20.063000
19397	6579	200	31	21.619000
19398	6580	200	31	23.830000
19399	6581	200	31	24.649000
19400	6582	200	31	23.175000
19401	6583	200	31	21.865000
19402	6584	200	31	22.274000
19403	6585	200	31	23.339000
19404	6586	200	31	23.666000
19405	6587	200	31	22.438000
19406	6588	200	31	20.882000
19407	6589	200	31	18.343000
19408	6590	200	31	20.391000
19409	6591	200	31	22.274000
19410	6592	200	31	24.567000
19411	6593	200	31	25.386000
19412	6594	200	31	24.158000
19413	6595	200	31	23.093000
19414	6596	200	31	22.192000
19415	6597	200	31	22.847000
19416	6598	200	31	24.485000
19417	6599	200	31	22.602000
19418	6600	200	31	21.128000
19419	6469	100	32	73.016900
19420	6470	100	32	73.016900
19421	6471	100	32	73.016900
19422	6472	100	32	73.016900
19423	6473	100	32	73.016900
19424	6474	100	32	73.016900
19425	6475	100	32	73.016900
19426	6476	100	32	73.016900
19427	6477	100	32	73.016900
19428	6478	100	32	73.016900
19429	6479	100	32	73.016900
19430	6480	100	32	73.016900
19431	6481	100	32	73.016900
19432	6482	100	32	73.016900
19433	6483	100	32	73.016900
19434	6484	100	32	73.016900
19435	6485	100	32	73.016900
19436	6486	100	32	73.016900
19437	6487	100	32	73.016900
19438	6488	100	32	73.016900
19439	6489	100	32	73.016900
19440	6490	100	32	73.016900
19441	6491	100	32	73.016900
19442	6492	100	32	73.016900
19443	6493	100	32	73.016900
19444	6494	100	32	73.016900
19445	6495	100	32	73.016900
19446	6496	100	32	73.016900
19447	6497	100	32	73.016900
19448	6498	100	32	73.016900
19449	6499	100	32	73.016900
19450	6500	100	32	73.016900
19451	6501	100	32	73.016900
19452	6502	100	32	73.016900
19453	6503	100	32	73.016900
19454	6504	100	32	73.016900
19455	6505	100	32	73.016900
19456	6506	100	32	73.016900
19457	6507	100	32	73.016900
19458	6508	100	32	73.016900
19459	6509	100	32	73.016900
19460	6510	100	32	73.016900
19461	6511	100	32	73.016900
19462	6512	100	32	73.016900
19463	6513	100	32	73.016900
19464	6514	100	32	73.016900
19465	6515	100	32	73.016900
19466	6516	100	32	73.016900
19467	6517	100	32	73.016900
19468	6518	100	32	73.016900
19469	6519	100	32	73.016900
19470	6520	100	32	73.016900
19471	6521	100	32	73.016900
19472	6522	100	32	73.016900
19473	6523	100	32	73.016900
19474	6524	100	32	73.016900
19475	6525	100	32	73.016900
19476	6526	100	32	73.016900
19477	6527	100	32	73.016900
19478	6528	100	32	73.016900
19479	6529	100	32	73.016900
19480	6530	100	32	73.016900
19481	6531	100	32	73.016900
19482	6532	100	32	73.016900
19483	6533	100	32	73.016900
19484	6534	100	32	73.016900
19485	6535	100	32	73.016900
19486	6536	100	32	73.016900
19487	6537	100	32	73.016900
19488	6538	100	32	73.016900
19489	6539	100	32	73.016900
19490	6540	100	32	73.016900
19491	6541	100	32	73.016900
19492	6542	100	32	73.016900
19493	6543	100	32	73.016900
19494	6544	100	32	73.016900
19495	6545	100	32	73.016900
19496	6546	100	32	73.016900
19497	6547	100	32	73.016900
19498	6548	100	32	73.016900
19499	6549	100	32	73.016900
19500	6550	100	32	73.016900
19501	6551	100	32	73.016900
19502	6552	100	32	73.016900
19503	6553	100	32	73.016900
19504	6554	100	32	73.016900
19505	6555	100	32	73.016900
19506	6556	100	32	73.016900
19507	6557	100	32	73.016900
19508	6558	100	32	73.016900
19509	6559	100	32	73.016900
19510	6560	100	32	73.016900
19511	6561	100	32	73.016900
19512	6562	100	32	73.016900
19513	6563	100	32	73.016900
19514	6564	100	32	73.016900
19515	6565	100	32	73.016900
19516	6566	100	32	73.016900
19517	6567	100	32	73.016900
19518	6568	100	32	73.016900
19519	6569	100	32	73.016900
19520	6570	100	32	73.016900
19521	6571	100	32	73.016900
19522	6572	100	32	73.016900
19523	6573	100	32	73.016900
19524	6574	100	32	73.016900
19525	6575	100	32	73.016900
19526	6576	100	32	73.016900
19527	6577	100	32	73.016900
19528	6578	100	32	73.016900
19529	6579	100	32	73.016900
19530	6580	100	32	73.016900
19531	6581	100	32	73.016900
19532	6582	100	32	73.016900
19533	6583	100	32	73.016900
19534	6584	100	32	73.016900
19535	6585	100	32	73.016900
19536	6586	100	32	73.016900
19537	6587	100	32	73.016900
19538	6588	100	32	73.016900
19539	6589	100	32	73.016900
19540	6590	100	32	73.016900
19541	6591	100	32	73.016900
19542	6592	100	32	73.016900
19543	6593	100	32	73.016900
19544	6594	100	32	73.016900
19545	6595	100	32	73.016900
19546	6596	100	32	73.016900
19547	6597	100	32	73.016900
19548	6598	100	32	73.016900
19549	6599	100	32	73.016900
19550	6600	100	32	73.016900
19551	6601	100	36	27.036000
19552	6602	100	36	27.036000
19553	6603	100	36	27.036000
19554	6604	100	36	27.036000
19555	6605	100	36	27.036000
19556	6606	100	36	27.036000
19557	6607	100	36	27.036000
19558	6608	100	36	27.036000
19559	6609	100	36	27.036000
19560	6610	100	36	27.036000
19561	6611	100	36	27.036000
19562	6612	100	36	27.036000
19563	6613	100	36	27.036000
19564	6614	100	36	27.036000
19565	6615	100	36	27.036000
19566	6616	100	36	27.036000
19567	6617	100	36	27.036000
19568	6618	100	36	27.036000
19569	6619	100	36	27.036000
19570	6620	100	36	27.036000
19571	6621	100	36	27.036000
19572	6622	100	36	27.036000
19573	6623	100	36	27.036000
19574	6624	100	36	27.036000
19575	6625	100	36	27.036000
19576	6626	100	36	27.036000
19577	6627	100	36	27.036000
19578	6628	100	36	27.036000
19579	6629	100	36	27.036000
19580	6630	100	36	27.036000
19581	6631	100	36	27.036000
19582	6632	100	36	27.036000
19583	6633	100	36	27.036000
19584	6634	100	36	27.036000
19585	6635	100	36	27.036000
19586	6636	100	36	27.036000
19587	6637	100	36	27.036000
19588	6638	100	36	27.036000
19589	6639	100	36	27.036000
19590	6640	100	36	27.036000
19591	6641	100	36	27.036000
19592	6642	100	36	27.036000
19593	6643	100	36	27.036000
19594	6644	100	36	27.036000
19595	6645	100	36	27.036000
19596	6646	100	36	27.036000
19597	6647	100	36	27.036000
19598	6648	100	36	27.036000
19599	6649	100	36	27.036000
19600	6650	100	36	27.036000
19601	6651	100	36	27.036000
19602	6652	100	36	27.036000
19603	6653	100	36	27.036000
19604	6654	100	36	27.036000
19605	6655	100	36	27.036000
19606	6656	100	36	27.036000
19607	6657	100	36	27.036000
19608	6658	100	36	27.036000
19609	6659	100	36	27.036000
19610	6660	100	36	27.036000
19611	6661	100	36	27.036000
19612	6662	100	36	27.036000
19613	6663	100	36	27.036000
19614	6664	100	36	27.036000
19615	6665	100	36	27.036000
19616	6666	100	36	27.036000
19617	6667	100	36	27.036000
19618	6668	100	36	27.036000
19619	6669	100	36	27.036000
19620	6670	100	36	27.036000
19621	6671	100	36	27.036000
19622	6672	100	36	27.036000
19623	6673	100	36	27.036000
19624	6674	100	36	27.036000
19625	6675	100	36	27.036000
19626	6676	100	36	27.036000
19627	6677	100	36	27.036000
19628	6678	100	36	27.036000
19629	6679	100	36	27.036000
19630	6680	100	36	27.036000
19631	6681	100	36	27.036000
19632	6682	100	36	27.036000
19633	6683	100	36	27.036000
19634	6684	100	36	27.036000
19635	6685	100	36	27.036000
19636	6686	100	36	27.036000
19637	6687	100	36	27.036000
19638	6688	100	36	27.036000
19639	6689	100	36	27.036000
19640	6690	100	36	27.036000
19641	6691	100	36	27.036000
19642	6692	100	36	27.036000
19643	6693	100	36	27.036000
19644	6694	100	36	27.036000
19645	6695	100	36	27.036000
19646	6696	100	36	27.036000
19647	6697	100	36	27.036000
19648	6698	100	36	27.036000
19649	6699	100	36	27.036000
19650	6700	100	36	27.036000
19651	6701	100	36	27.036000
19652	6702	100	36	27.036000
19653	6703	100	36	27.036000
19654	6704	100	36	27.036000
19655	6705	100	36	27.036000
19656	6706	100	36	27.036000
19657	6707	100	36	27.036000
19658	6708	100	36	27.036000
19659	6709	100	36	27.036000
19660	6710	100	36	27.036000
19661	6711	100	36	27.036000
19662	6712	100	36	27.036000
19663	6713	100	36	27.036000
19664	6714	100	36	27.036000
19665	6715	100	36	27.036000
19666	6716	100	36	27.036000
19667	6717	100	36	27.036000
19668	6718	100	36	27.036000
19669	6719	100	36	27.036000
19670	6720	100	36	27.036000
19671	6721	100	36	27.036000
19672	6722	100	36	27.036000
19673	6723	100	36	27.036000
19674	6724	100	36	27.036000
19675	6725	100	36	27.036000
19676	6726	100	36	27.036000
19677	6727	100	36	27.036000
19678	6728	100	36	27.036000
19679	6729	100	36	27.036000
19680	6730	100	36	27.036000
19681	6731	100	36	27.036000
19682	6732	100	36	27.036000
19683	6601	200	34	15.416000
19684	6602	200	34	15.553000
19685	6603	200	34	23.920000
19686	6604	200	34	25.487000
19687	6605	200	34	24.909000
19688	6606	200	34	26.718000
19689	6607	200	34	26.061000
19690	6608	200	34	27.031000
19691	6609	200	34	26.642000
19692	6610	200	34	25.349000
19693	6611	200	34	20.871000
19694	6612	200	34	16.508000
19695	6613	200	34	16.027000
19696	6614	200	34	18.761000
19697	6615	200	34	20.344000
19698	6616	200	34	24.184000
19699	6617	200	34	25.502000
19700	6618	200	34	27.072000
19701	6619	200	34	27.373000
19702	6620	200	34	27.171000
19703	6621	200	34	26.295000
19704	6622	200	34	26.008000
19705	6623	200	34	21.862000
19706	6624	200	34	18.676000
19707	6625	200	34	15.842000
19708	6626	200	34	15.923000
19709	6627	200	34	22.653000
19710	6628	200	34	24.397000
19711	6629	200	34	26.568000
19712	6630	200	34	27.542000
19713	6631	200	34	27.623000
19714	6632	200	34	27.202000
19715	6633	200	34	27.071000
19716	6634	200	34	25.019000
19717	6635	200	34	20.283000
19718	6636	200	34	16.768000
19719	6637	200	34	12.826000
19720	6638	200	34	17.143000
19721	6639	200	34	22.234000
19722	6640	200	34	24.739000
19723	6641	200	34	28.145000
19724	6642	200	34	27.842000
19725	6643	200	34	27.117000
19726	6644	200	34	27.107000
19727	6645	200	34	26.780000
19728	6646	200	34	25.810000
19729	6647	200	34	19.988000
19730	6648	200	34	18.363000
19731	6649	200	34	15.232000
19732	6650	200	34	16.701000
19733	6651	200	34	22.047000
19734	6652	200	34	24.727000
19735	6653	200	34	26.826000
19736	6654	200	34	26.165000
19737	6655	200	34	27.078000
19738	6656	200	34	26.792000
19739	6657	200	34	26.682000
19740	6658	200	34	25.497000
19741	6659	200	34	21.808000
19742	6660	200	34	18.234000
19743	6661	200	34	14.153000
19744	6662	200	34	16.317000
19745	6663	200	34	22.445000
19746	6664	200	34	25.422000
19747	6665	200	34	26.156000
19748	6666	200	34	27.135000
19749	6667	200	34	27.061000
19750	6668	200	34	27.662000
19751	6669	200	34	25.803000
19752	6670	200	34	23.913000
19753	6671	200	34	20.880000
19754	6672	200	34	17.336000
19755	6673	200	34	15.242000
19756	6674	200	34	18.179000
19757	6675	200	34	21.143000
19758	6676	200	34	25.584000
19759	6677	200	34	27.533000
19760	6678	200	34	28.095000
19761	6679	200	34	26.982000
19762	6680	200	34	27.401000
19763	6681	200	34	27.101000
19764	6682	200	34	26.981000
19765	6683	200	34	22.010000
19766	6684	200	34	17.910000
19767	6685	200	34	16.342000
19768	6686	200	34	18.694000
19769	6687	200	34	23.153000
19770	6688	200	34	28.907000
19771	6689	200	34	27.223000
19772	6690	200	34	27.692000
19773	6691	200	34	26.673000
19774	6692	200	34	27.051000
19775	6693	200	34	26.583000
19776	6694	200	34	25.841000
19777	6695	200	34	22.158000
19778	6696	200	34	17.891000
19779	6697	200	34	16.207000
19780	6698	200	34	16.875000
19781	6699	200	34	21.463000
19782	6700	200	34	24.800000
19783	6701	200	34	26.248000
19784	6702	200	34	27.762000
19785	6703	200	34	27.479000
19786	6704	200	34	26.773000
19787	6705	200	34	26.091000
19788	6706	200	34	25.878000
19789	6707	200	34	21.970000
19790	6708	200	34	17.744000
19791	6709	200	34	16.040000
19792	6710	200	34	18.209000
19793	6711	200	34	21.271000
19794	6712	200	34	25.607000
19795	6713	200	34	27.355000
19796	6714	200	34	27.472000
19797	6715	200	34	27.649000
19798	6716	200	34	27.711000
19799	6717	200	34	27.329000
19800	6718	200	34	25.922000
19801	6719	200	34	22.528000
19802	6720	200	34	18.547000
19803	6721	200	34	15.271000
19804	6722	200	34	18.423000
19805	6723	200	34	22.785000
19806	6724	200	34	25.094000
19807	6725	200	34	26.241000
19808	6726	200	34	27.624000
19809	6727	200	34	27.673000
19810	6728	200	34	27.061000
19811	6729	200	34	26.502000
19812	6730	200	34	25.052000
19813	6731	200	34	21.598000
19814	6732	200	34	18.126000
19815	6601	100	35	88.262700
19816	6602	100	35	88.262700
19817	6603	100	35	88.262700
19818	6604	100	35	88.262700
19819	6605	100	35	88.262700
19820	6606	100	35	88.262700
19821	6607	100	35	88.262700
19822	6608	100	35	88.262700
19823	6609	100	35	88.262700
19824	6610	100	35	88.262700
19825	6611	100	35	88.262700
19826	6612	100	35	88.262700
19827	6613	100	35	88.262700
19828	6614	100	35	88.262700
19829	6615	100	35	88.262700
19830	6616	100	35	88.262700
19831	6617	100	35	88.262700
19832	6618	100	35	88.262700
19833	6619	100	35	88.262700
19834	6620	100	35	88.262700
19835	6621	100	35	88.262700
19836	6622	100	35	88.262700
19837	6623	100	35	88.262700
19838	6624	100	35	88.262700
19839	6625	100	35	88.262700
19840	6626	100	35	88.262700
19841	6627	100	35	88.262700
19842	6628	100	35	88.262700
19843	6629	100	35	88.262700
19844	6630	100	35	88.262700
19845	6631	100	35	88.262700
19846	6632	100	35	88.262700
19847	6633	100	35	88.262700
19848	6634	100	35	88.262700
19849	6635	100	35	88.262700
19850	6636	100	35	88.262700
19851	6637	100	35	88.262700
19852	6638	100	35	88.262700
19853	6639	100	35	88.262700
19854	6640	100	35	88.262700
19855	6641	100	35	88.262700
19856	6642	100	35	88.262700
19857	6643	100	35	88.262700
19858	6644	100	35	88.262700
19859	6645	100	35	88.262700
19860	6646	100	35	88.262700
19861	6647	100	35	88.262700
19862	6648	100	35	88.262700
19863	6649	100	35	88.262700
19864	6650	100	35	88.262700
19865	6651	100	35	88.262700
19866	6652	100	35	88.262700
19867	6653	100	35	88.262700
19868	6654	100	35	88.262700
19869	6655	100	35	88.262700
19870	6656	100	35	88.262700
19871	6657	100	35	88.262700
19872	6658	100	35	88.262700
19873	6659	100	35	88.262700
19874	6660	100	35	88.262700
19875	6661	100	35	88.262700
19876	6662	100	35	88.262700
19877	6663	100	35	88.262700
19878	6664	100	35	88.262700
19879	6665	100	35	88.262700
19880	6666	100	35	88.262700
19881	6667	100	35	88.262700
19882	6668	100	35	88.262700
19883	6669	100	35	88.262700
19884	6670	100	35	88.262700
19885	6671	100	35	88.262700
19886	6672	100	35	88.262700
19887	6673	100	35	88.262700
19888	6674	100	35	88.262700
19889	6675	100	35	88.262700
19890	6676	100	35	88.262700
19891	6677	100	35	88.262700
19892	6678	100	35	88.262700
19893	6679	100	35	88.262700
19894	6680	100	35	88.262700
19895	6681	100	35	88.262700
19896	6682	100	35	88.262700
19897	6683	100	35	88.262700
19898	6684	100	35	88.262700
19899	6685	100	35	88.262700
19900	6686	100	35	88.262700
19901	6687	100	35	88.262700
19902	6688	100	35	88.262700
19903	6689	100	35	88.262700
19904	6690	100	35	88.262700
19905	6691	100	35	88.262700
19906	6692	100	35	88.262700
19907	6693	100	35	88.262700
19908	6694	100	35	88.262700
19909	6695	100	35	88.262700
19910	6696	100	35	88.262700
19911	6697	100	35	88.262700
19912	6698	100	35	88.262700
19913	6699	100	35	88.262700
19914	6700	100	35	88.262700
19915	6701	100	35	88.262700
19916	6702	100	35	88.262700
19917	6703	100	35	88.262700
19918	6704	100	35	88.262700
19919	6705	100	35	88.262700
19920	6706	100	35	88.262700
19921	6707	100	35	88.262700
19922	6708	100	35	88.262700
19923	6709	100	35	88.262700
19924	6710	100	35	88.262700
19925	6711	100	35	88.262700
19926	6712	100	35	88.262700
19927	6713	100	35	88.262700
19928	6714	100	35	88.262700
19929	6715	100	35	88.262700
19930	6716	100	35	88.262700
19931	6717	100	35	88.262700
19932	6718	100	35	88.262700
19933	6719	100	35	88.262700
19934	6720	100	35	88.262700
19935	6721	100	35	88.262700
19936	6722	100	35	88.262700
19937	6723	100	35	88.262700
19938	6724	100	35	88.262700
19939	6725	100	35	88.262700
19940	6726	100	35	88.262700
19941	6727	100	35	88.262700
19942	6728	100	35	88.262700
19943	6729	100	35	88.262700
19944	6730	100	35	88.262700
19945	6731	100	35	88.262700
19946	6732	100	35	88.262700
19947	6733	100	42	24.780700
19948	6734	100	42	24.780700
19949	6735	100	42	24.780700
19950	6736	100	42	24.780700
19951	6737	100	42	24.780700
19952	6738	100	42	24.780700
19953	6739	100	42	24.780700
19954	6740	100	42	24.780700
19955	6741	100	42	24.780700
19956	6742	100	42	24.780700
19957	6743	100	42	24.780700
19958	6744	100	42	24.780700
19959	6745	100	42	24.780700
19960	6746	100	42	24.780700
19961	6747	100	42	24.780700
19962	6748	100	42	24.780700
19963	6749	100	42	24.780700
19964	6750	100	42	24.780700
19965	6751	100	42	24.780700
19966	6752	100	42	24.780700
19967	6753	100	42	24.780700
19968	6754	100	42	24.780700
19969	6755	100	42	24.780700
19970	6756	100	42	24.780700
19971	6757	100	42	24.780700
19972	6758	100	42	24.780700
19973	6759	100	42	24.780700
19974	6760	100	42	24.780700
19975	6761	100	42	24.780700
19976	6762	100	42	24.780700
19977	6763	100	42	24.780700
19978	6764	100	42	24.780700
19979	6765	100	42	24.780700
19980	6766	100	42	24.780700
19981	6767	100	42	24.780700
19982	6768	100	42	24.780700
19983	6769	100	42	24.780700
19984	6770	100	42	24.780700
19985	6771	100	42	24.780700
19986	6772	100	42	24.780700
19987	6773	100	42	24.780700
19988	6774	100	42	24.780700
19989	6775	100	42	24.780700
19990	6776	100	42	24.780700
19991	6777	100	42	24.780700
19992	6778	100	42	24.780700
19993	6779	100	42	24.780700
19994	6780	100	42	24.780700
19995	6781	100	42	24.780700
19996	6782	100	42	24.780700
19997	6783	100	42	24.780700
19998	6784	100	42	24.780700
19999	6785	100	42	24.780700
20000	6786	100	42	24.780700
20001	6787	100	42	24.780700
20002	6788	100	42	24.780700
20003	6789	100	42	24.780700
20004	6790	100	42	24.780700
20005	6791	100	42	24.780700
20006	6792	100	42	24.780700
20007	6793	100	42	24.780700
20008	6794	100	42	24.780700
20009	6795	100	42	24.780700
20010	6796	100	42	24.780700
20011	6797	100	42	24.780700
20012	6798	100	42	24.780700
20013	6799	100	42	24.780700
20014	6800	100	42	24.780700
20015	6801	100	42	24.780700
20016	6802	100	42	24.780700
20017	6803	100	42	24.780700
20018	6804	100	42	24.780700
20019	6805	100	42	24.780700
20020	6806	100	42	24.780700
20021	6807	100	42	24.780700
20022	6808	100	42	24.780700
20023	6809	100	42	24.780700
20024	6810	100	42	24.780700
20025	6811	100	42	24.780700
20026	6812	100	42	24.780700
20027	6813	100	42	24.780700
20028	6814	100	42	24.780700
20029	6815	100	42	24.780700
20030	6816	100	42	24.780700
20031	6817	100	42	24.780700
20032	6818	100	42	24.780700
20033	6819	100	42	24.780700
20034	6820	100	42	24.780700
20035	6821	100	42	24.780700
20036	6822	100	42	24.780700
20037	6823	100	42	24.780700
20038	6824	100	42	24.780700
20039	6825	100	42	24.780700
20040	6826	100	42	24.780700
20041	6827	100	42	24.780700
20042	6828	100	42	24.780700
20043	6829	100	42	24.780700
20044	6830	100	42	24.780700
20045	6831	100	42	24.780700
20046	6832	100	42	24.780700
20047	6833	100	42	24.780700
20048	6834	100	42	24.780700
20049	6835	100	42	24.780700
20050	6836	100	42	24.780700
20051	6837	100	42	24.780700
20052	6838	100	42	24.780700
20053	6839	100	42	24.780700
20054	6840	100	42	24.780700
20055	6841	100	42	24.780700
20056	6842	100	42	24.780700
20057	6843	100	42	24.780700
20058	6844	100	42	24.780700
20059	6845	100	42	24.780700
20060	6846	100	42	24.780700
20061	6847	100	42	24.780700
20062	6848	100	42	24.780700
20063	6849	100	42	24.780700
20064	6850	100	42	24.780700
20065	6851	100	42	24.780700
20066	6852	100	42	24.780700
20067	6853	100	42	24.780700
20068	6854	100	42	24.780700
20069	6855	100	42	24.780700
20070	6856	100	42	24.780700
20071	6857	100	42	24.780700
20072	6858	100	42	24.780700
20073	6859	100	42	24.780700
20074	6860	100	42	24.780700
20075	6861	100	42	24.780700
20076	6862	100	42	24.780700
20077	6863	100	42	24.780700
20078	6864	100	42	24.780700
20079	6733	200	40	14.065000
20080	6734	200	40	13.382000
20081	6735	200	40	20.760000
20082	6736	200	40	22.632000
20083	6737	200	40	22.043000
20084	6738	200	40	23.748000
20085	6739	200	40	22.516000
20086	6740	200	40	23.567000
20087	6741	200	40	23.728000
20088	6742	200	40	21.528000
20089	6743	200	40	18.642000
20090	6744	200	40	13.769000
20091	6745	200	40	13.573000
20092	6746	200	40	15.492000
20093	6747	200	40	18.308000
20094	6748	200	40	20.712000
20095	6749	200	40	21.123000
20096	6750	200	40	22.093000
20097	6751	200	40	23.362000
20098	6752	200	40	22.866000
20099	6753	200	40	23.029000
20100	6754	200	40	22.852000
20101	6755	200	40	19.347000
20102	6756	200	40	16.698000
20103	6757	200	40	15.099000
20104	6758	200	40	15.283000
20105	6759	200	40	19.798000
20106	6760	200	40	20.982000
20107	6761	200	40	23.045000
20108	6762	200	40	23.068000
20109	6763	200	40	23.666000
20110	6764	200	40	23.772000
20111	6765	200	40	24.399000
20112	6766	200	40	21.057000
20113	6767	200	40	19.332000
20114	6768	200	40	15.426000
20115	6769	200	40	14.363000
20116	6770	200	40	16.048000
20117	6771	200	40	20.578000
20118	6772	200	40	22.638000
20119	6773	200	40	23.938000
20120	6774	200	40	23.192000
20121	6775	200	40	23.167000
20122	6776	200	40	23.567000
20123	6777	200	40	23.299000
20124	6778	200	40	22.952000
20125	6779	200	40	20.338000
20126	6780	200	40	15.303000
20127	6781	200	40	14.199000
20128	6782	200	40	16.258000
20129	6783	200	40	19.247000
20130	6784	200	40	23.012000
20131	6785	200	40	22.349000
20132	6786	200	40	22.968000
20133	6787	200	40	23.233000
20134	6788	200	40	22.976000
20135	6789	200	40	23.933000
20136	6790	200	40	22.159000
20137	6791	200	40	19.572000
20138	6792	200	40	17.159000
20139	6793	200	40	13.969000
20140	6794	200	40	14.672000
20141	6795	200	40	19.100000
20142	6796	200	40	20.452000
20143	6797	200	40	22.847000
20144	6798	200	40	23.462000
20145	6799	200	40	23.242000
20146	6800	200	40	23.875000
20147	6801	200	40	23.028000
20148	6802	200	40	21.662000
20149	6803	200	40	19.342000
20150	6804	200	40	16.360000
20151	6805	200	40	14.199000
20152	6806	200	40	16.049000
20153	6807	200	40	18.308000
20154	6808	200	40	21.951000
20155	6809	200	40	23.833000
20156	6810	200	40	23.547000
20157	6811	200	40	23.908000
20158	6812	200	40	23.266000
20159	6813	200	40	24.305000
20160	6814	200	40	23.463000
20161	6815	200	40	20.352000
20162	6816	200	40	16.593000
20163	6817	200	40	15.293000
20164	6818	200	40	19.422000
20165	6819	200	40	20.988000
20166	6820	200	40	23.086000
20167	6821	200	40	23.027000
20168	6822	200	40	23.833000
20169	6823	200	40	23.941000
20170	6824	200	40	22.966000
20171	6825	200	40	23.733000
20172	6826	200	40	22.612000
20173	6827	200	40	19.648000
20174	6828	200	40	16.094000
20175	6829	200	40	13.595000
20176	6830	200	40	16.027000
20177	6831	200	40	18.509000
20178	6832	200	40	21.396000
20179	6833	200	40	22.559000
20180	6834	200	40	23.167000
20181	6835	200	40	24.338000
20182	6836	200	40	23.027000
20183	6837	200	40	22.832000
20184	6838	200	40	22.192000
20185	6839	200	40	18.547000
20186	6840	200	40	15.764000
20187	6841	200	40	14.797000
20188	6842	200	40	16.848000
20189	6843	200	40	19.918000
20190	6844	200	40	22.138000
20191	6845	200	40	22.921000
20192	6846	200	40	23.562000
20193	6847	200	40	24.238000
20194	6848	200	40	23.871000
20195	6849	200	40	24.727000
20196	6850	200	40	22.593000
20197	6851	200	40	18.987000
20198	6852	200	40	15.994000
20199	6853	200	40	15.069000
20200	6854	200	40	17.158000
20201	6855	200	40	20.288000
20202	6856	200	40	21.742000
20203	6857	200	40	22.619000
20204	6858	200	40	23.058000
20205	6859	200	40	24.003000
20206	6860	200	40	23.372000
20207	6861	200	40	23.368000
20208	6862	200	40	22.163000
20209	6863	200	40	19.283000
20210	6864	200	40	16.159000
20211	6733	100	41	93.967400
20212	6734	100	41	93.967400
20213	6735	100	41	93.967400
20214	6736	100	41	93.967400
20215	6737	100	41	93.967400
20216	6738	100	41	93.967400
20217	6739	100	41	93.967400
20218	6740	100	41	93.967400
20219	6741	100	41	93.967400
20220	6742	100	41	93.967400
20221	6743	100	41	93.967400
20222	6744	100	41	93.967400
20223	6745	100	41	93.967400
20224	6746	100	41	93.967400
20225	6747	100	41	93.967400
20226	6748	100	41	93.967400
20227	6749	100	41	93.967400
20228	6750	100	41	93.967400
20229	6751	100	41	93.967400
20230	6752	100	41	93.967400
20231	6753	100	41	93.967400
20232	6754	100	41	93.967400
20233	6755	100	41	93.967400
20234	6756	100	41	93.967400
20235	6757	100	41	93.967400
20236	6758	100	41	93.967400
20237	6759	100	41	93.967400
20238	6760	100	41	93.967400
20239	6761	100	41	93.967400
20240	6762	100	41	93.967400
20241	6763	100	41	93.967400
20242	6764	100	41	93.967400
20243	6765	100	41	93.967400
20244	6766	100	41	93.967400
20245	6767	100	41	93.967400
20246	6768	100	41	93.967400
20247	6769	100	41	93.967400
20248	6770	100	41	93.967400
20249	6771	100	41	93.967400
20250	6772	100	41	93.967400
20251	6773	100	41	93.967400
20252	6774	100	41	93.967400
20253	6775	100	41	93.967400
20254	6776	100	41	93.967400
20255	6777	100	41	93.967400
20256	6778	100	41	93.967400
20257	6779	100	41	93.967400
20258	6780	100	41	93.967400
20259	6781	100	41	93.967400
20260	6782	100	41	93.967400
20261	6783	100	41	93.967400
20262	6784	100	41	93.967400
20263	6785	100	41	93.967400
20264	6786	100	41	93.967400
20265	6787	100	41	93.967400
20266	6788	100	41	93.967400
20267	6789	100	41	93.967400
20268	6790	100	41	93.967400
20269	6791	100	41	93.967400
20270	6792	100	41	93.967400
20271	6793	100	41	93.967400
20272	6794	100	41	93.967400
20273	6795	100	41	93.967400
20274	6796	100	41	93.967400
20275	6797	100	41	93.967400
20276	6798	100	41	93.967400
20277	6799	100	41	93.967400
20278	6800	100	41	93.967400
20279	6801	100	41	93.967400
20280	6802	100	41	93.967400
20281	6803	100	41	93.967400
20282	6804	100	41	93.967400
20283	6805	100	41	93.967400
20284	6806	100	41	93.967400
20285	6807	100	41	93.967400
20286	6808	100	41	93.967400
20287	6809	100	41	93.967400
20288	6810	100	41	93.967400
20289	6811	100	41	93.967400
20290	6812	100	41	93.967400
20291	6813	100	41	93.967400
20292	6814	100	41	93.967400
20293	6815	100	41	93.967400
20294	6816	100	41	93.967400
20295	6817	100	41	93.967400
20296	6818	100	41	93.967400
20297	6819	100	41	93.967400
20298	6820	100	41	93.967400
20299	6821	100	41	93.967400
20300	6822	100	41	93.967400
20301	6823	100	41	93.967400
20302	6824	100	41	93.967400
20303	6825	100	41	93.967400
20304	6826	100	41	93.967400
20305	6827	100	41	93.967400
20306	6828	100	41	93.967400
20307	6829	100	41	93.967400
20308	6830	100	41	93.967400
20309	6831	100	41	93.967400
20310	6832	100	41	93.967400
20311	6833	100	41	93.967400
20312	6834	100	41	93.967400
20313	6835	100	41	93.967400
20314	6836	100	41	93.967400
20315	6837	100	41	93.967400
20316	6838	100	41	93.967400
20317	6839	100	41	93.967400
20318	6840	100	41	93.967400
20319	6841	100	41	93.967400
20320	6842	100	41	93.967400
20321	6843	100	41	93.967400
20322	6844	100	41	93.967400
20323	6845	100	41	93.967400
20324	6846	100	41	93.967400
20325	6847	100	41	93.967400
20326	6848	100	41	93.967400
20327	6849	100	41	93.967400
20328	6850	100	41	93.967400
20329	6851	100	41	93.967400
20330	6852	100	41	93.967400
20331	6853	100	41	93.967400
20332	6854	100	41	93.967400
20333	6855	100	41	93.967400
20334	6856	100	41	93.967400
20335	6857	100	41	93.967400
20336	6858	100	41	93.967400
20337	6859	100	41	93.967400
20338	6860	100	41	93.967400
20339	6861	100	41	93.967400
20340	6862	100	41	93.967400
20341	6863	100	41	93.967400
20342	6864	100	41	93.967400
20343	6865	100	63	28.613900
20344	6866	100	63	28.613900
20345	6867	100	63	28.613900
20346	6868	100	63	28.613900
20347	6869	100	63	28.613900
20348	6870	100	63	28.613900
20349	6871	100	63	28.613900
20350	6872	100	63	28.613900
20351	6873	100	63	28.613900
20352	6874	100	63	28.613900
20353	6875	100	63	28.613900
20354	6876	100	63	28.613900
20355	6877	100	63	28.613900
20356	6878	100	63	28.613900
20357	6879	100	63	28.613900
20358	6880	100	63	28.613900
20359	6881	100	63	28.613900
20360	6882	100	63	28.613900
20361	6883	100	63	28.613900
20362	6884	100	63	28.613900
20363	6885	100	63	28.613900
20364	6886	100	63	28.613900
20365	6887	100	63	28.613900
20366	6888	100	63	28.613900
20367	6889	100	63	28.613900
20368	6890	100	63	28.613900
20369	6891	100	63	28.613900
20370	6892	100	63	28.613900
20371	6893	100	63	28.613900
20372	6894	100	63	28.613900
20373	6895	100	63	28.613900
20374	6896	100	63	28.613900
20375	6897	100	63	28.613900
20376	6898	100	63	28.613900
20377	6899	100	63	28.613900
20378	6900	100	63	28.613900
20379	6901	100	63	28.613900
20380	6902	100	63	28.613900
20381	6903	100	63	28.613900
20382	6904	100	63	28.613900
20383	6905	100	63	28.613900
20384	6906	100	63	28.613900
20385	6907	100	63	28.613900
20386	6908	100	63	28.613900
20387	6909	100	63	28.613900
20388	6910	100	63	28.613900
20389	6911	100	63	28.613900
20390	6912	100	63	28.613900
20391	6913	100	63	28.613900
20392	6914	100	63	28.613900
20393	6915	100	63	28.613900
20394	6916	100	63	28.613900
20395	6917	100	63	28.613900
20396	6918	100	63	28.613900
20397	6919	100	63	28.613900
20398	6920	100	63	28.613900
20399	6921	100	63	28.613900
20400	6922	100	63	28.613900
20401	6923	100	63	28.613900
20402	6924	100	63	28.613900
20403	6925	100	63	28.613900
20404	6926	100	63	28.613900
20405	6927	100	63	28.613900
20406	6928	100	63	28.613900
20407	6929	100	63	28.613900
20408	6930	100	63	28.613900
20409	6931	100	63	28.613900
20410	6932	100	63	28.613900
20411	6933	100	63	28.613900
20412	6934	100	63	28.613900
20413	6935	100	63	28.613900
20414	6936	100	63	28.613900
20415	6937	100	63	28.613900
20416	6938	100	63	28.613900
20417	6939	100	63	28.613900
20418	6940	100	63	28.613900
20419	6941	100	63	28.613900
20420	6942	100	63	28.613900
20421	6943	100	63	28.613900
20422	6944	100	63	28.613900
20423	6945	100	63	28.613900
20424	6946	100	63	28.613900
20425	6947	100	63	28.613900
20426	6948	100	63	28.613900
20427	6949	100	63	28.613900
20428	6950	100	63	28.613900
20429	6951	100	63	28.613900
20430	6952	100	63	28.613900
20431	6953	100	63	28.613900
20432	6954	100	63	28.613900
20433	6955	100	63	28.613900
20434	6956	100	63	28.613900
20435	6957	100	63	28.613900
20436	6958	100	63	28.613900
20437	6959	100	63	28.613900
20438	6960	100	63	28.613900
20439	6961	100	63	28.613900
20440	6962	100	63	28.613900
20441	6963	100	63	28.613900
20442	6964	100	63	28.613900
20443	6965	100	63	28.613900
20444	6966	100	63	28.613900
20445	6967	100	63	28.613900
20446	6968	100	63	28.613900
20447	6969	100	63	28.613900
20448	6970	100	63	28.613900
20449	6971	100	63	28.613900
20450	6972	100	63	28.613900
20451	6973	100	63	28.613900
20452	6974	100	63	28.613900
20453	6975	100	63	28.613900
20454	6976	100	63	28.613900
20455	6977	100	63	28.613900
20456	6978	100	63	28.613900
20457	6979	100	63	28.613900
20458	6980	100	63	28.613900
20459	6981	100	63	28.613900
20460	6982	100	63	28.613900
20461	6983	100	63	28.613900
20462	6984	100	63	28.613900
20463	6985	100	63	28.613900
20464	6986	100	63	28.613900
20465	6987	100	63	28.613900
20466	6988	100	63	28.613900
20467	6989	100	63	28.613900
20468	6990	100	63	28.613900
20469	6991	100	63	28.613900
20470	6992	100	63	28.613900
20471	6993	100	63	28.613900
20472	6994	100	63	28.613900
20473	6995	100	63	28.613900
20474	6996	100	63	28.613900
20475	6865	200	61	15.127000
20476	6866	200	61	15.928000
20477	6867	200	61	22.509000
20478	6868	200	61	28.047000
20479	6869	200	61	31.845000
20480	6870	200	61	34.610000
20481	6871	200	61	30.163000
20482	6872	200	61	28.909000
20483	6873	200	61	28.236000
20484	6874	200	61	25.782000
20485	6875	200	61	19.909000
20486	6876	200	61	16.981000
20487	6877	200	61	14.509000
20488	6878	200	61	18.855000
20489	6879	200	61	20.964000
20490	6880	200	61	28.473000
20491	6881	200	61	33.637000
20492	6882	200	61	33.691000
20493	6883	200	61	30.209000
20494	6884	200	61	30.227000
20495	6885	200	61	27.472000
20496	6886	200	61	25.636000
20497	6887	200	61	21.201000
20498	6888	200	61	15.672000
20499	6889	200	61	15.364000
20500	6890	200	61	16.819000
20501	6891	200	61	23.955000
20502	6892	200	61	27.073000
20503	6893	200	61	33.146000
20504	6894	200	61	33.900000
20505	6895	200	61	29.536000
20506	6896	200	61	28.718000
20507	6897	200	61	28.528000
20508	6898	200	61	25.410000
20509	6899	200	61	20.409000
20510	6900	200	61	16.436000
20511	6901	200	61	13.736000
20512	6902	200	61	17.246000
20513	6903	200	61	21.446000
20514	6904	200	61	28.047000
20515	6905	200	61	33.736000
20516	6906	200	61	35.118000
20517	6907	200	61	31.446000
20518	6908	200	61	27.673000
20519	6909	200	61	28.854000
20520	6910	200	61	26.692000
20521	6911	200	61	20.600000
20522	6912	200	61	15.963000
20523	6913	200	61	14.572000
20524	6914	200	61	17.363000
20525	6915	200	61	23.645000
20526	6916	200	61	29.027000
20527	6917	200	61	32.318000
20528	6918	200	61	31.673000
20529	6919	200	61	30.773000
20530	6920	200	61	28.282000
20531	6921	200	61	28.464000
20532	6922	200	61	25.636000
20533	6923	200	61	19.618000
20534	6924	200	61	14.864000
20535	6925	200	61	13.264000
20536	6926	200	61	16.500000
20537	6927	200	61	22.037000
20538	6928	200	61	26.828000
20539	6929	200	61	30.383000
20540	6930	200	61	31.191000
20541	6931	200	61	30.964000
20542	6932	200	61	28.772000
20543	6933	200	61	28.945000
20544	6934	200	61	23.973000
20545	6935	200	61	19.492000
20546	6936	200	61	13.273000
20547	6937	200	61	13.690000
20548	6938	200	61	17.091000
20549	6939	200	61	20.736000
20550	6940	200	61	29.136000
20551	6941	200	61	33.609000
20552	6942	200	61	32.991000
20553	6943	200	61	30.646000
20554	6944	200	61	29.109000
20555	6945	200	61	29.155000
20556	6946	200	61	26.173000
20557	6947	200	61	20.810000
20558	6948	200	61	15.328000
20559	6949	200	61	13.573000
20560	6950	200	61	17.464000
20561	6951	200	61	23.709000
20562	6952	200	61	30.418000
20563	6953	200	61	33.201000
20564	6954	200	61	32.782000
20565	6955	200	61	31.418000
20566	6956	200	61	30.200000
20567	6957	200	61	29.154000
20568	6958	200	61	26.309000
20569	6959	200	61	21.273000
20570	6960	200	61	15.763000
20571	6961	200	61	14.282000
20572	6962	200	61	15.527000
20573	6963	200	61	22.254000
20574	6964	200	61	30.546000
20575	6965	200	61	34.028000
20576	6966	200	61	31.818000
20577	6967	200	61	29.664000
20578	6968	200	61	29.627000
20579	6969	200	61	29.228000
20580	6970	200	61	26.591000
20581	6971	200	61	21.591000
20582	6972	200	61	16.082000
20583	6973	200	61	13.482000
20584	6974	200	61	17.664000
20585	6975	200	61	22.927000
20586	6976	200	61	28.736000
20587	6977	200	61	32.309000
20588	6978	200	61	30.909000
20589	6979	200	61	30.618000
20590	6980	200	61	30.182000
20591	6981	200	61	29.818000
20592	6982	200	61	27.200000
20593	6983	200	61	21.228000
20594	6984	200	61	16.454000
20595	6985	200	61	14.554000
20596	6986	200	61	16.882000
20597	6987	200	61	23.364000
20598	6988	200	61	30.428000
20599	6989	200	61	33.627000
20600	6990	200	61	33.155000
20601	6991	200	61	32.237000
20602	6992	200	61	30.136000
20603	6993	200	61	27.509000
20604	6994	200	61	26.508000
20605	6995	200	61	21.027000
20606	6996	200	61	16.463000
20607	6865	100	62	77.209000
20608	6866	100	62	77.209000
20609	6867	100	62	77.209000
20610	6868	100	62	77.209000
20611	6869	100	62	77.209000
20612	6870	100	62	77.209000
20613	6871	100	62	77.209000
20614	6872	100	62	77.209000
20615	6873	100	62	77.209000
20616	6874	100	62	77.209000
20617	6875	100	62	77.209000
20618	6876	100	62	77.209000
20619	6877	100	62	77.209000
20620	6878	100	62	77.209000
20621	6879	100	62	77.209000
20622	6880	100	62	77.209000
20623	6881	100	62	77.209000
20624	6882	100	62	77.209000
20625	6883	100	62	77.209000
20626	6884	100	62	77.209000
20627	6885	100	62	77.209000
20628	6886	100	62	77.209000
20629	6887	100	62	77.209000
20630	6888	100	62	77.209000
20631	6889	100	62	77.209000
20632	6890	100	62	77.209000
20633	6891	100	62	77.209000
20634	6892	100	62	77.209000
20635	6893	100	62	77.209000
20636	6894	100	62	77.209000
20637	6895	100	62	77.209000
20638	6896	100	62	77.209000
20639	6897	100	62	77.209000
20640	6898	100	62	77.209000
20641	6899	100	62	77.209000
20642	6900	100	62	77.209000
20643	6901	100	62	77.209000
20644	6902	100	62	77.209000
20645	6903	100	62	77.209000
20646	6904	100	62	77.209000
20647	6905	100	62	77.209000
20648	6906	100	62	77.209000
20649	6907	100	62	77.209000
20650	6908	100	62	77.209000
20651	6909	100	62	77.209000
20652	6910	100	62	77.209000
20653	6911	100	62	77.209000
20654	6912	100	62	77.209000
20655	6913	100	62	77.209000
20656	6914	100	62	77.209000
20657	6915	100	62	77.209000
20658	6916	100	62	77.209000
20659	6917	100	62	77.209000
20660	6918	100	62	77.209000
20661	6919	100	62	77.209000
20662	6920	100	62	77.209000
20663	6921	100	62	77.209000
20664	6922	100	62	77.209000
20665	6923	100	62	77.209000
20666	6924	100	62	77.209000
20667	6925	100	62	77.209000
20668	6926	100	62	77.209000
20669	6927	100	62	77.209000
20670	6928	100	62	77.209000
20671	6929	100	62	77.209000
20672	6930	100	62	77.209000
20673	6931	100	62	77.209000
20674	6932	100	62	77.209000
20675	6933	100	62	77.209000
20676	6934	100	62	77.209000
20677	6935	100	62	77.209000
20678	6936	100	62	77.209000
20679	6937	100	62	77.209000
20680	6938	100	62	77.209000
20681	6939	100	62	77.209000
20682	6940	100	62	77.209000
20683	6941	100	62	77.209000
20684	6942	100	62	77.209000
20685	6943	100	62	77.209000
20686	6944	100	62	77.209000
20687	6945	100	62	77.209000
20688	6946	100	62	77.209000
20689	6947	100	62	77.209000
20690	6948	100	62	77.209000
20691	6949	100	62	77.209000
20692	6950	100	62	77.209000
20693	6951	100	62	77.209000
20694	6952	100	62	77.209000
20695	6953	100	62	77.209000
20696	6954	100	62	77.209000
20697	6955	100	62	77.209000
20698	6956	100	62	77.209000
20699	6957	100	62	77.209000
20700	6958	100	62	77.209000
20701	6959	100	62	77.209000
20702	6960	100	62	77.209000
20703	6961	100	62	77.209000
20704	6962	100	62	77.209000
20705	6963	100	62	77.209000
20706	6964	100	62	77.209000
20707	6965	100	62	77.209000
20708	6966	100	62	77.209000
20709	6967	100	62	77.209000
20710	6968	100	62	77.209000
20711	6969	100	62	77.209000
20712	6970	100	62	77.209000
20713	6971	100	62	77.209000
20714	6972	100	62	77.209000
20715	6973	100	62	77.209000
20716	6974	100	62	77.209000
20717	6975	100	62	77.209000
20718	6976	100	62	77.209000
20719	6977	100	62	77.209000
20720	6978	100	62	77.209000
20721	6979	100	62	77.209000
20722	6980	100	62	77.209000
20723	6981	100	62	77.209000
20724	6982	100	62	77.209000
20725	6983	100	62	77.209000
20726	6984	100	62	77.209000
20727	6985	100	62	77.209000
20728	6986	100	62	77.209000
20729	6987	100	62	77.209000
20730	6988	100	62	77.209000
20731	6989	100	62	77.209000
20732	6990	100	62	77.209000
20733	6991	100	62	77.209000
20734	6992	100	62	77.209000
20735	6993	100	62	77.209000
20736	6994	100	62	77.209000
20737	6995	100	62	77.209000
20738	6996	100	62	77.209000
20739	6997	100	12	24.745700
20740	6998	100	12	24.745700
20741	6999	100	12	24.745700
20742	7000	100	12	24.745700
20743	7001	100	12	24.745700
20744	7002	100	12	24.745700
20745	7003	100	12	24.745700
20746	7004	100	12	24.745700
20747	7005	100	12	24.745700
20748	7006	100	12	24.745700
20749	7007	100	12	24.745700
20750	7008	100	12	24.745700
20751	7009	100	12	24.745700
20752	7010	100	12	24.745700
20753	7011	100	12	24.745700
20754	7012	100	12	24.745700
20755	7013	100	12	24.745700
20756	7014	100	12	24.745700
20757	7015	100	12	24.745700
20758	7016	100	12	24.745700
20759	7017	100	12	24.745700
20760	7018	100	12	24.745700
20761	7019	100	12	24.745700
20762	7020	100	12	24.745700
20763	7021	100	12	24.745700
20764	7022	100	12	24.745700
20765	7023	100	12	24.745700
20766	7024	100	12	24.745700
20767	7025	100	12	24.745700
20768	7026	100	12	24.745700
20769	7027	100	12	24.745700
20770	7028	100	12	24.745700
20771	7029	100	12	24.745700
20772	7030	100	12	24.745700
20773	7031	100	12	24.745700
20774	7032	100	12	24.745700
20775	7033	100	12	24.745700
20776	7034	100	12	24.745700
20777	7035	100	12	24.745700
20778	7036	100	12	24.745700
20779	7037	100	12	24.745700
20780	7038	100	12	24.745700
20781	7039	100	12	24.745700
20782	7040	100	12	24.745700
20783	7041	100	12	24.745700
20784	7042	100	12	24.745700
20785	7043	100	12	24.745700
20786	7044	100	12	24.745700
20787	7045	100	12	24.745700
20788	7046	100	12	24.745700
20789	7047	100	12	24.745700
20790	7048	100	12	24.745700
20791	7049	100	12	24.745700
20792	7050	100	12	24.745700
20793	7051	100	12	24.745700
20794	7052	100	12	24.745700
20795	7053	100	12	24.745700
20796	7054	100	12	24.745700
20797	7055	100	12	24.745700
20798	7056	100	12	24.745700
20799	7057	100	12	24.745700
20800	7058	100	12	24.745700
20801	7059	100	12	24.745700
20802	7060	100	12	24.745700
20803	7061	100	12	24.745700
20804	7062	100	12	24.745700
20805	7063	100	12	24.745700
20806	7064	100	12	24.745700
20807	7065	100	12	24.745700
20808	7066	100	12	24.745700
20809	7067	100	12	24.745700
20810	7068	100	12	24.745700
20811	7069	100	12	24.745700
20812	7070	100	12	24.745700
20813	7071	100	12	24.745700
20814	7072	100	12	24.745700
20815	7073	100	12	24.745700
20816	7074	100	12	24.745700
20817	7075	100	12	24.745700
20818	7076	100	12	24.745700
20819	7077	100	12	24.745700
20820	7078	100	12	24.745700
20821	7079	100	12	24.745700
20822	7080	100	12	24.745700
20823	7081	100	12	24.745700
20824	7082	100	12	24.745700
20825	7083	100	12	24.745700
20826	7084	100	12	24.745700
20827	7085	100	12	24.745700
20828	7086	100	12	24.745700
20829	7087	100	12	24.745700
20830	7088	100	12	24.745700
20831	7089	100	12	24.745700
20832	7090	100	12	24.745700
20833	7091	100	12	24.745700
20834	7092	100	12	24.745700
20835	7093	100	12	24.745700
20836	7094	100	12	24.745700
20837	7095	100	12	24.745700
20838	7096	100	12	24.745700
20839	7097	100	12	24.745700
20840	7098	100	12	24.745700
20841	7099	100	12	24.745700
20842	7100	100	12	24.745700
20843	7101	100	12	24.745700
20844	7102	100	12	24.745700
20845	7103	100	12	24.745700
20846	7104	100	12	24.745700
20847	7105	100	12	24.745700
20848	7106	100	12	24.745700
20849	7107	100	12	24.745700
20850	7108	100	12	24.745700
20851	7109	100	12	24.745700
20852	7110	100	12	24.745700
20853	7111	100	12	24.745700
20854	7112	100	12	24.745700
20855	7113	100	12	24.745700
20856	7114	100	12	24.745700
20857	7115	100	12	24.745700
20858	7116	100	12	24.745700
20859	7117	100	12	24.745700
20860	7118	100	12	24.745700
20861	7119	100	12	24.745700
20862	7120	100	12	24.745700
20863	7121	100	12	24.745700
20864	7122	100	12	24.745700
20865	7123	100	12	24.745700
20866	7124	100	12	24.745700
20867	7125	100	12	24.745700
20868	7126	100	12	24.745700
20869	7127	100	12	24.745700
20870	7128	100	12	24.745700
20871	6997	200	10	15.697000
20872	6998	200	10	17.266000
20873	6999	200	10	25.128000
20874	7000	200	10	29.963000
20875	7001	200	10	31.928000
20876	7002	200	10	32.306000
20877	7003	200	10	30.703000
20878	7004	200	10	28.643000
20879	7005	200	10	28.477000
20880	7006	200	10	26.380000
20881	7007	200	10	22.356000
20882	7008	200	10	17.122000
20883	7009	200	10	17.664000
20884	7010	200	10	21.209000
20885	7011	200	10	24.124000
20886	7012	200	10	29.407000
20887	7013	200	10	34.200000
20888	7014	200	10	34.302000
20889	7015	200	10	30.326000
20890	7016	200	10	28.836000
20891	7017	200	10	28.134000
20892	7018	200	10	26.796000
20893	7019	200	10	20.197000
20894	7020	200	10	16.667000
20895	7021	200	10	17.950000
20896	7022	200	10	19.162000
20897	7023	200	10	25.544000
20898	7024	200	10	28.927000
20899	7025	200	10	33.813000
20900	7026	200	10	32.639000
20901	7027	200	10	28.530000
20902	7028	200	10	28.066000
20903	7029	200	10	28.158000
20904	7030	200	10	26.551000
20905	7031	200	10	21.940000
20906	7032	200	10	17.222000
20907	7033	200	10	15.310000
20908	7034	200	10	19.640000
20909	7035	200	10	23.666000
20910	7036	200	10	29.824000
20911	7037	200	10	32.764000
20912	7038	200	10	34.837000
20913	7039	200	10	29.359000
20914	7040	200	10	28.059000
20915	7041	200	10	27.982000
20916	7042	200	10	26.331000
20917	7043	200	10	21.764000
20918	7044	200	10	17.362000
20919	7045	200	10	17.311000
20920	7046	200	10	18.377000
20921	7047	200	10	25.641000
20922	7048	200	10	28.244000
20923	7049	200	10	34.176000
20924	7050	200	10	31.235000
20925	7051	200	10	29.067000
20926	7052	200	10	27.830000
20927	7053	200	10	28.746000
20928	7054	200	10	26.143000
20929	7055	200	10	21.338000
20930	7056	200	10	16.275000
20931	7057	200	10	15.862000
20932	7058	200	10	17.790000
20933	7059	200	10	24.413000
20934	7060	200	10	27.526000
20935	7061	200	10	32.428000
20936	7062	200	10	34.583000
20937	7063	200	10	29.032000
20938	7064	200	10	28.271000
20939	7065	200	10	27.735000
20940	7066	200	10	26.587000
20941	7067	200	10	22.067000
20942	7068	200	10	17.977000
20943	7069	200	10	16.240000
20944	7070	200	10	19.653000
20945	7071	200	10	21.552000
20946	7072	200	10	28.148000
20947	7073	200	10	32.033000
20948	7074	200	10	35.154000
20949	7075	200	10	28.483000
20950	7076	200	10	28.859000
20951	7077	200	10	28.546000
20952	7078	200	10	28.275000
20953	7079	200	10	22.228000
20954	7080	200	10	18.109000
20955	7081	200	10	15.732000
20956	7082	200	10	20.073000
20957	7083	200	10	24.900000
20958	7084	200	10	31.371000
20959	7085	200	10	33.027000
20960	7086	200	10	32.382000
20961	7087	200	10	28.979000
20962	7088	200	10	28.555000
20963	7089	200	10	27.946000
20964	7090	200	10	27.328000
20965	7091	200	10	22.851000
20966	7092	200	10	18.126000
20967	7093	200	10	16.413000
20968	7094	200	10	18.673000
20969	7095	200	10	23.621000
20970	7096	200	10	30.975000
20971	7097	200	10	33.126000
20972	7098	200	10	31.345000
20973	7099	200	10	30.062000
20974	7100	200	10	28.947000
20975	7101	200	10	27.622000
20976	7102	200	10	27.815000
20977	7103	200	10	23.588000
20978	7104	200	10	17.253000
20979	7105	200	10	16.149000
20980	7106	200	10	18.918000
20981	7107	200	10	24.470000
20982	7108	200	10	29.699000
20983	7109	200	10	33.829000
20984	7110	200	10	30.321000
20985	7111	200	10	28.129000
20986	7112	200	10	29.027000
20987	7113	200	10	28.920000
20988	7114	200	10	28.063000
20989	7115	200	10	23.807000
20990	7116	200	10	18.993000
20991	7117	200	10	16.369000
20992	7118	200	10	20.213000
20993	7119	200	10	25.313000
20994	7120	200	10	30.119000
20995	7121	200	10	34.456000
20996	7122	200	10	33.646000
20997	7123	200	10	30.672000
20998	7124	200	10	28.526000
20999	7125	200	10	28.134000
21000	7126	200	10	26.144000
21001	7127	200	10	21.728000
21002	7128	200	10	18.234000
21003	6997	100	11	84.380500
21004	6998	100	11	84.380500
21005	6999	100	11	84.380500
21006	7000	100	11	84.380500
21007	7001	100	11	84.380500
21008	7002	100	11	84.380500
21009	7003	100	11	84.380500
21010	7004	100	11	84.380500
21011	7005	100	11	84.380500
21012	7006	100	11	84.380500
21013	7007	100	11	84.380500
21014	7008	100	11	84.380500
21015	7009	100	11	84.380500
21016	7010	100	11	84.380500
21017	7011	100	11	84.380500
21018	7012	100	11	84.380500
21019	7013	100	11	84.380500
21020	7014	100	11	84.380500
21021	7015	100	11	84.380500
21022	7016	100	11	84.380500
21023	7017	100	11	84.380500
21024	7018	100	11	84.380500
21025	7019	100	11	84.380500
21026	7020	100	11	84.380500
21027	7021	100	11	84.380500
21028	7022	100	11	84.380500
21029	7023	100	11	84.380500
21030	7024	100	11	84.380500
21031	7025	100	11	84.380500
21032	7026	100	11	84.380500
21033	7027	100	11	84.380500
21034	7028	100	11	84.380500
21035	7029	100	11	84.380500
21036	7030	100	11	84.380500
21037	7031	100	11	84.380500
21038	7032	100	11	84.380500
21039	7033	100	11	84.380500
21040	7034	100	11	84.380500
21041	7035	100	11	84.380500
21042	7036	100	11	84.380500
21043	7037	100	11	84.380500
21044	7038	100	11	84.380500
21045	7039	100	11	84.380500
21046	7040	100	11	84.380500
21047	7041	100	11	84.380500
21048	7042	100	11	84.380500
21049	7043	100	11	84.380500
21050	7044	100	11	84.380500
21051	7045	100	11	84.380500
21052	7046	100	11	84.380500
21053	7047	100	11	84.380500
21054	7048	100	11	84.380500
21055	7049	100	11	84.380500
21056	7050	100	11	84.380500
21057	7051	100	11	84.380500
21058	7052	100	11	84.380500
21059	7053	100	11	84.380500
21060	7054	100	11	84.380500
21061	7055	100	11	84.380500
21062	7056	100	11	84.380500
21063	7057	100	11	84.380500
21064	7058	100	11	84.380500
21065	7059	100	11	84.380500
21066	7060	100	11	84.380500
21067	7061	100	11	84.380500
21068	7062	100	11	84.380500
21069	7063	100	11	84.380500
21070	7064	100	11	84.380500
21071	7065	100	11	84.380500
21072	7066	100	11	84.380500
21073	7067	100	11	84.380500
21074	7068	100	11	84.380500
21075	7069	100	11	84.380500
21076	7070	100	11	84.380500
21077	7071	100	11	84.380500
21078	7072	100	11	84.380500
21079	7073	100	11	84.380500
21080	7074	100	11	84.380500
21081	7075	100	11	84.380500
21082	7076	100	11	84.380500
21083	7077	100	11	84.380500
21084	7078	100	11	84.380500
21085	7079	100	11	84.380500
21086	7080	100	11	84.380500
21087	7081	100	11	84.380500
21088	7082	100	11	84.380500
21089	7083	100	11	84.380500
21090	7084	100	11	84.380500
21091	7085	100	11	84.380500
21092	7086	100	11	84.380500
21093	7087	100	11	84.380500
21094	7088	100	11	84.380500
21095	7089	100	11	84.380500
21096	7090	100	11	84.380500
21097	7091	100	11	84.380500
21098	7092	100	11	84.380500
21099	7093	100	11	84.380500
21100	7094	100	11	84.380500
21101	7095	100	11	84.380500
21102	7096	100	11	84.380500
21103	7097	100	11	84.380500
21104	7098	100	11	84.380500
21105	7099	100	11	84.380500
21106	7100	100	11	84.380500
21107	7101	100	11	84.380500
21108	7102	100	11	84.380500
21109	7103	100	11	84.380500
21110	7104	100	11	84.380500
21111	7105	100	11	84.380500
21112	7106	100	11	84.380500
21113	7107	100	11	84.380500
21114	7108	100	11	84.380500
21115	7109	100	11	84.380500
21116	7110	100	11	84.380500
21117	7111	100	11	84.380500
21118	7112	100	11	84.380500
21119	7113	100	11	84.380500
21120	7114	100	11	84.380500
21121	7115	100	11	84.380500
21122	7116	100	11	84.380500
21123	7117	100	11	84.380500
21124	7118	100	11	84.380500
21125	7119	100	11	84.380500
21126	7120	100	11	84.380500
21127	7121	100	11	84.380500
21128	7122	100	11	84.380500
21129	7123	100	11	84.380500
21130	7124	100	11	84.380500
21131	7125	100	11	84.380500
21132	7126	100	11	84.380500
21133	7127	100	11	84.380500
21134	7128	100	11	84.380500
\.


--
-- Name: measures_id_msr_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('measures_id_msr_seq', 21134, true);


--
-- Name: measures_mobile_id_mmo_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('measures_mobile_id_mmo_seq', 1, false);


--
-- Name: obs_pr_id_opr_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('obs_pr_id_opr_seq', 13, true);


--
-- Data for Name: obs_type; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY obs_type (id_oty, name_oty, desc_oty) FROM stdin;
1	insitu-fixed-point	fixed, in-situ, pointwise observation
2	insitu-mobile-point	mobile, in-situ, pointwise observation
3	virtual	virtual procedure
\.


--
-- Name: obs_type_id_oty_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('obs_type_id_oty_seq', 1, false);


--
-- Data for Name: observed_properties; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY observed_properties (name_opr, def_opr, desc_opr, constr_opr, id_opr) FROM stdin;
air-temperature	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:temperature	air temperature at 2 meters above terrain	{"interval": ["-40", "100"], "role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0"}	1
air-rainfall	urn:ogc:def:parameter:x-istsos:1.0:meteo:air:rainfall	liquid precipitation or snow water equivalent	{"role": "urn:x-ogc:def:classifiers:x-istsos:1.0:qualityIndexCheck:level0", "min": "0"}	2
longitude	urn:ogc:def:parameter:x-istsos:1.0:longittude		\N	10
latitude	urn:ogc:def:parameter:x-istsos:1.0:lattitude		\N	11
pressure	urn:ogc:def:parameter:x-istsos:1.0:pressure		\N	12
evapotranspiration	urn:ogc:def:parameter:x-istsos:1.0:evapo		\N	13
\.


--
-- Data for Name: off_proc; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY off_proc (id_off_prc, id_off_fk, id_prc_fk) FROM stdin;
108	5	54
4	2	2
6	2	3
8	2	4
10	2	5
121	5	55
122	5	58
123	5	59
124	5	57
125	5	60
126	5	62
127	5	61
128	5	64
129	5	65
130	5	66
131	5	63
132	5	56
33	2	6
34	2	10
35	2	12
37	2	11
38	2	14
43	2	21
51	2	9
52	2	8
53	2	7
56	3	28
69	3	29
70	3	33
71	3	34
72	3	35
73	3	37
74	3	36
75	3	38
76	3	30
77	3	39
78	3	31
79	3	40
80	3	32
82	4	41
95	4	43
96	4	46
97	4	50
98	4	47
99	4	48
100	4	49
101	4	51
102	4	52
103	4	53
104	4	45
105	4	44
106	4	42
\.


--
-- Name: off_proc_id_opr_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('off_proc_id_opr_seq', 132, true);


--
-- Data for Name: offerings; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY offerings (name_off, desc_off, expiration_off, active_off, id_off) FROM stdin;
temporary	temporary offering to hold self-registered procedures/sensors waiting for service adimistration acceptance	\N	t	1
temperatureOffering	This is related to mean temperature of various places	\N	t	2
precipitationOffering	Gives the mean rainfall	\N	t	3
pressureOffering	Gives the mean atmospheric pressure	\N	t	4
evapotranspirationOffering	Gives the combined ground surface evaporation and plant tranpiration	\N	t	5
\.


--
-- Name: offerings_id_off_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('offerings_id_off_seq', 5, true);


--
-- Data for Name: positions; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY positions (id_pos, id_qi_fk, id_eti_fk, geom_pos) FROM stdin;
\.


--
-- Name: prc_obs_id_pro_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('prc_obs_id_pro_seq', 198, true);


--
-- Data for Name: proc_obs; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY proc_obs (id_pro, id_prc_fk, id_uom_fk, id_opr_fk, constr_pro) FROM stdin;
6	2	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
5	2	10	10	\N
4	2	11	11	\N
7	3	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
8	3	10	10	\N
9	3	11	11	\N
12	4	11	11	\N
11	4	10	10	\N
10	4	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
15	5	11	11	\N
14	5	10	10	\N
13	5	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
16	6	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
17	6	10	10	\N
18	6	11	11	\N
19	7	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
20	7	10	10	\N
21	7	11	11	\N
22	8	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
23	8	10	10	\N
24	8	11	11	\N
25	9	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
26	9	10	10	\N
27	9	11	11	\N
28	10	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
29	10	10	10	\N
30	10	11	11	\N
31	11	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
32	11	10	10	\N
33	11	11	11	\N
34	12	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
35	12	10	10	\N
36	12	11	11	\N
88	30	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
89	30	11	11	\N
90	30	10	10	\N
91	31	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
92	31	11	11	\N
93	31	10	10	\N
42	14	11	11	\N
41	14	10	10	\N
40	14	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
85	29	11	11	\N
86	29	10	10	\N
87	29	1	2	{"interval": [0.0, 600.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
94	32	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
95	32	11	11	\N
96	32	10	10	\N
97	33	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
98	33	11	11	\N
99	33	10	10	\N
100	34	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
101	34	11	11	\N
102	34	10	10	\N
103	35	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
104	35	11	11	\N
105	35	10	10	\N
106	36	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
107	36	11	11	\N
108	36	10	10	\N
109	37	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
110	37	11	11	\N
111	37	10	10	\N
112	38	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
113	38	11	11	\N
114	38	10	10	\N
115	39	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
116	39	11	11	\N
117	39	10	10	\N
118	40	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
119	40	11	11	\N
120	40	10	10	\N
123	41	12	12	\N
122	41	10	10	\N
121	41	11	11	\N
124	42	12	12	\N
125	42	10	10	\N
126	42	11	11	\N
127	43	12	12	\N
128	43	10	10	\N
129	43	11	11	\N
130	44	12	12	\N
131	44	10	10	\N
132	44	11	11	\N
136	46	12	12	\N
137	46	10	10	\N
138	46	11	11	\N
139	47	12	12	\N
140	47	10	10	\N
141	47	11	11	\N
142	48	12	12	\N
143	48	10	10	\N
144	48	11	11	\N
145	49	12	12	\N
146	49	10	10	\N
147	49	11	11	\N
135	45	11	11	\N
134	45	10	10	\N
133	45	12	12	\N
148	50	12	12	\N
149	50	10	10	\N
150	50	11	11	\N
151	51	12	12	\N
152	51	10	10	\N
153	51	11	11	\N
154	52	12	12	\N
155	52	10	10	\N
63	21	11	11	\N
62	21	10	10	\N
61	21	2	1	{"interval": [-10.0, 50.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
156	52	11	11	\N
159	53	11	11	\N
158	53	10	10	\N
157	53	12	12	\N
160	54	10	10	\N
161	54	11	11	\N
162	54	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
163	55	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
164	55	11	11	\N
165	55	10	10	\N
166	56	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
167	56	11	11	\N
168	56	10	10	\N
169	57	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
170	57	11	11	\N
171	57	10	10	\N
172	58	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
173	58	11	11	\N
174	58	10	10	\N
175	59	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
176	59	11	11	\N
177	59	10	10	\N
178	60	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
179	60	11	11	\N
180	60	10	10	\N
181	61	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
182	61	11	11	\N
183	61	10	10	\N
184	62	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
185	62	11	11	\N
186	62	10	10	\N
187	63	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
188	63	11	11	\N
189	63	10	10	\N
190	64	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
191	64	11	11	\N
192	64	10	10	\N
193	65	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
194	65	11	11	\N
195	65	10	10	\N
196	66	1	13	{"interval": [0.0, 20.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
197	66	11	11	\N
198	66	10	10	\N
84	28	1	2	{"interval": [0.0, 900.0], "role": "urn:ogc:def:classifiers:x-istsos:1.0:qualityIndex:check:reasonable"}
83	28	11	11	\N
82	28	10	10	\N
\.


--
-- Data for Name: procedures; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY procedures (id_prc, assignedid_prc, name_prc, desc_prc, stime_prc, etime_prc, time_res_prc, time_acq_prc, id_oty_fk, id_foi_fk, mqtt_prc) FROM stdin;
3	7e2014aaaa9c11e69a34acd1b8c9a681	temp_aizwal	Mean temperature of Aizwal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	3	\N
46	06d9b44cacf311e6bcc5acd1b8c9a681	pressure_DadraNagar	Mean pressure of DadraNagar City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	29	\N
6	ccbb98c2aa9d11e68da6acd1b8c9a681	temp_bengaluru	Mean temperature of Bengaluru City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	6	\N
43	c6d192acacf211e6b269acd1b8c9a681	pressure_Bokaro	Mean pressure of Bokaro City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	8	\N
4	1504c532aa9d11e6b605acd1b8c9a681	temp_aurangabad	Mean temperature of Aurangabad City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	\N	\N	1	4	\N
2	f63ba39caa9b11e68493acd1b8c9a681	temp_ahmedabad	Mean temperature of Ahmedabad City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	2	\N
54	15f1d9e0acf411e68d82acd1b8c9a681	evapotranspiration_Ahmedabad	Mean evapotranspiration of Ahmedabad City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	2	\N
55	37a845f6acf411e6bcc5acd1b8c9a681	evapotranspiration_Aizwal	Mean evapotranspiration of Aizwal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	3	\N
56	49618a64acf411e68964acd1b8c9a681	evapotranspiration_Aurangabad	Mean evapotranspiration of Aurangabad City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	4	\N
57	5e5e3200acf411e6a02bacd1b8c9a681	evapotranspiration_Bathinda	Mean evapotranspiration of Bathinda City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	5	\N
58	75ce8a2aacf411e6a02bacd1b8c9a681	evapotranspiration_Bengaluru	Mean evapotranspiration of Bengaluru City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	6	\N
59	86006116acf411e682b9acd1b8c9a681	evapotranspiration_Chandigarh	Mean evapotranspiration of Chandigarh City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	9	\N
60	97199ba2acf411e6b666acd1b8c9a681	evapotranspiration_Chennai	Mean evapotranspiration of Chennai City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	10	\N
62	c2fe2a44acf411e6ba3cacd1b8c9a681	evapotranspiration_Delhi	Mean evapotranspiration of Delhi City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	27	\N
61	ada888ceacf411e6ba3cacd1b8c9a681	evapotranspiration_Kargil	Mean evapotranspiration of Kargil City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	17	\N
64	e904c3baacf411e6ba3cacd1b8c9a681	evapotranspiration_Vijaywada	Mean evapotranspiration of Vijaywada City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	28	\N
65	fc09f930acf411e6981aacd1b8c9a681	evapotranspiration_WestKameng	Mean evapotranspiration of WestKameng City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	26	\N
66	0b3a7470acf511e6baacacd1b8c9a681	evapotranspiration_Yavatmal	Mean evapotranspiration of Yavatmal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	1	\N
29	c895d97eacf011e694ffacd1b8c9a681	precipitation_Aizwal	Mean precipitation of Aizwal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	3	\N
30	e8ede662acf011e68d82acd1b8c9a681	precipitation_Bengaluru	Mean precipitation of Bengaluru City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	6	\N
31	05c890a2acf111e6981aacd1b8c9a681	precipitation_Bikaner	Mean precipitation of Bikaner City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	7	\N
32	1a8be6e2acf111e68d82acd1b8c9a681	precipitation_Bokaro	Mean precipitation of Bokaro City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	8	\N
34	3fdb2840acf111e68964acd1b8c9a681	precipitation_Darrang	Mean precipitation of Darrang City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	13	\N
36	6ef9d73eacf111e682b9acd1b8c9a681	precipitation_Delhi	Mean precipitation of Delhi City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	27	\N
35	5c718b66acf111e6a02bacd1b8c9a681	precipitation_Muzaffarpur	Mean precipitation of Muzaffarpur City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	19	\N
37	802d4798acf111e694ffacd1b8c9a681	precipitation_Shimla	Mean precipitation of Shimla City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	24	\N
38	90c0dca0acf111e68d82acd1b8c9a681	precipitation_Vijaywada	Mean precipitation of Vijaywada City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	28	\N
39	a5957e1aacf111e6bcc5acd1b8c9a681	precipitation_WestKameng	Mean precipitation of WestKameng City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	26	\N
40	b6f1ef5eacf111e6b269acd1b8c9a681	precipitation_Yavatmal	Mean precipitation of Yavatmal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	1	\N
41	5d3e2c56acf211e694ffacd1b8c9a681	pressure_Bengaluru	Mean pressure of Bengaluru City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	6	\N
28	7211e796acf011e6ba3cacd1b8c9a681	precipitation_Ahmedabad	Mean precipitation of Ahmedabad City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	2	\N
44	df2bcc64acf211e6b269acd1b8c9a681	pressure_Chandigarh	Mean pressure of Chandigarh City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	9	\N
45	f1662d02acf211e692e4acd1b8c9a681	pressure_Chennai	Mean pressure of Chennai City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	10	\N
50	7ecd16c4acf311e6bcc5acd1b8c9a681	pressure_Delhi	Mean pressure of Delhi City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	27	\N
47	1d45d68eacf311e68d82acd1b8c9a681	pressure_JaintiaHills	Mean pressure of JaintiaHills City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	16	\N
48	3152fbc0acf311e6b269acd1b8c9a681	pressure_Kargil	Mean pressure of Kargil City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	17	\N
51	9574d6c8acf311e6981aacd1b8c9a681	pressure_Shimla	Mean pressure of Shimla City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	24	\N
52	aa869d62acf311e6981aacd1b8c9a681	pressure_Vijaywada	Mean pressure of Vijaywada City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	28	\N
53	b9f297d8acf311e692e4acd1b8c9a681	pressure_Yavatmal	Mean pressure of Yavatmal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	\N	\N	1	1	\N
5	685a1da4aa9d11e68493acd1b8c9a681	temp_bathinda	Mean temperature of Bathinda City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	5	\N
7	0314501caa9e11e6b9d9acd1b8c9a681	temp_bikaner	Mean temperature of Bikaner City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	7	\N
9	1d0f90f2aa9f11e69329acd1b8c9a681	temp_chandigarh	Mean temperature of Chandigarh City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	9	\N
10	4e58bdd2aa9f11e69329acd1b8c9a681	temp_chennai	Mean temperature of Chennai City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	10	\N
11	97ebf716aa9f11e69329acd1b8c9a681	temp_dadranagarhaveli	Mean temperature of Dadra and Nagar Haveli City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	11	\N
12	bf685460aa9f11e69329acd1b8c9a681	temp_darjeeling	Mean temperature of Darjeeling City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	12	\N
14	76d216eaaaa011e6b9d9acd1b8c9a681	temp_eastimphal	Mean temperature of Yavatmal City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	\N	\N	1	1	\N
63	d52782f6acf411e682b9acd1b8c9a681	evapotranspiration_Shimla	Mean evapotranspiration of Shimla City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	24	\N
33	2ed153b2acf111e694ffacd1b8c9a681	precipitation_Chandigarh	Mean precipitation of Chandigarh City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	9	\N
42	b2849970acf211e682b9acd1b8c9a681	pressure_Bikaner	Mean pressure of Bikaner City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	7	\N
49	487ce392acf311e6b666acd1b8c9a681	pressure_Muzaffarpur	Mean pressure of Muzaffarpur City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	30	\N
8	2f984760aa9e11e68f24acd1b8c9a681	temp_bokaro	Mean temperature of Bokaro City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	0	0	1	8	\N
21	f6a5b24eaaa211e68b19acd1b8c9a681	temp_newdelhi	Mean temperature of New Delhi City	1992-01-02 04:40:00+05:30	2003-01-02 05:30:00+05:30	\N	\N	1	20	\N
\.


--
-- Name: procedures_id_prc_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('procedures_id_prc_seq', 66, true);


--
-- Data for Name: quality_index; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY quality_index (name_qi, desc_qi, id_qi) FROM stdin;
aggregation no data	no values are present for this aggregation interval	-100
outboud	gross error	0
raw	the format is correct	100
acceptable	the value is acceptable for the observed property	110
reasonable	the value is in a resonable range for that observed property and station	200
timely coherent	the value is coherent with time-series	300
spatilly coherent	the value is coherent with close by observations	400
manually adjusted	the value has been manually corrected	500
correct	the value has not been modified and is correct	600
\.


--
-- Data for Name: tran_log; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY tran_log (id_trl, transaction_time_trl, operation_trl, procedure_trl, begin_trl, end_trl, count, stime_prc, etime_prc) FROM stdin;
\.


--
-- Name: tran_log_id_trl_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('tran_log_id_trl_seq', 1, false);


--
-- Data for Name: uoms; Type: TABLE DATA; Schema: weatherstation; Owner: postgres
--

COPY uoms (name_uom, desc_uom, id_uom) FROM stdin;
mm	millimeter	1
°C	Celsius degree	2
%	percentage	3
m/s	metre per second	4
W/m2	Watt per square metre	5
m3/s	cube meter per second	8
mm/h	evapotranspiration	9
°E	Longitude	10
°N	Latitude	11
hpa	Pressure Measurement	12
\.


--
-- Name: uoms_id_uom_seq; Type: SEQUENCE SET; Schema: weatherstation; Owner: postgres
--

SELECT pg_catalog.setval('uoms_id_uom_seq', 12, true);


SET search_path = weather, pg_catalog;

--
-- Name: cron_log_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cron_log
    ADD CONSTRAINT cron_log_pkey PRIMARY KEY (id_clo);


--
-- Name: event_time_id_prc_fk_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_id_prc_fk_key UNIQUE (id_prc_fk, time_eti);


--
-- Name: event_time_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_pkey PRIMARY KEY (id_eti);


--
-- Name: feature_type_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feature_type
    ADD CONSTRAINT feature_type_pkey PRIMARY KEY (id_fty);


--
-- Name: foi_name_foi_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_name_foi_key UNIQUE (name_foi);


--
-- Name: foi_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_pkey PRIMARY KEY (id_foi);


--
-- Name: measures_fix_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_fix_pkey PRIMARY KEY (id_msr);


--
-- Name: measures_id_eti_fk_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_eti_fk_key UNIQUE (id_eti_fk, id_pro_fk);


--
-- Name: measures_mobile_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT measures_mobile_pkey PRIMARY KEY (id_pos);


--
-- Name: obs_pr_def_opr_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observed_properties
    ADD CONSTRAINT obs_pr_def_opr_key UNIQUE (def_opr);


--
-- Name: obs_pr_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observed_properties
    ADD CONSTRAINT obs_pr_pkey PRIMARY KEY (id_opr);


--
-- Name: obs_type_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY obs_type
    ADD CONSTRAINT obs_type_pkey PRIMARY KEY (id_oty);


--
-- Name: off_proc_id_off_fk_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_off_fk_key UNIQUE (id_off_fk, id_prc_fk);


--
-- Name: off_proc_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_pkey PRIMARY KEY (id_off_prc);


--
-- Name: offerings_name_off_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT offerings_name_off_key UNIQUE (name_off);


--
-- Name: offerings_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT offerings_pkey PRIMARY KEY (id_off);


--
-- Name: prc_obs_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_pkey PRIMARY KEY (id_pro);


--
-- Name: proc_obs_id_uom_fk_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT proc_obs_id_uom_fk_key UNIQUE (id_uom_fk, id_opr_fk, id_prc_fk);


--
-- Name: procedures_assignedid_prc_key; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_assignedid_prc_key UNIQUE (assignedid_prc);


--
-- Name: procedures_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id_prc);


--
-- Name: quality_index_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quality_index
    ADD CONSTRAINT quality_index_pkey PRIMARY KEY (id_qi);


--
-- Name: tran_log_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tran_log
    ADD CONSTRAINT tran_log_pkey PRIMARY KEY (id_trl);


--
-- Name: uoms_pkey; Type: CONSTRAINT; Schema: weather; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uoms
    ADD CONSTRAINT uoms_pkey PRIMARY KEY (id_uom);


SET search_path = weatherstation, pg_catalog;

--
-- Name: cron_log_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cron_log
    ADD CONSTRAINT cron_log_pkey PRIMARY KEY (id_clo);


--
-- Name: event_time_id_prc_fk_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_id_prc_fk_key UNIQUE (id_prc_fk, time_eti);


--
-- Name: event_time_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_pkey PRIMARY KEY (id_eti);


--
-- Name: feature_type_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY feature_type
    ADD CONSTRAINT feature_type_pkey PRIMARY KEY (id_fty);


--
-- Name: foi_name_foi_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_name_foi_key UNIQUE (name_foi);


--
-- Name: foi_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_pkey PRIMARY KEY (id_foi);


--
-- Name: measures_fix_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_fix_pkey PRIMARY KEY (id_msr);


--
-- Name: measures_id_eti_fk_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_eti_fk_key UNIQUE (id_eti_fk, id_pro_fk);


--
-- Name: measures_mobile_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT measures_mobile_pkey PRIMARY KEY (id_pos);


--
-- Name: obs_pr_def_opr_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observed_properties
    ADD CONSTRAINT obs_pr_def_opr_key UNIQUE (def_opr);


--
-- Name: obs_pr_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observed_properties
    ADD CONSTRAINT obs_pr_pkey PRIMARY KEY (id_opr);


--
-- Name: obs_type_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY obs_type
    ADD CONSTRAINT obs_type_pkey PRIMARY KEY (id_oty);


--
-- Name: off_proc_id_off_fk_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_off_fk_key UNIQUE (id_off_fk, id_prc_fk);


--
-- Name: off_proc_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_pkey PRIMARY KEY (id_off_prc);


--
-- Name: offerings_name_off_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT offerings_name_off_key UNIQUE (name_off);


--
-- Name: offerings_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT offerings_pkey PRIMARY KEY (id_off);


--
-- Name: prc_obs_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_pkey PRIMARY KEY (id_pro);


--
-- Name: proc_obs_id_uom_fk_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT proc_obs_id_uom_fk_key UNIQUE (id_uom_fk, id_opr_fk, id_prc_fk);


--
-- Name: procedures_assignedid_prc_key; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_assignedid_prc_key UNIQUE (assignedid_prc);


--
-- Name: procedures_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id_prc);


--
-- Name: quality_index_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quality_index
    ADD CONSTRAINT quality_index_pkey PRIMARY KEY (id_qi);


--
-- Name: tran_log_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tran_log
    ADD CONSTRAINT tran_log_pkey PRIMARY KEY (id_trl);


--
-- Name: uoms_pkey; Type: CONSTRAINT; Schema: weatherstation; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uoms
    ADD CONSTRAINT uoms_pkey PRIMARY KEY (id_uom);


SET search_path = weather, pg_catalog;

--
-- Name: ety_prc_date; Type: INDEX; Schema: weather; Owner: postgres; Tablespace: 
--

CREATE INDEX ety_prc_date ON event_time USING btree (id_eti, time_eti);


SET search_path = weatherstation, pg_catalog;

--
-- Name: ety_prc_date; Type: INDEX; Schema: weatherstation; Owner: postgres; Tablespace: 
--

CREATE INDEX ety_prc_date ON event_time USING btree (id_eti, time_eti);


SET search_path = weather, pg_catalog;

--
-- Name: cron_log_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY cron_log
    ADD CONSTRAINT cron_log_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: event_time_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: foi_id_fty_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_id_fty_fk_fkey FOREIGN KEY (id_fty_fk) REFERENCES feature_type(id_fty);


--
-- Name: measures_fix_id_qi_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_fix_id_qi_fk_fkey FOREIGN KEY (id_qi_fk) REFERENCES quality_index(id_qi) ON UPDATE CASCADE;


--
-- Name: measures_id_eti_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_eti_fk_fkey FOREIGN KEY (id_eti_fk) REFERENCES event_time(id_eti) ON DELETE CASCADE;


--
-- Name: measures_id_pro_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_pro_fk_fkey FOREIGN KEY (id_pro_fk) REFERENCES proc_obs(id_pro);


--
-- Name: measures_mobile_id_qi_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT measures_mobile_id_qi_fk_fkey FOREIGN KEY (id_qi_fk) REFERENCES quality_index(id_qi) ON UPDATE CASCADE;


--
-- Name: off_proc_id_off_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_off_fk_fkey FOREIGN KEY (id_off_fk) REFERENCES offerings(id_off) ON DELETE CASCADE;


--
-- Name: off_proc_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: positions_id_eti_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_id_eti_fk_fkey FOREIGN KEY (id_eti_fk) REFERENCES event_time(id_eti) ON DELETE CASCADE;


--
-- Name: prc_obs_id_opr_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_id_opr_fk_fkey FOREIGN KEY (id_opr_fk) REFERENCES observed_properties(id_opr);


--
-- Name: prc_obs_id_uom_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_id_uom_fk_fkey FOREIGN KEY (id_uom_fk) REFERENCES uoms(id_uom);


--
-- Name: proc_obs_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT proc_obs_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: procedures_id_foi_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_id_foi_fk_fkey FOREIGN KEY (id_foi_fk) REFERENCES foi(id_foi);


--
-- Name: procedures_id_oty_fk_fkey; Type: FK CONSTRAINT; Schema: weather; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_id_oty_fk_fkey FOREIGN KEY (id_oty_fk) REFERENCES obs_type(id_oty);


SET search_path = weatherstation, pg_catalog;

--
-- Name: cron_log_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY cron_log
    ADD CONSTRAINT cron_log_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: event_time_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY event_time
    ADD CONSTRAINT event_time_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: foi_id_fty_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY foi
    ADD CONSTRAINT foi_id_fty_fk_fkey FOREIGN KEY (id_fty_fk) REFERENCES feature_type(id_fty);


--
-- Name: measures_fix_id_qi_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_fix_id_qi_fk_fkey FOREIGN KEY (id_qi_fk) REFERENCES quality_index(id_qi) ON UPDATE CASCADE;


--
-- Name: measures_id_eti_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_eti_fk_fkey FOREIGN KEY (id_eti_fk) REFERENCES event_time(id_eti) ON DELETE CASCADE;


--
-- Name: measures_id_pro_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_id_pro_fk_fkey FOREIGN KEY (id_pro_fk) REFERENCES proc_obs(id_pro);


--
-- Name: measures_mobile_id_qi_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT measures_mobile_id_qi_fk_fkey FOREIGN KEY (id_qi_fk) REFERENCES quality_index(id_qi) ON UPDATE CASCADE;


--
-- Name: off_proc_id_off_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_off_fk_fkey FOREIGN KEY (id_off_fk) REFERENCES offerings(id_off) ON DELETE CASCADE;


--
-- Name: off_proc_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY off_proc
    ADD CONSTRAINT off_proc_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: positions_id_eti_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_id_eti_fk_fkey FOREIGN KEY (id_eti_fk) REFERENCES event_time(id_eti) ON DELETE CASCADE;


--
-- Name: prc_obs_id_opr_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_id_opr_fk_fkey FOREIGN KEY (id_opr_fk) REFERENCES observed_properties(id_opr);


--
-- Name: prc_obs_id_uom_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT prc_obs_id_uom_fk_fkey FOREIGN KEY (id_uom_fk) REFERENCES uoms(id_uom);


--
-- Name: proc_obs_id_prc_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY proc_obs
    ADD CONSTRAINT proc_obs_id_prc_fk_fkey FOREIGN KEY (id_prc_fk) REFERENCES procedures(id_prc) ON DELETE CASCADE;


--
-- Name: procedures_id_foi_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_id_foi_fk_fkey FOREIGN KEY (id_foi_fk) REFERENCES foi(id_foi);


--
-- Name: procedures_id_oty_fk_fkey; Type: FK CONSTRAINT; Schema: weatherstation; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_id_oty_fk_fkey FOREIGN KEY (id_oty_fk) REFERENCES obs_type(id_oty);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

