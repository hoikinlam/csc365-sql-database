-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT RoomCode, RoomName
FROM rooms
WHERE decor = 'traditional'
    AND Beds = 2
    AND basePrice > 170
ORDER BY RoomCode ASC;

-- Query 2
SELECT Code, LastName, CheckIn
FROM reservations, rooms
WHERE RoomCode = Room
    AND RoomName = 'Mendicant with cryptic'
    AND DATEDIFF(Checkout, CheckIn) = 5
ORDER BY CheckIn ASC;

-- Query 3
SELECT LastName, CheckIn, Checkout, (Adults + Kids) AS Guests, (Rate * DATEDIFF(Checkout, CheckIn)) AS Cost
FROM reservations, rooms
WHERE RoomCode = Room
    AND RoomName = 'Frugal not apropos'
    AND MONTH(CheckIn) = 7
    AND MONTH(Checkout) = 7
ORDER BY CheckIn ASC;

-- Query 4
SELECT RoomName, CheckIn, Checkout
FROM reservations, rooms
WHERE RoomCode = Room
    AND CheckIn <= '2010-11-01'
    AND Checkout > '2010-11-01'
ORDER BY RoomName ASC;

-- Query 5
SELECT DISTINCT CODE, RoomName, 
    DATE_FORMAT(CheckIn, '%M %e') AS CheckIn, 
    DATE_FORMAT(Checkout, '%M %d') AS Checkout, 
    DATEDIFF(Checkout, CheckIn) * Rate AS PAID
FROM reservations, rooms
WHERE (FirstName = 'BO' AND LastName = 'DURAN')
    AND RoomCode = Room
ORDER BY CheckIn ASC;

-- Query 6
SELECT DISTINCT rm2.RoomName, r2.LastName, r2.CheckIn, DATEDIFF(r2.Checkout, r2.CheckIn) AS Days
FROM reservations r1, reservations r2, rooms rm1, rooms rm2
WHERE rm1.RoomCode = r1.Room AND rm2.RoomCode = r2.Room
    AND rm2.decor = 'modern'
    AND rm1.decor = 'modern'
    AND (r1.FirstName = 'FRITZ' AND r1.LastName ='SPECTOR')
    AND r2.CODE != r1.CODE
    AND r2.CheckIn < r1.Checkout AND r2.Checkout > r1.CheckIn
ORDER BY CheckIn ASC;

-- Query 7
SELECT CODE, RoomCode, RoomName, DATE_FORMAT(CheckIn, '%e %b') AS Checkin, DATE_FORMAT(Checkout, '%e %b') AS Checkout
FROM reservations, rooms
WHERE RoomCode = Room
    AND bedType = 'Double'
    AND Adults = 4
ORDER BY MONTH(CheckIn) ASC;