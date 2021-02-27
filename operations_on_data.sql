GO
USE AGAIN
GO

--insertion
--inserting into Customers
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Adelina','Popescu','0234567777','Ploiesti','str.1 Mai')
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Andrei','Dorin','083452312','Bucuresti','str. Dorobantilor')
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Ioana','Andreescu','0789654322','Bacau','str. Seciului')
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Daniel','Radeanu','09087655887','Baia Mare','str. Bolovani')
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Diana','Nicolae','0564297654','Zalau','str. 1907')
INSERT INTO Customers(first_name, last_name,phone,city, street) VALUES ('Robert','Stefanescu','0277324591','Constanta','str. Caraiman')

--insert into Stores
INSERT INTO Stores(name,city,street) VALUES ('Store1', 'Brasov','str. Avram Iancu')
INSERT INTO Stores(name,city,street) VALUES ('Store2', 'Suceava','str. Mihai Eminescu')
INSERT INTO Stores(name,city,street) VALUES ('Store3', 'Cluj Napoca','str. Piezisa')
INSERT INTO Stores(name,city,street) VALUES ('Store4', 'Craiova','str. 1907')
INSERT INTO Stores(name,city,street) VALUES ('Store5', 'Timisoara','str.Revolutiei')

--insert into Category
INSERT INTO Category (name) VALUES ('Inele')
INSERT INTO Category (name) VALUES ('Bratari')
INSERT INTO Category (name) VALUES ('Coliere')
INSERT INTO Category (name) VALUES ('Pandantive')
INSERT INTO Category (name) VALUES ('Brose')

--insert into Products
INSERT INTO Products(name,quantity,category_id) VALUES ('Inel onix', 22,1)
INSERT INTO Products(name,quantity,category_id) VALUES ('Inel argint',17,1)
INSERT INTO Products(name,quantity,category_id) VALUES ('Bratara cu cristale', 10,2)
INSERT INTO Products(name,quantity,category_id) VALUES ('Colier argint', 10,3)
INSERT INTO Products(name,quantity,category_id) VALUES ('Pandantiv cu broscuta', 16,4)
INSERT INTO Products(name,quantity,category_id) VALUES ('Brosa cu fluture', 10,5)
INSERT INTO Products(name,quantity,category_id) VALUES ('Bratara din aur', 7,2)

--insert into Orders
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (2,3,5,'DELIVERED')
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (1,2,6,'DELIVERED')
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (3,1,2,'IN PROGRESS')
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (6,4,5,'DELIVERED')
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (4,2,7,'IN PROGRESS')
INSERT INTO Orders(customer_id,store_id,product_id,order_status) VALUES (5,5,1,'RECEIVED')

--insert into Staff
INSERT INTO Staff(first_name,last_name,store_id) VALUES ('Rares','Mihaiescu',1)
INSERT INTO Staff(first_name,last_name,store_id) VALUES ('Mihaela','Voiculescu',2)
INSERT INTO Staff(first_name,last_name,store_id) VALUES ('Valeria','Stan',3)
INSERT INTO Staff(first_name,last_name,store_id) VALUES ('Stefan','Dinescu',4)
INSERT INTO Staff(first_name,last_name,store_id) VALUES ('Daniela','Olariu',5)

--insert into Products_Customers
INSERT INTO Products_Customers(customer_id,product_id) VALUES (2,5)
INSERT INTO Products_Customers(customer_id,product_id) VALUES (1,6)
INSERT INTO Products_Customers(customer_id,product_id) VALUES (3,2)
INSERT INTO Products_Customers(customer_id,product_id) VALUES (6,5)
INSERT INTO Products_Customers(customer_id,product_id) VALUES (4,7)
INSERT INTO Products_Customers(customer_id,product_id) VALUES (5,1)

SELECT * FROM Customers
SELECT * FROM Stores
SELECT * FROM Category
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Staff
SELECT * FROM Products_Customers

--UPDATE
SELECT * FROM Customers
UPDATE Customers
SET street='str. Mihail Kogalniceanu' WHERE street='str.1 Mai'
SELECT * FROM Customers

SELECT* FROM Orders
UPDATE Orders
SET order_status='DELIVERED' WHERE order_status='RECEIVED'
SELECT * FROM Orders

--SELECT STATEMENTS
--a
--UNION : displays all customers and staff alphabetically ordered by last_name
SELECT last_name FROM Customers
UNION
SELECT last_name FROM Staff
ORDER BY last_name asc

--INTERSECT: displays products which were ordered
SELECT product_id FROM Orders
INTERSECT
SELECT product_id FROM Products

--EXCEPT: displays products which were not ordered
SELECT product_id FROM Orders
EXCEPT
SELECT product_id FROM Products

--b
--INNER JOIN: displays stores which got orders and staff
SELECT store_id FROM Orders WHERE Orders.store_id in (SELECT Staff.store_id FROM (Staff INNER JOIN Stores ON Staff.store_id=Stores.store_id)) 
													
--LEFT JOIN: display products which got ordered
SELECT Products.Name, Orders.product_id
FROM Products
LEFT JOIN Orders ON Products.product_id=Orders.product_id

--RIGHT JOIN: display customers which ordered
SELECT Customers.first_name, Orders.customer_id
FROM Customers
LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id

--FULL JOIN: displays all employeeswho work at the stores
SELECT Staff.first_name,Staff.last_name, Stores.store_id
	FROM Staff
	FULL JOIN Stores on Stores.store_id=Staff.store_id

--c
--displays the products that weren't ordered
SELECT Products.name FROM Products
WHERE Products.product_id not in(SELECT Orders.product_id FROM Orders)
--displays the products that were ordered
SELECT Products.name FROM Products
WHERE exists (SELECT Orders.product_id FROM Orders WHERE Orders.product_id=Products.product_id)

--d
--display the name of the customers that haven't ordered
SELECT Customers.last_name FROM Customers
WHERE Customers.customer_id not in(SELECT Orders.customer_id from Orders)

--e
--display the biggest quantity of a product 
SELECT max(quantity) FROM Products 
GROUP BY product_id
HAVING count(product_id)>=1

--display the number of all products in the shops
SELECT sum(quantity) FROM Products
GROUP BY product_id

--display the smallest quantity of a product
SELECT min(quantity) FROM Products 
GROUP BY product_id
HAVING count(product_id)>=1

--DELETE AND RESET IDENTITY
DELETE FROM Products WHERE product_id>=0
dbcc checkident('Products', reseed, 0)

DELETE FROM Staff WHERE staff_id>=0
dbcc checkident('Staff', reseed, 0)

DELETE FROM Customers WHERE customer_id>=0
dbcc checkident('Customers', reseed, 0)

DELETE FROM Stores WHERE store_id>=0
dbcc checkident('Stores', reseed, 0)

DELETE FROM Orders WHERE order_id>=0
dbcc checkident('Orders', reseed, 0)

DELETE FROM Category WHERE category_id>=0
dbcc checkident('Category', reseed, 0)

DELETE FROM Products_Customers WHERE product_id>=0 AND customer_id>=0
dbcc checkident('Products_Customers', reseed, 0)