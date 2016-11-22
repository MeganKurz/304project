DROP TABLE OrderedProduct;
DROP TABLE Invoice;
DROP TABLE Rating;
DROP TABLE Grow;
DROP TABLE WorksAt;
DROP TABLE Greenhouse;
DROP TABLE Employee;
DROP TABLE Account;
DROP TABLE warehouse;
DROP TABLE Product;
DROP TABLE CactiSpecies;


CREATE TABLE Account (
username  VARCHAR(50),
pass  VARCHAR(50) NOT NULL,
fullName  VARCHAR(50) NOT NULL,
billingAddress  VARCHAR(100) NOT NULL,
shippingAddres  VARCHAR(100) NOT NULL,
preferredPayment  VARCHAR(75),
accountType  VARCHAR(10) CHECK (accountType IN ('Customer', 'Admin', 'Supervisor')),
email  VARCHAR(75) NOT NULL,
phone  VARCHAR(10),
PRIMARY KEY(username));

CREATE TABLE Warehouse (
     whouseName  VARCHAR(20),
     whouseLocation  VARCHAR(80) NOT NULL,
     PRIMARY KEY (whouseName));

CREATE TABLE Invoice (
orderId  INT IDENTITY NOT NULL,
totalAmount  DECIMAL(9,2) CHECK (totalAmount>=0),
weight  DECIMAL(9, 3) CHECK (weight>=0),
orderDate  DATE NOT NULL,
paymentType  VARCHAR(50),
shipDate  DATE NOT NULL,
shipType  VARCHAR(50) NOT NULL,
expectedDelivery  DATE,
accountUsername  VARCHAR(50) NOT NULL,
whouseName  VARCHAR(20) NOT NULL,
PRIMARY KEY (orderId),
CONSTRAINT FK_Invoice_Account FOREIGN KEY (accountUsername) REFERENCES Account(username),
CONSTRAINT FK_Invoice_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName));
    
 CREATE TABLE CactiSpecies (
species  VARCHAR(50) PRIMARY KEY,
food  VARCHAR(50) NOT NULL,
sunLevel  INTEGER CHECK (sunLevel BETWEEN 1 and 10),
waterLevel  INTEGER CHECK (waterLevel BETWEEN 1 and 10));   

CREATE TABLE Product (
productId  INT IDENTITY NOT NULL,
weight  DECIMAL(5,2) NOT NULL,
productName  VARCHAR(50) NOT NULL,
species VARCHAR(50),
price  DECIMAL (9,2) NOT NULL,
Inventory  INTEGER,
PRIMARY KEY (productId),
CONSTRAINT FK_Product_CactiSpecies FOREIGN KEY (species) REFERENCES CactiSpecies (species));


CREATE TABLE OrderedProduct (
productId    INT,
orderId  INT,
quantity  INTEGER CHECK (quantity >= 0),
PRIMARY KEY (productId, orderId),
CONSTRAINT FK_OrderedProduct_Product FOREIGN KEY (productId) REFERENCES Product (productId),
CONSTRAINT FK_OrderedProduct_Invoice FOREIGN KEY (orderId) REFERENCES Invoice (orderId));



CREATE TABLE Greenhouse (
ghouseId   VARCHAR(50),
ghouseLocation   VARCHAR(80) NOT NULL,
whouseName VARCHAR(20) NOT NULL,
PRIMARY KEY (ghouseId),
CONSTRAINT FK_Greenhouse_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse (whouseName));
    

CREATE TABLE Grow (
ghouseId  VARCHAR(50),
species  VARCHAR(50),
PRIMARY KEY (ghouseId, species),
CONSTRAINT FK_Grow_Greenhouse FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId),
CONSTRAINT FK_Grow_CactiSpecies FOREIGN KEY (species) REFERENCES CactiSpecies (species));


CREATE TABLE Rating(
accountUser  VARCHAR(50),
productId  INT, 
stars  INTEGER CHECK(stars BETWEEN 0 and 5),
review  VARCHAR(150),
PRIMARY KEY(accountUser, productId),
CONSTRAINT FK_Rating_Product FOREIGN KEY(productId) REFERENCES Product(productId),
CONSTRAINT FK_Rating_Account FOREIGN KEY(accountUser) REFERENCES Account(username));


CREATE TABLE Employee (
empId  VARCHAR(50),
empName  VARCHAR(50) NOT NULL,
title  CHAR(2) CHECK (title IN ('AD', 'SP', 'GH', 'WH')),
empSuperId  VARCHAR(50),
whouseName  VARCHAR(20),
PRIMARY KEY(empId),
CONSTRAINT FK_Employee_Warehouse FOREIGN KEY (whouseName) REFERENCES Warehouse(whouseName),
CONSTRAINT FK_Employee_Employee FOREIGN KEY (empSuperId) REFERENCES Employee(empId));
    
    
CREATE TABLE WorksAt (
ghouseId  VARCHAR(50),
empId  VARCHAR(50),
PRIMARY KEY(ghouseId, empId),
CONSTRAINT FK_WorksAt_Greenhouse FOREIGN KEY (ghouseId) REFERENCES Greenhouse (ghouseId),
CONSTRAINT FK_WorksAt_Employee FOREIGN KEY (empId) REFERENCES Employee (empId));

