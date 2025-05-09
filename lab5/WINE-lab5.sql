-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT w1.Grape, w1.Winery, w1.Name, w1.Score, (w1.Price * w1.Cases * 12) AS Revenue
FROM wine w1, wine w2, appellations
WHERE w1.Vintage = 2006
    AND w1.Appellation = appellations.Appellation
    AND appellations.County = 'Napa'
    AND w2.Vintage = 2006
    AND w2.Winery = 'Rosenblum'
    AND w2.Appellation = 'Paso Robles'
    AND w2.Grape = 'Zinfandel'
    AND (w1.Price * w1.Cases * 12) > (w2.Price * w2.Cases * 12)
ORDER BY Revenue DESC;

-- Query 2
SELECT AVG(Score)
FROM wine
WHERE Grape = 'Zinfandel'
    AND Appellation = 'Sonoma Valley';

-- Query 3
SELECT SUM(Price * Cases * 12)
FROM wine
WHERE Vintage = 2009
    AND Grape = 'Sauvignon Blanc'
    AND Score >= 89;

-- Query 4
SELECT AVG(wine.Cases)
FROM wine, appellations
WHERE wine.Appellation = appellations.Appellation
    AND appellations.Area = 'Central Coast'
    AND wine.Grape = 'Zinfandel';

-- Query 5
SELECT COUNT(w1.WineId)
FROM wine w1, wine w2, grapes
WHERE w2.Score = 98
    AND w1.Appellation = 'Russian River Valley'
    AND w2.Appellation = 'Russian River Valley'
    AND w1.Vintage = w2.Vintage
    AND w1.Grape = grapes.Grape
    AND grapes.Color = 'Red';