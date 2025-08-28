CREATE TABLE IF NOT EXISTS trans(
    trans_id VARCHAR(16) PRIMARY KEY,
    trans_date DATE,
    total_cost DECIMAL,
    payment_method VARCHAR(32),
    city VARCHAR(32),
    store_type VARCHAR(32),
    discount_applied BOOLEAN,
    promotion VARCHAR(64),
    cust_id VARCHAR(16)
);


CREATE TABLE IF NOT EXISTS trans_prod(
    product VARCHAR(32),
    trans_id VARCHAR(16),
	product_id VARCHAR(16),
    PRIMARY KEY (trans_id, product_id)
);


-- CREATE SEQUENCE cust_ID_seq
--     START WITH 1
--     INCREMENT BY 1
--     MINVALUE 1
--     NO MAXVALUE
--     OWNED BY cust.cust_id


CREATE TABLE IF NOT EXISTS cust(
    customer_name VARCHAR(64),
    customer_category VARCHAR(32),
    cust_id VARCHAR(16) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS product(
    product VARCHAR(32),
    product_id VARCHAR(16) PRIMARY KEY
);