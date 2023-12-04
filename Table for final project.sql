DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS store_location CASCADE;
DROP TABLE IF EXISTS store_management CASCADE;
DROP TABLE IF EXISTS store_labor_cost CASCADE;
DROP TABLE IF EXISTS location_type CASCADE;
DROP TABLE IF EXISTS store CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS payment_type CASCADE;
DROP TABLE IF EXISTS invoice CASCADE;
DROP TABLE IF EXISTS invoice_by_day CASCADE;
DROP TABLE IF EXISTS daily_sales CASCADE;
DROP TABLE IF EXISTS product_line CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS invoice_product_relationship CASCADE;
DROP TABLE IF EXISTS invoice_relation CASCADE;


CREATE TABLE employees (
	employee_id		int,
	sex				varchar(10),
	sex_indicator	int,
	age				int,
	years_of_experience	int,
	num_of_training	int,
	PRIMARY KEY (employee_id)
); 

CREATE TABLE store_location (
	store_id		int,
	name			varchar(100),
	latitude		float,
	longitude		float,
	street			varchar(50),
	city			varchar(25),
	state			varchar(2),
	zip				int,
	phone			varchar(12),
	website			varchar(100),
	PRIMARY KEY (store_id)
); 

CREATE TABLE store_management (
	store_id		int,
	manager_id		int,
	PRIMARY KEY (store_id, manager_id),
	FOREIGN KEY (store_id) REFERENCES store_location
); 

CREATE TABLE store_labor_cost (
	store_id		int,
	total_wages_m	float,
	number_of_staffs	int,
	avg_wage_k		float,
	PRIMARY KEY (store_id),
	FOREIGN KEY (store_id) REFERENCES store_location
); 

CREATE TABLE location_type (
	type_id			int,
	type_name		varchar(10),
	explanation		varchar(100),
	PRIMARY KEY (type_id)
); 

CREATE TABLE store (
	store_id		int,
	location_type_id	int,
	store_age_years	int,
	sales_m			float,
	gross_profit	float,
	ads_expense_k	float,
	PRIMARY KEY (store_id, location_type_id),
	FOREIGN KEY (store_id) REFERENCES store_location,
	FOREIGN KEY (location_type_id) REFERENCES location_type(type_id)
); 

CREATE TABLE customer (
	customer_id		int,
	year_of_birth	int,
	education		varchar(15),
	marital_status	varchar(10),
	income			float,
	dt_customer		date,
	PRIMARY KEY (customer_id)
); 


CREATE TABLE payment_type (
	payment_type_id	int,
	payment_type	varchar(15),
	PRIMARY KEY (payment_type_id)
); 

CREATE TABLE invoice (
	invoice_id		varchar(12),
	total_sale		float,
	tax				float,
	cost_of_sold	float,
	gross_income	float,
	payment_type_id	int,
	PRIMARY KEY (invoice_id),
	FOREIGN KEY (payment_type_id) REFERENCES payment_type
); 

CREATE TABLE invoice_by_day (
	date			date,
	time			time,
	invoice_id		varchar(12),
	PRIMARY KEY (date, invoice_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice
); 

CREATE TABLE daily_sales (
	date			date,
	net_purchases	float,
	gross_sale		float,
	tax_of_sell		float,
	margin			float,
	PRIMARY KEY (date)
); 

CREATE TABLE product_line (
	product_line_id		int,
	product_line_name	varchar(30),
	PRIMARY KEY (product_line_id)
); 

CREATE TABLE product (
	product_id		int,
	product_name	varchar(60),
	unit_price		numeric(4,2),
	product_line_id	int,
	PRIMARY KEY (product_id),
	FOREIGN KEY (product_line_id) REFERENCES product_line
); 

CREATE TABLE invoice_product_relationship (
	invoice_id		varchar(12),
	product_id		int,
	quantity		int,
	PRIMARY KEY (invoice_id, product_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice,
	FOREIGN KEY (product_id) REFERENCES product
); 

CREATE TABLE invoice_relation (
	invoice_id		varchar(12),
	customer_id		int,
	store_id		int,
	PRIMARY KEY (invoice_id, customer_id, store_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice,
	FOREIGN KEY (customer_id) REFERENCES customer,
	FOREIGN KEY (store_id) REFERENCES store_location
);
