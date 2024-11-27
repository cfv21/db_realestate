USE RPRODUCTS;

-- 1) Find the addresses of all houses currently listed.
SELECT House.address
FROM House;

-- 2) Find the addresses and MLS numbers of all houses currently listed.
SELECT Listings.mlsNumber, Listings.address
FROM Listings, House
WHERE Listings.address = House.address;

-- 3) Find the addresses of all 3-bedroom, 2-bathroom houses currently listed.
SELECT House.address
FROM House
WHERE House.bedrooms = 3 AND House.bathrooms = 2;

-- 4) Find the addresses and prices of all 3-bedroom, 2-bathroom houses with prices in the range $100,000 to $250,000, 
--    with the results shown in descending order of price.
SELECT House.address, Property.price
FROM House, Property
WHERE House.address = Property.address
      AND House.bedrooms = 3 AND House.bathrooms = 2 
      AND Property.price BETWEEN 100000 AND 250000
ORDER BY Property.price DESC;

-- 5) Find the addresses and prices of all business properties that are advertised as office space in descending order of price.
SELECT Property.address, Property.price
FROM Property
JOIN BusinessProperty ON Property.address = BusinessProperty.address
WHERE BusinessProperty.propertyType = 'Office'
ORDER BY Property.price DESC;

-- 6) Find all the ids, names and phones of all agents, together with the names of their firms and the dates when they started.
SELECT Agent.AgentID, Agent.name AS AgentName, Agent.phone, Firm.name AS FirmName, Agent.dateStarted
FROM Agent, Firm
WHERE Agent.firmID = Firm.id;

-- 7) Find all the properties currently listed by agent with id “001” (or some other suitable id).
-- Replace '001' with a valid agent ID.
SELECT Property.address
FROM Property
JOIN Listings ON Property.address = Listings.address
WHERE Listings.agentID = '1';

-- 8) Find all Agent.name-Buyer.name pairs where the buyer works with the agent, sorted alphabetically by Agent.name.
SELECT Agent.name AS AgentName, Buyer.name AS BuyerName
FROM Agent
JOIN Works_with ON Agent.AgentID = Works_with.agentID
JOIN Buyer ON Works_with.buyerID = Buyer.id
ORDER BY Agent.name ASC;

-- 9) For each agent, find the total number of buyers currently working with that agent, 
--     i.e., the output should be Agent.id-count pairs.
SELECT Agent.AgentID, COUNT(Works_with.buyerID) AS BuyerCount
FROM Agent
LEFT JOIN Works_with ON Agent.AgentID = Works_with.agentID
GROUP BY Agent.AgentID;

-- 10) For some buyer that is interested in a house, where the buyer is identified by an id (e.g., “001”), 
--     find all houses that meet the buyer’s preferences, with the results shown in descending order of price.
-- Replace '001' with a valid buyer ID.
SELECT Property.address
FROM Property
JOIN House ON Property.address = House.address
JOIN BusinessProperty ON BusinessProperty.address = Property.address
JOIN Buyer ON Buyer.id = '1'
WHERE (Buyer.propertyType = 'Residential' AND House.bedrooms = Buyer.bedrooms 
       AND House.bathrooms = Buyer.bathrooms)
   OR (Buyer.propertyType = 'Commercial' AND BusinessProperty.propertyType = Buyer.businessPropertyType)
ORDER BY Property.price DESC;
