DROP DATABASE IF EXISTS Products;

CREATE DATABASE Products;

USE listings;

CREATE TABLE Property
(
   address varchar(50) PRIMARY KEY,
   ownerName varchar(30),
   price INTEGER,
);

CREATE TABLE House
(
   bedrooms INTEGER,
   bathrooms INTEGER,
   size INTEGER,
   FOREIGN KEY address REFERENCES Property(address)
);

CREATE TABLE BusinessProperty
(
   type char(20),
   size INTEGER,
   FOREIGN KEY address REFERENCES Property(address)
);

CREATE TABLE Firm
(
   id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   FOREIGN KEY address REFERENCES Property(address)
);

CREATE TABLE Agent
(
   AgentID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   phone CHAR(12),
   FOREIGN KEY firmID REFERENCES Firm(id),
   dateStarted DATE
);

CREATE TABLE Listings
(
   mlsNumber INTEGER,
   FOREIGN KEY address REFERENCES Property(address),
   FOREIGN KEY agentID REFERENCES Agent(AgentID),
   dateListed DATE
);

CREATE TABLE Buyer
(
   id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   phone CHAR(12),
   propertyType CHAR(20),
   bedrooms INTEGER,
   bathrooms INTEGER,
   businessPropertyType CHAR(20),
   minimumPreferredPrice INTEGER,
   maximumPreferredPrice INTEGER
);

CREATE TABLE Works_with
(
   FOREIGN KEY buyerid REFERENCES Buyer(id),
   FOREIGN KEY agentid REFERENCES Agent(AgentID)
);

DROP DATABASE IF EXISTS products;

CREATE DATABASE products;

USE products;

CREATE TABLE books
(
   ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   Title varchar(60),
   Category varchar(32),
   ISBN varchar(20)
);

