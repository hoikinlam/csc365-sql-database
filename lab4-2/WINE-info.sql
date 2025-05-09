-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT wine.Name, wine.Winery, wine.Score
FROM appellations, wine
WHERE appellations.Appellation = 'Napa Valley'
    AND wine.Grape = 'Zinfandel'
    AND appellations.Appellation = wine.Appellation
    AND wine.Vintage = 2008
ORDER BY wine.Score DESC;

-- Query 2
SELECT DISTINCT grapes.Grape
FROM wine, grapes
WHERE grapes.Grape = wine.Grape
    AND wine.Vintage = 2009
    AND wine.Score >= 90
    AND grapes.Color = 'White'
ORDER BY grapes.Grape ASC;

-- Query 3
SELECT DISTINCT appellations.Appellation, appellations.County
FROM appellations, wine
WHERE appellations.County = 'Sonoma'
    AND wine.Grape = 'Grenache'
    AND wine.Appellation = appellations.Appellation
ORDER BY appellations.County ASC, appellations.Appellation ASC;

-- Query 4
SELECT Name, Vintage, Score, (Cases * Price * 12) AS REVENUE
FROM wine
WHERE Winery = 'Altamura'
ORDER BY REVENUE DESC;

-- Query 5
SELECT (w1.Price + (2 * w2.Price) + (3 * w3.Price)) AS TOTAL
FROM wine w1, wine w2, wine w3
WHERE (w1.Winery = 'Kosta Browne' AND w1.Name = 'Koplen Vineyard' AND w1.Vintage = 2008 AND w1.Grape = 'Pinot Noir')
    AND (w2.Winery = 'Darioush' AND w2.Name = 'Darius II' AND w2.Vintage = 2007 AND w2.Grape = 'Cabernet Sauvingnon')
    AND (w3.Winery = 'Kistler' AND w3.Name = 'McCrea Vineyard' AND w3.Vintage = 2006 AND w3.Grape = 'Chardonnay')