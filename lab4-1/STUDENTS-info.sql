-- Lab4 - STUDENTS
-- Hoikin Lam - hlam13@calpoly.edu
-- Oct 28, 2024


-- Query 1
SELECT FirstName,LastName
FROM list
WHERE classroom = 104
ORDER BY LastName DESC;

-- Query 2
SELECT DISTINCT classroom, grade
FROM list
ORDER BY grade ASC;

-- Query 3
SELECT DISTINCT First, Last
FROM teachers, list
WHERE list.grade = 1 AND list.classroom = teachers.classroom
ORDER BY Last ASC;

-- Query 4
SELECT First, Last
FROM teachers, list
WHERE (list.FirstName = 'LANCE' AND list.LastName = 'HOOSOCK') 
    AND (list.classroom = teachers.classroom);

-- Query 5
SELECT DISTINCT others.FirstName, others.LastName, others.classroom
FROM list lynn, list others
WHERE (lynn.FirstName = 'LYNNETTE' AND lynn.LastName = 'HOESCHEN')
    AND lynn.grade = others.grade
    AND lynn.classroom != others.classroom
ORDER BY classroom ASC, LastName ASC;