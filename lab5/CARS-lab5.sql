-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT m1.Make, c1.Year, carmakers.maker
FROM cardata c1, cardata c2, makes m1, makes m2, models, carmakers
WHERE c2.Year = 1982
    AND c2.Id = m2.Id
    AND m2.Make = 'honda civic'
    AND c1.Year > 1980
    AND c1.Id = m1.Id
    AND m1.Model = models.Model
    AND models.Maker = carmakers.Id
    AND c1.MPG > c2.MPG
ORDER BY c1.MPG DESC;

-- Query 2
SELECT AVG(cardata.Horsepower), MAX(cardata.Horsepower), MIN(cardata.Horsepower)
FROM cardata, makes, models, countries, carmakers
WHERE cardata.Id = makes.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Name = 'france'
    AND (cardata.Year >= 1971 AND cardata.Year <= 1976)
    AND cardata.Cylinders = 4;

-- Query 3
SELECT COUNT(c1.Id)
FROM cardata c1, cardata c2, makes
WHERE c1.Year = 1971
    AND c2.Year = 1972
    AND c2.Id = makes.Id
    AND makes.Make = 'volvo 145e (sw)' 
    AND c1.Accelerate < c2.Accelerate;

-- Query 4
SELECT COUNT(carmakers.Id)
FROM cardata, makes, carmakers, models
WHERE cardata.Id = makes.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND cardata.Weight > 5000;