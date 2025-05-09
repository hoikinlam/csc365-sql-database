-- Hoikin Lam hlam13@calpoly.edu

CREATE TABLE Teachers
(
    LastName VARCHAR(9),
    FirstName VARCHAR(9),
    Classroom int,
    PRIMARY KEY (Classroom)
);

CREATE TABLE List
(
    LastName VARCHAR(11),
    FirstName VARCHAR(11),
    Grade int,
    Classroom int,
    PRIMARY KEY (LastName, FirstName),
    FOREIGN KEY (Classroom) REFERENCES Teachers(Classroom)
);