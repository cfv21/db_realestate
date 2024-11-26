
DROP DATABASE IF EXISTS RPRODUCTS;

CREATE DATABASE RPRODUCTS;

USE RPRODUCTS;

CREATE TABLE Property
(
   address VARCHAR(50) PRIMARY KEY,
   ownerName VARCHAR(30),
   price INTEGER
);

INSERT INTO Property(address, ownerName, price) VALUES ('1521 Copeland Ave', 'Walter White', 700000);
INSERT INTO Property(address, ownerName, price) VALUES ('808 W Carolina Street', 'Genghis Khan', 352000);
INSERT INTO Property(address, ownerName, price) VALUES ('333 Elm Street', 'Michael Myers', 1000000);
INSERT INTO Property(address, ownerName, price) VALUES ('1 Sesame Street', 'Big Bird', 200000);
INSERT INTO Property(address, ownerName, price) VALUES ('25 Martin Luther King Jr. Blvd', 'Martin Luther King III', 410000);

CREATE TABLE House
(
   bedrooms INTEGER,
   bathrooms INTEGER,
   size INTEGER,
   address VARCHAR(50) UNIQUE,
   FOREIGN KEY (address) REFERENCES Property(address)
);

INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (3, 2, 1500, '1521 Copeland Ave');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (4, 3, 2000, '808 W Carolina Street');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (2, 1, 1200, '333 Elm Street');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (5, 4, 2500, '1 Sesame Street');
INSERT INTO House (bedrooms, bathrooms, size, address) VALUES (3, 2, 1600, '25 Martin Luther King Jr. Blvd');

CREATE TABLE BusinessProperty
(
   propertyType CHAR(20),
   size INTEGER,
   address VARCHAR(50) UNIQUE,
   FOREIGN KEY (address) REFERENCES Property(address)
);

INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Retail', 3000, '1521 Copeland Ave');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Office', 4500, '808 W Carolina Street');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Warehouse', 6000, '333 Elm Street');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Hotel', 10000, '1 Sesame Street');
INSERT INTO BusinessProperty (propertyType, size, address) VALUES ('Restaurant', 3500, '25 Martin Luther King Jr. Blvd');

CREATE TABLE Firm
(
   id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   address VARCHAR(50)
);

INSERT INTO Firm(name, address) VALUES ('VanderVeer Enterprises', '1 Broadway Street');
INSERT INTO Firm(name, address) VALUES ('KJW', '5000 Main Street');
INSERT INTO Firm(name, address) VALUES ('The Establishment', 'The Pentagon');
INSERT INTO Firm(name, address) VALUES ('Disney', '331 1st Street');
INSERT INTO Firm(name, address) VALUES ('MyRealEstatePlanner', '55 Applewood Drive');

CREATE TABLE Agent
(
   AgentID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30),
   phone CHAR(12),
   firmID INTEGER,
   dateStarted DATE,
   FOREIGN KEY (firmID) REFERENCES Firm(id)
);

INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES ('Calvin VanderVeer', '8005882300', 1, '2000-10-05');
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES ('Kenton Weiss', '2228675309', 2, '2021-08-08');
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES ('The Rizzler', '4200001234', 3, '2011-11-11');
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES ('Mike Wazowski', '5102765292', 4, '2001-11-02');
INSERT INTO Agent(name, phone, firmID, dateStarted) VALUES ('LeBron James', '1234567890', 5, '2020-04-25');

CREATE TABLE Listings
(
   mlsNumber INTEGER,
   address VARCHAR(50) UNIQUE,
   agentId INTEGER,
   dateListed DATE,
   FOREIGN KEY (address) REFERENCES Property(address),
   FOREIGN KEY (agentID) REFERENCES Agent(AgentID)
);

INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1001, '1521 Copeland Ave', 1, '2023-05-10');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1002, '808 W Carolina Street', 2, '2023-06-15');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1003, '333 Elm Street', 3, '2023-07-20');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1004, '1 Sesame Street', 4, '2023-08-25');
INSERT INTO Listings (mlsNumber, address, agentId, dateListed) VALUES (1005, '25 Martin Luther King Jr. Blvd', 5, '2023-09-30');

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

INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES ('John Buyer', '5556781234', 'Residential', 3, 2, NULL, 200000, 300000);

INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES ('Jane Investor', '5557892345', 'Commercial', NULL, NULL, 'Retail', 500000, 700000);

INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES ('Mike Homeowner', '5558903456', 'Residential', 4, 3, NULL, 300000, 400000);

INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES ('Emma Developer', '5559014567', 'Commercial', NULL, NULL, 'Office', 800000, 1000000);

INSERT INTO Buyer (name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES ('Olivia Builder', '5550125678', 'Residential', 5, 4, NULL, 400000, 600000);

CREATE TABLE Works_with
(
   buyerid INTEGER,
   agentid INTEGER,
   FOREIGN KEY (buyerid) REFERENCES Buyer(id),
   FOREIGN KEY (agentid) REFERENCES Agent(AgentID)
);

INSERT INTO Works_with (buyerid, agentid) VALUES (1, 5);
INSERT INTO Works_with (buyerid, agentid) VALUES (2, 4);
INSERT INTO Works_with (buyerid, agentid) VALUES (3, 3);
INSERT INTO Works_with (buyerid, agentid) VALUES (4, 2);
INSERT INTO Works_with (buyerid, agentid) VALUES (5, 1);
