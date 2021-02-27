--on Customers
--fnd an existing index named index1 and delete if found
IF EXISTS (SELECT name FROM sys.indexes WHERE NAME='index_Products_quantity')
DROP INDEX index_Products_quantity ON Products
GO

--create a non clustered index
CREATE NONCLUSTERED INDEX index_Products_quantity ON Products(quantity)
GO

SELECT * FROM Products where quantity=22
GO
SELECT * FROM Products ORDER BY quantity
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE NAME='index_Customers_city')
DROP INDEX index_Customers_city ON Customers
GO
CREATE NONCLUSTERED INDEX index_Customers_city ON Customers(city)
GO
SELECT * FROM Customers where city='Deva'
GO
SELECT * FROM Customers ORDER BY city
GO



