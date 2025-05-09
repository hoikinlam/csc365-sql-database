-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
WITH WinePerGrape AS(
    SELECT grapes.Grape, COUNT(wine.WineId) AS count
    FROM grapes, wine, appellations
    WHERE wine.Grape = grapes.Grape
        AND grapes.Color = 'Red'
        AND wine.Appellation = appellations.Appellation
        AND appellations.County = 'San Luis Obispo'
    GROUP BY grapes.Grape
),
MaxCount AS(
    SELECT MAX(count) AS count
    FROM WinePerGrape
)
SELECT Grape
FROM WinePerGrape, MaxCount
WHERE WinePerGrape.count = MaxCount.count;

-- Query 2
WITH WineCount AS(
    SELECT grapes.Grape, COUNT(wine.WineId) AS count
    FROM wine, grapes
    WHERE wine.Grape = grapes.Grape
        AND wine.Score >= 93
    GROUP BY grapes.Grape
),
MaxCount AS(
    SELECT MAX(count) AS count
    FROM WineCount
)
SELECT WineCount.Grape
FROM WineCount, MaxCount
WHERE WineCount.count = MaxCount.count;

-- Query 3
WITH CasePerWine AS(
    SELECT WineId, Cases
    FROM wine
    GROUP BY WineId
    ORDER BY Cases DESC
),
CaseCount AS(
    SELECT CasePerWine.WineId, CasePerWine.Cases,
        (SELECT COUNT(Cases)
        FROM wine
        WHERE wine.Cases > CasePerWine.Cases) + 1 AS Position
    FROM CasePerWine
)
SELECT wine.Winery, wine.Name, CasePerWine.Cases
FROM CaseCount, CasePerWine, wine
WHERE CaseCount.Position = 37
    AND wine.WineId = CasePerWine.WineId
    AND CaseCount.WineId = CasePerWine.WineId;

-- Query 4
WITH Zinfandel AS(
    SELECT WineId, Grape, Score
    FROM wine
    WHERE Grape = 'Zinfandel'
        AND Vintage = 2008
),
Grenache AS(
    SELECT Grape, MAX(Score) AS max
    FROM wine
    WHERE Grape = 'Grenache'
        AND Vintage = 2007
)
SELECT wine.Winery, wine.Name, wine.Appellation, wine.Score, wine.Price
FROM Zinfandel, Grenache, wine
WHERE Zinfandel.Score >= Grenache.max
    AND Zinfandel.WineId = wine.WineId;

-- Query 5
WITH DCV AS(
    SELECT Vintage, MAX(Score) AS score
    FROM wine
    WHERE Appellation = 'Dry Creek Valley'
    GROUP BY Vintage
),
Carneros AS(
    SELECT Vintage, MAX(Score) AS score
    FROM wine
    WHERE Appellation = 'Carneros'
    GROUP BY Vintage
),
DCVWins AS(
    SELECT DCV.Vintage, DCV.score
    FROM DCV, Carneros
    WHERE DCV.score > Carneros.score
        AND DCV.Vintage = Carneros.Vintage
),
CarneroWins AS(
    SELECT Carneros.Vintage, Carneros.score
    FROM DCV, Carneros
    WHERE Carneros.score > DCV.score
        AND DCV.Vintage = Carneros.Vintage
),
CountDCV AS(
    SELECT COUNT(Vintage) AS count
    FROM DCVWins
),
CountCarneros AS(
    SELECT COUNT(Vintage) AS count
    FROM CarneroWins
)
SELECT CountDCV.count AS DryCreek, CountCarneros.count AS Carneros
FROM CountDCV, CountCarneros;

-- Query 6
WITH WineriesCount AS(
    SELECT appellations.Area,
        COUNT(CASE 
                WHEN wine.Grape = 'Grenache' THEN wine.Winery
              END
             ) AS count
    FROM wine, appellations
    WHERE wine.Appellation = appellations.Appellation
        AND appellations.Area != 'California'
        AND appellations.Area != 'N/A'
    GROUP BY appellations.Area
)
SELECT Area, count
FROM WineriesCount
ORDER BY Area;