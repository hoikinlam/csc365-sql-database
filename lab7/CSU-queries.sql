-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
WITH MaxDegrees AS(
    SELECT campuses.Campus, SUM(degrees.degrees) AS count 
    FROM degrees, campuses
    WHERE campuses.Id = degrees.CampusId
        AND degrees.Year >= 1990
        AND degrees.Year <= 2004
    GROUP BY campuses.Campus
)
SELECT campuses.Campus, campuses.County, SUM(degrees.degrees)
FROM campuses, degrees, MaxDegrees
WHERE campuses.Id = degrees.CampusId
    AND MaxDegrees.Campus = campuses.Campus
    AND degrees.Year >= 1990
    AND degrees.Year <= 2004
GROUP BY campuses.Campus, campuses.County
HAVING SUM(degrees.degrees) = (SELECT MAX(MaxDegrees.count) FROM MaxDegrees);

-- Query 2
WITH TotalDegrees AS(
    SELECT campuses.Id, SUM(degrees.degrees) AS total
    FROM campuses, degrees
    WHERE campuses.Id = degrees.CampusId
        AND degrees.Year BETWEEN 1990 AND 2004
    GROUP BY campuses.Id
),
Largest AS(
    SELECT MAX(total) AS large
    FROM TotalDegrees
),
Smallest AS(
    SELECT MIN(total) AS small
    FROM TotalDegrees
)
SELECT (large / small) AS ratio
FROM Largest, Smallest;

-- Query 3
WITH RatioPerYear AS(
    SELECT campuses.Campus, faculty.Year, (enrollments.FTE / faculty.FTE) AS Ratio
    FROM campuses, enrollments, faculty
    WHERE campuses.Id = enrollments.CampusId
        AND campuses.Id = faculty.CampusId
        AND faculty.Year = enrollments.Year
    GROUP BY campuses.Id, faculty.Year
),
BestRatio AS(
    SELECT Campus, MIN(Ratio) AS Ratio
    FROM RatioPerYear
    GROUP BY Campus
)
SELECT RatioPerYear.Campus, RatioPerYear.Year, RatioPerYear.Ratio
FROM RatioPerYear, BestRatio
    WHERE RatioPerYear.Ratio = BestRatio.Ratio
ORDER  BY RatioPerYear.Ratio;

-- Query 4
WITH RatioPerYear AS(
    SELECT campuses.Campus, faculty.Year, (enrollments.FTE / faculty.FTE) AS Ratio
    FROM campuses, enrollments, faculty
    WHERE campuses.Id = enrollments.CampusId
        AND campuses.Id = faculty.CampusId
        AND faculty.Year = enrollments.Year
    GROUP BY campuses.Id, faculty.Year
),
BestRatio AS(
    SELECT Campus, MIN(Ratio) AS Ratio
    FROM RatioPerYear
    GROUP BY Campus
),
BestRatioWithYear AS(
    SELECT RatioPerYear.Campus, RatioPerYear.Year, RatioPerYear.Ratio
    FROM RatioPerYear, BestRatio
        WHERE RatioPerYear.Ratio = BestRatio.Ratio
    ORDER  BY RatioPerYear.Ratio
),
CountBestRatio AS(
    SELECT Year, COUNT(*) AS count
    FROM BestRatioWithYear
    GROUP BY Year
),
MaxCount AS(
    SELECT MAX(count) AS max
    FROM CountBestRatio
),
TotalUni AS(
    SELECT COUNT(*) AS total
    FROM campuses
)
SELECT Year, (MaxCount.max / TotalUni.total) * 100 AS Percent
FROM CountBestRatio, MaxCount, TotalUni
WHERE CountBestRatio.count = MaxCount.max;

-- Query 5
WITH AvgFaculty AS(
    SELECT campuses.Id, AVG(faculty.FTE) AS AvgFTE
    FROM campuses, faculty
    WHERE campuses.Id = faculty.CampusId
    GROUP BY campuses.Id
),
NoEngineering AS(
    SELECT Id
    FROM campuses
    EXCEPT
    SELECT DISTINCT campuses.Id
    FROM campuses, discEnr, disciplines
    WHERE disciplines.Name = 'Engineering'
        AND disciplines.Id = discEnr.Discipline
        AND campuses.Id = discEnr.CampusId
)
SELECT campuses.Campus, AvgFaculty.AvgFTE
FROM AvgFaculty, NoEngineering, campuses
WHERE AvgFaculty.Id = NoEngineering.Id
    AND NoEngineering.Id = campuses.Id
ORDER BY AvgFaculty.AvgFTE DESC;

-- Query 6
SELECT campuses.Campus,
CASE
    WHEN Year > 1955 THEN 'did not exist'
    ELSE 'existed'
END AS status
FROM campuses
ORDER BY campuses.Campus;