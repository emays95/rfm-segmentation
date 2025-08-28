CREATE TABLE IF NOT EXISTS trans(
    trans_id VARCHAR(16) PRIMARY KEY,
    trans_date DATE,
    customer_name VARCHAR(64),
    total_cost DECIMAL,
    payment_method VARCHAR(32),
    city VARCHAR(32),
    store_type VARCHAR(32),
    discount_applied BOOLEAN,
    promotion VARCHAR(64)

);


CREATE IF NOT EXISTS trans_prod(
    trans_id VARCHAR(16),
    product VARCHAR(32),
    PRIMARY KEY (trans_id, product)
);

CREATE SEQUENCE cust_ID_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    OWNED BY cust.cust_id
;


CREATE IF NOT EXISTS cust(
    cust_id INT DEFAULT nextval('cust_id_seq') PRIMARY KEY,
    customer_name VARCHAR(64),
    customer_category VARCHAR(32)
);