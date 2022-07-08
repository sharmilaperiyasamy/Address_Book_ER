--uc1 create Address book service database

create database Address_Book_Service;
use Address_Book_Service;

--uc2 create table address book table

create table Address_Book
(
PersonId int not null identity primary key,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Address varchar(200) not null,
City varchar(50) not null,
State varchar(50) not null,
Zip int not null,
Phone_no varchar(20) not null,
Email varchar(50) not null
);

select * from Address_Book;

--uc3 insert contacts to the table Address book

insert into Address_Book(FirstName,LastName,Address,City,State,Zip,Phone_no,Email) values
('Akash','Kumar','Palakod','Dharmapuri','TamilNadu','678095','7683898484','akashkumar@gmail.com'),
('Praneesh','Raj','Avinashi','Tirupur','TamilNadu','356627','3276767328','pranees298@yahoo.com'),
('Regina','Joseph','Salem','Salem','Tamilnadu','637501','1789899890','regina2119@gmail.com'),
('Siva','Kumar','Namakkal','Namakkal','Tamilnadu','216787','3172817287','sivakumar334@gmail.com');

--uc4 edit contact using their name

update Address_Book set LastName = 'Vani' where FirstName = 'Akash';

--uc5 delete a contact using name

delete from Address_Book where FirstName = 'Praneesh';

--uc6 ability to retrieve person name using state or city

select FirstName, LastName from Address_Book where state = 'Tamilnadu';

select FirstName, LastName from Address_Book where city = 'Salem';

--uc7 size of address book by city and state

select count(City) from Address_Book;

select City, count(*) as AddressCount from Address_Book GROUP BY City;

select count(State) from Address_Book;

select State, count(*) as AddressCount from Address_Book GROUP BY State;

--uc8 ability to sort alphabetically for the given city


insert into Address_Book(FirstName,LastName,Address,City,State,Zip,Phone_no,Email) values
('Praveen','Kumar','Tiruchengode','Namakkal','TamilNadu','678095','7683898484','Praveenkumar@gmail.com');

Select * from Address_Book where City = 'Namakkal' order by FirstName;

--uc9 add columns name and type

alter table Address_Book 
add name varchar(50),
Persontype varchar(50);

update Address_Book set PersonType = 'Family' where PersonId = 1;
update Address_Book set name = 'Orthodox' where PersonId = 1;
update Address_Book set PersonType = 'Profession', name = 'Engineer' where PersonId = 3;
update Address_Book set PersonType = 'Friends', name = 'VIP' where PersonId = 4;
update Address_Book set PersonType = 'Friends', name = 'VIP' where PersonId = 5;

--uc10 count by type

select count(PersonType) from Address_Book;

select PersonType, count(*) from Address_Book group by PersonType;

--uc11 add person to both family and friend

insert into Address_Book(FirstName,LastName,Address,City,State,Zip,Phone_no,Email,name,Persontype) values
('Ragu','Ram','Salem','Salem','TamilNadu','677999','2132474839','raguram122@yahoo.com','Shashtri','Family'),
('Deepa','Kumari','Hosur','Hosur','TamilNadu','327222','3267287878','deeepakumari@gmail.com','VIP','Friends');

--uc12 er diagram

create table PersonType
(
PersonTypeId int not null identity primary key,
type varchar(50) not null
);

select * from PersonType;

insert into PersonType(type) values ('Family'),('Profession'),('Friends');

create table FamilyName
(
FamilyId int not null identity primary key,
Name varchar(50) not null
);

--drop table FamilyName;

insert into FamilyName(Name) values ('Orthodox'),('Shashtri');

select * from FamilyName;

create table Address
(
AddressId int not null primary key Identity,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Address varchar(200) not null,
City varchar(50) not null,
State varchar(50) not null,
Zip int not null,
PhoneNumber varchar(20) not null
);

insert into Address(FirstName,LastName,Address,City,State,Zip,PhoneNumber) values
('Akash','Kumar','Palakod','Dharmapuri','TamilNadu','678095','7683898484'),
('Praneesh','Raj','Avinashi','Tirupur','TamilNadu','356627','3276767328'),
('Regina','Joseph','Salem','Salem','Tamilnadu','637501','1789899890'),
('Siva','Kumar','Namakkal','Namakkal','Tamilnadu','216787','3172817287'),
('Ragu','Ram','Salem','Salem','TamilNadu','677999','2132474839'),
('Deepa','Kumari','Hosur','Hosur','TamilNadu','327222','3267287878');

select * from Address;

--Adding constraints to tables

create table Address_Book_Details
(
AddressId int,
FamilyId int,
PersonTypeId int,
PersonId int,
constraint Address_pk Primary key (AddressId, FamilyId, PersonTypeId, PersonId),
constraint fk_Address_details foreign key (AddressId) references Address(AddressId),
constraint fk_Family foreign key (FamilyId) references FamilyName(FamilyId),
constraint fk_type foreign key (PersonTypeId) references PersonType(PersonTypeId),
constraint fk_Person foreign key (PersonId) references Address_Book(PersonId)
);

select * from Address_Book_Details;

insert into Address_Book_Details(AddressId,FamilyId,PersonTypeId,PersonId) values (1,1,1,1);

select AddressId,Email from Address,Address_Book where Address_Book.PersonId = Address.AddressId;


select count(City) from Address_Book;

select City, count(*) as AddressCount from Address_Book GROUP BY City;

--Stored Procedure
go
CREATE PROCEDURE StoreProcedureAddressBook
(
@FirstName VARCHAR(25),
@LastName VARCHAR(30),
@Address varchar(200),
@City VARCHAR(30),
@State varchar(30),
@Zip int,
@Phone_no VARCHAR(50),
@Email varchar(30),
@Name varchar(30),
@Type varchar(30)
)
AS
BEGIN
INSERT INTO Address_Book VALUES(@FirstName,@LastName,@Address,@City,@State,@Zip,@Phone_no,@Email,@Name,@Type)
END

--drop procedure StoreProcedureAddressBook;
delete from PersonType where PersonTypeId=5;