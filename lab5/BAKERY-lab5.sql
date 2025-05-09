-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT DISTINCT SaleDate
FROM customers, receipts, items, goods
WHERE (customers.LastName = 'TOUSSAND' AND customers.FirstName = 'SHARRON'
    AND customers.CId = receipts.Customer
    AND receipts.RNumber = items.Receipt
    AND items.Ordinal = 5)
    OR (customers.CId = receipts.Customer
    AND receipts.RNumber = items.Receipt
    AND items.Item = goods.GId
    AND goods.Flavor = 'Gongolais' AND goods.Food = 'Cookie')
ORDER BY SaleDate;

-- Query 2
SELECT SUM(goods.PRICE)
FROM customers, receipts, items, goods
WHERE (customers.LastName = 'LOGAN' AND customers.FirstName = 'JULIET')
    AND customers.CId = receipts.Customer
    AND receipts.RNumber = items.Receipt
    AND items.Item = goods.GId
    AND MONTH(receipts.SaleDate) = 10
    AND DAY(receipts.SaleDate) <= 10;

-- Query 3
SELECT COUNT(DISTINCT receipts.RNumber)
FROM receipts, items, goods
WHERE receipts.RNumber = items.Receipt
    AND items.Item = goods.GId
    AND goods.Flavor = 'Chocolate'

-- Query 4
SELECT COUNT(items.Receipt)
FROM goods, items, receipts
WHERE receipts.RNumber = items.Receipt
    AND items.Item = goods.GId
    AND MONTH(receipts.SaleDate) = 10 
    AND YEAR(receipts.SaleDate) = 2007
    AND goods.Flavor = 'Chocolate'