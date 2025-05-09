-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT DISTINCT makes.Make, cardata.Year
FROM cardata, makes
WHERE makes.Id = cardata.Id
    AND makes.Model = 'pontiac'
    AND cardata.Year < 1977
ORDER BY cardata.Year ASC;

-- Query 2
SELECT DISTINCT makes.Make, cardata.Year
FROM cardata, makes, models, carmakers
WHERE cardata.Id = makes.Id
    AND (cardata.Year = 1976 OR cardata.Year = 1977)
    AND makes.model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.FullName = 'Chrysler'
ORDER BY cardata.Year ASC, makes.Make ASC;

-- Query 3
SELECT carmakers.FullName, countries.Name
FROM countries, carmakers
WHERE countries.Id = carmakers.Country
    AND (countries.Name = 'france' OR countries.Name = 'sweden')
ORDER BY countries.Name ASC, carmakers.FullName ASC;

-- Query 4
SELECT carmakers.Maker, makes.Make
FROM cardata, makes, carmakers, models
WHERE cardata.Cylinders != 4
    AND cardata.Year = 1979
    AND cardata.MPG > 20
    AND cardata.Accelerate < 18
    AND cardata.Id = makes.Id
    AND models.Model = makes.Model
    AND models.Maker = carmakers.Id
ORDER BY cardata.MPG DESC;

-- Query 5
SELECT DISTINCT carmakers.FullName, countries.Name
FROM cardata, makes, carmakers, countries, models, continents
WHERE cardata.Weight < 2000
    AND (cardata.Year >= 1977 AND cardata.Year <= 1979)
    AND cardata.Id = makes.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Continent = continents.Id
    AND continents.Name = 'america'
ORDER BY carmakers.FullName ASC;

-- Query 6
SELECT makes.Make, cardata.Year, cardata.Weight / cardata.Horsepower as ratio
FROM cardata, makes, models
WHERE cardata.Year > 1971
    AND cardata.Id = makes.Id
    AND makes.Model = models.Model
    AND models.Model = 'volvo'
    AND (cardata.Weight / cardata.Horsepower)
ORDER BY ratio DESC;