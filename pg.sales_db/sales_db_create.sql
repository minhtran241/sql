CREATE TABLE customer(
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(60) NOT NULL,
    company VARCHAR(60) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(40) NOT NULL,
    state CHAR(2) NOT NULL,
    zip SMALLINT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    birth_date DATE NULL,
    sex CHAR(1) NOT NULL,
    date_entered TIMESTAMP NOT NULL,
    id SERIAL PRIMARY KEY
);

CREATE TYPE sex_type AS ENUM
('M', 'F');

ALTER TABLE public.customer
ALTER COLUMN sex TYPE sex_type USING sex::sex_type;

CREATE TABLE sales_person(
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(60) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(40) NOT NULL,
    state CHAR(2) NOT NULL DEFAULT 'PA',
    zip SMALLINT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    birth_date DATE NULL,
    sex sex_type NOT NULL,
    date_hired TIMESTAMP NOT NULL,
    id SERIAL PRIMARY KEY
);

CREATE TABLE product_type(
    name VARCHAR(30) NOT NULL,
    id SERIAL PRIMARY KEY
);

ALTER TABLE product_type 
ADD CONSTRAINT check_name 
CHECK (name = 'Business' OR name = 'Casual' OR name = 'Athletic');

ALTER TABLE product_type ADD CONSTRAINT check_name_unique UNIQUE(name);

CREATE TABLE product(
    type_id INTEGER REFERENCES product_type(id),
    name VARCHAR(30) NOT NULL,
    supplier VARCHAR(30) NOT NULL,
    description TEXT NOT NULL,
    id SERIAL PRIMARY KEY
);

CREATE TABLE item(
    product_id INTEGER REFERENCES product(id),
    size INTEGER NOT NULL,
    color VARCHAR(30) NOT NULL,
    picture VARCHAR(256) NOT NULL,
    price NUMERIC(6,2) NOT NULL,
    id SERIAL PRIMARY KEY
);

CREATE TABLE sales_order(
    customer_id INTEGER REFERENCES customer(id),
    sales_person_id INTEGER REFERENCES sales_person(id),
    time_order_taken TIMESTAMP NOT NULL,
    purchase_order_number INTEGER NOT NULL,
    credit_card_number VARCHAR(16) NOT NULL,
    credit_card_exper_month SMALLINT NOT NULL CHECK (credit_card_exper_month > 0 AND credit_card_exper_month < 13),
    credit_card_exper_day SMALLINT NOT NULL CHECK (credit_card_exper_day > 0 AND credit_card_exper_day < 32),
    credit_card_secret_code SMALLINT NOT NULL,
    name_on_card VARCHAR(100) NOT NULL,
    id SERIAL PRIMARY KEY
);

CREATE TABLE sales_item(
    item_id INTEGER REFERENCES item(id),
    sales_order_id INTEGER REFERENCES sales_order(id),
    qunatity INTEGER NOT NULL,
    discount NUMERIC(3,2) NULL DEFAULT 0,
    taxable BOOLEAN NOT NULL DEFAULT FALSE,
    sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
    id SERIAL PRIMARY KEY
);

ALTER TABLE sales_item ADD day_of_week VARCHAR(8);

ALTER TABLE sales_item ALTER COLUMN day_of_week SET NOT NULL;

ALTER TABLE sales_item RENAME COLUMN day_of_week TO weekday;

ALTER TABLE sales_item DROP COLUMN weekday;

CREATE TABLE transaction_type(
    name VARCHAR(30) NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    id SERIAL PRIMARY KEY
);

ALTER TABLE transaction_type RENAME TO transaction;

CREATE INDEX transaction_id ON transaction(name);

CREATE INDEX transaction_id_2 ON transaction(name, payment_type);

TRUNCATE TABLE transaction;

ALTER TABLE customer ALTER COLUMN zip TYPE INTEGER;
ALTER TABLE customer ADD CONSTRAINT check_zip CHECK (zip > 0);

ALTER TABLE sales_person ALTER COLUMN zip TYPE INTEGER;

ALTER TABLE sales_person ADD CONSTRAINT check_zip CHECK (zip > 0);

ALTER TABLE sales_order ALTER COLUMN purchase_order_number TYPE BIGINT;

ALTER TABLE sales_item RENAME COLUMN qunatity TO quantity;

CREATE TABLE past_due(
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    balance NUMERIC(6,2) NOT NULL
);

CREATE TABLE distributor(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    doj DATE DEFAULT NOW()
);

CREATE TABLE distributor_audit(
    id SERIAL PRIMARY KEY,
    dist_id INT NOT NULL REFERENCES distributor(id),
    old_name VARCHAR(100) NOT NULL,
    new_name VARCHAR(100) NOT NULL,
    edit_date TIMESTAMP NOT NULL
);