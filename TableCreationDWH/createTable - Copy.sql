CREATE TABLE IF NOT EXISTS publisher (
    publisher_sk INT PRIMARY KEY,            -- Primary key constraint
    publisher_id INT UNIQUE NOT NULL,        -- Unique and NOT NULL constraint
    publisher_name VARCHAR(400)      -- NOT NULL constraint
);


CREATE TABLE author (
    author_sk INT PRIMARY KEY,
    author_id INT UNIQUE NOT NULL
    author_name VARCHAR(400)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY NOT NULL,
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    num_pages INT,
    publication_date DATE,
	language_name VARCHAR(50),
	publisher_id INT REFERENCES publisher (publisher_id),
	author_id INT REFERENCES author (author_id)
);

CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY NOT NULL,
    address_status VARCHAR(30)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY NOT NULL,
    country_name VARCHAR(200)
);

CREATE TABLE city (
	city_id INT PRIMARY KEY NOT NULL,
	city VARCHAR(200),
	country_id INT REFERENCES country (country_id)
)

CREATE TABLE address (
    address_id INT PRIMARY KEY NOT NULL,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city_id INT REFERENCES city (city_id)                                         
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350),
	address_status_id INT REFERENCES address_status (address_status_id)
);

CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY NOT NULL,
    method_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY NOT NULL,
    order_date TIMESTAMP
);

CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY NOT NULL,
    status_value VARCHAR(20)
);

CREATE TABLE order_history (
    history_id SERIAL PRIMARY KEY NOT NULL,
	status_date_time TIMESTAMP,
    order_status_id INT REFERENCES order_status (order_status_id),
	order_id INT REFERENCES orders (order_id)
);

CREATE TABLE book_order_sales (
	order_price INT NOT NULL,
	quantity INT NOT NULL,
	shipping_cost INT NOT NULL,
	book_id INT REFERENCES book (book_id),
	customer_id INT REFERENCES customer (customer_id),
	method_id INT REFERENCES shipping_method (method_id),
	order_id INT REFERENCES orders (order_id)
);





