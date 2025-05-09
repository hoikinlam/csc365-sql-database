-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT rooms.RoomName, rooms.RoomCode, COUNT(reservations.CODE)
FROM rooms, reservations
WHERE reservations.Room = rooms.RoomCode
GROUP BY rooms.RoomCode
HAVING COUNT(reservations.CODE) =
    (SELECT MAX(RoomCount.count)
    FROM
        (SELECT reservations.Room, COUNT(*) AS count
        FROM reservations, rooms
        WHERE reservations.Room = rooms.RoomCode
        GROUP BY reservations.Room) AS RoomCount);

-- Query 2
WITH OccupiedPerRoom AS(
    SELECT reservations.CODE, reservations.Room, DATEDIFF(Checkout, CheckIn) AS Days
    FROM reservations
    GROUP BY reservations.CODE
),
MostOccupiedRoom AS(
    SELECT Room, SUM(Days) AS count
    FROM OccupiedPerRoom
    GROUP BY Room
)
SELECT DISTINCT rooms.RoomName, rooms.RoomCode, MostOccupiedRoom.count
FROM OccupiedPerRoom, MostOccupiedRoom, rooms
WHERE rooms.RoomCode = MostOccupiedRoom.Room
    AND MostOccupiedRoom.count = (SELECT MAX(MostOccupiedRoom.count) FROM MostOccupiedRoom);

-- Query 3
WITH ReservationTotal AS(
    SELECT CODE, Room, (Rate * DATEDIFF(Checkout, CheckIn)) AS total
    FROM reservations
    GROUP BY CODE
),
MostExpense AS(
    SELECT Room, MAX(total) AS total
    FROM ReservationTotal
    GROUP BY Room
),
RoomCodes AS(
    SELECT ReservationTotal.CODE, ReservationTotal.Room, ReservationTotal.total
    FROM ReservationTotal, MostExpense
    WHERE ReservationTotal.total = MostExpense.total
        AND ReservationTotal.Room = MostExpense.Room
)
SELECT rooms.RoomName, reservations.CheckIn, reservations.Checkout, reservations.LastName, reservations.Rate, RoomCodes.total
FROM RoomCodes, reservations, rooms
WHERE RoomCodes.CODE = reservations.CODE
    AND reservations.Room = rooms.RoomCode
ORDER BY RoomCodes.total DESC;

-- Query 4
WITH RevenuePerMonth AS(
    SELECT DATE_FORMAT(CheckIn, '%M') AS Month, SUM(Rate * DATEDIFF(Checkout, CheckIn)) AS Revenue
    FROM reservations
    GROUP BY Month
),
ReservationsPerMonth AS(
    SELECT DATE_FORMAT(CheckIn, '%M') AS Month, COUNT(CODE) AS Reservation
    FROM reservations
    GROUP BY Month
)
SELECT RevenuePerMonth.Month, RevenuePerMonth.Revenue, ReservationsPerMonth.Reservation
FROM RevenuePerMonth, ReservationsPerMonth
WHERE RevenuePerMonth.Month = ReservationsPerMonth.Month
    AND RevenuePerMonth.Revenue = (SELECT MAX(RevenuePerMonth.Revenue) FROM RevenuePerMonth);

-- Query 5
SELECT rooms.RoomName, rooms.RoomCode,
CASE
    WHEN MAX(reservations.CheckIn <= '2010-08-10' AND reservations.Checkout > '2010-08-10') THEN 'Occupied'
    ELSE 'Empty'
END AS Status
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
GROUP BY rooms.RoomCode
ORDER BY rooms.RoomCode;