use AGAIN
go

--1. implement a stored procedure for the INSERT operation on a table;
--the procedure’s parameters should describe the entities / relationships
--in the table; the procedure should use at least 2 user-defined functions
--to validate certain parameters;

--user defined function no1: checks if the variable is a positive number
	create or alter function checkInt(@no int)
	returns bit as
	begin
		declare @n bit
		if @no>=0 
			set @n=1
		else
			set @n=0
		return @n
	end
	go 

--checks if the variable contains at least one character
create or alter function checkVarchar(@sname varchar(50))
returns bit as
begin
	declare @b bit
	if @sname LIKE '[a-z]%' OR @sname like '[A-Z]%'
		set @b=1
	else
		set @b=0
	return @b
end
go


create or alter procedure addCustomers @first_name varchar(255), @last_name varchar(255),@phone varchar(255),@city varchar(255), @street varchar(255)
as
begin
if dbo.checkVarchar(@first_name)=1 and dbo.checkVarchar(@last_name)=1 
	begin
		insert into Customers(first_name,last_name,phone,city,street) values ( @first_name, @last_name, @phone, @city,@street)
		print 'values added'
		select * from Customers
	end
else
	begin
		print 'the parameters are not correct, try again'
		select * from Customers
	end
end
go

exec addCustomers  @first_name='Andreescu', @last_name='Radu', @phone='0876557687', @city='Ploiesti',@street='str.Cuza Voda'
exec addCustomers  @first_name='Paulescu', @last_name='Mihaela', @phone='023567662', @city='Oradea',@street='str.Ardealului'


create or alter procedure addProducts @name varchar(255), @quantity int
as
begin
if dbo.checkInt(@quantity)=1 and dbo.checkVarchar(@name)=1
	begin
		insert into Products(name,quantity) values (@name,@quantity)
		print 'values added'
		select * from Products
	end
else
	begin
		print 'error'
		select * from Customers
	end
end
go

exec addProducts @name='Inel din aur', @quantity=22

--2. create a view that operates on at least 4 tables; write a SELECT on the view returning information that
--is useful to a potential user; 
--select the name of the customers who ordered products from category 2

create or alter view oneView
as
select Customers.first_name, Customers.last_name
from Category, Customers,Orders, Products
where Category.category_id=2
and Products.category_id=Category.category_id
and Orders.product_id=Products.product_id
and Customers.customer_id=Orders.customer_id
go

select * from oneView
go

--3.implement a trigger for a table for insert update delete
create table Logs(
TriggerDate date,
TriggerType varchar(50),
NameAffectedTable varchar(50),
NoAMDRows int)

select * from Logs
go

delete from Logs
go


create table CustomersCopy(
	customers_id int primary key not null,
	first_name varchar(30),
	last_name varchar(30),
	phone varchar(30),
	city varchar(30),
	street varchar(30))
go



create or alter trigger Add_Customers ON Customers for insert as
begin
	insert into CustomersCopy(customers_id,first_name, last_name, phone, city, street)
	select * 
	from inserted
	
	insert into Logs(TriggerDate, TriggerType,NameAffectedTable, NoAMDRows)
	values (GETDATE(), 'INSERT', 'Customers', @@ROWCOUNT)
	
end
go

create or alter trigger Delete_Customers ON Customers for delete as
begin
	 insert into Logs(TriggerDate, TriggerType,NameAffectedTable, NoAMDRows)
	 values (GETDATE(), 'DELETE', 'Customers', @@ROWCOUNT)
	
end
go

exec addCustomers @first_name='a', @last_name='b', @phone='c',@city='d',@street='e'
insert into Customers(first_name,last_name,phone,city,street) values ('Adelina','Moraru','77643997','Deva','str. Eroilor')
insert into Customers(first_name,last_name,phone,city,street) values ('Alex','David','907654','Botosani','str. Mihai Eminescu')
SELECT * FROM Logs
select * from Customers

delete from Customers where Customers.city='d'

create or alter trigger Update_Customers ON Customers for update as
begin
	 insert into Logs(TriggerDate, TriggerType,NameAffectedTable, NoAMDRows)
	values (GETDATE(), 'UPDATE', 'Customers', @@ROWCOUNT)
	
end
go

update Customers
set phone='1234567'
where phone='023567662'
go
SELECT * FROM Logs
select * from Customers