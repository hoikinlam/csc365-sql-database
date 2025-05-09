-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT makes.Make, cardata.Year, cardata.Horsepower
FROM cardata, makes
WHERE cardata.Id = makes.Id
    AND cardata.Horsepower = (SELECT MAX(cardata.Horsepower)
                              FROM cardata);

-- Query 2
SELECT makes.Make, cardata.Year
FROM cardata, makes
WHERE cardata.Id = makes.Id
    AND cardata.MPG = (SELECT MAX(cardata.MPG) FROM cardata)
    AND cardata.Accelerate = (SELECT MIN(cardata.Accelerate)
                            FROM cardata
                            WHERE cardata.MPG = (SELECT MAX(cardata.MPG) FROM cardata));

-- Query 3
WITH CarCount AS(
    SELECT carmakers.Id, carmakers.Country, COUNT(cardata.Id) AS count
    FROM cardata, carmakers, models, makes
    WHERE cardata.Id = makes.Id
        AND makes.Model = models.Model
        AND carmakers.Id = models.Maker
    GROUP BY carmakers.Id, carmakers.Country
),
MaxCountry AS(
    SELECT Country, MAX(count) AS count
    FROM CarCount
    GROUP BY Country
),
Final AS(
    SELECT CarCount.Country, CarCount.Id
    FROM CarCount, MaxCountry
    WHERE CarCount.count = MaxCountry.count
        AND CarCount.Country = MaxCountry.Country
)
SELECT countries.Name, carmakers.Maker
FROM Final, carmakers, countries
WHERE Final.Country = countries.Id
    AND Final.Id = carmakers.Id
ORDER BY countries.Name;

-- Query 4
WITH Everything AS(
    SELECT cardata.Year, carmakers.Id, COUNT(cardata.Id) AS count, AVG(cardata.Accelerate) AS acc, AVG(cardata.Weight) AS weight
    FROM cardata, makes, models, carmakers
    WHERE cardata.Id = makes.Id
        AND makes.Model = models.Model
        AND models.Maker = carmakers.Id
    GROUP BY cardata.Year, carmakers.Id
    HAVING COUNT(cardata.Id) > 1
),
Heaviest AS(
    SELECT Year, MAX(weight) AS weight
    FROM Everything
    GROUP BY Year
)
SELECT Everything.Year, carmakers.Maker, Everything.count,Everything.acc
FROM Everything, Heaviest, carmakers
WHERE Everything.weight = Heaviest.weight
    AND Everything.Id = carmakers.Id
ORDER BY Everything.Year;

-- Query 5
WITH 8cylinder AS(
    SELECT MPG
    FROM cardata
    WHERE Cylinders = 8
),
4cylinder AS(
    SELECT MPG
    FROM cardata
    WHERE Cylinders = 4
)
SELECT DISTINCT (SELECT MAX(MPG) FROM 8cylinder) - (SELECT MIN(MPG) FROM 4cylinder)
FROM 8cylinder, 4cylinder;

-- Query 6
WITH CarCount AS(
    SELECT cardata.Year, countries.Name, COUNT(cardata.Id) AS count
    FROM cardata, makes, models, carmakers, countries
    WHERE cardata.Id = makes.Id
        AND makes.Model = models.Model
        AND models.Maker = carmakers.Id
        AND cardata.Year BETWEEN 1972 AND 1976
        AND carmakers.Country = countries.Id
    GROUP BY cardata.Year, countries.Id
),
USACount AS(
    SELECT Year, Name, count
    FROM CarCount
    WHERE CarCount.Name = 'usa'
),
OthersCount AS(
    SELECT Year, Name, count
    FROM CarCount
    WHERE CarCount.Name != 'usa'
)
SELECT DISTINCT USACount.Year,
    CASE
        WHEN USACount.count > OthersCount.count THEN 'us'
        ELSE 'rest of the world'
    END AS Leader
FROM USACount, OthersCount
WHERE USACount.Year = OthersCount.Year;