-- Hoikin Lam hlam13@calpoly.edu

-- Query 1
SELECT teachers.Last, teachers.First, Q.count
FROM teachers,
        (SELECT classroom, COUNT(*) AS count
        FROM list
        GROUP BY classroom) Q
WHERE teachers.classroom = 
    (SELECT list.classroom 
    FROM teachers, list
    WHERE teachers.classroom = list.classroom
    GROUP BY list.classroom
    HAVING COUNT(list.LastName) =
        (SELECT MIN(Q.count)
        FROM
            (SELECT classroom, COUNT(*) AS count
            FROM list
            GROUP BY classroom) Q))
    AND Q.classroom = teachers.classroom;

-- Query 2
WITH NumStudents AS(
    SELECT classroom, COUNT(*) AS count
    FROM list
    GROUP BY classroom
),
AvgNum AS(
    SELECT list.grade, AVG(NumStudents.count) AS count
    FROM NumStudents, list
    WHERE NumStudents.classroom = list.classroom
    GROUP BY list.grade
)
SELECT AvgNum.grade, AvgNum.count
FROM AvgNum
WHERE AvgNum.count = (SELECT MAX(AvgNum.count) FROM AvgNum);

-- Query 3
WITH Longest AS(
    SELECT grade, LastName, FirstName, LENGTH(CONCAT(LastName, FirstName)) AS Length
    FROM list
)
SELECT grade, FirstName, LastName
FROM Longest
WHERE Length = (SELECT MAX(Length) FROM Longest);

-- Query 4
WITH StudentCount AS(
    SELECT classroom, COUNT(*) AS count
    FROM list
    GROUP BY classroom
)
SELECT s1.classroom, s2.classroom, s1.count
FROM StudentCount s1, StudentCount s2
WHERE s1.count = s2.count
    AND s1.classroom != s2.classroom
    AND s1.classroom < s2.classroom
ORDER BY s1.count ASC;

-- Query 5
WITH CountClassroom AS(
    SELECT grade, COUNT(DISTINCT classroom) AS count
    FROM list
    GROUP BY grade
),
StudentCount AS(
    SELECT classroom, grade, COUNT(*) AS count
    FROM list
    GROUP BY classroom, grade
),
Grades AS(
    SELECT DISTINCT CountClassroom.grade
    FROM CountClassroom, StudentCount
    WHERE CountClassroom.grade = StudentCount.grade
        AND CountClassroom.count > 1
),
Largest AS(
    SELECT Grades.grade, StudentCount.classroom, StudentCount.count
    FROM StudentCount, Grades
    WHERE Grades.grade = StudentCount.grade
),
LargestPerGrade AS(
    SELECT grade, MAX(count) AS count
    FROM Largest
    GROUP BY grade
),
Final AS(
    SELECT classroom, LargestPerGrade.grade, LargestPerGrade.count
    FROM LargestPerGrade, StudentCount
    WHERE LargestPerGrade.grade = StudentCount.grade
        AND LargestPerGrade.count = StudentCount.count
)
SELECT Final.grade, teachers.Last
FROM Final, teachers
WHERE Final.classroom = teachers.classroom
ORDER BY grade ASC;