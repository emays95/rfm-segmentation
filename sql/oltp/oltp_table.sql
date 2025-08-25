CREATE TABLE IF NOT EXISTS trans(
      trans_id VARCHAR(50) PRIMARY KEY,
      trans_date DATE,
      customer_name VARCHAR(64),
      product VARCHAR(256),
      total_items INT,
      payment_method VARCHAR(32),
      city VARCHAR(32),
      store_type VARCHAR(32),
      discount_applied BOOLEAN,
      customer_category VARCHAR(32),
      season VARCHAR(8),
      promotion VARCHAR(64)

)
