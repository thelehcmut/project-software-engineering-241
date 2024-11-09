DROP DATABASE IF EXISTS Harmonie;

CREATE DATABASE IF NOT EXISTS Harmonie;

USE Harmonie;

DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (
	id              INT             AUTO_INCREMENT              PRIMARY KEY,
	cccd            VARCHAR(12)     UNIQUE                      NOT NULL,
	fname           VARCHAR(255)                                NOT NULL,
	lname           VARCHAR(255)                                NOT NULL,
	dob             DATE                                        NOT NULL,
	gender          ENUM('M', 'F')                              NOT NULL,
	phone           VARCHAR(10)     UNIQUE                      NOT NULL,
	creation_date   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   NOT NULL,
	email           VARCHAR(255)    UNIQUE                      NOT NULL
);


DROP TABLE IF EXISTS Sellers;
CREATE TABLE IF NOT EXISTS Sellers ( -- Inheritance of Users
	id              INT             AUTO_INCREMENT              PRIMARY KEY,
    tax_id          VARCHAR(15)     UNIQUE                      NOT NULL,

	FOREIGN KEY (id) REFERENCES Users(id)
);


DROP TABLE IF EXISTS Stores;
CREATE TABLE IF NOT EXISTS Stores ( -- Weak entity of Sellers
	id              INT             AUTO_INCREMENT              NOT NULL,
	seller_id       INT                                         NOT NULL,
    name            VARCHAR(255)                                NOT NULL,
	creation_date   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   NOT NULL,
	description     TEXT,
    address         VARCHAR(255)                                NOT NULL,

    FOREIGN KEY (seller_id) REFERENCES Sellers(id),
    PRIMARY KEY (id, seller_id)
);


DROP TABLE IF EXISTS Products;
CREATE TABLE IF NOT EXISTS Products ( -- Weak entity of Stores
	id              INT             AUTO_INCREMENT,
	name            VARCHAR(255)                                NOT NULL,
	brand           VARCHAR(255),
	price           DECIMAL(10,2)                               NOT NULL,
	quantity        INT                                         NOT NULL,
	description     TEXT,
	views           INT             DEFAULT 0,
	rating_count    INT             DEFAULT 0,
    avg_rating      DECIMAL(5,2)    DEFAULT 0.0                 NOT NULL,
	category        VARCHAR(255),
	store_id        INT                                         NOT NULL,


	FOREIGN KEY (store_id) REFERENCES Stores(id),
    PRIMARY KEY (id, store_id)
);


DROP TABLE IF EXISTS ProductImages;
CREATE TABLE IF NOT EXISTS ProductImages (
    product_id      INT                                         NOT NULL,
    image_url       VARCHAR(255)                                NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(id),
    PRIMARY KEY (product_id, image_url)
);

DROP TABLE IF EXISTS Carts;
CREATE TABLE IF NOT EXISTS Carts (
	id              INT             AUTO_INCREMENT          	PRIMARY KEY,
	total_items     INT             DEFAULT 0               	NOT NULL,
    total_price     DECIMAL(10,2)   DEFAULT 0.0             	NOT NULL
);


DROP TABLE IF EXISTS Buyers;
CREATE TABLE IF NOT EXISTS Buyers (
    id              INT             AUTO_INCREMENT              PRIMARY KEY,
    cart_id         INT                                         NOT NULL,
    FOREIGN KEY (id) REFERENCES Users(id),
    FOREIGN KEY (cart_id) REFERENCES Carts(id)
);


DROP TABLE IF EXISTS ShippingInfo;
CREATE TABLE IF NOT EXISTS ShippingInfo (
    buyer_id        INT                                         NOT NULL,
    address         VARCHAR(255)                                NOT NULL,
    phone           VARCHAR(10)                                 NOT NULL,

    FOREIGN KEY (buyer_id) REFERENCES Buyers(id),
    PRIMARY KEY (buyer_id, address, phone)
);


DROP TABLE IF EXISTS CartProducts;
CREATE TABLE IF NOT EXISTS CartProducts (
    product_id      INT                                         NOT NULL,
	cart_id         INT                                         NOT NULL,
	quantity        INT                                         NOT NULL,
    total_price     DECIMAL(10,2)                               NOT NULL,
	FOREIGN KEY (cart_id) REFERENCES Carts(id),
	FOREIGN KEY (product_id) REFERENCES Products(id),
    PRIMARY KEY (product_id, cart_id)
);


DROP TABLE IF EXISTS Discounts;
CREATE TABLE IF NOT EXISTS Discounts (
    id              INT             AUTO_INCREMENT              PRIMARY KEY,
	code            VARCHAR(50)                                 NOT NULL,
	release_date    DATE                                        NOT NULL,
	quantity        INT                                         NOT NULL,
	start_date      DATE                                        NOT NULL,
    expiration_date DATE                                        NOT NULL,
	discount_type   ENUM('Product', 'Shipping')                 NOT NULL,
	max_discount    DECIMAL(10,2),
	discount_pct    DECIMAL(5,2),
	store_id        INT,
	FOREIGN KEY (store_id) REFERENCES Stores(id)
);


DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (
	id               INT             AUTO_INCREMENT              PRIMARY KEY,
	buyer_id         INT                                         NOT NULL,
	date             TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   NOT NULL,
	total_qtt        INT             DEFAULT 0                   NOT NULL,
	shipping_address VARCHAR(255)                                NOT NULL,
	contact_phone    VARCHAR(15),

	FOREIGN KEY (buyer_id, shipping_address, contact_phone) 
            REFERENCES ShippingInfo(buyer_id, address, phone)
);


DROP TABLE IF EXISTS OrderItems;
CREATE TABLE IF NOT EXISTS OrderItems (
	order_id        INT                                         NOT NULL,
	product_id      INT                                         NOT NULL,        
	quantity        INT                                         NOT NULL,
	unit_price      DECIMAL(10,2)                               NOT NULL,

	FOREIGN KEY (order_id) REFERENCES Orders(id),
	FOREIGN KEY (product_id) REFERENCES Products(id),
    PRIMARY KEY (order_id, product_id)
);


DROP TABLE IF EXISTS Invoices;
CREATE TABLE IF NOT EXISTS Invoices ( -- Weak entity of Orders
	id              INT             AUTO_INCREMENT              NOT NULL,
	order_id        INT                                         NOT NULL,
	invoice_date    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   NOT NULL,
	total_amount    DECIMAL(10,2)                               NOT NULL,
	
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    PRIMARY KEY (id, order_id)
);


DROP TABLE IF EXISTS ShippingBoxes;
CREATE TABLE IF NOT EXISTS ShippingBoxes ( -- Weak entity of Invoices
	id               INT             AUTO_INCREMENT              NOT NULL,
	invoice_id       INT                                         NOT NULL,
	packing_date     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   NOT NULL,
	special_notes    TEXT,
	status           ENUM('Pending', 'Shipped', 'Delivered')     DEFAULT 'Pending',
	shipping_cost    DECIMAL(10,2)                               NOT NULL,
    shipping_company VARCHAR(255)                                NOT NULL,
    delivery_person  VARCHAR(255)                                NOT NULL,

    FOREIGN KEY (invoice_id) REFERENCES Invoices(id),
    PRIMARY KEY (id, invoice_id)
);



DROP TABLE IF EXISTS ProductReviews;
CREATE TABLE IF NOT EXISTS ProductReviews (
	product_id      INT                                          NOT NULL,    
	user_id         INT                                          NOT NULL,
    date            TIMESTAMP         DEFAULT CURRENT_TIMESTAMP  NOT NULL,
    rating          INT               CHECK(rating BETWEEN 1 AND 5),
	review_text     TEXT,

	FOREIGN KEY (product_id) REFERENCES Products(id),
	FOREIGN KEY (user_id) REFERENCES Users(id),
    
    PRIMARY KEY (product_id, user_id, date)
);