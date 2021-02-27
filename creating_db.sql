CREATE TABLE Customers(
	customer_id INT IDENTITY (1,1) PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	phone VARCHAR(255),
	city VARCHAR(255),
	street VARCHAR(255))


CREATE TABLE Stores(
	store_id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	city VARCHAR(255) NOT NULL,
	street VARCHAR(255) NOT NULL,)

CREATE TABLE Category(
	category_id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(255))

CREATE TABLE Products(
	product_id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	quantity INT NOT NULL,
	category_id INT,
	FOREIGN KEY(category_id)
	REFERENCES Category(category_id))

CREATE TABLE Orders(
	order_id INT IDENTITY (1,1) PRIMARY KEY,
	customer_id INT,
	store_id INT,
	product_id INT,
	order_status VARCHAR(255)
	FOREIGN KEY(customer_id)
	REFERENCES Customers (customer_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) 
	REFERENCES Stores(store_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id)
	REFERENCES Products(product_id)
	ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE Staff(
	staff_id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	store_id INT,
	FOREIGN KEY(store_id)
	REFERENCES Stores(store_id))

CREATE TABLE Products_Customers(
	customer_id INT,
	product_id INT,
	FOREIGN KEY (customer_id)
	REFERENCES Customers(customer_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(product_id)
	REFERENCES Products(product_id)
	ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE Delivery(
	ID INT NOT NULL,
	Name VARCHAR(255) NOT NULL,
	Number INT NOT NULL,
	CONSTRAINT PK_Delivery PRIMARY KEY(ID,Name))
SELECT * FROM Delivery

CREATE TABLE Car(
	ID INT PRIMARY KEY NOT NULL,
	NUMBER INT)
SELECT * FROM Car
	




