CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY NOT NULL, 
    publisher_name VARCHAR(400) NOT NULL
);


CREATE TABLE book_language (
    language_id INT PRIMARY KEY NOT NULL,
    language_code VARCHAR(8),
    language_name VARCHAR(50)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY NOT NULL,
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    num_pages INT,
    publication_date DATE,
	publisher_id INT REFERENCES publisher (publisher_id),
	language_id INT REFERENCES book_language (language_id)
);

CREATE TABLE author (
    author_id INT PRIMARY KEY NOT NULL,
    author_name VARCHAR(400)
);

CREATE TABLE book_author (
    book_id INT REFERENCES book (book_id),
    author_id INT REFERENCES author (author_id),
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE address_status (
    status_id INT PRIMARY KEY NOT NULL,
    address_status VARCHAR(30)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY NOT NULL,
    country_name VARCHAR(200)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY NOT NULL,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
    country_id INT REFERENCES country (country_id)                                         
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350)
);

CREATE TABLE customer_address (
    customer_id INT REFERENCES customer (customer_id),
    address_id INT REFERENCES address (address_id),
    address_status_id INT REFERENCES address_status (status_id),
    PRIMARY KEY (customer_id, address_id) 
);

CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY NOT NULL,
    method_name VARCHAR(100),
    cost DECIMAL(6, 2)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY NOT NULL,
    order_date TIMESTAMP,
    customer_id INT REFERENCES customer (customer_id),
    shipping_method_id INT REFERENCES shipping_method (method_id),
    dest_address_id INT REFERENCES address (address_id) 
);

CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY NOT NULL,
    status_value VARCHAR(20)
);


CREATE TABLE order_line (
    line_id SERIAL PRIMARY KEY NOT NULL,
    order_id INT REFERENCES orders (order_id),
    book_id INT REFERENCES book (book_id),
    price DECIMAL(5, 2)
);

CREATE TABLE order_history (
    history_id SERIAL PRIMARY KEY NOT NULL,
    order_id INT REFERENCES orders (order_id),
    order_status_id INT REFERENCES order_status (order_status_id),
    status_date TIMESTAMP
);


