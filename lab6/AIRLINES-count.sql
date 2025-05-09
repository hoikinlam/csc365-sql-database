-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT airports.Code, airports.Name
FROM airports, flights
WHERE airports.Code = flights.Source
GROUP BY airports.Code
HAVING COUNT(flights.Source) = 19;

-- Query 2
SELECT COUNT(DISTINCT f1.Source)
FROM flights f1, flights f2
WHERE f1.Destination = f2.Source
    AND f2.Destination = 'LTS'
    AND f1.Destination != 'LTS'
    AND f1.Source != 'LTS';

-- Query 3
SELECT COUNT(DISTINCT f1.Source)
FROM flights f1, flights f2
WHERE (f1.Destination = f2.Source
    AND f2.Destination = 'LTS'
    AND f1.Destination != 'LTS'
    AND f1.Source != 'LTS')
    OR (f1.Destination = 'LTS');

-- Query 4
SELECT DISTINCT airlines.Name, COUNT(DISTINCT f1.Source) AS Airports
FROM airlines, flights f1, flights f2
WHERE airlines.Id = f1.Airline
    AND f1.Airline = f2.Airline
    AND f1.Source = f2.Source
    AND f1.Destination != f2.Destination
GROUP BY airlines.Name
HAVING COUNT(f1.Source)
ORDER BY Airports DESC;