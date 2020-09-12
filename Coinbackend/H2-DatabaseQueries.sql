DROP ALL OBJECTS;

CREATE TABLE category (
	id IDENTITY,
	name VARCHAR(50),
	description VARCHAR(255),
	image_url VARCHAR(50),
	is_active BOOLEAN,
	CONSTRAINT pk_category_id PRIMARY KEY (id) 

);

CREATE TABLE user_detail (
	id IDENTITY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	role VARCHAR(50),
	enabled BOOLEAN,
	password VARCHAR(60),
	email VARCHAR(100),
	contact_number VARCHAR(15),	
	CONSTRAINT pk_user_id PRIMARY KEY(id)
);

CREATE TABLE product (
	id IDENTITY,
	code VARCHAR(20),
	name VARCHAR(50),
	year VARCHAR(50),
	detail VARCHAR(100),
	description VARCHAR(255),
	unit_price DECIMAL(10,2),
	quantity INT,
	is_active BOOLEAN,
	category_id INT,
	supplier_id INT,
	purchases INT DEFAULT 0,
	views INT DEFAULT 0,
	CONSTRAINT pk_product_id PRIMARY KEY (id),
 	CONSTRAINT fk_product_category_id FOREIGN KEY (category_id) REFERENCES category (id),
	CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES user_detail(id)	
);	

-- the address table to store the user billing and shipping addresses
CREATE TABLE address (
	id IDENTITY,
	user_id int,
	address_line_one VARCHAR(100),
	address_line_two VARCHAR(100),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(10),
	is_billing BOOLEAN,
	is_shipping BOOLEAN,
	CONSTRAINT fk_address_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_address_id PRIMARY KEY (id)
);

-- the cart table to store the user cart top-level details
CREATE TABLE cart (
	id IDENTITY,
	user_id int,
	grand_total DECIMAL(10,2),
	cart_lines int,
	CONSTRAINT fk_cart_user_id FOREIGN KEY (user_id) REFERENCES user_detail (id),
	CONSTRAINT pk_cart_id PRIMARY KEY (id)
);

-- the cart line table to store the cart details
CREATE TABLE cart_line (
	id IDENTITY,
	cart_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	is_available boolean,
	CONSTRAINT fk_cartline_product_id FOREIGN KEY (product_id) REFERENCES product (id),
	CONSTRAINT pk_cartline_id PRIMARY KEY (id)
);

-- the order detail table to store the order
CREATE TABLE order_detail (
	id IDENTITY,
	user_id int,
	order_total DECIMAL(10,2),
	order_count int,
	shipping_id int,
	billing_id int,
	order_date date,
	CONSTRAINT fk_order_detail_user_id FOREIGN KEY (user_id) REFERENCES user_detail (id),
	CONSTRAINT fk_order_detail_shipping_id FOREIGN KEY (shipping_id) REFERENCES address (id),
	CONSTRAINT fk_order_detail_billing_id FOREIGN KEY (billing_id) REFERENCES address (id),
	CONSTRAINT pk_order_detail_id PRIMARY KEY (id)
);

-- the order item table to store order items
CREATE TABLE order_item (
	id IDENTITY,
	order_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	CONSTRAINT fk_order_item_product_id FOREIGN KEY (product_id) REFERENCES product (id),
	CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES order_detail (id),
	CONSTRAINT pk_order_item_id PRIMARY KEY (id)
);


-- adding three categories
INSERT INTO category (name, description,image_url,is_active) VALUES ('Indian Collection', 'This is description for indian Coins!', 'CAT_1.png', true);
INSERT INTO category (name, description,image_url,is_active) VALUES ('Forign Collection', 'This is description for abroad!', 'CAT_2.png', true);
INSERT INTO category (name, description,image_url,is_active) VALUES ('Other Collection', 'This is description for Other Collection!', 'CAT_3.png', true);
-- adding three users 
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Ashish', 'Sharma', 'ADMIN', true, '$2a$06$ORtBskA2g5Wg0HDgRE5ZsOQNDHUZSdpJqJ2.PGXv0mKyEvLnKP7SW', 'as@gmail.com', '8888888888');
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Ravindra', 'Jadeja', 'SUPPLIER', true, '$2a$06$bzYMivkRjSxTK2LPD8W4te6jjJa795OwJR1Of5n95myFsu3hgUnm6', 'rj@gmail.com', '9999999999');
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Ravichandra', 'Ashwin', 'SUPPLIER', true, '$2a$06$i1dLNlXj2uY.UBIb9kUcAOxCigGHUZRKBtpRlmNtL5xtgD6bcVNOK', 'ra@gmail.com', '7777777777');
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Khozema', 'Nullwala', 'USER', true, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'kn@gmail.com', '7777777777');

-- adding five products
INSERT INTO product (code, name, year,deatil, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('A1947', ' Indian British(Standard circulation coin)', '1947', 'Weight :11.g , Diameter:22mm, Thickness:2.48mm, Shape: Round','T1 Rupee( Crowed head George VI facing left )', 1850.00, 1, true, 1, 3, 1, 5);
INSERT INTO product (code, name, year, detail,description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('A1984', 'Circulating Commememorative Coin', '1985','Weight :12.6g , Diameter:31.1g, Thickness:2.3mm, Shape: Round', 'Commemorative issue :Death og indira Ghandi -statesperson ,1917-1984', 300, 2, true, 1, 1, 0, 0 );
INSERT INTO product (code, name, year,detail, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('B1947', ' One(1) Rupee (Standard Circulation Coin)', '1947','Weight :12.6g , Diameter:31.1g, Thickness:2.3mm, Shape: Round', '5 Rupee Coin with  Crowed head George vi facing left', 200, 2, false, 1, 1, 0, 0 );
INSERT INTO product (code, name, year, detail,description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('A1955', 'indian (Standard Circulation Coin)', '1950-1955','Weight :2.916g , Diameter:21mm, Thickness:1.14mm, Shape: Round', '1 Pice(1/64) -1955 Ashoka Lion Capital', 3400, 2, true, 1, 2, 0, 2 );
INSERT INTO product (code, name, year,detail,  description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('AF2004', '1 cent with 2 maple leaves on the same twig', '2004', 'Weight :2.2500 g , Diameter:19.05 mm, Thickness:1.45 mm, Shape: Round','The maple leaf is a proud and distinctive Canadian symbol', 5000, 3, true, 2, 1, 0, 0 );
INSERT INTO product (code, name, year,detail,  description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('BF1980', 'Canada Elizabeth II(Standard  Circulation Coin)', '1965-1980', 'Weight :4.54 grams , Diameter: 21.2 mm, Thickness:1.75 mm, Shape: Round','The portrait in right profile of Elizabeth II, when she was 39 years old.', 4000, 3, true, 2, 1, 0, 0 );
INSERT INTO product (code, name, year,detail,  description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('A1981', ' 10 paisa Indian (Commemorative Coin)', '1981', 'Weight :2.3g , Diameter:26mm, Thickness:2mm, Shape: Scallop','This coin shows the FAO -World Food Day (Republic of indian 1957-2019)', 300, 2, true, 1, 1, 0, 0 );
INSERT INTO product (code, name, year,detail,  description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('A1928', ' 1 Pice = 1/4 Anna  Indian-British', '1912-1936', 'Weight :4.85 g , Diameter:25.4 mm, Thickness:1.35 mm, Shape: Round','King George V crowned head left, legend in English, toothed rim', 500, 1, true, 1, 1, 0, 0 );






-- adding a supplier correspondece address
INSERT INTO address( user_id, address_line_one, address_line_two, city, state, country, postal_code, is_billing, is_shipping) 
VALUES (4, '102 Sabarmati Society, Mahatma Gandhi Road', 'Near Salt Lake, Gandhi Nagar', 'Ahmedabad', 'Gujarat', 'India', '111111', true, false );
-- adding a cart for testing 
INSERT INTO cart (user_id, grand_total, cart_lines) VALUES (4, 0, 0);

