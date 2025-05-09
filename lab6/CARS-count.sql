-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT carmakers.Maker, AVG(cardata.MPG) AS AverageMPG, STD(cardata.MPG) AS StDevMPG
FROM carmakers, cardata, continents, countries, makes, models
WHERE makes.Id = cardata.Id
    AND models.Model = makes.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Continent = continents.Id
    AND continents.Name = 'europe'
GROUP BY carmakers.Maker
HAVING AVG(cardata.MPG) IS NOT NULL
    AND STD(cardata.MPG) IS NOT NULL
ORDER BY MAX(cardata.MPG) ASC;

-- Query 2
SELECT carmakers.Maker AS maker, COUNT(cardata.Id) AS FAST
FROM carmakers, cardata, countries, makes, models
WHERE makes.Id = cardata.Id
    AND models.Model = makes.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Name = 'usa'
    AND cardata.Cylinders = 4
    AND cardata.Weight < 4000
    AND cardata.Accelerate < 14
GROUP BY carmakers.Maker
HAVING COUNT(cardata.Id)
ORDER BY COUNT(cardata.Id) DESC;

-- Query 3
SELECT carH.Year, MAX(carT.MPG), MIN(carT.MPG), AVG(carT.MPG)
FROM cardata carH, makes makeH, cardata carT, makes makeT
WHERE carH.Id = makeH.Id
  AND makeH.Model = 'honda'
  AND carT.Id = makeT.Id
  AND makeT.Model = 'toyota'
  AND carH.Year = carT.Year
GROUP BY carT.Year
HAVING COUNT(makeH.Model) > 2
EXCEPT
SELECT carT.Year, MAX(carT.MPG), MIN(carT.MPG), AVG(carT.MPG)
FROM cardata carH, makes makeH, cardata carT, makes makeT
WHERE carH.Id = makeH.Id
  AND makeH.Model = 'honda'
  AND carT.Id = makeT.Id
  AND makeT.Model = 'toyota'
  AND carT.Year < carH.Year
GROUP BY carT.Year;

-- Query 4
SELECT cardata.Year, COUNT(cardata.Id) 
FROM cardata, makes, models, carmakers, countries
WHERE cardata.Year >= 1975
    AND cardata.Year <= 1979
    AND cardata.Id = makes.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Name = 'japan'
GROUP BY cardata.Year
HAVING COUNT(cardata.Horsepower) < 150
ORDER BY cardata.Year ASC;