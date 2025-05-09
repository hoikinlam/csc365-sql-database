-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT DISTINCT airlines.Name, airlines.Abbr
FROM airlines, flights
WHERE flights.Source = 'APN'
    AND flights.Airline = airlines.Id
ORDER BY airlines.Name ASC;

-- Query 2
SELECT DISTINCT flights.FlightNo, flights.Destination, airports.Name
FROM airports, flights, airlines
WHERE airlines.Id = flights.Airline
    AND airports.Code = flights.Destination
    AND airlines.Abbr = 'Delta'
    AND flights.Source = 'KQA'
ORDER BY flights.FlightNo ASC;

-- Query 3
SELECT DISTINCT f1.FlightNo, f2.FlightNo, airports.Code, airports.Name
FROM flights f1, flights f2, airports, airlines
WHERE airlines.Id = f1.Airline AND airlines.Id = f2.Airline
    AND airlines.Abbr = 'Delta'
    AND f1.Source = 'KQA'
    AND f1.Destination = f2.Source
    AND f1.Source != f2.Destination
    AND airports.Code = f2.Destination
ORDER BY airports.Code ASC;

-- Query 4
SELECT DISTINCT a1.Name AS Source, a1.Code, a2.Name AS Dest, a2.Code
FROM airlines al1, airlines al2, airports a1, airports a2, flights f1, flights f2
WHERE (al1.Id = f1.Airline AND al2.Id = f2.Airline)
    AND (al1.Abbr = 'Delta' AND al2.Abbr = 'JetBlue')
    AND ((f1.Source = a1.Code AND f1.Destination = a2.Code)
         OR (f1.Source = a2.Code AND f1.Destination = a1.Code))
    AND ((f2.Source = a1.Code AND f2.Destination = a2.Code)
         OR (f2.Source = a2.Code AND f2.Destination = a1.Code))
    AND a1.Code < a2.Code;

-- Query 5
SELECT DISTINCT airports.Code
FROM airports, airlines a1, flights f1,
    airlines a2, flights f2,
    airlines a3, flights f3,
    airlines a4, flights f4,
    airlines a5, flights f5
WHERE a1.Id = f1.Airline AND a1.Abbr = 'Delta' AND airports.Code = f1.Source
    AND a2.Id = f2.Airline AND a2.Abbr = 'Frontier' AND airports.Code = f2.Source
    AND a3.Id = f3.Airline AND a3.Abbr = 'USAir' AND airports.Code = f3.Source
    AND a4.Id = f4.Airline AND a4.Abbr = 'UAL'AND airports.Code = f4.Source
    AND a5.Id = f5.Airline AND a5.Abbr = 'Southwest' AND airports.Code = f5.Source
ORDER BY airports.Code ASC;