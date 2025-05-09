-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT Place, RunTime, FirstName, LastName, TIME_FORMAT(Pace, '%i:%S') AS Pace
FROM marathon
WHERE Town = 'LITTLE FERRY'
    AND State = 'NJ'
ORDER BY RunTime ASC;

-- Query 2
SELECT FirstName, LastName, Place, RunTime, GroupPlace
FROM marathon
WHERE Sex = 'F'
    AND Town = 'QUNICY'
    AND State = 'MA'
ORDER BY Place ASC;

-- Query 3
SELECT FirstName, LastName, Town, Place, GroupPlace, RunTime
FROM marathon
WHERE Age = 27
    AND Sex = 'F'
    AND State = 'RI'
ORDER BY RunTime ASC;

-- Query 4
SELECT DISTINCT m1.BibNumber
FROM marathon m1, marathon m2
WHERE m1.BibNumber = m2.BibNumber
    AND m1.Place != m2.Place
ORDER BY m1.BibNumber ASC;

-- Query 5
SELECT m1.Sex, m1.AgeGroup, m1.FirstName, m1.LastName, m1.Age, m2.FirstName, m2.LastName, m2.Age
FROM marathon m1, marathon m2
WHERE m1.GroupPlace = 1
    AND m2.GroupPlace = 2
    AND m1.AgeGroup = m2.AgeGroup
    AND m1.Sex = m2.Sex
ORDER BY m1.Sex ASC, m1.AgeGroup ASC;