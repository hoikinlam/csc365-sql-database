-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT campuses.Campus, AVG(enrollments.FTE) AS "Average Enrollment"
FROM campuses, fees, enrollments
WHERE campuses.Id = fees.CampusId
    AND (fees.Year >= 2000 AND fees.Year <= 2004)
    AND campuses.Id = enrollments.CampusId
    AND fees.Year = enrollments.Year
GROUP BY campuses.Campus
HAVING AVG(fees.fee) > 2300
ORDER BY AVG(enrollments.FTE) DESC;

-- Query 2
SELECT campuses.Campus, MIN(enrollments.Enrolled), AVG(enrollments.Enrolled), MAX(enrollments.Enrolled), STD(enrollments.Enrolled)
FROM campuses, enrollments
WHERE campuses.Id = enrollments.CampusId
GROUP BY campuses.Campus
HAVING COUNT(enrollments.Year) > 60
ORDER BY AVG(enrollments.Enrolled) DESC;

-- Query 3
SELECT campuses.Campus, SUM(fees.fee * enrollments.Enrolled) AS TotalRevenue
FROM campuses, enrollments, fees
WHERE (campuses.County = 'Los Angeles' OR campuses.County = 'Orange')
    AND campuses.Id = enrollments.CampusId
    AND enrollments.Year >= 2001
    AND enrollments.Year = fees.Year
    AND campuses.Id = fees.CampusId
GROUP BY campuses.Campus
ORDER BY TotalRevenue DESC;

-- Query 4
SELECT campuses.Campus, COUNT(discEnr.Discipline)
FROM campuses, enrollments, discEnr
WHERE campuses.Id = enrollments.CampusId
    AND enrollments.Year = 2004
    AND enrollments.Enrolled > 20000
    AND discEnr.CampusId = campuses.Id
    AND discEnr.Gr != 0
GROUP BY campuses.Campus
HAVING COUNT(discEnr.Discipline)
ORDER BY campuses.Campus ASC;