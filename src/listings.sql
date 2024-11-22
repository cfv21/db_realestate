DROP DATABASE IF EXISTS Products;

CREATE DATABASE Products;

USE listings;

CREATE TABLE Property
(
   address varchar(50) PRIMARY KEY,
   ownerName varchar(30),
   price INTEGER,
);

INSERT INTO Property(address, ownerName, price) VALUES ('1521 Copeland Ave', 'Walter White', 700000);
INSERT INTO Property(address, ownerName, price) VALUES ('808 W Carolina Street', 'Genghis Khan', 352000);
INSERT INTO Property(address, ownerName, price) VALUES ('333 Elm Street', 'Michael Myers', 1000000);
INSERT INTO Property(address, ownerName, price) VALUES ('1 Sesame Street','Big Bird', 200000);
INSERT INTO Property(address, ownerName, price) VALUES ('25 Martin Luther King Jr. Blvd','Martin Luther King III', 410000);

CREATE TABLE House
(
   bedrooms INTEGER,
   bathrooms INTEGER,
   size INTEGER,
   address VARCHAR(50) UNIQUE,
   FOREIGN KEY address REFERENCES Property(address)
);

INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (3, 2, 1500, '123 Main St');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (4, 3, 2000, '456 Elm St');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (2, 1, 1200, '789 Oak St');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (5, 4, 2500, '321 Pine St');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (3, 2, 1600, '654 Maple St');


INSERT INTO House(bedrooms, bathrooms, size) VALUES(4,3,2500);
INSERT INTO House(bedrooms, bathrooms, size) VALUES(1,1,400);
INSERT INTO House(bedrooms, bathrooms, size) VALUES(10,10,4000);
INSERT INTO House(bedrooms, bathrooms, size) VALUES(5,2,2900);
INSERT INTO House(bedrooms, bathrooms, size) VALUES(2,2,1950);

CREATE TABLE BusinessProperty
(
   propertyType char(20),
   size INTEGER,
   address VARCHAR(50) UNIQUE,
   FOREIGN KEY address Property Firm(address)
);

INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Retail', 3000, '123 Main St');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Office', 4500, '456 Elm St');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Warehouse', 6000, '789 Oak St');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Hotel', 10000, '321 Pine St');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Restaurant', 3500, '654 Maple St');


CREATE TABLE Firm
(
   id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   address VARCHAR(50)
);

INSERT INTO Firm(name, address) VALUES('VanderVeer Enterprises','1 Broadway Street');
INSERT INTO Firm(name, address) VALUES('KJW','5000 Main Street');
INSERT INTO Firm(name, address) VALUES('The Establishment','The Pentagon');
INSERT INTO Firm(name, address) VALUES('Disney','331 1st Street');
INSERT INTO Firm(name, address) VALUES('MyRealEstatePlanner','55 Applewood Drive');

CREATE TABLE Agent
(
   AgentID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   phone CHAR(12),
   firmID INTEGER,
   dateStarted DATE,
   FOREIGN KEY (firmID) REFERENCES Firm(id)
);

INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES('Calvin VanderVeer','8005882300',1,10/05/2000);
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES('Kenton Weiss','2228675309',2,8/8/2021);
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES('The Rizzler','4200001234',3,11/11/11);
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES('Mike Wazowski','5102765292',4,11/2/2001);
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES('LeBron James','1234567890',5,4/25/2020);

CREATE TABLE Listings
(
   mlsNumber INTEGER,
   address VARCHAR(50) UNIQUE,
   agentId INTEGER,
   dateListed DATE,
   FOREIGN KEY address REFERENCES Property(address),
   FOREIGN KEY agentID REFERENCES Agent(AgentID)
);

INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1001, '123 Main St', 101, '2023-05-10');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1002, '456 Elm St', 102, '2023-06-15');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1003, '789 Oak St', 103, '2023-07-20');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1004, '321 Pine St', 104, '2023-08-25');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1005, '654 Maple St', 105, '2023-09-30');


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

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) 
VALUES (1,'John Buyer','555-678-1234','Residential',3,2,NULL,200000,300000);

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) 
VALUES (2,'Jane Investor','555-789-2345','Commercial',NULL,NULL,'Retail',500000,700000);

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) 
VALUES (3,'Mike Homeowner','555-890-3456','Residential',4,3,NULL,300000,400000);

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) 
VALUES (4,'Emma Developer','555-901-4567','Commercial',NULL,NULL,'Office',800000,1000000);

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice) 
VALUES (5,'Olivia Builder','555-012-5678','Residential',5,4,NULL,400000,600000);


CREATE TABLE Works_with
(
   buyerid INTEGER,
   agentid INTEGER,
   FOREIGN KEY buyerid REFERENCES Buyer(id),
   FOREIGN KEY agentid REFERENCES Agent(AgentID)
);

INSERT INTO Works_With (buyerid, agentid) VALUES (1,5);
INSERT INTO Works_With (buyerid, agentid) VALUES (2,4);
INSERT INTO Works_With (buyerid, agentid) VALUES (3,3);
INSERT INTO Works_With (buyerid, agentid) VALUES (4,2);
INSERT INTO Works_With (buyerid, agentid) VALUES (5,1);
