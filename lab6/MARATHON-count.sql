-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT AgeGroup, Sex, COUNT(Place) AS TotalRunners, MIN(Place) AS BestRunner, MAX(Place) AS WorstRunner
FROM marathon
GROUP BY AgeGroup, Sex
ORDER BY AgeGroup, Sex;

-- Query 2
SELECT COUNT(*)
FROM marathon m1, marathon m2
WHERE m1.State = m2.State
    AND m1.AgeGroup = m2.AgeGroup
    AND m1.Sex = m2.Sex
    AND m1.GroupPlace = 1
    AND m2.GroupPlace = 2;

-- Query 3
SELECT DATE_FORMAT(Pace, '%i'), COUNT(Place)
FROM marathon
GROUP BY DATE_FORMAT(Pace, '%i');

-- Query 4
SELECT State, COUNT(Place)
FROM marathon
WHERE GroupPlace <= 10
GROUP BY State
ORDER BY COUNT(Place) DESC;