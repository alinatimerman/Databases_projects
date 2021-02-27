--on Customers
--fnd an existing index named index1 and delete if found
IF EXISTS (SELECT name FROM sys.indexes WHERE NAME='index_Customers_phone')
DROP INDEX index_Customers_phone ON Customers
GO

--create a non clustered index called index_Customers_phone using the phone column
CREATE NONCLUSTERED INDEX index_Customers_phone ON Customers(phone)

--INCLUDE LIVE QUERY STATISTICS