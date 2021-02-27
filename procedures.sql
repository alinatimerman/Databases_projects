USE AGAIN
GO

--ADD COLUMN
CREATE OR ALTER PROCEDURE edit1
AS
BEGIN
ALTER TABLE Products
ADD price2 INT
PRINT 'new column "price" was added'
END
GO

EXEC edit1
GO
SELECT * FROM Products
GO

CREATE OR ALTER PROCEDURE edit2
AS
BEGIN
ALTER TABLE Stores
ADD number INT
PRINT 'column "number" added'
END
GO

EXEC edit2
GO
SELECT * FROM Stores
GO


--DELETE COLUMN
CREATE OR ALTER PROCEDURE undo_edit1
AS
BEGIN
ALTER TABLE Products
DROP COLUMN price2 
PRINT 'new column "price" was removed'
END
GO

EXEC undo_edit1
GO
SELECT * FROM Products
GO

CREATE OR ALTER PROCEDURE undo_edit2
AS
BEGIN
ALTER TABLE Stores
DROP COLUMN number
END
GO

EXEC undo_edit2
GO
SELECT * FROM Stores
GO

--ADD/DELETE PRIMARY KEY

CREATE OR ALTER PROCEDURE edit3
AS
BEGIN
ALTER TABLE Delivery
DROP CONSTRAINT PK_Delivery
END
GO

EXEC edit3
GO
SELECT * FROM Delivery
GO

CREATE OR ALTER PROCEDURE undo_edit3
AS
BEGIN
ALTER TABLE Delivery
ADD CONSTRAINT PK_Delivery PRIMARY KEY(ID)
END
GO

EXEC undo_edit3
GO
SELECT * FROM Delivery
GO



--DELETE/ADD FOREIGN KEY
CREATE OR ALTER PROCEDURE edit4
AS 
BEGIN
ALTER TABLE Car
ADD CONSTRAINT FK_DeliveryCar FOREIGN KEY(ID) REFERENCES Delivery(ID)
END
GO

EXEC edit4
GO
SELECT * FROM Car
GO

CREATE OR ALTER PROCEDURE undo_edit4
AS
BEGIN
ALTER TABLE Car
DROP CONSTRAINT FK_DeliveryCar
END 
GO

EXEC undo_edit4
GO
SELECT * FROM Car
GO

--CREATE/DROP TABLE 
CREATE OR ALTER PROCEDURE edit5
AS
BEGIN
CREATE TABLE Managers(
    manager_id int not null primary key,
    name varchar(30) not null,
    store_id int foreign key references Stores(store_id))
	insert into Managers(manager_id,name) values (72, 'Ana Davidescu'),(84,'Ioana Pop'), (331,'Daniel Radu')
print 'the new table has been added'
end 
go

exec edit5
go
select * from Managers 
go

create or alter procedure undo_edit5
as
begin
drop table Managers
print 'The new table "Managers" deleted'
end
go


create table currentVersion(current_version int)
insert into currentVersion(current_version) values(0)
go


create table versionTable(
id int primary key,
doing varchar(50) not null,
undoing varchar(50) not null)
go

drop table versionTable

insert into versionTable(id,doing,undoing) values (1,'exec edit1','exec undo_edit1'),
												  (2,'exec edit2','exec undo_edit2'),
												  (3,'exec edit3','exec undo_edit3'),
												  (4,'exec edit4','exec undo_edit4'),
												  (5,'exec edit5','exec undo_edit5');
go


create or alter procedure main @version int 
as
begin
if((@version>=0) and (@version<(select count(*)from versionTable)))
begin
	while (select current_version from currentVersion) != @version
	begin
		if(select current_version from currentVersion)> @version
			begin

			declare @statement as nvarchar(200)=(select v.undoing from versionTable v, currentVersion c where c.current_version=v.id);
			execute sp_executesql @statement;
			update currentVersion set current_version=current_version-1;

			end
		else
			begin
		 
			update currentVersion set current_version=current_version+1;
			declare @anotherStatement as nvarchar(200)=(select v.doing from versionTable v, currentVersion c where c.current_version=v.id);
			execute sp_executesql @anotherStatement;
		
			end
	end
end
else
	begin
	print 'Version not available, please try again'
	end
end
go

exec main 1
go

Select * from Managers

update currentVersion set current_version=0
go
select current_version from currentVersion
go


