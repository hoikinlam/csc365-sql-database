-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT rooms.RoomName, SUM(DATEDIFF(CheckOut, CheckIn) * Rate) AS REVENUE, AVG(DATEDIFF(CheckOut, CheckIn) * Rate) AS AverageRevenue
FROM rooms, reservations
WHERE rooms.RoomCode = reservations.Room
    AND MONTH(reservations.CheckIn) IN (6, 7, 8)
GROUP BY rooms.RoomName
ORDER BY REVENUE DESC;

-- Query 2
SELECT COUNT(*), SUM(DATEDIFF(Checkout, CheckIn) * Rate)
FROM reservations
WHERE YEAR(CheckIn) = 2010
    AND WEEKDAY(CheckIn) = 0
    AND WEEKDAY(CheckOut) = 5;

-- Query 3
SELECT DAYNAME(MIN(CheckIn)) AS DAY, COUNT(DISTINCT CODE) AS STAYS, SUM(DATEDIFF(Checkout, CheckIn) * Rate) AS REVENUE
FROM reservations
WHERE DATEDIFF(Checkout, CheckIn) > 5
GROUP BY MOD(DAYNAME(CheckIn) - 2, 7)
ORDER BY MOD(DAYNAME(CheckIn) - 2, 7);

-- Query 4
SELECT rooms.RoomName, SUM(Adults + Kids) AS People
FROM rooms, reservations
WHERE rooms.RoomCode = reservations.Room
    AND YEAR(CheckIn) = 2010
GROUP BY rooms.RoomName
ORDER BY People DESC;

-- Query 5
SELECT rooms.RoomCode, rooms.RoomName, SUM(DATEDIFF(LEAST(Checkout, '2010-12-31'), GREATEST(CheckIn, '2010-01-01'))) AS Occupied
FROM rooms, reservations
WHERE rooms.RoomCode = reservations.Room
    AND (
    (YEAR(CheckIn) = 2010 AND YEAR(Checkout) = 2010)
    OR (YEAR(CheckIn) = 2010 AND YEAR(Checkout) > 2010)
    OR (YEAR(CheckIn) < 2010 AND YEAR(Checkout) >= 2010)
    )
GROUP BY rooms.RoomCode
ORDER BY Occupied DESC;