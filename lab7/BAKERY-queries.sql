-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT c.FirstName, c.LastName
FROM customers c, goods g, items i, receipts r
WHERE c.CId = r.Customer
    AND r.RNumber = i.Receipt
    AND i.Item = g.GId
    AND MONTH(r.SaleDate) = 10
    AND YEAR(r.SaleDate) = 2007
GROUP BY c.FirstName, c.LastName
HAVING SUM(g.Price) = (SELECT MAX(Spending)
                       FROM (
                            (SELECT customers.FirstName, customers.LastName, SUM(goods.Price) as Spending
                            FROM customers, receipts, items, goods
                            WHERE receipts.Customer = customers.CId
                            AND receipts.RNumber = items.Receipt
                            AND items.Item = goods.GId
                            AND MONTH(receipts.SaleDate) = 10
                            AND YEAR(receipts.SaleDate) = 2007
                            GROUP BY customers.FirstName, customers.LastName)
                            ) MaxSpending
                        );

-- Query 2
SELECT c.FirstName, c.LastName
FROM customers c
EXCEPT
SELECT c.FirstName, c.LastName
FROM customers c, goods g, items i, receipts r
WHERE c.CId = r.Customer
    AND MONTH(r.SaleDate) = 10
    AND YEAR(r.SaleDate) = 2007
    AND r.RNumber = i.Receipt
    AND i.Item = g.GId
    AND g.Food = 'Eclair'
GROUP BY c.FirstName, c.LastName
ORDER BY LastName;

-- Query 3
SELECT CakeCounts.FirstName, CakeCounts.LastName
FROM     
    (SELECT c.FirstName, c.LastName, COUNT(g.GId) AS Cake
    FROM customers c, goods g, items i, receipts r
    WHERE c.CId = r.Customer
        AND r.RNumber = i.Receipt
        AND i.Item = g.GId
        AND g.Food = 'Cake'
    GROUP BY c.CId) AS CakeCounts
    ,
    (SELECT c.FirstName, c.LastName, COUNT(g.GId) AS Cookie
    FROM customers c, goods g, items i, receipts r
    WHERE c.CId = r.Customer
        AND r.RNumber = i.Receipt
        AND i.Item = g.GId
        AND g.Food = 'Cookie'
    GROUP BY c.CId) AS CookieCounts
WHERE CakeCounts.FirstName = CookieCounts.FirstName
    AND CakeCounts.LastName = CookieCounts.LastName
    AND CakeCounts.Cake > CookieCounts.Cookie
ORDER BY CakeCounts.LastName;

-- Query 4
SELECT goods.Flavor, goods.Food, COUNT(items.Receipt)
FROM goods, items
WHERE goods.GId = items.Item
GROUP BY goods.GId
HAVING COUNT(items.Receipt) = (SELECT MAX(PastryCounts.Pastry)
                                FROM
                                    (SELECT goods.Food, goods.Flavor, COUNT(items.Receipt) AS Pastry
                                    FROM goods, items
                                    WHERE goods.GId = items.Item
                                    GROUP BY goods.GId) AS PastryCounts);

-- Query 5
SELECT receipts.SaleDate
FROM goods, items, receipts,
    (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
    FROM goods, items, receipts
    WHERE goods.GId = items.Item
        AND items.Receipt = receipts.RNumber
    GROUP BY receipts.RNumber) AS ReceiptTotal
WHERE goods.GId = items.Item
    AND items.Receipt = receipts.RNumber
    AND receipts.RNumber = ReceiptTotal.RNumber
GROUP BY receipts.SaleDate
HAVING SUM(ReceiptTotal.X) = (SELECT MAX(DayTotal.Y)
                            FROM (SELECT receipts.SaleDate, SUM(ReceiptTotal.X) AS Y
                                FROM goods, items, receipts,
                                    (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
                                    FROM goods, items, receipts
                                    WHERE goods.GId = items.Item
                                        AND items.Receipt = receipts.RNumber
                                    GROUP BY receipts.RNumber) AS ReceiptTotal
                                WHERE goods.GId = items.Item
                                    AND items.Receipt = receipts.RNumber
                                    AND receipts.RNumber = ReceiptTotal.RNumber
                                GROUP BY receipts.SaleDate) AS DayTotal);

-- Query 6
SELECT goods.Food, goods.Flavor, COUNT(items.Item) AS Counted
FROM goods, items, receipts
WHERE receipts.SaleDate = ( SELECT receipts.SaleDate
                            FROM goods, items, receipts,
                                (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
                                FROM goods, items, receipts
                                WHERE goods.GId = items.Item
                                    AND items.Receipt = receipts.RNumber
                                GROUP BY receipts.RNumber) AS ReceiptTotal
                            WHERE goods.GId = items.Item
                                AND items.Receipt = receipts.RNumber
                                AND receipts.RNumber = ReceiptTotal.RNumber
                            GROUP BY receipts.SaleDate
                            HAVING SUM(ReceiptTotal.X) = 
                                   (SELECT MAX(DayTotal.Y)
                                    FROM (SELECT receipts.SaleDate, SUM(ReceiptTotal.X) AS Y
                                          FROM goods, items, receipts,
                                              (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
                                              FROM goods, items, receipts
                                              WHERE goods.GId = items.Item
                                                  AND items.Receipt = receipts.RNumber
                                              GROUP BY receipts.RNumber) AS ReceiptTotal
                                    WHERE goods.GId = items.Item
                                        AND items.Receipt = receipts.RNumber
                                        AND receipts.RNumber = ReceiptTotal.RNumber
                                    GROUP BY receipts.SaleDate) AS DayTotal))
    AND receipts.RNumber = items.Receipt
    AND items.Item = goods.GId
GROUP BY goods.GId
HAVING COUNT(items.Item) = ( SELECT MAX(HighestRevenueDay.Counted)
                             FROM ( SELECT goods.GId, COUNT(items.Item) AS Counted
                                    FROM goods, items, receipts
                                    WHERE receipts.SaleDate = ( SELECT receipts.SaleDate
                                                                FROM goods, items, receipts,
                                                                    (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
                                                                    FROM goods, items, receipts
                                                                    WHERE goods.GId = items.Item
                                                                        AND items.Receipt = receipts.RNumber
                                                                    GROUP BY receipts.RNumber) AS ReceiptTotal
                                                                WHERE goods.GId = items.Item
                                                                    AND items.Receipt = receipts.RNumber
                                                                    AND receipts.RNumber = ReceiptTotal.RNumber
                                                                GROUP BY receipts.SaleDate
                                                                HAVING SUM(ReceiptTotal.X) = (SELECT MAX(DayTotal.Y)
                                                                                            FROM (SELECT receipts.SaleDate, SUM(ReceiptTotal.X) AS Y
                                                                                                FROM goods, items, receipts,
                                                                                                    (SELECT receipts.RNumber, SUM(goods.PRICE) AS X
                                                                                                    FROM goods, items, receipts
                                                                                                    WHERE goods.GId = items.Item
                                                                                                        AND items.Receipt = receipts.RNumber
                                                                                                    GROUP BY receipts.RNumber) AS ReceiptTotal
                                                                                                WHERE goods.GId = items.Item
                                                                                                    AND items.Receipt = receipts.RNumber
                                                                                                    AND receipts.RNumber = ReceiptTotal.RNumber
                                                                                                GROUP BY receipts.SaleDate) AS DayTotal))
                                        AND receipts.RNumber = items.Receipt
                                        AND items.Item = goods.GId
                                    GROUP BY goods.GId) AS HighestRevenueDay
                                );

-- Query 7
WITH CakeCount AS(
    SELECT goods.Flavor, customers.CId, goods.Food, COUNT(receipts.RNumber) AS count
    FROM goods, items, receipts, customers
    WHERE goods.GId = items.Item
        AND items.Receipt = receipts.RNumber
        AND goods.Food = 'Cake'
        AND receipts.Customer = customers.CId
    GROUP BY goods.Flavor, customers.CId
),
MaxCount AS(
    SELECT Flavor, MAX(CakeCount.count) AS count
    FROM CakeCount
    GROUP BY Flavor
)
SELECT CakeCount.Flavor, CakeCount.Food, customers.FirstName, customers.LastName, CakeCount.count
FROM CakeCount, MaxCount, customers
WHERE CakeCount.Flavor = MaxCount.Flavor
    AND CakeCount.count = MaxCount.count
    AND customers.CId = CakeCount.CId
ORDER BY CakeCount.count DESC, CakeCount.Flavor, customers.LastName;

-- Query 8
SELECT FirstName, LastName
FROM customers
EXCEPT
SELECT FirstName, LastName
FROM customers, receipts
WHERE customers.CId = receipts.Customer
    AND receipts.SaleDate BETWEEN '2007-10-19' AND '2007-10-23'
ORDER BY LastName;

-- Query 9
SELECT customers.FirstName, customers.LastName,
    CASE WHEN SUM(CASE WHEN goods.Food = 'Eclair' THEN 1 ELSE 0 END) = 0 THEN NULL 
         ELSE SUM(CASE WHEN goods.Food = 'Eclair' THEN 1 ELSE 0 END) END AS Eclairs,
    CASE WHEN SUM(CASE WHEN goods.Food = 'Danish' THEN 1 ELSE 0 END) = 0 THEN NULL 
         ELSE SUM(CASE WHEN goods.Food = 'Danish' THEN 1 ELSE 0 END) END AS Danishes,
    CASE WHEN SUM(CASE WHEN goods.Food = 'Pie' THEN 1 ELSE 0 END) = 0 THEN NULL 
         ELSE SUM(CASE WHEN goods.Food = 'Pie' THEN 1 ELSE 0 END) END AS Pies
FROM customers, goods, items, receipts
WHERE customers.CId = receipts.Customer
    AND goods.GId = items.Item
    AND items.Receipt = receipts.RNumber
GROUP BY customers.CId
ORDER BY customers.LastName;

-- Query 10
WITH ChocRevenue AS(
    SELECT goods.Food, SUM(goods.PRICE) AS Revenue
    FROM goods, items
    WHERE goods.Flavor = 'Chocolate'
        AND goods.GId = items.Item
    GROUP BY goods.Food
),
SumChoc AS(
    SELECT SUM(Revenue) AS Revenue
    FROM ChocRevenue
),
CroissantRevenue AS(
    SELECT SUM(goods.PRICE) AS Revenue
    FROM goods, items
    WHERE goods.Food = 'Croissant'
        AND goods.GId = items.Item
)
SELECT
    CASE
        WHEN SumChoc.Revenue > CroissantRevenue.Revenue THEN 'Chocolate'
        WHEN SumChoc.Revenue < CroissantRevenue.Revenue THEN 'Croissant'
        ELSE 'Tied'
    END AS HigherRevenue
FROM SumChoc, CroissantRevenue;