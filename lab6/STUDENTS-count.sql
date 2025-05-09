-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT teachers.Last, teachers.First
FROM teachers, list
WHERE teachers.Classroom = list.classroom
GROUP BY teachers.Last, teachers.First
HAVING COUNT(list.LastName) = 2 OR COUNT(list.LastName) = 3
ORDER BY teachers.Last;

-- Query 2
SELECT grade, GROUP_CONCAT(DISTINCT classroom SEPARATOR ', ') AS AllClassrooms
FROM list
GROUP BY grade
ORDER BY grade;

-- Query 3
SELECT classroom, COUNT(LastName)
FROM list
WHERE grade = 0
GROUP BY classroom
ORDER BY COUNT(LastName) DESC;

-- Query 4
SELECT classroom, MIN(LastName)
FROM list
WHERE grade = 1
GROUP BY classroom
ORDER BY classroom;

-- Query 5
SELECT teachers.First, teachers.Last
FROM teachers, list
WHERE teachers.Classroom = list.classroom
GROUP BY teachers.First, teachers.Last
HAVING COUNT(list.LastName) > 5
ORDER BY teachers.Last;