CREATE TABLE IF NOT EXISTS publisher (
    publisher_sk INT PRIMARY KEY,            -- Primary key constraint
    publisher_id INT UNIQUE NOT NULL,        -- Unique and NOT NULL constraint
    publisher_name VARCHAR(400)      -- NOT NULL constraint
);

create sequence publisher_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE author (
    author_sk INT PRIMARY KEY,
    author_id INT UNIQUE NOT NULL,
    author_name VARCHAR(400)
);

create sequence author_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE book (
    book_sk INT PRIMARY KEY NOT NULL,
	book_id INT UNIQUE NOT NULL, 
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    num_pages INT,
	language_name VARCHAR(50),
	publisher_sk INT REFERENCES publisher (publisher_sk)
);


create sequence book_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE book_author (
author_sk INT REFERENCES author (author_sk),
book_sk INT REFERENCES book(book_sk),
PRIMARY KEY (author_sk, book_sk)   
);

create sequence book_author_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE address_status (
    address_status_sk INT PRIMARY KEY NOT NULL,
	address_status_id INT UNIQUE NOT NULL,
    address_status VARCHAR(30)
);
create sequence address_status_sk_seq
    increment 1
    minvalue 1;
	
CREATE TABLE customer (
    customer_sk INT PRIMARY KEY NOT NULL,
	customer_id INT UNIQUE NOT NULL,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350)
	);

create sequence customer_sk_seq
    increment 1
    minvalue 1;


CREATE TABLE country (
    country_sk INT PRIMARY KEY NOT NULL,
	country_id INT UNIQUE NOT NULL,
    country_name VARCHAR(200)
);

create sequence country_sk_seq
    increment 1
    minvalue 1;


CREATE TABLE city (
	city_sk INT PRIMARY KEY NOT NULL,
	city_id INT UNIQUE NOT NULL,
	city VARCHAR(200),
	country_sk INT REFERENCES country (country_sk)
)

create sequence city_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE address (
    address_sk INT PRIMARY KEY NOT NULL,
	address_id INT UNIQUE NOT NULL,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city_sk INT REFERENCES city (city_sk)                                         
);
create sequence address_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE customer_address (
address_sk INT REFERENCES address (address_sk),
customer_sk INT REFERENCES customer(customer_sk),
address_status_sk INT REFERENCES address_status(address_status_sk),
PRIMARY KEY (address_sk, customer_sk)   
)


CREATE TABLE shipping_method (
    method_sk INT PRIMARY KEY NOT NULL,
	method_id INT UNIQUE NOT NULL,
    method_name VARCHAR(100)
);
create sequence method_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE  public.date_dim
(
    date_sk INT PRIMARY KEY NOT NULL,
    date date NOT NULL,
    day VARCHAR(20),
    week VARCHAR(20),
    month VARCHAR(20),
    year VARCHAR(20)
)

create sequence date_sk_seq
    increment 1
    minvalue 1;


CREATE TABLE orders (
    order_sk INT PRIMARY KEY NOT NULL,
	order_id INT UNIQUE NOT NULL,
    order_date_sk INT REFERENCES date_dim(date_sk)
);

create sequence order_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE order_history (
    history_sk INT PRIMARY KEY NOT NULL,
	history_id INT UNIQUE NOT NULL,
    order_status_value VARCHAR(100),
	status_date_sk INT REFERENCES date_dim(date_sk),
	order_sk INT REFERENCES orders (order_sk)
);

create sequence history_sk_seq
    increment 1
    minvalue 1;

CREATE TABLE book_order_sales (
	book_sk INT REFERENCES book(book_sk),
	customer_sk INT REFERENCES customer (customer_sk),
	method_sk INT REFERENCES shipping_method (method_sk),
	order_sk INT REFERENCES orders (order_sk),
	address_sk INT REFERENCES address (address_sk),
	date_sk INT REFERENCES date_dim (date_sk),
	order_line_number INT,
	book_price DECIMAL(10, 2),
	quantity INT,
	shipping_cost DECIMAL(10, 2),
	PRIMARY KEY (book_sk, customer_sk, method_sk, order_sk,address_sk,date_sk) 
);
	

	
	
	





