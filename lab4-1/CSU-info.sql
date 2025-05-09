-- Lab 4 - CSU
-- Hoikin Lam
-- Oct 28, 2024

-- Query 1
SELECT Campus, Year
FROM campuses
WHERE Year < 1920
ORDER BY Year ASC;

-- Query 2
SELECT degrees.year, degrees
FROM degrees, campuses
WHERE CampusID = Id
    AND Campus = 'Fresno State University'
    AND (degrees.year >= 2000 AND degrees.year <= 2004)
ORDER BY degrees.year ASC;

-- Query 3
SELECT Campus, disciplines.Name, Gr, Ug
FROM campuses, discEnr, disciplines
WHERE (Campus = 'California Polytechnic State University-San Luis Obispo' 
        OR Campus = 'California State Polytechnic University-Pomona')
    AND discEnr.CampusID = campuses.Id
    AND discEnr.Discipline = disciplines.Id
    AND discEnr.Year = 2004
    AND (disciplines.Name = 'Mathematics' 
        OR disciplines.Name = 'Engineering'
        OR disciplines.Name = 'Computer and Info. Sciences')
ORDER BY Campus ASC, disciplines.Name ASC;

-- Query 4
SELECT DISTINCT Campus, enrollments.Year, degrees.degrees/enrollments.FTE AS RATIO
FROM campuses, enrollments, degrees
WHERE (degrees.degrees/enrollments.FTE) > 0.25
    AND campuses.Id = degrees.CampusId
    AND campuses.Id = enrollments.CampusId
    AND degrees.year = enrollments.year
    AND (enrollments.year < 2000 AND enrollments.year >= 1990)
ORDER BY RATIO DESC;

-- Query 5
SELECT DISTINCT Campus, disciplines.Name, ug, gr
FROM campuses, disciplines, discEnr
WHERE campuses.Id = discEnr.CampusId
    AND disciplines.Id = discEnr.Discipline
    AND (Ug != 0 AND Gr != 0)
    AND Gr >= Ug*4
    AND discEnr.Year = 2004
ORDER BY Campus ASC, disciplines.Name ASC;

-- Query 6
SELECT DISTINCT fees.Year
    , (fees.fee * enrollments.FTE) AS COLLECTED
    , (fees.fee * enrollments.FTE) / faculty.FTE AS 'PER FACULTY'
FROM fees, enrollments, campuses, faculty
WHERE Campus = 'San Diego State University'
    AND campuses.Id = fees.CampusId
    AND campuses.Id = faculty.CampusId
    AND campuses.Id = enrollments.CampusId
    AND fees.Year = enrollments.Year
    AND fees.Year = faculty.Year
    AND (fees.Year <= 2004 AND fees.Year >= 2000)
ORDER BY fees.Year ASC;

-- Query 7
SELECT DISTINCT c1.campus
    , e1.FTE AS STUDENTS    
    , faculty.FTE AS Faculty
    , e1.FTE / faculty.FTE AS RATIO
FROM campuses c1, campuses sj, faculty, enrollments e1, enrollments sje
WHERE c1.Id = e1.CampusId 
    AND sj.Id = sje.CampusId
    AND sj.Campus = 'San Jose State University'
    AND e1.Year = 2003 
    AND sje.Year = 2003
    AND e1.FTE > sje.FTE
    AND c1.Id = faculty.CampusId
    AND e1.Year = faculty.Year
ORDER BY RATIO ASC;

-- Query 8
SELECT DISTINCT sd.year
FROM enrollments sd, enrollments sj, campuses csd, campuses csj
WHERE csd.Campus = 'San Diego State University'
    AND csj.Campus = 'San Jose State University'
    AND csd.Id = sd.CampusId
    AND csj.Id = sj.CampusId
    AND sd.Year = sj.Year
    AND sd.FTE > sj.FTE
ORDER BY sd.year ASC;