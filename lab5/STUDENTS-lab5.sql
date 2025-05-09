-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT DISTINCT l1.FirstName, l1.LastName, l1.grade, l2.FirstName, l2.LastName, l2.grade
FROM list l1, list l2
WHERE l1.FirstName = l2.FirstName
    AND l1.LastName != l2.LastName
    AND l1.LastName < l2.LastName;

-- Query 2
SELECT list.FirstName, list.LastName
FROM list, teachers
WHERE teachers.classroom = list.classroom
    AND list.grade = 4
    AND (teachers.Last != 'KAWA' AND teachers.First != 'GORDON')
ORDER BY LastName ASC;

-- Query 3
SELECT COUNT(grade)
FROM list
WHERE grade = 1 OR grade = 2;

-- Query 4
SELECT COUNT(l1.LastName)
FROM list l1, list l2
WHERE l1.FirstName != 'ELTON' AND l1.LastName != 'FULVIO'
    AND l2.FirstName = 'ELTON' AND l2.LastName = 'FULVIO'
    AND l1.classroom = l2.classroom;