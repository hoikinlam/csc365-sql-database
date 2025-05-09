-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Score, AVG(Price), MIN(Price), MAX(Price), COUNT(WineId), SUM(Cases)
FROM wine
WHERE Score > 88
GROUP BY Score
ORDER BY Score;

-- Query 2
SELECT grapes.Grape, MAX(wine.Price * 12)
FROM grapes, wine
WHERE grapes.Color = 'Red'
    AND grapes.Grape = wine.Grape
GROUP BY grapes.Grape
HAVING COUNT(wine.WineId) > 10
ORDER BY MAX(wine.Price * 12) DESC;

-- Query 3
SELECT wine.Winery, GROUP_CONCAT(DISTINCT wine.Name SEPARATOR ', ')
FROM wine
WHERE wine.Appellation = 'Sonoma Valley'
    AND wine.Grape = 'Zinfandel'
GROUP BY wine.Winery
ORDER BY wine.Winery ASC;

-- Query 4
SELECT appellations.County, MAX(wine.Score)
FROM appellations, wine, grapes
WHERE appellations.County != 'N/A'
    AND appellations.Appellation = wine.Appellation
    AND wine.Vintage = 2009
    AND wine.Grape = grapes.Grape
    AND grapes.Color = 'Red'
GROUP BY appellations.County
ORDER BY MAX(wine.Score) DESC;