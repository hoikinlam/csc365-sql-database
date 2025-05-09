-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT customers.FirstName, customers.LastName, COUNT(DISTINCT receipts.RNumber) AS Purchases
FROM customers, receipts
WHERE customers.CId = receipts.Customer
GROUP BY customers.FirstName, customers.LastName
HAVING COUNT(DISTINCT receipts.RNumber) >= 15
ORDER BY Purchases DESC;

-- Query 2
SELECT goods.Flavor, COUNT(items.Item) AS NCookies, COUNT(DISTINCT customers.CId) as Purchasers, SUM(goods.PRICE) AS Revenue
FROM goods, items, customers, receipts
WHERE goods.Food = 'Cookie'
    AND goods.GId = items.Item
    AND customers.CId = receipts.Customer
    AND receipts.RNumber = items.Receipt
GROUP BY goods.Flavor
HAVING COUNT(items.Item)
    AND COUNT(DISTINCT customers.CId)
    AND SUM(goods.PRICE)
ORDER BY goods.Flavor ASC;

-- Query 3
SELECT DAYNAME(receipts.SaleDate) AS DAY, receipts.SaleDate, COUNT(DISTINCT receipts.RNumber) AS PURCHASES, COUNT(items.Item) AS ITEMS, SUM(goods.PRICE) AS REVENUE
FROM receipts, items, goods
WHERE MONTH(receipts.SaleDate) = 10
    AND DAY(receipts.SaleDate) >= 15
    AND DAY(receipts.SaleDate) <= 21
    AND receipts.RNumber = items.Receipt
    AND goods.GId = items.Item
GROUP BY receipts.SaleDate
HAVING COUNT(DISTINCT receipts.RNumber)
    AND COUNT(items.Item)
    AND SUM(goods.PRICE)
ORDER BY receipts.SaleDate ASC;

-- Query 4
SELECT customers.FirstName, customers.LastName, items.Receipt, SUM(goods.PRICE) AS Total
FROM goods, items, receipts, customers
WHERE goods.GId = items.Item
    AND items.Receipt = receipts.RNumber
    AND receipts.Customer = customers.CId
GROUP BY items.Receipt
HAVING SUM(goods.PRICE) >= 30
ORDER BY SUM(goods.PRICE) DESC;

-- Query 5
SELECT customers.FirstName, customers.LastName, COUNT(receipts.RNumber) AS Num_Large_Purchases
FROM customers, receipts, items
WHERE customers.CId = receipts.Customer
    AND receipts.RNumber = items.Receipt
    AND items.Ordinal = 5
GROUP BY customers.FirstName, customers.LastName
HAVING COUNT(DISTINCT receipts.RNumber)
ORDER BY MAX(receipts.SaleDate), customers.LastName ASC;