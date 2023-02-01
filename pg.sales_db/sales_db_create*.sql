BEGIN;


CREATE TABLE IF NOT EXISTS public.customer
(
    first_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    email character varying(60) COLLATE pg_catalog."default" NOT NULL,
    company character varying(60) COLLATE pg_catalog."default" NOT NULL,
    street character varying(50) COLLATE pg_catalog."default" NOT NULL,
    city character varying(40) COLLATE pg_catalog."default" NOT NULL,
    state character(2) COLLATE pg_catalog."default" NOT NULL,
    zip integer NOT NULL,
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    birth_date date,
    sex sex_type NOT NULL,
    date_entered timestamp without time zone NOT NULL,
    id integer NOT NULL DEFAULT nextval('customer_id_seq'::regclass),
    CONSTRAINT customer_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.distributor
(
    id integer NOT NULL DEFAULT nextval('distributor_id_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default",
    doj date DEFAULT now(),
    CONSTRAINT distributor_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.distributor_audit
(
    id integer NOT NULL DEFAULT nextval('distributor_audit_id_seq'::regclass),
    dist_id integer NOT NULL,
    old_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    new_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    edit_date timestamp without time zone NOT NULL,
    CONSTRAINT distributor_audit_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.item
(
    product_id integer,
    size integer NOT NULL,
    color character varying(30) COLLATE pg_catalog."default" NOT NULL,
    picture character varying(256) COLLATE pg_catalog."default" NOT NULL,
    price numeric(6, 2) NOT NULL,
    id integer NOT NULL DEFAULT nextval('item_id_seq'::regclass),
    CONSTRAINT item_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.past_due
(
    id integer NOT NULL DEFAULT nextval('past_due_id_seq'::regclass),
    customer_id integer NOT NULL,
    balance numeric(6, 2) NOT NULL,
    CONSTRAINT past_due_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.product
(
    type_id integer,
    name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    supplier character varying(30) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    CONSTRAINT product_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.product_type
(
    name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    id integer NOT NULL DEFAULT nextval('product_type_id_seq'::regclass),
    CONSTRAINT product_type_pkey PRIMARY KEY (id),
    CONSTRAINT check_name_unique UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.sales_item
(
    item_id integer,
    sales_order_id integer,
    quantity integer NOT NULL,
    discount numeric(3, 2) DEFAULT 0,
    taxable boolean NOT NULL DEFAULT false,
    sales_tax_rate numeric(5, 2) NOT NULL DEFAULT 0,
    id integer NOT NULL DEFAULT nextval('sales_item_id_seq'::regclass),
    CONSTRAINT sales_item_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.sales_order
(
    customer_id integer,
    sales_person_id integer,
    time_order_taken timestamp without time zone NOT NULL,
    purchase_order_number bigint NOT NULL,
    credit_card_number character varying(16) COLLATE pg_catalog."default" NOT NULL,
    credit_card_exper_month smallint NOT NULL,
    credit_card_exper_day smallint NOT NULL,
    credit_card_secret_code smallint NOT NULL,
    name_on_card character varying(100) COLLATE pg_catalog."default" NOT NULL,
    id integer NOT NULL DEFAULT nextval('sales_order_id_seq'::regclass),
    CONSTRAINT sales_order_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.sales_person
(
    first_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    email character varying(60) COLLATE pg_catalog."default" NOT NULL,
    street character varying(50) COLLATE pg_catalog."default" NOT NULL,
    city character varying(40) COLLATE pg_catalog."default" NOT NULL,
    state character(2) COLLATE pg_catalog."default" NOT NULL DEFAULT 'PA'::bpchar,
    zip integer NOT NULL,
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    birth_date date,
    sex sex_type NOT NULL,
    date_hired timestamp without time zone NOT NULL,
    id integer NOT NULL DEFAULT nextval('sales_person_id_seq'::regclass),
    CONSTRAINT sales_person_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.distributor_audit
    ADD CONSTRAINT distributor_audit_dist_id_fkey FOREIGN KEY (dist_id)
    REFERENCES public.distributor (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.item
    ADD CONSTRAINT item_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.product (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product
    ADD CONSTRAINT product_type_id_fkey FOREIGN KEY (type_id)
    REFERENCES public.product_type (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.sales_item
    ADD CONSTRAINT sales_item_item_id_fkey FOREIGN KEY (item_id)
    REFERENCES public.item (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.sales_item
    ADD CONSTRAINT sales_item_sales_order_id_fkey FOREIGN KEY (sales_order_id)
    REFERENCES public.sales_order (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.sales_order
    ADD CONSTRAINT sales_order_customer_id_fkey FOREIGN KEY (customer_id)
    REFERENCES public.customer (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.sales_order
    ADD CONSTRAINT sales_order_sales_person_id_fkey FOREIGN KEY (sales_person_id)
    REFERENCES public.sales_person (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;