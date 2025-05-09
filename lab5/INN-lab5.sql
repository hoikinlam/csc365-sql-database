-- Hoikin Lam

-- Query 1
SELECT RoomCode, RoomName
FROM rooms, reservations
WHERE RoomCode = Room
    AND CheckIn <= '2010-02-16' 
    AND CheckOut >= '2010-02-16'
INTERSECT
SELECT RoomCode, RoomName
FROM rooms, reservations
WHERE RoomCode = Room
    AND CheckIn <= '2010-07-12' 
    AND CheckOut >= '2010-07-12'
INTERSECT
SELECT RoomCode, RoomName
FROM rooms, reservations
WHERE RoomCode = Room
    AND CheckIn <= '2010-10-20' 
    AND CheckOut >= '2010-10-20'
ORDER BY RoomName ASC;

-- Query 2
SELECT COUNT(reservations.CODE)
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
    AND rooms.decor = 'modern'
    AND DATEDIFF(Checkout, CheckIn) = 7;

-- Query 3
SELECT count(reservations.CODE)
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
    AND reservations.Adults = 2 AND reservations.Kids = 2
    AND MONTH(CheckIn) = 8 AND MONTH(Checkout) = 8;

-- Query 4
SELECT AVG(DATEDIFF(reservations.Checkout, reservations.CheckIn))
FROM reservations, rooms
WHERE rooms.RoomCode = reservations.Room
    AND rooms.RoomName = 'Interim but salutary'
    AND reservations.CheckIn >= '2010-05-01'
    AND reservations.Checkout < '2010-08-31';

-- Query 5
SELECT COUNT(reservations.CODE)
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
    AND rooms.RoomName = 'Interim but salutary'
    AND MONTH(CheckIn) = 7
    AND MONTH(Checkout) = 7
    AND YEAR(CheckIn) = 2010
    AND YEAR(Checkout) = 2010;

-- Query 6
SELECT GROUP_CONCAT(DISTINCT rooms.RoomName SEPARATOR ' and ')
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
    AND reservations.LastName = 'DONIGAN' AND reservations.FirstName = 'GLEN'
ORDER BY rooms.RoomName ASC;