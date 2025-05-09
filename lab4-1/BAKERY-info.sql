-- Lab 4 - BAKERY
-- Hoikin Lam
-- Oct 28, 2024

-- Query 1
SELECT Flavor, Food, Price
FROM goods
WHERE (Price >= 1 AND Price <= 2) AND Food = 'Cookie'
ORDER BY Flavor ASC;

-- Query 2
SELECT Flavor, Food, Price
FROM goods
WHERE Food = 'Pie'
    OR (Price >= 3.40 AND Price <= 3.65)
    OR (Food = 'Croissant' AND NOT Flavor = 'Apple')
ORDER BY Price ASC;

-- Query 3
SELECT DISTINCT FirstName, LastName
FROM customers, receipts
WHERE SaleDate = '2007-10-24'
    AND customers.CId = receipts.Customer
ORDER BY LastName ASC;

-- Query 4
SELECT DISTINCT E1.Flavor, E2.Flavor
FROM goods E1, goods E2
WHERE (E1.Price = E2.Price)
    AND E1.Food = 'Eclair'
    AND E2.Food = 'Eclair'
    AND E1.Flavor <> E2.Flavor
    AND E1.Flavor < E2.Flavor; -- Prevents duplicate pairs as E1 comes before E2 alphabetically

-- Query 5
SELECT DISTINCT Flavor, Food
FROM goods, receipts, items
WHERE SaleDate = '2007-10-09'
    AND RNumber = Receipt
    AND Food = 'Croissant'
    AND GId = Item
ORDER BY Flavor ASC;

-- Query 6
SELECT DISTINCT r1.Receipt, Flavor, Food, SaleDate
FROM goods, items r1, items r2, receipts
WHERE Food = 'Cake'
    AND r1.Item = GId AND r2.Item = GId
    AND r1.Receipt = RNumber
    AND r1.Receipt = r2.Receipt
    AND r1.Ordinal != r2.Ordinal
ORDER BY Receipt ASC;

-- Query 7
SELECT DISTINCT r1.SaleDate
FROM receipts r1, receipts r2, items, customers
WHERE (FirstName = 'MIGDALIA' AND LastName = 'STADICK')
    AND (CId = r1.Customer AND CId = r2.Customer)
    AND r1.RNumber != r2.RNumber
    AND r1.SaleDate = r2.SaleDate
ORDER BY r1.SaleDate ASC;