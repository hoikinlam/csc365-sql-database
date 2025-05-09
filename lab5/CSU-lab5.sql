-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT AVG(degrees.degrees)
FROM campuses, degrees
WHERE campuses.Id = degrees.CampusId
    AND campuses.Campus = 'California Polytechnic State University-San Luis Obispo'
    AND (degrees.year >= 1995 AND degrees.year <= 2000)

-- Query 2
SELECT MIN(fees.fee) AS Smallest, AVG(fees.fee) AS Average, MAX(fees.fee) AS Largest
FROM campuses, fees
WHERE campuses.Id = fees.CampusId
    AND fees.Year = 2002

-- Query 3
SELECT AVG((enrollments.FTE) / (faculty.FTE)) AS Ratio
FROM campuses, enrollments, faculty
WHERE campuses.Id = enrollments.CampusId
    AND campuses.Id = faculty.CampusId
    AND enrollments.Year = 2004 
    AND faculty.Year = 2004
    AND enrollments.FTE > 15000

-- Query 4
SELECT DISTINCT enrollments.Year
FROM campuses, enrollments, degrees
WHERE Campus = 'California Polytechnic State University-San Luis Obispo'
    AND campuses.Id = enrollments.CampusId
    AND campuses.Id = degrees.CampusId
    AND enrollments.Enrolled > 17000
UNION
SELECT DISTINCT degrees.year
FROM campuses, enrollments, degrees
WHERE Campus = 'California Polytechnic State University-San Luis Obispo'
    AND campuses.Id = degrees.CampusId
    AND degrees.degrees > 3500
ORDER BY year ASC;

-- Query 5
SELECT enrollments.Year
FROM campuses, enrollments
WHERE campuses.Campus = 'California Polytechnic State University-San Luis Obispo'
    AND campuses.Id = enrollments.CampusId
    AND enrollments.FTE > 15000
EXCEPT
SELECT degrees.year
FROM campuses, degrees
WHERE campuses.Campus = 'San Jose State University'
    AND campuses.Id = degrees.CampusId
    AND degrees.degrees < 4000