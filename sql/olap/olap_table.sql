CREATE TABLE IF NOT EXISTS cust_dim(
	cust_id VARCHAR(32) PRIMARY KEY,
	cust_name VARCHAR(64),
	cust_category VARCHAR(32)

);

CREATE TABLE IF NOT EXISTS trans_prod_fact(
	trans_id VARCHAR(50),
	product_id VARCHAR(8),
	trans_date DATE,
	customer_ID VARCHAR(64),
	PRIMARY KEY (trans_id, product_id)

);

CREATE TABLE IF NOT EXISTS trans_dim(
	trans_id VARCHAR(50) PRIMARY KEY,
	total_cost DECIMAL,
	payment_method VARCHAR(32),
	city VARCHAR(32),
	store_type VARCHAR(32),
	discount_applied BOOLEAN,
	promotion VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS prod_dim(
	product_id VARCHAR(8) PRIMARY KEY,
	product_name VARCHAR(32)
);

-- create date dimension table (from Postgres wiki)
CREATE TABLE IF NOT EXISTS date_dim AS
SELECT
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	-- Localized month name
	to_char(datum, 'TMMonth') AS MonthName,
	extract(day from datum) AS Day,
	extract(doy from datum) AS DayOfYear,
	-- Localized weekday
	to_char(datum, 'TMDay') AS WeekdayName,
	-- ISO calendar week
	extract(week from datum) AS CalendarWeek,
	to_char(datum, 'dd. mm. yyyy') AS FormattedDate,
	'Q' || to_char(datum, 'Q') AS Quartal,
	to_char(datum, 'yyyy/"Q"Q') AS YearQuartal,
	to_char(datum, 'yyyy/mm') AS YearMonth,
	-- ISO calendar year and week
	to_char(datum, 'iyyy/IW') AS YearCalendarWeek,
	-- Weekend
	CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS Weekend,
	-- Fixed holidays
		-- for America
		CASE WHEN to_char(datum, 'MMDD') IN ('0101', '0704', '1225', '1226')
		THEN 'Holiday' ELSE 'No holiday' END
		AS AmericanHoliday,
		-- for Canada
		CASE WHEN to_char(datum, 'MMDD') IN ('0101', '0701', '1225', '1226')
		THEN 'Holiday' ELSE 'No holiday' END
		AS CanadianHoliday,
	-- Some periods of the year, adjust for your organisation and country
	CASE WHEN to_char(datum, 'MMDD') BETWEEN '0601' AND '0731' THEN 'Summer break'
		 WHEN to_char(datum, 'MMDD') BETWEEN '1115' AND '1225' THEN 'Christmas season'
		 WHEN to_char(datum, 'MMDD') > '1225' OR to_char(datum, 'MMDD') <= '0106' THEN 'Winter break'
		ELSE 'Normal' END
		AS Period,
	-- ISO start and end of the week of this date
	datum + (1 - extract(isodow from datum))::integer AS CWStart,
	datum + (7 - extract(isodow from datum))::integer AS CWEnd,
	-- Start and end of the month of this date
	datum + (1 - extract(day from datum))::integer AS MonthStart,
	(datum + (1 - extract(day from datum))::integer + '1 month'::interval)::date - '1 day'::interval AS MonthEnd
FROM (
	-- There are 3 leap years in this range, so calculate 365 * 10 + 3 records
	SELECT '2020-01-01'::DATE + sequence.day AS datum
	FROM generate_series(0,3652) AS sequence(day)
	GROUP BY sequence.day
	 ) DQ
order by 1;

